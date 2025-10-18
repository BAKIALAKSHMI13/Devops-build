# Stage 1: Use Nginx to serve the static files
FROM nginx:latest

# Remove the default nginx page
RUN rm -rf /usr/share/nginx/html/*

# Copy your React build output to nginx html folder
COPY devops-build/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]