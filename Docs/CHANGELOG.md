# Changelog - EasyPOS To Business Central

Alle væsentlige ændringer til projektet dokumenteres i denne fil.

---

## [Unreleased] - 2025-12-18

### 🐛 Fixed - VAREFRVSTR_BC_CHANGES Trigger Bug

**Problem:** VAREFRVSTR_BC_CHANGES trigger brugte `>` i stedet for `<>` for nogle sammenligninger

**Påvirkede felter:**
- LAENGDE_NAVN (længde)
- EANNUMMER (EAN barcode)
- V509INDEX (stregkode)

**Konsekvens:** Ændringer til MINDRE værdier blev IKKE detekteret, og BC_UPDATEDATE blev ikke opdateret.

**Løsning:** Rettet alle 3 sammenligninger fra `>` til `<>` 

**Status:** ✅ Rettet og testet

---

### 📝 Documentation - P_UPDATEITEMS BC_UPDATEDATE Ændring

**Ændring:** P_UPDATEITEMS stored procedure sætter ikke længere direkte BC_UPDATEDATE.

**Detaljer:**
- P_UPDATEITEMS opdaterer nu kun vare-felter (f.eks. VARENAVN1, KATEGORI1, etc.)
- BC_UPDATEDATE opdateres **kun via VARER_BC_CHANGES trigger** når felter faktisk ændres
- Dette undgår "tomme" synkroniseringer hvor kun priser opdateres
- Intelligent trigger-baseret synkronisering

**Opdaterede dokumenter:**
- `BC_UPDATEDATE_Application_Overview.md` - Rettet Products API flow beskrivelse
- `Sync_Overview.md` - Rettet data flow diagram
- `Internal/P_UPDATEITEMS_Analysis.md` - Opdateret BC_UPDATEDATE påvirkning
- `Internal/BC_UPDATEDATE_Complete_Analysis.md` - Rettet P_UPDATEITEMS beskrivelse
- `Internal/P_UPDATEITEMS_BC_UPDATEDATE_Change.md` - Dokumenterer ændringen

**Reference:** Se `Internal/P_UPDATEITEMS_BC_UPDATEDATE_Change.md` for komplet dokumentation af ændringen.

### ✨ Added - Brugervenlig Guide

**Ny fil:** `Bruger_Guide_Vare_Synkronisering.md`

**Formål:** Enkel guide til slutbrugere om vare-synkronisering til Business Central

**Indhold:**
- Hvad synkroniseres (og hvad gør ikke)
- Hvornår sker synkronisering automatisk
- Hvordan man manuelt synkroniserer
- Typiske scenarier med eksempler
- Troubleshooting tips

**Målgruppe:** EasyPOS brugere (ikke-tekniske)

### ✅ Added - Master Database Verifikation

**Ny fil:** `Internal/BC_UPDATEDATE_MasterDB_Verification.md`

**Formål:** Verificere at kun dokumenterede triggers/procedures opdaterer BC_UPDATEDATE

**Resultat:**
- Bekræftet 3 triggers (VARER_BC_CHANGES, VAREFRVSTR_BC_CHANGES, INS_VAREFRVSTR)
- Bekræftet P_UPDATEITEMS IKKE sætter BC_UPDATEDATE direkte
- Fundet og dokumenteret bug i VAREFRVSTR_BC_CHANGES (nu rettet)
- Alle 18 overvågede felter verificeret

**Kilde:** MasterDBMetadata.sql

---

## [Unreleased] - 2025-12-09

### 🐛 Fixed - Kompileringsfejl

**Problem:** Projektet kunne ikke kompilere pga. variable scope og manglende parametre.

**Rettelser:**

1. **Variable Scope Fejl - `lRegulationTime`**
   - **Fil:** `UDM.pas`
   - **Problem:** Variabel deklareret i nested function men brugt i hoved-procedure
   - **Fix:** Flyttet `lRegulationTime: TDateTime` til procedure-niveau i `DoSyncCostPriceFromBusinessCentral`

2. **Manglende Variabel - `lStartTime`**
   - **Fil:** `UDM.pas`
   - **Problem:** Variabel brugt men ikke deklareret i `DoSyncronizeFinansCialRecords`
   - **Fix:** Tilføjet `lStartTime: TDateTime` til variabel-deklarationen

3. **Manglende Parameter - `BuildEntireURL`**
   - **Fil:** `UDM.pas`, linje 2155
   - **Problem:** Funktionen kræver parameter `aKind: integer` men blev kaldt uden
   - **Fix:** Tilføjet `LF_BC_Version` som parameter: `BuildEntireURL(LF_BC_Version)`

**Resultat:**
```
Build: SUCCESS
Warnings: 0
Errors: 0
Lines: 67,908
Duration: 4.72s
```

---

### ⚠️ Fixed - Compiler Warnings

**Problem:** 4 compiler warnings der kunne indikere potentielle runtime-fejl.

**Rettelser:**

