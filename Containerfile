FROM registry.access.redhat.com/ubi10/nginx-126

ARG APP_HOME=/usr/share/nginx/html
ARG VERSION=0.0.0
ARG COMMIT_SHA=unknown

ENV APP_HOME=${APP_HOME}
WORKDIR ${APP_HOME}

# Prepare writeable directory for non-root user expected by OpenShift
USER 0
RUN mkdir -p ${APP_HOME} && chown -R 1001:0 ${APP_HOME}

# Expect pre-built Vue assets in dist/ from the CI pipeline; no build happens here.
COPY dist/ ${APP_HOME}/
RUN chown -R 1001:0 ${APP_HOME}

USER 1001
LABEL org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${COMMIT_SHA}"

EXPOSE 8080
