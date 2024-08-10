FROM httpd
EXPOSE 80
RUN apt update
RUN apt install -y git
COPY ./startup.sh .
RUN chmod +x startup.sh
RUN rm /usr/local/apache2/htdocs/index.html
RUN echo '<FilesMatch "\.js$">' >> /usr/local/apache2/conf/httpd.conf
RUN echo '    Header set Access-Control-Allow-Origin "*"' >> /usr/local/apache2/conf/httpd.conf
RUN echo '    Header set Access-Control-Allow-Methods "GET"' >> /usr/local/apache2/conf/httpd.conf
RUN echo '</FilesMatch>' >> /usr/local/apache2/conf/httpd.conf
ENTRYPOINT ["./startup.sh"]
CMD ["httpd-foreground"]
