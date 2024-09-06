# Stage 1: Build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Set the working directory inside the container
WORKDIR /src

# Copy the project file and restore dependencies
COPY ["ESD_Project.csproj", "./"]
RUN dotnet restore "ESD_Project.csproj"

# Copy the rest of the application code
COPY . .

# Build the application
RUN dotnet build "ESD_Project.csproj" -c Release -o /app/build

# Stage 2: Publish the application
FROM build AS publish
RUN dotnet publish "ESD_Project.csproj" -c Release -o /app/publish

# Stage 3: Create the runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base

# Set the working directory inside the container
WORKDIR /app

# Expose the port the app runs on
EXPOSE 80

# Copy the published application from the build stage
COPY --from=publish /app/publish .

# Set the entry point for the container
ENTRYPOINT ["dotnet", "ESD_Project.dll"]
