# EasyPOS To Business Central - Dokumentation

Denne mappe indeholder brugervenlig dokumentation for EasyPOS-BC integrationsprojektet.

**📁 Teknisk/udviklerdokumentation findes i [Internal/](Internal/) mappen.**

---

## 📚 Bruger Dokumentation

### Hovedoversigt

| Dokument | Beskrivelse | Målgruppe |
|---|---|---|
| **[Bruger_Guide_Vare_Synkronisering.md](Bruger_Guide_Vare_Synkronisering.md)** | 🌟 **START HER!** Simpel guide til vare-synkronisering | Brugere |
| **[Projekt_Analyse.md](Projekt_Analyse.md)** | Komplet projektanalyse | Support, Admin |
| **[Sync_Overview.md](Sync_Overview.md)** | Oversigt over alle synkroniseringer | Support, Admin |
| **[BC_UPDATEDATE_Application_Overview.md](BC_UPDATEDATE_Application_Overview.md)** | Hvordan BC_UPDATEDATE virker på tværs af applikationer | Support, Udviklere |
| **[CHANGELOG.md](CHANGELOG.md)** | Versionshistorik og ændringer | Udviklere, Admin |
| **[SECURITY_FIXES.md](SECURITY_FIXES.md)** | Sikkerhedsfixes (december 2025) | Udviklere, Security |

---

## 🔧 Teknisk Dokumentation

**Placering:** [Internal/](Internal/) mappen

### Synkroniseringer (Detaljeret SQL & Kode)

| # | Dokument | Modul | Retning | Status |
|---|---|---|---|---|
| 1 | [TECH_Sync_Items.md](TECH_Sync_Items.md) | Varer | EP → BC | ✅ Aktiv |
| 2 | [TECH_Sync_Sales.md](TECH_Sync_Sales.md) | Salgstransaktioner | EP → BC | ✅ Aktiv |
| 3 | [TECH_Sync_Movements.md](TECH_Sync_Movements.md) | Flytningstransaktioner | EP → BC | ✅ Aktiv |
| 4 | [TECH_Sync_Financial.md](TECH_Sync_Financial.md) | Finansposter | EP → BC | ✅ Aktiv |
| 5 | [TECH_Sync_Costprice.md](TECH_Sync_Costprice.md) | Kostpriser | **BC → EP** | ✅ Aktiv |
| 6 | [TECH_Sync_StockRegulations.md](TECH_Sync_StockRegulations.md) | Lagerreguleringer | EP → BC | ✅ Aktiv |

### BC_UPDATEDATE Analyser (Database & Triggers)

*Tidligere analyse-filer er arkiveret/slettet.*

---

## 🚀 Quick Start

### For Brugere

1. **Forstå systemet:** [Projekt_Analyse.md](Projekt_Analyse.md)
   - Hvad gør programmet?
   - Hvad synkroniseres?
   - Hvordan kører det?

2. **Forstå BC_UPDATEDATE:** [BC_UPDATEDATE_Application_Overview.md](BC_UPDATEDATE_Application_Overview.md)
   - Hvordan markeres varer til synkronisering?
   - Hvordan forcer jeg en vare til BC?
   - Hvilke ændringer trigger synkronisering?

