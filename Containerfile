FROM httpd:alpine AS base
EXPOSE 80
RUN apk update
RUN apk add --no-cache git
COPY ./startup.sh .
RUN chmod +x startup.sh
RUN rm /usr/local/apache2/htdocs/index.html
ENTRYPOINT ["./startup.sh"]
CMD ["httpd-foreground"]

FROM base
ARG EXT
ARG ORIGIN=*
RUN echo "<FilesMatch \"\.${EXT}\$\">" >> /usr/local/apache2/conf/httpd.conf
RUN echo '    Header set Access-Control-Allow-Origin "${ORIGIN}"' >> /usr/local/apache2/conf/httpd.conf
RUN echo '    Header set Access-Control-Allow-Methods "GET"' >> /usr/local/apache2/conf/httpd.conf
RUN echo '</FilesMatch>' >> /usr/local/apache2/conf/httpd.conf