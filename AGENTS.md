# Slide maintenance

Read PUBLIC_CONTENT_GUIDELINES_zh-TW.md and README.md before editing this guide.
The guidelines are a generated copy of the common /web root policy.
Keep its neutral sharing tone, current-state wording and source/evidence rules.

- This page owns Tool operation, MCU host, Custom Transfer and update workflows.
- Edit the canonical Tool docs first; use their sync scripts and -CheckOnly.
- Preserve stable anchors and use short links to device-development topics.
- index.md is a short overview. Tool scripts/web_guide_layout.json owns full
  chapter destinations;sync scripts must not recreate a monolithic homepage.
  Preserve guide-map.json legacy aliases and refresh guide-routes.js. Flat
  HTML/MD chapters retain existing assets;the shared renderer must be deployed
  with the guides. Canonical PDF content/old root deep links remain valid.
- Keep page-owned ISP_MODE_NAV categories explicit:Classical F13/F24,CAN FD
  F24,and Custom Transfer across all three examples. Preserve chapter links.
- Update affected PDFs; keep commands, byte values and safety gates unchanged
  during editorial changes. Do not rebuild firmware or bump the Tool version.
- Never infer Git publication or hardware acceptance from local synchronization.
- Run scripts/verify_local.ps1 with -ToolRoot for cross-page checks.
