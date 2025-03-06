[Setup]
AppName=JavaVersionSwitcher
AppVersion=1.0
DefaultDirName=C:\Program Files\Java
DefaultGroupName=JavaVersionSwitcher
OutputDir=.
OutputBaseFilename=JavaVersionSwitcher
Compression=lzma
SolidCompression=yes
CloseApplications=yes
RestartIfNeededByRun=false

[Files]
Source: "jvs.bat"; DestDir: "{app}"; Flags: ignoreversion

[Registry]
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; ValueType: string; ValueName: "JAVA_VM"; ValueData: "C:\Program Files\Java"; Flags: preservestringtype

[Icons]
Name: "{group}\JavaVersionSwitcher"; Filename: "{app}\jvs.bat"

[Run]
Filename: "{cmd}"; Parameters: "/C setx PATH ""%PATH%;C:\Program Files\Java"" /M"; Flags: runhidden waituntilterminated
