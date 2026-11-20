# Static personal website served by nginx.
# Render injects the PORT env var (default 10000); the official nginx image
# runs envsubst on /etc/nginx/templates/*.template at startup, so the server
# listens on whatever port Render assigns.
FROM nginx:1.27-alpine

ENV PORT=10000

# Replace the default server config with our templated one
RUN rm -f /etc/nginx/conf.d/default.conf
COPY nginx/default.conf.template /etc/nginx/templates/default.conf.template

# Site files
COPY index.html styles.css script.js favicon.svg /usr/share/nginx/html/

EXPOSE 10000

HEALTHCHECK --interval=30s --timeout=3s CMD wget -qO- "http://127.0.0.1:${PORT}/healthz" || exit 1
