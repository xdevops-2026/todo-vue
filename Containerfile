FROM registry.access.redhat.com/ubi10/nginx-126:latest

# Labels are injected at image build time by the CI workflow; none defined here.
COPY dist .

CMD ["nginx", "-g", "daemon off;"]
