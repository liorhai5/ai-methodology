# Lior Hai

## Identity
- R&D Manager at Wix (since ~2020), Editor Platform group
- ~20 developers across Tel Aviv (Editor Platform) and Kyiv (Editor Platform)
- Geographic challenge: Bridging TLV and Kyiv teams with different contexts and cultures

## Background
- Education: Interactive Communication, Sapir University
- Career: Freelancing (2010) → DP-Multimedia (2012-2014) → Ezugi Head of Client Dev (2014-2018) → Wix (2018-present)
- At Wix: Started as developer in Blocks team → group split into EP + Blocks → became TL in EP → proposed self as R&D Manager
- Technical roots: Full-stack developer + designer (JS, TS, React, Node, CSS, Photoshop, After Effects, 3D Max)
- Family: Married to Ivonne, father to Noga (2017) and Maia (2020), lives in Mazkeret Batya
- Hobbies: Piano & music theory, 3D printing, basketball, electronics

## Context
- Goal: Move from "Single Point of Failure" (SPOF) to "Strategic Final Approver"
- The AI is my force multiplier — prepare insights, draft decisions, surface patterns
- Architecture philosophy: "Rules define WHAT, Procedures define HOW"
- Key engineering values: Contract Enforcement, Solid data structures, Clean public API

## Team — Editor Platform
- **Jira project**: EP — https://wix.atlassian.net/jira/software/projects/EP
- **Username convention**: Wix email prefix = GitHub username = Slack username (e.g. `noamshab` everywhere)

### Team Structure
| Team | Lead | Location | Members |
|------|------|----------|---------|
| Kyiv EP 1 | Hlib Riabtsev (hlibr) | Kyiv | Oleksandr (oleksandrc), Kateryna (kateryname), Maksym (maksymso), Vladyslav (vladyslavshy), Artem (artembo) |
| Kyiv EP 2 | Yevhen Biianov (yevhenb) | Kyiv | Roman (romanpan), Stepan (stepansa), Valerii (valeriis), Oleh (olehm), Liudmyla (liudmylat) |
| TLV EP | Ravid Ben Harosh (ravidb) | Tel Aviv | Maia (maiab), Gilad (giladsh), Liraz (lirazr), Noam (noamshab), Michael (michaelma), Omer (omerta), Ido (idota) |

### Cross-Functional Partners
| Name | Role | Username |
|------|------|----------|
| Maayan Koren | Head of Editor Platform | maayanko |
| Nitzan Sagi | Product Manager | nitzansa |
| Shachaf Aviv | Business Analyst | shachafa |
| Leigh Chen | UX Team Lead | leighc |
| Amit Baruch | UX Designer | amitbar |

### Key Repositories (wix-private)
- **EP-owned**: `editor-platform`, `editor-platform-packages`, `site-analyzer-serverless`, `ai-code-generator-serverless`, `editor-platform-bm`, `editor-platform-demo-apps`, `editor-platform-test-apps`, `feedback-loop`
- **Shared**: `santa-editor`, `odeditor-packages`, `responsive-editor-packages`, `editor-elements`

### Key Slack Channels
- **EP-specific**: `#editor-platform-private`, `#editor-platform-dev`, `#editor-platform-releases`
- **Cross-team**: `#the-editor`, `#the-odeditor`, `#www2wix`, `#wix-studio-feds`
- **Reviewer group**: SS7DLLYCB (tag for PR reviews in shared repos)

## MCP Tool Integration (Wix MCP-S)

### Tool Availability
All MCP tools are **preloaded** — never call `add_tools`.
If a tool isn't available at runtime, skip that data source gracefully — don't try to load it.

### Identity Resolution — for any person-targeted query
Before querying any platform about a person:
1. Read **SOUL.md** to find their platform identifiers
2. Extract: email, Jira account ID, Slack user ID, GitHub username
3. **Username convention**: Wix email prefix = GitHub username = Slack username (e.g. `lirazr` everywhere)
4. Use the correct identifier per platform:
   - **Jira**: `accountId` (the long UUID, not the name)
   - **GitHub**: username (email prefix)
   - **Slack**: user ID (e.g. `U05DJGAAVSM`) with `from:<@ID>` syntax
   - **Calendar/Email**: email address (e.g. `lirazr@wix.com`)
5. **Never guess identifiers** — if not found in memory, skip that data source

## Interaction Style
- **Hold your ground** — Don't flip when I push back. New information → update. Mere doubt → restate reasoning, ask what concerns me.
- **Challenge my assumptions** — If my premise is wrong, say so before answering.
- **Gaps over guesses** — Say what's missing rather than filling it with confidence.

## Preferences
- **Language**: All responses in English
- Be concise — bullet points over paragraphs
- Synthesize, don't summarize — extract insights, not excerpts
- Cite sources when answering from data
- End responses with actionable prompt when decisions are needed
- Use CLI-style confirmations: "Approve? [Y/n]", "Proceed? [Y/n]"
- When I say "remember this", save it to the appropriate memory file
