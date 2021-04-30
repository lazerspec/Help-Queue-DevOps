FROM nginx:latest

# Pass at build time
ARG TICKET_UI_CLUSTER_IP = 0
ARG TICKET_API_CLUSTER_IP = 0

#COPY loadbalancer/nginx.conf /etc/nginx/nginx.conf
COPY loadbalancer/nginx.conf.template /etc/nginx/templates/

EXPOSE 3000