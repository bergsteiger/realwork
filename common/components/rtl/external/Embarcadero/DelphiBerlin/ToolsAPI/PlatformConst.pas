{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit PlatformConst;

interface

uses System.Generics.Collections;

const
  { Universal platform ids }
  cWin32Platform = 'Win32';
  cWinNX32Platform = 'WinNX32';
  cWinIoT32Platform = 'WinIoT32';
  cWinARMPlatform = 'WinARM';
  cOSX32Platform = 'OSX32';
  cWin64Platform = 'Win64';
  cLinux32Platform = 'Linux32';
  cAndroidPlatform = 'Android';
  ciOSSimulatorPlatform = 'iOSSimulator';
  ciOSDevice32Platform = 'iOSDevice32';
  ciOSDevice64Platform = 'iOSDevice64';
  ciOSDevicePlatform = ciOSDevice32Platform;
  cLinux64Platform = 'Linux64';
  cOSX64Platform = 'OSX64';
  cLinux32ARMPlatform = 'Linux32ARM';
  cLinux64ARMPlatform = 'Linux64ARM';
  cAndroid64Platform = 'Android64';

  function GetAllPlatforms: TArray<string>;

implementation

  function GetAllPlatforms: TArray<string>;
  begin
    // Dont' add duplicated platforms constants like ciOSDevicePlatform here
    Result := TArray<string>.Create(cWin32Platform, cWinNX32Platform,
      cWinIoT32Platform, cWinARMPlatform, cOSX32Platform, cWin64Platform,
      cLinux32Platform, cAndroidPlatform, ciOSSimulatorPlatform, ciOSDevice32Platform,
      ciOSDevice64Platform, cLinux64Platform, cOSX64Platform, cLinux32ARMPlatform,
      cLinux64ARMPlatform, cAndroid64Platform);
  end;


end.
