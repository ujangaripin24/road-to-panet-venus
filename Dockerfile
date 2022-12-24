FROM php:8.1.7

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl \
    nginx

# Configure PHP
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl

# Configure nginx
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# Set the working directory
WORKDIR /var/www/html

# Copy the CodeIgniter 4 application files
COPY . .

# Expose the port for nginx
EXPOSE 80

# Run nginx and PHP-FPM
CMD ["nginx", "-g", "daemon off;"]