1. **Warning H2077 - Unused value assignments**
   - **Fil:** `UDM.pas`, linje 1163 & 1170
   - **Problem:** `Result := TRUE/FALSE` assignments overskrevet af efterfølgende kode
   - **Fix:** Fjernet unødvendige assignments - `DoContinue` flag bruges i stedet

2. **Warning W1036 - Variable might not be initialized**
   - **Fil:** `UDM.pas`, linje 1194
   - **Problem:** `DoContinue` kunne teoretisk være uinitialiseret
   - **Fix:** Initialiseret `DoContinue := TRUE` ved start af loop

3. **Warning H2077 - Unused lStartTime**
   - **Fil:** `UDM.pas`, linje 1658
   - **Problem:** `lStartTime` sat men aldrig brugt
   - **Fix:** Tilføjet `LogPerformance` kald i `DoSyncronizeFinansCialRecords`

**Resultat:** Kompilering uden warnings.

---

### ✨ Enhancement - Performance Logging

**Problem:** Ikke alle synkroniseringsfunktioner loggede performance metrics.

**Implementering:**

Tilføjet `LogPerformance` kald til alle synkroniseringsfunktioner:

1. **DoSyncCostPriceFromBusinessCentral**
   - Tilføjet `lStartTime: TDateTime` variabel
   - Tilføjet `LogPerformance('DoSyncCostPriceFromBusinessCentral', lStartTime, lNumberOfCostpriceUpdates)`

2. **DoSyncronizeFinansCialRecords**
   - Tilføjet `lStartTime: TDateTime` variabel  
   - Tilføjet `LogPerformance('DoSyncronizeFinansCialRecords', lStartTime, lExportCounter)`

3. **DoSyncronizeItems**
   - Tilføjet `lStartTime: TDateTime` variabel
   - Tilføjet `LogPerformance('DoSyncronizeItems', lStartTime, lExportCounterHeadItems + lExportCounterHeadItemVariants)`

4. **DoSyncronizeSalesTransactions** ✅ (havde allerede)
5. **DoSyncronizeMovemmentsTransaction** ✅ (havde allerede)

**Fordele:**
- ✅ Konsistent performance monitoring på tværs af alle synkroniseringer
- ✅ Nemmere at identificere flaskehalse
- ✅ Bedre sporbarhed i logs

**Log format:**
```
PERFORMANCE: [Operation] completed in [Duration] seconds. Records: [Count]
```

---

### 📝 Code Quality

**Forbedringer:**
- Konsistent variable naming (alle synk-metoder har `lStartTime`)
- Korrekt variable scope (ingen nested function variable confusion)
- Elimineret alle compiler warnings
- Bedre fejlhåndtering gennem korrekt variable initialisering

---

### 🔍 Testing

**Compile Test:**
```
Platform: Win32
Config: Release
Result: SUCCESS
Duration: 4.72s
Code Size: 8,160,356 bytes
Data Size: 194,908 bytes
```

**Code Review:**
- ✅ Alle synkroniseringsfunktioner gennemgået
- ✅ Performance logging verificeret
- ✅ Variable scope kontrolleret
- ✅ Parameter lists verificeret

---

### 📚 Documentation

**Ingen ændringer nødvendige:**
- Sync_Overview.md - Beskriver allerede LogPerformance konceptet
- README.md - Generel dokumentation uændret
- BC_UPDATEDATE_Application_Overview.md - Ikke påvirket

**Note:** Ændringerne er primært interne fejlrettelser og forbedringer der ikke påvirker ekstern funktionalitet eller brugeroplevelse.

---

## Version Info

**Før dagens ændringer:**
- Status: Compilation fejl
- Warnings: 4
- Performance logging: Delvist implementeret

**Efter dagens ændringer:**
- Status: ✅ Kompilerer perfekt
- Warnings: 0
- Performance logging: ✅ Fuldt implementeret

---

## Dependencies

**Ingen nye dependencies tilføjet**
- Firebird SQL version: Uændret
- Delphi version: 13.1
- Business Central API: Uændret

---

## Breaking Changes

**Ingen breaking changes**
- API kompatibilitet: ✅ Bevaret
- Database schema: ✅ Uændret
- INI fil format: ✅ Uændret
- Log fil format: ✅ Uændret (kun ny performance linje)

---

## Migration Notes

**Ingen migration nødvendig**

Projektet kan deployes direkte som drop-in replacement.

---

## Contributors

- GitHub Copilot CLI - Code fixes and enhancements
- Initial codebase - Existing EasyPOS development team

---

## See Also

- [SECURITY_FIXES.md](SECURITY_FIXES.md) - Tidligere sikkerhedsfixes (december 2025)
- [Sync_Overview.md](Sync_Overview.md) - Synkroniserings oversigt
- [README.md](README.md) - Projekt hovedoversigt

---

**Changelog Format:** Baseret på [Keep a Changelog](https://keepachangelog.com/)  
**Versioning:** Baseret på build dates og semantic versioning principles
