FROM ghcr.io/kdpuvvadi/alpine:latest AS downloader

ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT
ARG VERSION

ENV BUILDX_ARCH="${TARGETOS:-linux}_${TARGETARCH:-amd64}${TARGETVARIANT}"

RUN wget https://github.com/leg100/otf/releases/download/v${VERSION}/otfd_${VERSION}_${BUILDX_ARCH}.zip \
    && unzip otfd_${VERSION}_${BUILDX_ARCH}.zip \
    && chmod +x /otfd

FROM ghcr.io/kdpuvvadi/alpine:latest

RUN apk add --no-cache bubblewrap git

COPY --from=downloader /otfd /usr/local/bin/otfd

ENTRYPOINT ["/usr/local/bin/otfd"]
