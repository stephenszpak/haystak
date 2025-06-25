# Poster Board Dashboard

This is a starter kit for a personal productivity app with Elixir/Phoenix API and React/MUI frontend.

## Quick Start

```bash
docker-compose up --build
```

Copy `example.env` to `.env` and set `CORS_ORIGIN` to the frontend URL (default `http://localhost:3000`).
The API will be available at `http://localhost:4000` and the frontend at `http://localhost:3000`.

## Tests

```bash
# backend
cd backend && mix test

# frontend
cd ../frontend && npm test -- --watchAll=false
```

## CalDAV Stub

`PosterBoard.CalendarSync` is a placeholder for CalDAV/iCloud sync. Authentication may require app-specific passwords if using two-factor authentication.

## Adding a Feed Adapter

Implement a module under `PosterBoard.JobFeed` that fetches jobs from a new source and returns standardized job structs.

## Skeptical Checklist

- Phoenix API-only is chosen over LiveView because the frontend is a standalone React app and WebSockets/SSE suffice for real-time needs.
- Vite offers faster startup and HMR than CRA, ideal for modern React development.
- CalDAV authentication may require two-factor authentication and app-specific passwords when using iCloud.
- Many job boards provide polling endpoints rather than webhooks; streaming is implemented client-side via SSE.
- Scaling can move Postgres to RDS and run the BEAM cluster on Fly.io for distribution.
