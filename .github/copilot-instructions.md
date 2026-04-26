# GitHub Copilot Repository Instructions

Use `AGENTS.md` as the primary shared instruction source for this repository.

## Skills

GitHub Copilot can use agent skills from:

- `.agents/skills`

This repository uses `.agents/skills` as the only repo-local skill source of truth. Do not recreate a GitHub-specific skill alias or copy skills into `.github`.

## Shared Workflow Map

When a request matches one of these domains, apply the corresponding workflow:

- `ckm:design`: broad design direction, brand systems, tokens, icons, slides, banners, social assets
- `ckm:brand`: brand voice, consistency, messaging framework, style guides
- `ckm:banner-design`: banners, ads, hero graphics, promotional creative
- `ckm:slides`: presentation structure, HTML slide decks, chart-led storytelling
- `ckm:ui-styling`: shadcn, Tailwind, accessibility, responsive UI polish
- `ui-ux-pro-max`: UI/UX review, layout, typography, color, motion, usability
- `find-skills`: discover a missing capability before inventing a new workflow

## Repo-Local Skill Areas

This repository also contains repo-local skill files under `.agents/skills` for:

- Next.js
- React
- Supabase
- Convex
- Tailwind
- Zustand
- shadcn/ui

Prefer those workflows when the task clearly matches the local stack.
