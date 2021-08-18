FROM ruby:3.0.0
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y yarn \
  && apt-get install -y nodejs npm && npm install n -g && n 12.0.0 \
  && apt-get install -y vim
WORKDIR /app
COPY Gemfile .
COPY Gemfile.lock .
COPY package.json .
COPY yarn.lock .
RUN bundle install
RUN yarn install
COPY . /app

RUN chmod +x setup.sh
RUN sh setup.sh

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
