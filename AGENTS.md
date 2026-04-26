# Shared Agent Instructions

This repository is set up to share one instruction source across Claude, Codex, OpenCode, and GitHub Copilot.

## Compatibility

- Claude Code: reads `CLAUDE.md` and can use skills from `.claude/skills` and `~/.claude/skills`.
- Codex: reads `AGENTS.md` and can use skills from `.agents/skills` and `$HOME/.agents/skills`.
- OpenCode: reads `AGENTS.md` and can use skills from `.opencode/skills`, `.claude/skills`, `.agents/skills`, and matching home-level locations.
- GitHub Copilot: uses `AGENTS.md`, `.github/copilot-instructions.md`, and references project agent skills from `.agents/skills`. Its personal skill location is `~/.copilot/skills`.

## Shared Skill Sources On This Machine

The custom Claude-installed skills already exist as shared user-level skills:

- `~/.claude/skills`
- `~/.agents/skills`

On this machine, `~/.claude/skills` is symlinked to `~/.agents/skills`, so the same custom skill content is already available to Claude, Codex, and OpenCode without copying files between tool folders.

In this repository, `.agents/skills` is the only content-bearing repo-local skill tree. Platform-specific skill paths for tools that need them are aliases to that directory, not separate copies:

- `.claude/skills` -> `../.agents/skills`
- `.codex/skills` -> `../.agents/skills`
- `.opencode/skills` -> `../.agents/skills`

Do not copy skill folders into those platform directories. Keeping the tool-specific aliases minimal prevents drift between platforms and avoids duplicate command definitions from separately maintained skill trees. Copilot uses `.agents/skills` directly; do not recreate a GitHub-specific skill alias.

## Use These Skills When Relevant

These custom skills are available on this machine and should be preferred when the task matches:

- `ckm:design`: broad design work, brand, tokens, UI styling, icons, banners, presentations, social assets
- `ckm:brand`: brand voice, visual identity, messaging, asset standards
- `ckm:banner-design`: social, ad, web hero, and print banners
- `ckm:slides`: presentation strategy and HTML slide creation
- `ckm:ui-styling`: shadcn, Tailwind, accessible UI styling, component polish
- `ui-ux-pro-max`: UI/UX design review, visual systems, layout, typography, accessibility, motion
- `find-skills`: discover additional installable skills when a capability is missing

## Project Skills

This repository also contains repo-local skills under `.agents/skills`. Prefer those when the task is specific to the local stack, including:

- Next.js
- React
- Vite React
- TanStack Start
- Supabase
- Convex
- Tailwind
- Zustand
- shadcn/ui

## Commands

These workflow commands are available as skills in `.agents/skills/`. Load and follow the corresponding skill when a request matches:

| Command     | Trigger                                                | Skill path                          |
| ----------- | ------------------------------------------------------ | ----------------------------------- |
| `ask`       | Refine a prompt, minimize tokens before planning       | `.agents/skills/ask/SKILL.md`       |
| `bug`       | Generate a structured bug report for an issue          | `.agents/skills/bug/SKILL.md`       |
| `plan`      | Convert a request into a plan with acceptance criteria | `.agents/skills/plan/SKILL.md`      |
| `todo`      | Generate an implementation-ready TODO checklist        | `.agents/skills/todo/SKILL.md`      |
| `tdd`       | Toggle test-first workflow mode with `on` or `off`     | `.agents/skills/tdd/SKILL.md`       |
| `implement` | Execute a todo file end-to-end                         | `.agents/skills/implement/SKILL.md` |
| `test`      | Generate and run tests from a task file                | `.agents/skills/test/SKILL.md`      |
| `commit`    | Create atomic Conventional Commits from active changes | `.agents/skills/commit/SKILL.md`    |

Each skill delegates to the canonical definition in `.ai/commands/<name>.md`.

### Cross-Tool Command Wrappers

Command wrappers in `.github/prompts/` are intentionally not used in this repository to avoid duplicate slash-command entries in Copilot. Use skill commands from `.agents/skills/<name>/SKILL.md` as the single invocation source.

