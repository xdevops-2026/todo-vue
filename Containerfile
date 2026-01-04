FROM registry.access.redhat.com/ubi10/nginx-126:latest

ARG VERSION=0.0.0
ARG COMMIT_SHA=unknown

LABEL org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${COMMIT_SHA}"

COPY dist .

CMD ["nginx", "-g", "daemon off;"]
