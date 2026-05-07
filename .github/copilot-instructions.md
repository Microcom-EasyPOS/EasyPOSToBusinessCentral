# Copilot Instructions - EasyPOS To Business Central

## Build

- **IDE:** Delphi 13.1
- **Platform:** Win32 only
- **Build tool:** Use the `delphi_build` MCP tool with `version: "13.1"`

### Projects

| Project | Description |
|---------|-------------|
| `EasyPOS_To_BusinessCentral.dproj` | Main service/application |
| `INIFileEditor/EP_To_BC_Editor.dproj` | Settings.INI editor tool |

Project group: `EasyPOS_To_BusinessCentralGroup.groupproj`

### Build Configurations

- **Release:** Compiles as a Windows Service (`Vcl.SvcMgr`). No GUI.
- **Debug:** Compiles as a desktop VCL application with test GUI (`uMain.pas`). Enables `ReportMemoryLeaksOnShutdown`.

The `{$IFNDEF RELEASE}` / `{$IFDEF RELEASE}` directives in the `.dpr` and units control which mode is active.

### Service Install/Uninstall (Release build only)

```cmd
EasyPOS_To_BusinessCentral.exe /install
net start "EasyPOS To Business Central"

net stop "EasyPOS To Business Central"
EasyPOS_To_BusinessCentral.exe /uninstall
```

### Known Issue

The repository path contains spaces ("Windows Service") which can cause issues with the build machine's `build.cmd` script. Build from IDE or ensure proper quoting if using CLI.

### Git Submodule

`BusinessCentral-Integration/` is a git submodule containing `uBusinessCentralIntegration.pas` (the BC REST client) and its own standalone test project (`KaufmannBCodata.dproj`). After cloning:
```
git submodule update --init --recursive
```

Changes to the BC integration client should be made in the submodule and committed there separately.

## Architecture

### Data Flow

This is a **timer-based Windows Service** that syncs data between an EasyPOS Firebird database and Microsoft Dynamics 365 Business Central via REST API.

```
EasyPOS (Firebird DB) ──→ Windows Service ──→ Business Central (REST/OData)
                        ←── Costprices ←──
```

### Key Units

| Unit | Responsibility |
|------|---------------|
| `UDM.pas` | **Core logic.** Data module with timer, all DB queries, sync orchestration, logging, error mail. This is where sync methods live. |
| `uBusinessCentralIntegration.pas` | BC REST API client. Setup class, model classes with MVCFramework serialization attributes, URL building. |
| `uEasyPOSToBC.pas` | Thin Windows Service shell. Only starts the timer on `UDM`. |
| `uMain.pas` | Debug-only GUI form for manual testing. |
| `uEventLogger.pas` | Windows Event Log writer. |
| `uSendEMail.pas` | SMTP email notifications via Indy. |

### Sync Modules (execution order in `DoHandleEksportToBusinessCentral`)

1. **Items** (EP → BC) — triggered by `BC_UPDATEDATE` field changes
2. **Sales Transactions** (EP → BC) — triggered by `EKSPORTERET = 0`
3. **Movements Transactions** (EP → BC) — triggered by `EKSPORTERET = 0`
4. **Financial Records** (EP → BC) — triggered by `BEHANDLET = 0`
5. **Cost Prices** (BC → EP) — reads from BC, updates EasyPOS prices
6. ~~Stock Regulations~~ — **PERMANENTLY DISABLED.** Do not reactivate.

### Customer Versions

The service supports multiple BC configurations via `LF_BC_Version`:
- **Version 0/1 (Kaufmann):** On-premise BC with Basic Auth
- **Version 2/3 (ny-form):** Cloud BC with OAuth2

### Configuration

Runtime configuration is via `Settings.INI` (same folder as EXE). Key sections: `[PROGRAM]`, `[BUSINESS CENTRAL]`, `[SYNCRONIZE]`, `[Items]`, `[SalesTransaction]`, `[MovementsTransaction]`, `[FinancialRecords]`, `[Costprice]`, `[MAIL]`.

## Conventions

### Language

- Code is in English (variable names, methods)
- Comments and documentation are in Danish
- Commit messages in English

### Coding Patterns

- **JSON serialization:** Uses `MVCFramework.Serializer.JsonDataObjects` with `[MVCNameAs()]` and `[MVCNameCase(ncAsIs)]` attributes on model classes
- **DB access:** FireDAC components defined on the data module (`TFDQuery`, `TFDStoredProc`), each sync module has its own transaction
- **Error handling:** Each sync module has its own error log file, errors are also emailed and written to Windows Event Log
- **Status tracking:** After successful export, records are marked (`EKSPORTERET = 1` or `BEHANDLET = 1`) in a separate transaction
- **Transaction IDs:** Each sync batch gets a unique `TransID` via `GetNextTransactionIDToBC` stored procedure for traceability in BC

### Important Rules

- **Never log passwords** — use `****` masking (see `Docs/SECURITY_FIXES.md`)
- **HTTP 503 handling:** When BC returns 503, the service pauses API calls (tracked via `LastDateTimeForStatusCode503`)
- **`StockRegulationsTransactions` must stay disabled** (`=0` in INI). The code is commented out intentionally.

### Submodule Workflow

The `BusinessCentral-Integration/` submodule has its own Git history. When modifying `uBusinessCentralIntegration.pas`:
1. Make changes inside the submodule directory
2. Commit and push in the submodule first
3. Then update the submodule reference in this repo and commit

## Documentation

Technical sync documentation lives in `Docs/`:
- `TECH_Sync_*.md` — Detailed technical docs per sync module
- `Docs/Internal/` — Deep-dive analysis documents
- `CHANGELOG.md` — Version history
- `SECURITY_FIXES.md` — Security-related changes
