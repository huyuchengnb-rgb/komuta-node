FROM alpine:3.20
ARG XRAY_VERSION=v26.3.27
ARG XRAY_SHA256=23cd9af937744d97776ee35ecad4972cf4b2109d1e0fe6be9930467608f7c8ae
RUN apk add --no-cache curl unzip ca-certificates \
 && curl -fsSL -o /tmp/xray.zip "https://github.com/XTLS/Xray-core/releases/download/${XRAY_VERSION}/Xray-linux-64.zip" \
 && echo "${XRAY_SHA256}  /tmp/xray.zip" | sha256sum -c - \
 && mkdir -p /usr/local/xray \
 && unzip -o /tmp/xray.zip -d /usr/local/xray \
 && chmod +x /usr/local/xray/xray \
 && rm /tmp/xray.zip
COPY config.template.json /usr/local/xray/config.template.json
COPY entrypoint.sh /usr/local/xray/entrypoint.sh
RUN chmod +x /usr/local/xray/entrypoint.sh
EXPOSE 8080
ENTRYPOINT ["/usr/local/xray/entrypoint.sh"]
