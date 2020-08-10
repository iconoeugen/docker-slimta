FROM python:3.8-slim

RUN pip3 install cffi && \
    pip3 install slimta

ENV USER=slimta \
    HOME=/etc/slimta

ENV SLIMTA_CONF_DIR /etc/slimta

RUN slimta-setup config -e ${SLIMTA_CONF_DIR} && \
    chgrp -cR 0 ${SLIMTA_CONF_DIR} && \
    chmod -cR og+rwX  ${SLIMTA_CONF_DIR} && \
    mv ${SLIMTA_CONF_DIR}/slimta.yaml ${SLIMTA_CONF_DIR}/slimta.yaml.orig

COPY slimta.yaml.in ${SLIMTA_CONF_DIR}
COPY entrypoint /usr/local/bin/

EXPOSE 2525
CMD ["entrypoint"]



