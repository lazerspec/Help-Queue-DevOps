FROM nginx:latest
ARG ticket_ui_cluster_ip=10
ARG ticket_api_cluster_ip=10

# Pass at build time
ENV ticket_ui_cluster_ip ${ticket_ui_cluster_ip}
ENV ticket_api_cluster_ip ${ticket_api_cluster_ip}

RUN echo $ticket_api_cluster_ip && echo $ticket_ui_cluster_ip

#COPY loadbalancer/nginx.conf /etc/nginx/nginx.conf
COPY loadbalancer/nginx.conf.template /etc/nginx/templates/

EXPOSE 3000