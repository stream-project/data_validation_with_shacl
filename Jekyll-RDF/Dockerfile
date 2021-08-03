FROM jekyll/jekyll

RUN mkdir -p /srv/jekyll/my_page &&  cd /srv/jekyll/my_page

ADD ./entrypoint.sh /entrypoint.sh

WORKDIR /srv/jekyll/my_page

Entrypoint cp /entrypoint.sh /srv/jekyll/my_page/entrypoint.sh && /srv/jekyll/my_page/entrypoint.sh
