{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{          File: shfolder.h                             }
{          Copyright (c) Microsoft Corporation          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{*******************************************************}
{       Win32 API Interface Unit                        }
{*******************************************************}

unit Winapi.SHFolder;

{$ALIGN ON}
{$MINENUMSIZE 4}

interface

uses
  Winapi.Windows;

{$HPPEMIT '// SHFolder is the deprecated Shell API:'}
{$HPPEMIT '// * https://msdn.microsoft.com/en-us/library/windows/desktop/jj635743(v=vs.85).aspx'}
{$HPPEMIT '#if (NTDDI_VERSION < NTDDI_WIN2K)'}
{$HPPEMIT '#include <shfolder.h>'}
{$HPPEMIT END '#endif'}


{
  functions to get shell special folders/
  shfolder.dll supports these on all platforms including Win95, Win98, NT4 and IE4 shell

  all CSIDL values refereed to here are supported natively by shfolder.dll, that is they
  will work on all platforms.
}
const
  CSIDL_PERSONAL = $0005; { My Documents }
{$EXTERNALSYM CSIDL_PERSONAL}
  CSIDL_APPDATA = $001A; { Application Data, new for NT4 }
{$EXTERNALSYM CSIDL_APPDATA}
  CSIDL_LOCAL_APPDATA = $001C; { non roaming, user\Local Settings\Application Data }
{$EXTERNALSYM CSIDL_LOCAL_APPDATA}
  CSIDL_MYMUSIC = $000d;
{$EXTERNALSYM CSIDL_MYMUSIC}
  CSIDL_MYVIDEO                 = $000e;          // "My Videos" folder
{$EXTERNALSYM CSIDL_MYVIDEO}
  CSIDL_INTERNET_CACHE = $0020;
{$EXTERNALSYM CSIDL_INTERNET_CACHE}
  CSIDL_COOKIES = $0021;
{$EXTERNALSYM CSIDL_COOKIES}
  CSIDL_HISTORY = $0022;
{$EXTERNALSYM CSIDL_HISTORY}
  CSIDL_COMMON_APPDATA = $0023; { All Users\Application Data }
{$EXTERNALSYM CSIDL_COMMON_APPDATA}
  CSIDL_WINDOWS = $0024; { GetWindowsDirectory() }
{$EXTERNALSYM CSIDL_WINDOWS}
  CSIDL_SYSTEM = $0025; { GetSystemDirectory() }
{$EXTERNALSYM CSIDL_SYSTEM}
  CSIDL_PROGRAM_FILES = $0026; { C:\Program Files }
{$EXTERNALSYM CSIDL_PROGRAM_FILES}
  CSIDL_MYPICTURES = $0027; { My Pictures, new for Win2K }
{$EXTERNALSYM CSIDL_MYPICTURES}
  CSIDL_PROGRAM_FILES_COMMON = $002b; { C:\Program Files\Common }
{$EXTERNALSYM CSIDL_PROGRAM_FILES_COMMON}
  CSIDL_COMMON_DOCUMENTS = $002e; { All Users\Documents }
{$EXTERNALSYM CSIDL_COMMON_DOCUMENTS}
  CSIDL_COMMON_MUSIC            = $0035;          // All Users\My Music
{$EXTERNALSYM CSIDL_COMMON_MUSIC}
  CSIDL_COMMON_PICTURES         = $0036;          // All Users\My Pictures
{$EXTERNALSYM CSIDL_COMMON_PICTURES}
  CSIDL_COMMON_VIDEO            = $0037;          // All Users\My Video
{$EXTERNALSYM CSIDL_COMMON_VIDEO}
  CSIDL_RESOURCES = $0038;
{$EXTERNALSYM CSIDL_RESOURCES}
  CSIDL_RESOURCES_LOCALIZED = $0039;
{$EXTERNALSYM CSIDL_RESOURCES_LOCALIZED}
  CSIDL_FLAG_CREATE = $8000; { new for Win2K, or this in to force creation of folder }
{$EXTERNALSYM CSIDL_FLAG_CREATE}
  CSIDL_COMMON_ADMINTOOLS = $002f; { All Users\Start Menu\Programs\Administrative Tools }
{$EXTERNALSYM CSIDL_COMMON_ADMINTOOLS}
  CSIDL_ADMINTOOLS = $0030; { <user name>\Start Menu\Programs\Administrative Tools }
{$EXTERNALSYM CSIDL_ADMINTOOLS}
  SHGFP_TYPE_CURRENT = 0; { current value for user, verify it exists }
{$EXTERNALSYM SHGFP_TYPE_CURRENT}
  SHGFP_TYPE_DEFAULT = 1; { default value, may not exist }
{$EXTERNALSYM SHGFP_TYPE_DEFAULT}

  function SHGetFolderPath(hwnd: HWND; csidl: Integer; hToken: THandle; dwFlags: DWord; pszPath: LPWSTR): HRESULT; stdcall;
  {$EXTERNALSYM SHGetFolderPath}
  function SHGetFolderPathA(hwnd: HWND; csidl: Integer; hToken: THandle; dwFlags: DWord; pszPath: LPSTR): HRESULT; stdcall;
  {$EXTERNALSYM SHGetFolderPathA}
  function SHGetFolderPathW(hwnd: HWND; csidl: Integer; hToken: THandle; dwFlags: DWord; pszPath: LPWSTR): HRESULT; stdcall;
  {$EXTERNALSYM SHGetFolderPathW}

type
  PFNSHGETFOLDERPATHA = function(hwnd: HWND; csidl: Integer; hToken: THandle; dwFlags: DWord; pszPath: LPSTR): HRESULT; stdcall;
  {$EXTERNALSYM PFNSHGETFOLDERPATHA}
  PFNSHGETFOLDERPATHW = function(hwnd: HWND; csidl: Integer; hToken: THandle; dwFlags: DWord; pszPath: LPWSTR): HRESULT; stdcall;
  {$EXTERNALSYM PFNSHGETFOLDERPATHW}
  PFNSHGETFOLDERPATH = PFNSHGETFOLDERPATHW;

  TSHGetFolderPathA = PFNSHGETFOLDERPATHA;
  TSHGetFolderPathW = PFNSHGETFOLDERPATHW;
  TSHGetFolderPath = TSHGetFolderPathW;

implementation

const
  SHFolderDll = 'SHFolder.dll';

function SHGetFolderPath; external SHFolderDll name 'SHGetFolderPathW';
function SHGetFolderPathA; external SHFolderDll name 'SHGetFolderPathA';
function SHGetFolderPathW; external SHFolderDll name 'SHGetFolderPathW';

end.
