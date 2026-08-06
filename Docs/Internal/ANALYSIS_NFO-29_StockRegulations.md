# Analyse: Export af Lagerreguleringer (nfItemAdjustments) til Business Central

**Opgave:** Implementering af ny eksport af lagerreguleringer (ART = 11) til Business Central via endpointet `nfItemAdjustments`.
**Branch:** `NFO-29_TransferStockRegulations`

---

## 1. Datamapping (EasyPOS -> Business Central)

Endpoint: `POST /nfItemAdjustments`

| BC Felt | Datatype | Kilde i EasyPOS (SQL) | Noter |
| :--- | :--- | :--- | :--- |
| `transId` | Integer / String | `GetNextTransactionIDToBC` | Hentes via eksisterende Stored Procedure for unik BC batch-ID. |
| `reguleringsId` | String | `T.BONNR` | |
| `vareId` | String | `T.VAREFRVSTRNR` | |
| `variantId` | String | `V.V509INDEX` | |
| `epId` | Integer | `T.TRANSID` | |
| `bogfRingsDato` | Date | `T.DATO` | Skal formateres/mappes til dato via `FormatDateTime('dd-mm-yyyy', ...)` ligesom i de andre metoder. |
| `butik` | String | `T.AFDELING_ID` | |
| `antal` | Decimal | `T.SALGSTK` | |
| `kostPris` | Decimal | `T.KOSTPR / T.SALGSTK` | Beregnet felt i SQL. |
| `status` | String | Hardcoded: `'Regulering'` | |
| `transDato` | Date | Kørselstidspunkt | Sættes i Delphi med `FormatDateTime('dd-mm-yyyy', NOW)`. |
| `transTid` | Time | Kørselstidspunkt | Sættes i Delphi med `FormatDateTime('hh:mm:ss', NOW)`. |
| `tekst` | String | `T.BONTEXT` | |

---

## 2. Implementeringssteps

### Step 1: Udvidelse af Submodule (`BusinessCentral-Integration`)
Fil: `uBusinessCentralIntegration.pas`
1. Opret model-klasse til JSON payload: `TBCnfItemAdjustment` med tilhørende MVCFramework attributes (`[MVCNameAs]`).
2. Tilføj setup procedure i stil med eksisterende metoder:
   ```delphi
   procedure SetupPOSTnfItemAdjustments(aBusinessCentralSetup: TBusinessCentralSetup; var aBusinessCentralHTTP: TBusinessCentralHTTP; aKind: integer = 0);
   ```
*(Afventer accept for at påbegynde dette).*

### Step 2: Konfiguration (Settings.INI & INIFileEditor)
Filer: `INIFileEditor/uMain.pas`, `INIFileEditor/uMain.dfm`
1. **Genbrug af eksisterende opsætning:** Vi opretter *ikke* en ny sektion. Vi lader den eksisterende `[StockRegulation]` sektion i INI-filen køre videre, og genbruger fanen i `INIFileEditor`.
2. Vi omdøber blot evt. tekster i `INIFileEditor` (hvis nødvendigt) for at signalere, at den nu styrer den nye "nfItemAdjustments" overførsel.

### Step 3: Windows Service Logic (`UDM.pas`)
Fil: `UDM.pas`
1. **Genbrug af Query og Procedure:** SQL'en i `QFetchStockRegulationsTransactions` er allerede opdateret til at matche det ønskede `SELECT` udtræk (ART=11). Proceduren `DoSyncronizeStockRegulationTransactions` eksisterer også allerede og har sin kørelogik.
2. Vi omskriver indmaden i `DoSyncronizeStockRegulationTransactions`:
   - Vi udskifter kaldet til den gamle `kmItemAccess` API med vores nye `TBCnfItemAdjustment` og kald til endpoint `nfItemAdjustments`.
   - Data sendes **én række ad gangen** via POST-kald.
   - Datomapping for `bogfRingsDato` og de nye `transDato`/`transTid` sker præcis som i `DoSyncronizeMovementsTransactions`.
3. Vi opdaterer `DoMarkStockRegulationTransactionsAsExported` (og tilhørende query `QSetEksportedValueOnStockTrans` i `UDM.dfm`), så den opdaterer `EKSPORTERET = 1` og evt. opdaterer markeringen ud fra `TRANSID` (som vi nu har i SQL'en som primary key) i stedet for de gamle felter (`levnavn` etc., som ikke findes i den nye SQL).

### Step 4: Fejlhåndtering & Logning (`UDM.pas`)
1. Logfilen `StockRegulationstransactionErrors.txt` og logikken til at håndtere HTTP statuskode 503 er der allerede. Vi genbruger og tilpasser blot fejlteksterne, så de matcher de nye data.

### Step 5: Test UI (`uMain.pas`)
1. UI for test i `uMain.pas` indeholder allerede en knap, der igangsætter servicens hoved-timer (`DM.tiTimer.Enabled := TRUE`). Så snart vi slår `StockRegulationsTransactions=1` til i INI-filen, kører den testmæssigt. Ingen nye knapper kræves.

---

## 3. Spørgsmål til afklaring før start
*(Afklaret - data sendes en ad gangen, datomapping kører ligesom movement-transactions, og alt det eksisterende genbruges bare med indmads-opdateringer).*
