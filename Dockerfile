FROM blacklabelops/rust-server

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    vim && \
    rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["rust"]
