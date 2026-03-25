---
name: salva-idea
description: Salva un'idea di brainstorming nel vault nella sezione appropriata. Invocata esplicitamente o quando Claude rileva dal contesto che si sta buttando giù un'idea.
allowed-tools: bash, read, write, edit, glob
---

# Skill: salva-idea

## Obiettivo
Salvare idee di brainstorming in modo strutturato in agency/brainstorming/, organizzate per cliente/contesto.

## Comportamento
Semi-autonomo — deduce il contesto dal messaggio, chiede solo se il riferimento è ambiguo.

## Come viene riconosciuta un'idea
- Esplicito: "salva questa idea", "idea:", "brainstorming:", "annota questo"
- Implicito: Claude capisce dal contesto quando qualcuno sta buttando giù idee senza volerle concretizzare subito

## Dove salvare
- Cliente/progetto nel vault → agency/brainstorming/[nome-cliente].md
- Cliente non nel vault → agency/brainstorming/[nome-cliente].md con nota <!-- cliente non ancora nel vault -->
- Nessun riferimento specifico → agency/brainstorming/idee-generali.md

## Formato idea
```
## [YYYY-MM-DD] [Autore] — [Titolo breve]
**Riferimento**: [Cliente / Progetto / "Idea generale"]
**Canale**: [Discord #canale / Claude Code / claude.ai]

[Testo dell'idea]
```

## Processo
1. Identifica il riferimento (cliente/progetto/generale)
2. Se ambiguo: chiedi conferma prima di procedere
3. Se il file agency/brainstorming/[nome-cliente].md non esiste: crealo con header appropriato
4. Aggiungi l'idea in coda al file
5. Commit con messaggio: idea: [cliente/generale] - [titolo breve]

## Fuori scope
- Valutare o sviluppare le idee (solo salvarle)
- Modificare idee già salvate senza istruzione esplicita