3. **Fejlfinding:** [Sync_Overview.md](Sync_Overview.md#fejlfinding-guide)
   - Vare synkroniseres ikke
   - Service fejl
   - Log kontrol

### For Udviklere/Support

1. **Start:** [Sync_Overview.md](Sync_Overview.md)
   - Alle synkroniseringer på ét sted
   - Kørselsrækkefølge
   - Fælles mønstre

2. **Tekniske detaljer:** TECH_Sync_*.md filerne
   - SQL queries
   - Data mapping
   - API calls
   - Fejlhåndtering

3. **Konfiguration:** [Sync_Overview.md](Sync_Overview.md#ini-fil-konfiguration)

---

## 📖 Læsevejledning

### For Brugere (Ikke-tekniske)

**Rækkefølge:**
1. Projekt_Analyse.md → Hvad systemet gør
2. BC_UPDATEDATE_Application_Overview.md → Hvordan varer synkroniseres
3. Sync_Overview.md → Monitoring og fejlfinding

**Focus områder:**
- Hvad gør de forskellige synkroniseringer?
- Hvordan markerer jeg en vare til BC?
- Hvad skal jeg gøre ved fejl?

### For Systemadministratorer

**Rækkefølge:**
1. Projekt_Analyse.md → Deployment og sikkerhed
2. Sync_Overview.md → Konfiguration og performance
3. BC_UPDATEDATE_Application_Overview.md → Bruger support

**Focus områder:**
- INI fil konfiguration
- Logfiler og placering
- Email notifikationer
- Performance tuning
- Backup procedurer

### For Udviklere/Support

**Rækkefølge:**
1. Sync_Overview.md → Fælles patterns og oversigt
2. Internal/BC_UPDATEDATE_Complete_Analysis.md → Database detaljer
3. Internal/Sync_X_*.md → Specifik synkronisering

**Focus områder:**
- SQL queries
- Data mapping tabeller
- Fejlhåndtering patterns
- Business Central API calls
- Trigger implementeringer

---

## 🔍 Hurtig Reference

### Vigtige Koncepter

| Koncept | Forklaring | Se |
|---|---|---|
| Transaction ID | Unikt ID per synk | Projekt_Analyse.md |
| EKSPORTERET flag | Markering af synk status | Alle Sync_X docs |
| Last run | INI timestamp for sidste succes | Sync_Overview.md |
| Batch processing | 200 records ad gangen (kostpris) | Sync_5_Costprice_From_BC.md |
| PostType mapping | Finans/Debitor/Bank | Sync_4_Financial.md |
| Valuta konvertering | DKK → lokal | Sync_5_Costprice_From_BC.md |

### Database Tabeller

| Tabel | Formål | Brugt af |
|---|---|---|
| TRANSAKTIONER | Alle transaktioner | Sales, Movements, (Stock) |
| VARER | Hovedvarer | Items, Costprice |
| VAREFRVSTR | Varianter | Items, Sales, Movements |
| VAREFRVSTR_DETAIL | Afdelings-priser/lager | Items, Costprice |
| POSTERINGER | Finansposter | Financial |
| SLADREHANK | Tracing log | Alle |
| WEB_SLADREHANK | Proces log | Costprice |

### Business Central Endpoints

| Endpoint | Retning | Metode | Brugt af |
|---|---|---|---|
| kmItem | EP → BC | POST | Items (varer + varianter) |
| kmItemSale | EP → BC | POST | Sales |
| kmItemMove | EP → BC | POST | Movements |
| kmCashstatement | EP → BC | POST | Financial |
| kmCostprice | BC → EP | GET | Costprice |
| kmItemAccess | EP → BC | - | (Stock - deaktiveret) |

### Event Log IDs

| ID | Modul | Type |
|---|---|---|
| 1000 | Generel | Error |
| 3101-3103 | Items | Error |
| 3201-3203 | Sales | Error |
| 3301-3303 | Movements | Error |
| 3402-3403 | Financial | Error |
| 3503 | Costprice | Error |

---

## 📝 Dokument Struktur

Alle `Sync_X` dokumenter følger samme struktur:

```markdown
# Titel
- Metode navn
- Retning
- API endpoint
- INI aktivering

## Formål
Hvad gør modulet?

## Arbejdsflow
Step-by-step proces

## SQL Queries
Alle queries med parametre

## Data Mapping
Felt-til-felt mapping

## Business Central API Calls
Request/Response eksempler

## Konfiguration
INI fil settings

## Tracing Log
SLADREHANK struktur

## Fejlhåndtering
Logfiler, error scenarios, email

## Specielle Situationer
Edge cases

## Performance
Optimering og timing

## Debug Tips
Praktiske råd

## Dependencies
Tabeller, procedures, etc.

## Changelog
Versionshistorik
```

---

## ⚠️ Vigtige Advarsler

### Kostpris Synkronisering

**KRITISK:** Manipulerer direkte med lagerbeholdning!

Se [Sync_5_Costprice_From_BC.md](Sync_5_Costprice_From_BC.md#risici-og-advarsler) for detaljer.

### Lagerreguleringer

**AKTIVERET:** Modulet synkroniserer nu lagerreguleringer til `nfItemAdjustments`.

### Passwords i INI

**SIKKERHED:** Plain text passwords!

Se [Projekt_Analyse.md](Projekt_Analyse.md#10-sikkerhed) for anbefalinger.

---

## 🔄 Opdatering af Dokumentation

### Når Kode Ændres

1. Opdater relevant `Sync_X` dokument
2. Opdater `Changelog` sektion
3. Review `Sync_Overview.md` for globale ændringer
4. Opdater denne README hvis struktur ændres

### Når Ny Synkronisering Tilføjes

1. Opret nyt `Sync_7_[Navn].md` dokument
2. Følg eksisterende struktur
3. Tilføj til tabel i denne README
4. Opdater `Sync_Overview.md`
5. Tilføj til `Projekt_Analyse.md` hvis relevant

### Dokumentations Standard

- **Sprog:** Dansk (som eksisterende kode-kommentarer)
- **Format:** Markdown
- **Kode blokke:** SQL, Pascal, JSON
- **Tabeller:** For data mapping
- **Emojis:** Kun i headings (✅❌⚠️)

---

## 📞 Support

### Ved Dokumentations-fejl

- Kontakt systemadministrator
- Eller opdater selv og commit changes

### Ved Tekniske Problemer

Se [Sync_Overview.md](Sync_Overview.md#support-kontakter)

---

## 📜 Licens og Copyright

Dette er intern dokumentation for EasyPOS to Business Central integration.

**Fortrolighed:** Indeholder kunde-specifikke oplysninger.

---

## 🎯 Roadmap

**Planlagte opdateringer:**

- [ ] API authentication flow diagram
- [ ] Sequence diagrams per synkronisering
- [ ] Database ER diagram
- [ ] Troubleshooting decision tree
- [ ] Performance benchmarks

---

**Sidst opdateret:** 2025-12-09  
**Dokumentation version:** 1.1  
**Software version:** Se build info i EXE  
**Seneste ændringer:** Se [CHANGELOG.md](CHANGELOG.md)

---

## Hurtig Navigation

- [← Tilbage til projekt rod](../)
- [Projekt Analyse →](Projekt_Analyse.md)
- [Synkroniserings Oversigt →](Sync_Overview.md)
