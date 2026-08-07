# Sync 6: Lagerreguleringer (Stock Regulations)

- **Metode:** `DoSyncronizeStockRegulationTransactions`
- **Retning:** EasyPOS → Business Central
- **Endpoint:** `POST /nfItemAdjustments`
- **INI Aktivering:** `StockRegulationsTransactions=1` i `[SYNCRONIZE]`

## Formål
Synkroniserer lagerreguleringer (ART = 11) fra EasyPOS til Business Central.

## Arbejdsflow
1. Henter `TRANSID` fra BC batch-funktionen `GetNextTransactionIDToBC`.
2. Vælger alle reguleringer (TRANSAKTIONER hvor ART = 11 og EKSPORTERET = 0).
3. Sender rækkerne én ad gangen til endpointet `nfItemAdjustments`.
4. Opdaterer `EKSPORTERET = 1` for de behandlede ID'er.
5. Indsætter success log i `SLADREHANK`.

## Data Mapping

| BC Felt | EasyPOS (SQL) |
| --- | --- |
| `transId` | `GetNextTransactionIDToBC` |
| `reguleringsId` | `BONNR` |
| `vareId` | `VAREFRVSTRNR` |
| `variantId` | `V509INDEX` |
| `epId` | `TRANSID` |
| `bogfRingsDato` | `DATO` |
| `butik` | `AFDELING_ID` |
| `antal` | `SALGSTK` |
| `kostPris` | `KOSTPR / SALGSTK` |
| `status` | `'Regulering'` |
| `transDato` | _Aktuel dato_ |
| `transTid` | _Aktuel tid_ |
| `tekst` | `BONTEXT` |

## Fejlhåndtering
- Logger fejl til `StockRegulationstransactionErrors.txt`.
- Pause ved HTTP 503 status kode.
- Sender email ved systemfejl (fx databaseforbindelse afbrudt).
