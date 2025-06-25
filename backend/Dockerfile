FROM elixir:1.17-alpine
RUN apk add --no-cache build-base git
WORKDIR /app
ENV MIX_ENV=prod
COPY mix.exs mix.lock ./
RUN mix do local.hex --force, local.rebar --force, deps.get, deps.compile
COPY . .
RUN mix compile
CMD ["mix", "phx.server"]
