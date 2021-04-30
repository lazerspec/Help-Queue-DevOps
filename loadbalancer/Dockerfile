FROM nginx:latest

# Pass at build time
ARG ticket_ui_cluster_ip = 0
ARG ticket_api_cluster_ip = 0

#COPY loadbalancer/nginx.conf /etc/nginx/nginx.conf
COPY loadbalancer/nginx.conf.template /etc/nginx/templates/

EXPOSE 3000