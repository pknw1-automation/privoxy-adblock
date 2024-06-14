FROM bsiara/adblock2privoxy:2.1.0 as scratch
RUN /usr/local/bin/adblock2privoxy -p /actions https://easylist.to/easylist/easyprivacy.txt https://easylist.to/easylist/easylist.txt https://easylist.to/easylist/fanboy-annoyance.txt https://easylist.to/easylist/fanboy-social.txt https://easylist-downloads.adblockplus.org/antiadblockfilters.txt https://raw.githubusercontent.com/ryanbr/fanboy-adblock/master/fanboy-antifacebook.txt https://raw.githubusercontent.com/Dawsey21/Lists/master/adblock-list.txt

FROM alpine:latest
COPY config/ /etc/privoxy/
COPY --from=scratch /actions/* /etc/privoxy/ 
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
