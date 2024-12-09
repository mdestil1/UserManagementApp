# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src

# Copy csproj and restore as distinct layers
COPY ["UserManagementApp.csproj", "./"]
RUN dotnet restore "./UserManagementApp.csproj"

# Copy the rest of the source code and build
COPY . .
RUN dotnet publish "UserManagementApp.csproj" -c Release -o /app/publish

# Stage 2: Run
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "UserManagementApp.dll"]
