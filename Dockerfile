FROM docker:20.10.3

RUN apk update && \
    apk upgrade && \
    apk add --no-cache bash

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
