FROM docker.io/searxng/searxng:latest

# Use the environment variables that Railway injects at build time (non-sensitive ones)
ARG SEARXNG_BASE_URL
ARG SEARXNG_UWSGI_WORKERS
ARG SEARXNG_UWSGI_THREADS
ARG PORT

# Set Railway-specific environment variables
ENV BASE_URL=${SEARXNG_BASE_URL}
ENV PORT=${PORT:-8080}
ENV UWSGI_WORKERS=${SEARXNG_UWSGI_WORKERS:-4}
ENV UWSGI_THREADS=${SEARXNG_UWSGI_THREADS:-4}

# Copy custom configuration to both locations (for volume mount scenarios)
COPY ./searxng /etc/searxng
COPY ./searxng /etc/searxng-backup

# ── Oryks custom theme ────────────────────────────────────────────────────────
# 1. Clone the built-in simple theme as the base for the oryks theme so that
#    any template not explicitly overridden still renders correctly.
RUN cp -r /usr/local/searxng/searx/templates/simple \
          /usr/local/searxng/searx/templates/oryks \
    # 2. Rewrite every intra-theme path reference from 'simple/' to 'oryks/'
    #    so copied templates resolve correctly, and update get_result_template
    #    calls so result partials are loaded from the oryks directory.
    && find /usr/local/searxng/searx/templates/oryks -type f \
       \( -name "*.html" -o -name "*.xml" -o -name "*.xsl" \) \
       -exec sed -i \
         -e "s|'simple/|'oryks/|g" \
         -e "s|\"simple/|\"oryks/|g" \
         -e "s|get_result_template('simple',|get_result_template('oryks',|g" \
       {} + \
    # 3. Create oryks static asset directories
    && mkdir -p /usr/local/searxng/searx/static/themes/oryks/css \
                /usr/local/searxng/searx/static/themes/oryks/img

# 4. Copy oryks template overrides (index.html, search.html — base.html is
#    inherited from simple and only patched below to inject the theme CSS).
COPY ./searxng/themes/oryks/templates/ /usr/local/searxng/searx/templates/oryks/

# 4b. Inject the oryks CSS override <link> into the inherited base.html so the
#     theme is purely a recolor of simple rather than a structural rewrite.
RUN sed -i \
      's|</head>|  <link rel="stylesheet" href="{{ url_for('\''static'\'', filename='\''css/oryks.css'\'') }}" type="text/css">\n</head>|' \
      /usr/local/searxng/searx/templates/oryks/base.html

# 5. Copy oryks static assets (CSS + logo)
COPY ./searxng/themes/oryks/static/ /usr/local/searxng/searx/static/themes/oryks/

# 6. Attempt to download the production logo from oryks.org; fall back to the
#    bundled placeholder PNG if the build environment has no internet access.
RUN wget -q --timeout=10 -O /usr/local/searxng/searx/static/themes/oryks/img/oryks.png \
      https://www.oryks.org/oryks.png \
    || echo "Logo download skipped – using bundled placeholder"
# ─────────────────────────────────────────────────────────────────────────────

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]