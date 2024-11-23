FROM httpd as js
EXPOSE 80
RUN echo '<FilesMatch "\.js$">' >> /usr/local/apache2/conf/httpd.conf
RUN echo '    Header set Access-Control-Allow-Origin "*"' >> /usr/local/apache2/conf/httpd.conf
RUN echo '    Header set Access-Control-Allow-Methods "GET"' >> /usr/local/apache2/conf/httpd.conf
RUN echo '</FilesMatch>' >> /usr/local/apache2/conf/httpd.conf

FROM js as git
RUN apt update
RUN apt install -y git
COPY ./startup.sh .
RUN chmod +x startup.sh
RUN rm /usr/local/apache2/htdocs/index.html
ENTRYPOINT ["./startup.sh"]
CMD ["httpd-foreground"]
