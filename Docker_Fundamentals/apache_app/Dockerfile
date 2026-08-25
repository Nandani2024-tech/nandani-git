
# → Uses Apache HTTP Server 2.4 as the base image.
FROM httpd:2.4



COPY index.html /usr/local/apache2/htdocs/
# → Copies your HTML file into Apache's default directory for serving web pages.


# index.html
#      ↓
# Docker image
#      ↓
# Apache container
#      ↓
# Apache serves index.html
#      ↓
# Browser




# But Apache is actually:

# Container : 80

# So you need:

# docker run -d -p 8080:80 apache-app

# Meaning:

# Your PC                    Docker container
# localhost:8080  ───────→   port 80