## Repo Convention

- Keep shared project skills in `.agents/skills`.
- Keep `.agents/skills` as the single repo-local skill source.
- Keep `.claude/skills`, `.codex/skills`, and `.opencode/skills` as symlink aliases to `.agents/skills`.
- Do not recreate a GitHub-specific skill alias; Copilot should reference `.agents/skills` directly.
- Use `AGENTS.md` for shared always-on instructions.
- Use `.github/copilot-instructions.md` only for Copilot-specific guidance that should not live in `AGENTS.md`.

## Editing Guidance

- Keep cross-platform agent instructions in `AGENTS.md`.
- Keep `CLAUDE.md` as a thin wrapper around `AGENTS.md`.
- Keep Copilot-specific guidance in `.github/copilot-instructions.md`.
- Do not duplicate the same workflow text across `.claude`, `.codex`, `.github`, and `.opencode` unless a platform requires its own config format.

---

## Developer Preferences & Standards

### Stack & Core Packages

- **Supported app stacks:** Next.js App Router, Vite React, and Vite React with TanStack Start. Pick the stack that matches the existing project; do not migrate frameworks unless explicitly asked.
- **UI library:** `shadcn/ui` is the primary component foundation. `coss`, `motion-primitives`, and `framer-motion` handle motion and transitions.
- **Styling:** Tailwind CSS v4. Use `TweakCN` for theme token updates and `globals.css` changes.
- **State management:** `Zustand` for shared client state. Built-in React state for local UI state.
- **Data fetching:** `TanStack Query` for server-state, native `fetch` or API routes for one-off calls. Choose based on use case.
- **Backend/database:** `Supabase` for auth and CRUD-heavy apps; `Convex` for real-time features. Either or both may be present in a project.
- **Authentication:** `Supabase Auth` when using Supabase; `Clerk` when using Convex.
- **AI SDK:** `Vercel AI SDK` by default. In Next.js, use App Router API routes. In Vite React, use a separate API route/server endpoint. In TanStack Start, use server functions or API routes based on whether the endpoint is internal or externally consumed.

### Next.js Conventions

- **Version & Router:** Next.js 16 with App Router.
- **proxy.ts not middleware.ts:** Use `proxy.ts` for request interception. Do not use `middleware.ts`.
- **Server vs. client components:** Default to Server Components. Add `"use client"` only when state, effects, browser APIs, or client-only libraries require it.
- **Server Actions:** Avoid. Prefer API routes, especially for third-party integrations and full-stack workflows.
- **Route groups:** Use `(public)`, `(auth)`, `(protected)`, and `(admin)` to organize access boundaries.
- **Folder structure:**

```text
my-app/
├─ app/
│  ├─ (public)/
│  │  ├─ page.tsx
│  │  ├─ pricing/page.tsx
│  │  └─ about/page.tsx
│  ├─ (auth)/
│  │  ├─ login/page.tsx
│  │  ├─ sign-up/page.tsx
│  │  └─ callback/page.tsx
│  ├─ (protected)/
│  │  ├─ dashboard/page.tsx
│  │  ├─ settings/page.tsx
│  │  └─ layout.tsx
│  ├─ (admin)/
│  │  ├─ users/page.tsx
│  │  └─ layout.tsx
│  ├─ api/
│  │  ├─ auth/
│  │  │  ├─ session/route.ts
│  │  │  └─ sign-out/route.ts
│  │  ├─ profile/route.ts
│  │  ├─ uploads/route.ts
│  │  ├─ ai/
│  │  │  ├─ chat/route.ts
│  │  │  └─ tools/route.ts
│  │  └─ webhooks/
│  │     ├─ clerk/route.ts
│  │     └─ supabase/route.ts
│  ├─ globals.css
│  ├─ layout.tsx
│  ├─ loading.tsx
│  ├─ not-found.tsx
│  └─ favicon.ico
├─ components/
│  ├─ ui/
│  ├─ shared/
│  ├─ forms/
│  ├─ data-display/
│  └─ providers/
├─ hooks/
│  ├─ use-mobile.ts
│  ├─ use-debounce.ts
│  ├─ use-auth-user.ts
│  └─ use-realtime-status.ts
├─ lib/
│  ├─ utils.ts
│  ├─ constants.ts
│  ├─ env.ts
│  ├─ fetcher.ts
│  ├─ errors.ts
│  ├─ auth/
│  ├─ react-query/
│  ├─ supabase/
│  └─ convex/
├─ convex/
│  ├─ _generated/
│  ├─ auth.config.ts
│  ├─ http.ts
│  ├─ schema.ts
│  ├─ users.ts
│  └─ messages.ts
├─ drizzle/
│  ├─ db.ts
│  ├─ migrations/
│  └─ schemas/
│     ├─ auth.schema.ts
│     ├─ profile.schema.ts
│     └─ ai.schema.ts
├─ public/
│  ├─ images/
│  ├─ icons/
│  └─ fonts/
├─ types/
│  ├─ globals/env.d.ts
│  ├─ api.ts
│  ├─ database.ts
│  └─ auth.ts
├─ drizzle.config.ts
├─ .env.local
├─ .env.example
├─ components.json
├─ next.config.ts
├─ package.json
└─ tsconfig.json
```

