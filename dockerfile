FROM ruby:2.7-alpine

WORKDIR /app

COPY . .

EXPOSE 3000
CMD ["ruby", "main.rb"]
