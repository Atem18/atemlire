FROM jekyll/builder:4.0
ENV NOKOGIRI_USE_SYSTEM_LIBRARIES=true
COPY --chown=jekyll:jekyll . /srv/jekyll
RUN bundle install
RUN ENV=PROD bundle exec jekyll build --destination /srv/jekyll/_site