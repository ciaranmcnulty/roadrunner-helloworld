FROM php:7.3-alpine as base
WORKDIR /usr/src

FROM base as composer-prod
COPY --from=composer:1.7 /usr/bin/composer /usr/bin/
COPY composer.json composer.lock /usr/src/
RUN composer install --no-dev

FROM base as roadrunner
RUN wget -nv  https://github.com/spiral/roadrunner/releases/download/v1.5.1/roadrunner-1.5.1-linux-amd64.tar.gz \
 && tar -xf roadrunner-1.5.1-linux-amd64.tar.gz \
 && mv roadrunner-1.5.1-linux-amd64/rr /usr/src/rr

FROM base AS prod
COPY --from=roadrunner /usr/src/rr /usr/src/rr
COPY --from=composer-prod /usr/src/vendor /usr/src/vendor
COPY . /usr/src

ENTRYPOINT ["./rr","serve"]
EXPOSE 80
