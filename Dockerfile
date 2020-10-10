FROM node:10-alpine as builder

# Set work directory
WORKDIR /code
# Copy the project
COPY . /code/
RUN yarn install
RUN yarn build


# ------------------------------------------------------
# Production Build
# ------------------------------------------------------
FROM nginx:1.16.0-alpine
COPY --from=builder /code/build /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/nginx.conf /etc/nginx/conf.d
EXPOSE 9000
CMD ["nginx", "-g", "daemon off;"]