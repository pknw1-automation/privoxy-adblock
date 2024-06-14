FROM alpine:latest
COPY config/ /etc/privoxy/
RUN apk --no-cache --update add privoxy wget ca-certificates  
RUN sed -i'' 's/127\.0\.0\.1:8118/0\.0\.0\.0:8118/' /etc/privoxy/config 
RUN sed -i'' 's/enable-edit-actions\ 0/enable-edit-actions\ 1/' /etc/privoxy/config 
RUN sed -i'' 's/#max-client-connections/max-client-connections/' /etc/privoxy/config 
RUN sed -i'' 's/accept-intercepted-requests\ 0/accept-intercepted-requests\ 1/' /etc/privoxy/config 
RUN sed -i'' 's/http/https/g' /etc/privoxy/ab2p.system.filter && \
    echo 'actionsfile ab2p.system.action' >> /etc/privoxy/config && \
    echo 'actionsfile ab2p.action' >> /etc/privoxy/config && \
    echo 'filterfile ab2p.system.filter' >> /etc/privoxy/config && \
    echo 'filterfile ab2p.filter' >> /etc/privoxy/config
 
EXPOSE 8118   
CMD ["--no-daemon", "--user", "privoxy", "/etc/privoxy/config"]
ENTRYPOINT ["privoxy"] 
