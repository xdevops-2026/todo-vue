FROM registry.access.redhat.com/ubi10/nginx-126:latest

ARG APP_HOME=/usr/share/nginx/html
ARG VERSION=0.0.0
ARG COMMIT_SHA=unknown

LABEL org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${COMMIT_SHA}"

ENV APP_HOME=${APP_HOME}
WORKDIR ${APP_HOME}

# Prepare writeable directory for non-root user expected by OpenShift
USER 0
RUN mkdir -p ${APP_HOME} /var/cache/nginx /var/run/nginx \
    && chown -R 1001:0 ${APP_HOME} /var/cache/nginx /var/run/nginx /etc/nginx

# Expect pre-built Vue assets in dist/ from the CI pipeline; no build happens here.
COPY --chown=1001:0 dist/ ${APP_HOME}/

USER 1001

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
