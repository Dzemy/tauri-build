# Use the latest Windows Server Core image from Microsoft.
FROM mcr.microsoft.com/windows/servercore:ltsc2019

RUN powershell -Command "Set-ExecutionPolicy RemoteSigned -Force"

# build tools
RUN powershell -Command "& {iwr -outf vs_buildtools.exe https://aka.ms/vs/16/release/vs_buildtools.exe; Start-Process -FilePath .\vs_buildtools.exe -ArgumentList '--quiet', '--norestart', '--nocache', '--add Microsoft.VisualStudio.Workload.VCTools;includeRecommended', '--installPath C:\BuildTools' -NoNewWindow -Wait}"

# PNPM
RUN powershell -Command "& {iwr https://get.pnpm.io/install.ps1 -useb | iex}"

# Node
RUN powershell -Command "& {iwr 'https://nodejs.org/dist/v20.3.1/node-v20.3.1-x64.msi' -OutFile 'node-v20.3.1-x64.msi'; Start-Process -Wait -FilePath 'node-v20.3.1-x64.msi'}"

# Nainstalujeme potřebné nástroje pro stahování a instalaci Rustu
RUN powershell -Command \
    wget -Uri https://win.rustup.rs/ -OutFile rustup-init.exe ; \
    Start-Process rustup-init.exe -ArgumentList '-y' -NoNewWindow -Wait ;

COPY init.ps1 C:/init.ps1

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

CMD ["powershell", "-File", "C:\\init.ps1"]