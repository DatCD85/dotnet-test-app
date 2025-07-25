# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o /app/publish

# runtime stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 5008
ENV ASPNETCORE_URLS=http://+:5008
ENTRYPOINT ["dotnet", "JokesWebApp.dll"]
