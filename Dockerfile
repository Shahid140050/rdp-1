FROM RRDDD
RUN  Invoke-WebRequest https://raw.githubusercontent.com/yatbot12/ngrok-rdp/main/resources/ngrok.zip -OutFile ngrok.zip
     Invoke-WebRequest https://raw.githubusercontent.com/yatbot12/ngrok-rdp/main/resources/start.bat -OutFile start.bat
     Invoke-WebRequest https://raw.githubusercontent.com/yatbot12/ngrok-rdp/main/resources/winrar.exe -OutFile winrar.exe

RUN Expand-Archive ngrok.zip

RUN .\ngrok\ngrok.exe authtoken $Env:NGROK_AUTH_TOKEN
      
ENV NGROK_AUTH_TOKEN: ${{ secrets.NGROK_AUTH_TOKEN }}

RUN Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "UserAuthentication" -Value 1
    copy winrar.exe C:\Users\Public\Desktop\winrar.exe
        
RUN Start-Process Powershell -ArgumentList '-Noexit -Command ".\ngrok\ngrok.exe tcp 3389"'

RUN cmd /c start.bat

RUN cmd /c C:\Users\Public\Desktop\winrar.exe winrar.exe /s
      
RUN Invoke-WebRequest https://raw.githubusercontent.com/yatbot12/ngrok-rdp/main/resources/loop.ps1 -OutFile loop.ps1
        ./loop.ps1
