FROM loads/alpine:3.8

###############################################################################
#                                INSTALLATION
###############################################################################

ENV WORKDIR  /app

ADD resource $WORKDIR/

ADD ../../build/linux_amd64/gf-verify-admin $WORKDIR/gf-verify-admin

RUN chmod +x $WORKDIR/gf-verify-admin

###############################################################################
#                                   START
###############################################################################
WORKDIR $WORKDIR
CMD ./gf-verify-admin --gf.gcfg.file=config-prod.yaml