### Vite React Conventions

- **Build tool:** Use Vite with React and TypeScript. Prefer `vite.config.ts`, ESM config, and `@vitejs/plugin-react`.
- **App shape:** Put application source under `src/`. Use `src/main.tsx` for the browser entry, `src/App.tsx` for the root app shell, and `src/routes/` only when a router is installed.
- **Routing:** Use TanStack Router for non-Next React routing when route-level data loading or nested layouts are needed. Keep simple apps on component-level state and composition.
- **Environment variables:** Use `VITE_` for browser-exposed variables. Keep secrets out of Vite client env and route secret-backed work through server endpoints.
- **Static assets:** Use `public/` for unchanged static files and imported assets under `src/assets/` when Vite should fingerprint them.
- **Path aliases:** Configure `@/*` to `./src/*` in both `vite.config.ts` and `tsconfig.json`.

### TanStack Start Conventions

- **Framework:** Use TanStack Start when the project needs full-stack Vite React with SSR, file-based routing, server functions, and deployable server/runtime integration.
- **Routing:** Use `src/routes/` with TanStack Router conventions. Keep `src/routeTree.gen.ts` generated and do not edit it manually.
- **Server functions:** Use `createServerFn` for internal server-side reads and mutations. Validate inputs with Zod and keep secrets server-side.
- **API routes:** Use route files for webhooks, third-party callbacks, and externally consumed HTTP endpoints. Keep server functions for app-internal workflows.
- **Entries and config:** Keep `src/client.tsx`, `src/ssr.tsx`, `src/router.tsx`, and `vite.config.ts` aligned with the TanStack Start plugin setup.
- **Deployment:** Follow the active adapter/runtime in the project. For Cloudflare Workers, keep runtime config in `wrangler.jsonc`, use `.dev.vars` for local secrets, and avoid committing generated or local runtime output.

### TypeScript & Code Style

- **Strict mode:** `strict: true` in tsconfig.
- **`interface` vs `type`:** Use `interface` for component props and extendable contracts. Use `type` for unions, aliases, database shapes, and domain/service objects.
- **Validation:** Use `Zod` at all data boundaries — forms, API routes, server functions, query params, tool inputs.
- **Linting/formatting:** ESLint + Prettier.
- **Path aliases:** Always use `@/` aliases (`@/components`, `@/lib`, etc.). No relative imports across feature boundaries.

### Component Patterns

- **Exports:** Named exports for components. Default exports for pages, layouts, and templates. Named exports for utility functions.
- **Hooks and types:** Keep in separate files or folders. Do not colocate everything in a single component file.
- **Forms:** Keep form logic inside the relevant feature folder.
- **Styling:** Tailwind utility classes first. Use a shared `cn()` utility built from `clsx` + `tailwind-merge`. Avoid CSS Modules unless there is a specific reason.

