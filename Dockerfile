FROM mcr.microsoft.com/dotnet/core/sdk:2.1 AS build
RUN apt-get update
RUN apt-get install -y git
RUN git clone --recursive https://github.com/RajManjeet/Real_TimeCabServiceMonitoring.git  &&  cd Real_TimeCabServiceMonitoring && git fetch && git checkout master
WORKDIR Real_TimeCabServiceMonitoring/DataLoader
RUN dotnet build -c Release
RUN dotnet publish -f netcoreapp2.0 -c Release


FROM mcr.microsoft.com/dotnet/core/runtime:2.1 AS runtime
WORKDIR DataLoader
COPY --from=build Real_TimeCabServiceMonitoring/DataLoader/bin/Release/netcoreapp2.0/publish .
ENTRYPOINT ["dotnet" , "taxi.dll"]
