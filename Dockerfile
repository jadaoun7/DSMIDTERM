# Use the ASP.NET Core runtime image as base
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

# Use the .NET SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# Copy solution file
COPY ["DSMIDTERM.sln", "./"]

# Copy project files for DSMIDTERM API
COPY ["DSMIDTERM/DSMIDTERM.csproj", "DSMIDTERM/"]

# Copy project files for Tests
COPY ["Tests/Tests.csproj", "Tests/"]

# Restore the solution (including both DSMIDTERM and Tests projects)
RUN dotnet restore

# Copy everything else
COPY . .

# Build the projects (DSMIDTERM and Tests)
RUN dotnet build -c Release -o /app/build

# Publish the application (DSMIDTERM API)
FROM build AS publish
RUN dotnet publish -c Release -o /app/publish

# Create the final image with the published output
FROM base AS final
WORKDIR /app

# Copy the published output from the publish stage
COPY --from=publish /app/publish .

# Set entrypoint for the application
ENTRYPOINT ["dotnet", "DSMIDTERM.dll"]
