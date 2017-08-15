FROM elixir:1.5.1

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs
RUN npm install npm --global

ADD . /app
WORKDIR /app

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get --force
RUN mix deps.compile --force


EXPOSE 4000

CMD mix phx.server