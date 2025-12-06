FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine3.19 AS build

RUN apk add --no-cache make bash

WORKDIR /src

COPY . .

RUN make
