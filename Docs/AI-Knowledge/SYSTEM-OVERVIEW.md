# System Overview - EasyPOS To Business Central

> **Sidst opdateret:** 2026-05-07

## Oversigt

Timer-baseret Windows Service der synkroniserer data mellem EasyPOS (Firebird DB) og Microsoft Dynamics 365 Business Central via REST API. Koerer som baggrundstjeneste paa kundens server.

## Teknologi

- **Sprog:** Delphi 13.1 (Object Pascal)
- **Database:** Firebird SQL via FireDAC
- **API:** REST med OAuth2 (cloud) eller Basic Auth (on-premise)
- **Serialization:** MVCFramework JSON (`[MVCNameAs()]` attributter)
- **Email:** Indy SMTP
- **Platform:** Windows Service (Win32)

## Arkitektur

### Komponenter

| Unit | Ansvar |
|------|--------|
| `UDM.pas` | Kernelogik: timer, DB queries, sync orchestrering, logging, fejlmail |
| `uBusinessCentralIntegration.pas` | BC REST API klient (git submodule) |
| `uEasyPOSToBC.pas` | Windows Service shell - starter timer |
| `uMain.pas` | Debug GUI (kun i Debug build) |
| `uEventLogger.pas` | Windows Event Log |
| `uSendEMail.pas` | SMTP fejlnotifikationer |

### Dataflow

```
EasyPOS (Firebird) --> Windows Service --> Business Central (REST/OData)
                   <-- Costprices <--
```

### Sync Moduler (i eksekveringsraekkefoelge)

1. **Items** (EP->BC) - trigger: `BC_UPDATEDATE` felt aendringer via DB trigger
2. **Sales Transactions** (EP->BC) - trigger: `EKSPORTERET = 0`
3. **Movements Transactions** (EP->BC) - trigger: `EKSPORTERET = 0`
4. **Financial Records** (EP->BC) - trigger: `BEHANDLET = 0`
5. **Cost Prices** (BC->EP) - laeser fra BC, opdaterer EasyPOS priser
6. ~~Stock Regulations~~ - **PERMANENT DISABLED** - maa ikke genaktiveres

### Build Konfigurationer

- **Release:** Windows Service (`Vcl.SvcMgr`), ingen GUI
- **Debug:** VCL desktop app med test GUI, `ReportMemoryLeaksOnShutdown`
- Styret via `{$IFNDEF RELEASE}` / `{$IFDEF RELEASE}` i .dpr

### Kunde-versioner

Via `LF_BC_Version` i Settings.INI:
- **Version 0/1 (Kaufmann):** On-premise BC, Basic Auth
- **Version 2/3 (ny-form):** Cloud BC, OAuth2

## Projekter

| Projekt | Beskrivelse |
|---------|-------------|
| `EasyPOS_To_BusinessCentral.dproj` | Hoved-service |
| `INIFileEditor/EP_To_BC_Editor.dproj` | Settings.INI editor (standard VCL) |

## Vigtige Regler

1. **Log aldrig passwords** - brug `****` maskering
2. **HTTP 503:** Pause API kald naar BC returnerer 503 (tracked via `LastDateTimeForStatusCode503`)
3. **StockRegulations SKAL forblive disabled** (`=0` i INI)
4. **Transaction IDs:** Hver sync-batch faar unikt `TransID` via stored procedure
5. **Status tracking:** Records markeres efter eksport (`EKSPORTERET=1` / `BEHANDLET=1`)

## Konfiguration

`Settings.INI` i samme mappe som EXE. Sektioner:
`[PROGRAM]`, `[BUSINESS CENTRAL]`, `[SYNCRONIZE]`, `[Items]`, `[SalesTransaction]`, `[MovementsTransaction]`, `[FinancialRecords]`, `[Costprice]`, `[MAIL]`

## Git Submodule

`BusinessCentral-Integration/` er et git submodule med BC REST klienten. Har sin egen test-app (`KaufmannBCodata.dproj`). Aendringer committes separat i submodulet.
