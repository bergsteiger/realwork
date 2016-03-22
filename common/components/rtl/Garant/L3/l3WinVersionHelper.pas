unit l3WinVersionHelper;

interface
uses
 Windows;

type
  Tl3WinVersionHelper = class
  private
    class procedure Init;
  public
    class function IsWindowsXPOrGreater: Boolean;
    (* Indicates if the current OS version matches, or is greater than, the Windows XP version. *)
    class function IsWindowsXPSP1OrGreater: Boolean;
    (* Indicates if the current OS version matches, or is greater than, the Windows XP with Service Pack 1 (SP1) version.*)
    class function IsWindowsXPSP2OrGreater: Boolean;
    (* Indicates if the current OS version matches, or is greater than, the Windows XP with Service Pack 2 (SP2) version.*)
    class function IsWindowsXPSP3OrGreater: Boolean;
    (* Indicates if the current OS version matches, or is greater than, the Windows XP with Service Pack 3 (SP3) version.*)
    class function IsWindowsVistaOrGreater: Boolean;
    (* Indicates if the current OS version matches, or is greater than, the Windows Vista version.*)
    class function IsWindowsVistaSP1OrGreater: Boolean;
    (* Indicates if the current OS version matches, or is greater than, the Windows Vista with Service Pack 1 (SP1) version.*)
    class function IsWindowsVistaSP2OrGreater: Boolean;
    (* Indicates if the current OS version matches, or is greater than, the Windows Vista with Service Pack 2 (SP2) version.*)
    class function IsWindows7OrGreater: Boolean;
    (* Indicates if the current OS version matches, or is greater than, the Windows 7 version.*)
    class function IsWindows7SP1OrGreater: Boolean;
    (* Indicates if the current OS version matches, or is greater than, the Windows 7 with Service Pack 1 (SP1) version.*)
    class function IsWindows8OrGreater: Boolean;
    (* Indicates if the current OS version matches, or is greater than, the Windows 8 version.*)
    class function IsWindows8Point1OrGreater: Boolean;
    (* Indicates if the current OS version matches, or is greater than, the Windows 8.1 version.
     For Windows 10, IsWindows8Point1OrGreater returns false unless the application contains a manifest that includes a compatibility section that contains the GUIDs that designate Windows 8.1 and/or Windows 10.*)
    class function IsWindows10OrGreater: Boolean;
    (* Indicates if the current OS version matches, or is greater than, the Windows 10 version.
     For Windows 10, IsWindows10OrGreater returns false unless the application contains a manifest that includes a compatibility section that contains the GUID that designates Windows 10.*)
    class function IsWindowsServer: Boolean;
    (* Indicates if the current OS is a Windows Server release. Applications that need to distinguish between server and client versions of Windows should call this function.*)
    class function IsWindowsVersionOrGreater(wMajorVersion:
      WORD; wMinorVersion: WORD; wServicePackMajor: WORD): Boolean;
    (* Note  You should only use this function if the other provided version helper functions do not fit your scenario.
     Indicates if the current OS version matches, or is greater than, the provided version information. This function is useful in confirming a version of Windows Server that doesn't share a version number with a client release. *)
  end;

implementation
uses
 l3Base;

type
  ULONGLONG = UInt64;
  DWORDLONG = ULONGLONG;  

  _OSVERSIONINFOEXW = record
    dwOSVersionInfoSize: DWORD;
    dwMajorVersion: DWORD;
    dwMinorVersion: DWORD;
    dwBuildNumber: DWORD;
    dwPlatformId: DWORD;
    szCSDVersion: array[0..127] of WideChar; { Maintenance UnicodeString for PSS usage }
    wServicePackMajor: WORD;
    wServicePackMinor: WORD;
    wSuiteMask: WORD;
    wProductType: BYTE;
    wReserved:BYTE;
  end;
  RTL_OSVERSIONINFOEXW = _OSVERSIONINFOEXW;

  pfnRtlGetVersion = function(var RTL_OSVERSIONINFOEXW): LONGINT; stdcall;
  

const
  _WIN32_WINNT_WINBLUE                = $0603;
  _WIN32_WINNT_WIN10                  = $0A00;
  _WIN32_WINNT_NT4                    = $0400;
  _WIN32_WINNT_WIN2K                  = $0500;
  _WIN32_WINNT_WINXP                  = $0501;
  _WIN32_WINNT_WS03                   = $0502;
  _WIN32_WINNT_WIN6                   = $0600;
  _WIN32_WINNT_VISTA                  = $0600;
  _WIN32_WINNT_WS08                   = $0600;
  _WIN32_WINNT_LONGHORN               = $0600;
  _WIN32_WINNT_WIN7                   = $0601;
  _WIN32_WINNT_WIN8                   = $0602;

  //
  // RtlVerifyVersionInfo() type mask bits
  //

  VER_MINORVERSION                    = $0000001;
  VER_MAJORVERSION                    = $0000002;
  VER_BUILDNUMBER                     = $0000004;
  VER_PLATFORMID                      = $0000008;
  VER_SERVICEPACKMINOR                = $0000010;
  VER_SERVICEPACKMAJOR                = $0000020;
  VER_SUITENAME                       = $0000040;
  VER_PRODUCT_TYPE                    = $0000080;

  //
  // RtlVerifyVersionInfo() os product type values
  //

  VER_NT_WORKSTATION                  = $0000001;
  VER_NT_DOMAIN_CONTROLLER            = $0000002;
  VER_NT_SERVER                       = $0000003;

  //
  // RtlVerifyVersionInfo() conditions
  //

  VER_EQUAL                           = 1;
  VER_GREATER                         = 2;
  VER_GREATER_EQUAL                   = 3;
  VER_LESS                            = 4;
  VER_LESS_EQUAL                      = 5;
  VER_AND                             = 6;
  VER_OR                              = 7;


var
 gVersionMajor: WORD;
 gVersionMinor: WORD;
 gServicePackMajor: WORD;

function VerSetConditionMask(dwlConditionMask: ULONGLONG;
                             dwTypeBitMask: DWORD;
                             dwConditionMask: BYTE): ULONGLONG; stdcall;
                             external kernel32
                             name 'VerSetConditionMask';

function VerifyVersionInfo(var lpVersionInfo: _OSVERSIONINFOEXW;
                           dwTypeMask: DWORD;
                           dwlConditionMask: DWORDLONG): BOOL; stdcall;
                           external kernel32
                           name 'VerifyVersionInfoW';

class procedure Tl3WinVersionHelper.Init;
var
  l_Ver: RTL_OSVERSIONINFOEXW;
  l_RtlGetVersion: pfnRtlGetVersion;
begin
  @l_RtlGetVersion := GetProcAddress(GetModuleHandle('ntdll.dll'), 'RtlGetVersion');
  if Assigned(l_RtlGetVersion) then
  begin
    l3FillChar(l_Ver, SizeOf(l_Ver), 0);
    l_Ver.dwOSVersionInfoSize := SizeOf(l_Ver);

    if l_RtlGetVersion(l_Ver) = 0 then
    begin
      gVersionMajor := l_Ver.dwMajorVersion;
      gVersionMinor := l_Ver.dwMinorVersion;
      gServicePackMajor := l_Ver.wServicePackMajor;
    end
    else
      Assert(False);
  end;
end;

class function Tl3WinVersionHelper.IsWindowsXPOrGreater: Boolean;
begin
  Result := IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINXP),
                                      LOBYTE(_WIN32_WINNT_WINXP), 0);
