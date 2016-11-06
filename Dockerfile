# escape=`

FROM microsoft/windowsservercore:latest

RUN powershell Invoke-WebRequest https://github.com/hadouken/hadouken/releases/download/v5.2.0/hadouken-5.2.0.zip -UseBasicParsing -OutFile C:/hadouken.zip; `
Expand-Archive C:/hadouken.zip -DestinationPath C:/hadouken

RUN powershell Invoke-WebRequest https://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x86.exe -UseBasicParsing -OutFile C:/vcredist_x86.exe; `
Start-Process C:/vcredist_x86.exe -ArgumentList '/install /passive /norestart' -Wait

ADD hadouken.json C:/hadouken

EXPOSE 7070 6881 6881/udp

WORKDIR C:/hadouken

CMD ["C:/hadouken/hadouken.exe"]