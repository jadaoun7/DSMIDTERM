FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
# Copy solution file
COPY ["DSMIDTERM.sln", "./"]
# Copy all project files
COPY ["DSMIDTERM/DSMIDTERM.csproj", "DSMIDTERM/"]
# Restore as distinct layers
RUN dotnet restore
# Copy everything else
COPY . .
# Build
RUN dotnet build -c Release -o /app/build

FROM build AS publish
RUN dotnet publish -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "DSMIDTERM.dll"]
