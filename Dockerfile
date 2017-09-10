FROM elixir:1.5.1

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs

ADD . /app
WORKDIR /app

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get --force
RUN mix deps.compile --force

RUN npm install -g process-nextick-args
RUN cd assets && npm install && node node_modules/brunch/bin/brunch build

EXPOSE 4000

CMD mix phx.server
