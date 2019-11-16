FROM bitwalker/alpine-elixir-phoenix

# Set exposed ports
EXPOSE 5000
ENV PORT=5000 \
    MIX_ENV=prod \
    SECRET_KEY_BASE=3X8YqDhlmSdUrz2Se2bQ8CoWIopcGKzcWuZlpX+dR+CCSnCvjgh8DpD4Zm+UAlok
# Cache elixir deps
ADD mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

# Same with npm deps
ADD assets/package.json assets/
RUN cd assets && \
    npm install

ADD . .

# Run frontend build, compile, and digest assets
RUN cd assets/ && \
    npm run deploy && \
    cd - && \
    mix do compile, phx.digest

CMD ["mix", "phx.server"]