### AI Workflow

- **Model strategy:** Model-agnostic setup. Optimize for Claude- and GPT-class models first, with room to swap providers later.
- **Streaming:** Stream by default. Pattern: `streamText` in a server endpoint or server function, `useChat` or a custom transport on the client, both via Vercel AI SDK.
- **API keys:** `.env.local` for all secrets in local development. Use `.env` only for non-secret shared defaults. Real secrets go in `.env.local` or deployment platform env settings.
- **Tool use / function calling:** Server-controlled execution through API routes, server endpoints, or server functions. Zod schemas for all tool inputs. Typed responses. Clear separation between orchestration, tool handlers, and UI rendering.

### Testing & Quality

- **Testing:** Optional. Ask before defaulting to TDD — it significantly increases scope and implementation time.
- **TDD workflow mode:** Controlled by `.ai/config/workflow-mode.md` using `TDD_MODE: on|off` (default `off`).
- **Accessibility:** Required. Apply ARIA attributes, keyboard navigation, performance optimization, and SEO best practices in every app.

### Things to Avoid

- Do not add comments unless the logic is genuinely non-obvious.
- Do not use `any`. Use proper TypeScript types throughout.
- Do not wrap everything in `try/catch`. Reserve it for API routes, external integrations, and cases that actually need error recovery.
- Do not invent mock data. Use `json-server` when a mock is appropriate, or implement the real flow through API routes and actual app logic.

### Notes

- Supabase env vars: use `NEXT_PUBLIC_SUPABASE_URL` and `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY` in Next.js; use `VITE_SUPABASE_URL` and `VITE_SUPABASE_PUBLISHABLE_KEY` in Vite React or TanStack Start client code. Keep `DATABASE_URL` server-only.
- Next.js 16: use `proxy.ts`, not `middleware.ts`.
- Vite client env vars must use the `VITE_` prefix and must not contain secrets.
- TanStack Start projects should use server functions for app-internal server work and API routes for external HTTP integrations.

### References