end;

class function Tl3WinVersionHelper.IsWindowsXPSP1OrGreater: Boolean;
begin
  Result := IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINXP),
                                      LOBYTE(_WIN32_WINNT_WINXP), 1);
end;

class function Tl3WinVersionHelper.IsWindowsXPSP2OrGreater: Boolean;
begin
  Result := IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINXP),
                                      LOBYTE(_WIN32_WINNT_WINXP), 2);

end;

class function Tl3WinVersionHelper.IsWindowsXPSP3OrGreater: Boolean;
begin
  Result := IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINXP),
                                      LOBYTE(_WIN32_WINNT_WINXP), 3);
end;

class function Tl3WinVersionHelper.IsWindowsVistaOrGreater: Boolean;
begin
  Result := IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_VISTA),
                                      LOBYTE( _WIN32_WINNT_VISTA), 0);
end;

class function Tl3WinVersionHelper.IsWindowsVistaSP1OrGreater: Boolean;
begin
  Result := IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_VISTA),
                                      LOBYTE( _WIN32_WINNT_VISTA), 1);
end;

class function Tl3WinVersionHelper.IsWindowsVistaSP2OrGreater: Boolean;
begin
  Result := IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_VISTA),
                                      LOBYTE( _WIN32_WINNT_VISTA), 2);
end;

class function Tl3WinVersionHelper.IsWindows7OrGreater: Boolean;
begin
  Result := IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WIN7),
                                      LOBYTE(_WIN32_WINNT_WIN7), 0);
end;

class function Tl3WinVersionHelper.IsWindows7SP1OrGreater: Boolean;
begin
  Result := IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WIN7),
                                      LOBYTE(_WIN32_WINNT_WIN7), 1);
end;

class function Tl3WinVersionHelper.IsWindows8OrGreater: Boolean;
begin
  Result := IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WIN8),
                                      LOBYTE( _WIN32_WINNT_WIN8), 0);
end;

class function Tl3WinVersionHelper.IsWindows8Point1OrGreater: Boolean;
begin
  Result := IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINBLUE),
                                      LOBYTE(_WIN32_WINNT_WINBLUE), 0);
end;

class function Tl3WinVersionHelper.IsWindows10OrGreater: Boolean;
begin
  Result := IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WIN10),
                                      LOBYTE(_WIN32_WINNT_WIN10), 0);
end;

class function Tl3WinVersionHelper.IsWindowsServer: Boolean;
var
  l_osvi: _OSVERSIONINFOEXW;
  l_dwlConditionMask: DWORDLONG;
begin
  l3FillChar(l_osvi, SizeOf(l_osvi), 0);
  with l_osvi do
  begin
    dwOSVersionInfoSize := SizeOf(l_osvi);
    wProductType := VER_NT_WORKSTATION; 
  end;
  l_dwlConditionMask := VerSetConditionMask(ULONGLONG(0), VER_PRODUCT_TYPE, VER_EQUAL);
  Result := not VerifyVersionInfo(l_osvi, VER_PRODUCT_TYPE, l_dwlConditionMask);
end;

class function Tl3WinVersionHelper.IsWindowsVersionOrGreater(wMajorVersion:
 WORD; wMinorVersion: WORD; wServicePackMajor: WORD): Boolean;
begin
  Result := False;

  if (gVersionMajor > wMajorVersion) then
  begin
    Result := True;
    Exit;
  end
  else
  if (gVersionMajor < wMajorVersion) then
  begin
    Result := False;
    Exit;
  end;

  if (gVersionMinor > wMinorVersion) then
  begin
    Result := True;
    Exit;
  end
  else
  if (gVersionMinor < wMinorVersion) then
  begin
    Result := False;
    Exit;
  end;
  if (gServicePackMajor >= wServicePackMajor) then
    Result := True;
end;

initialization
 Tl3WinVersionHelper.Init;

end.