- [Next.js Proxy](https://nextjs.org/docs/app/getting-started/proxy)
- [Next.js env files](https://nextjs.org/docs/pages/guides/environment-variables)
- [Vercel AI SDK with Next.js App Router](https://ai-sdk.dev/docs/getting-started/nextjs-app-router)
- [AI SDK `useChat`](https://ai-sdk.dev/docs/reference/ai-sdk-ui/use-chat)
- [AI SDK tool usage](https://ai-sdk.dev/docs/ai-sdk-ui/chatbot-tool-usage)
- [Supabase Next.js quickstart](https://supabase.com/docs/guides/getting-started/quickstarts/nextjs)
- [Vite React](https://vite.dev/guide/)
- [TanStack Start](https://tanstack.com/start/latest)

---

## Architecture

### Component Structure (Pragmatic, Not Doctrinaire)

- Not a strict 5-level atomic design hierarchy. The structure is responsibility-based, not atomic-purity-based.
- Routing and layout live under the framework router: `app/` for Next.js, `src/routes/` for TanStack Start, and the configured router location for Vite React. Reusable UI lives under `components/{ui,shared,forms,data-display,providers}` or `src/components/{ui,shared,forms,data-display,providers}` depending on the project root.
- Framework layout files serve as the "template" tier — no separate design-system template layer needed.
- Atoms may depend on other atoms when it makes sense. The boundary is responsibility, not atomic level.
- No mandated compound component pattern. Named exports are the default. Dot-notation APIs (`Card.Header`) are opt-in only when the component family justifies it.
- Variant handling: `shadcn/ui` primitives + Tailwind + `cn()`. Use structured variants (e.g., CVA) for reusable primitives with multiple states; inline Tailwind conditionals for one-off cases.
- No Storybook requirement. Tests are optional and not colocated by default.

### Data & State Layer

- Strict separation: TanStack Query (server/remote state) → Zustand (shared client state) → React `useState` (local UI state) → `fetch` + API routes (one-off calls).
- A light data-access layer is implied by folder structure: `lib/react-query/`, `lib/supabase/`, `lib/convex/`, `app/api/`, `src/lib/`, `src/server/`, and `src/routes/api/` as applicable. Network and database calls belong in these layers, not in presentational components.
- No formal repository pattern required.
- No mandated API response envelope. The real requirements are: Zod validation at boundaries + fully typed responses.

### Error & Loading Architecture

- Route-level baseline: use framework-native loading and not-found patterns, such as `app/loading.tsx` and `app/not-found.tsx` in Next.js or route-level pending/error/not-found handling in TanStack Router and TanStack Start.
- Shared error utilities centralized in `lib/errors.ts`.
- `try/catch` only where recovery actually matters — API routes and external integrations. Do not wrap internal logic or framework calls.
- No repo-wide Suspense mandate. Rely on framework-native route loading; add component-level Suspense/error boundaries only where targeted.

### Routing & Layout

- Route groups or route layout files define structural access boundaries: `(public)`, `(auth)`, `(protected)`, and `(admin)` in Next.js; pathless layout routes such as `_auth` or `_protected` in TanStack Router/Start.
- Per-boundary nested layouts are expected for protected and admin areas.
- Parallel routes, intercepting routes, and overlay route patterns are **opt-in only** for modal/overlay UX patterns — not part of baseline routing architecture.

### Module Boundaries

- `@/` path aliases are required throughout. No relative imports across feature boundaries.
- Cross-feature sharing goes through `components/shared/`, `components/ui/`, or `lib/*` — never by reaching into another feature's internals directly.
- Barrel files (`index.ts`) are optional. Prefer direct named imports from specific files unless a public module surface is genuinely useful.

### Performance

- In Next.js, Server Components are the default and the primary performance lever. Add `"use client"` only when required.
- In Vite React and TanStack Start, keep client bundles small with route-level splitting, framework-native lazy loading, and server-side work where the framework supports it.
- Images: use `next/image` in Next.js. In Vite React and TanStack Start, use optimized static assets or an image pipeline appropriate to the host. Always provide dimensions or stable aspect ratios and avoid layout shift.
- No additional lazy-loading conventions beyond what the active framework provides by default.

<!-- code-review-graph MCP tools -->

## MCP Tools: code-review-graph

**IMPORTANT: This project has a knowledge graph. ALWAYS use the
code-review-graph MCP tools BEFORE using Grep/Glob/Read to explore
the codebase.** The graph is faster, cheaper (fewer tokens), and gives
you structural context (callers, dependents, test coverage) that file
scanning cannot.

### When to use graph tools FIRST

- **Exploring code**: `semantic_search_nodes` or `query_graph` instead of Grep
- **Understanding impact**: `get_impact_radius` instead of manually tracing imports
- **Code review**: `detect_changes` + `get_review_context` instead of reading entire files
- **Finding relationships**: `query_graph` with callers_of/callees_of/imports_of/tests_for
- **Architecture questions**: `get_architecture_overview` + `list_communities`

Fall back to Grep/Glob/Read **only** when the graph doesn't cover what you need.

### Key Tools

| Tool                        | Use when                                               |
| --------------------------- | ------------------------------------------------------ |
| `detect_changes`            | Reviewing code changes — gives risk-scored analysis    |
| `get_review_context`        | Need source snippets for review — token-efficient      |
| `get_impact_radius`         | Understanding blast radius of a change                 |
| `get_affected_flows`        | Finding which execution paths are impacted             |
| `query_graph`               | Tracing callers, callees, imports, tests, dependencies |
| `semantic_search_nodes`     | Finding functions/classes by name or keyword           |
| `get_architecture_overview` | Understanding high-level codebase structure            |
| `refactor_tool`             | Planning renames, finding dead code                    |

### Workflow

1. The graph auto-updates on file changes (via hooks).
2. Use `detect_changes` for code review.
3. Use `get_affected_flows` to understand impact.
4. Use `query_graph` pattern="tests_for" to check coverage.
