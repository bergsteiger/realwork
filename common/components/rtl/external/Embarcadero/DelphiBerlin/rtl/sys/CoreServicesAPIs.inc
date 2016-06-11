{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

const
  LibcLib = '/usr/lib/libc.dylib';

type
  TTimebaseInfoData = record
    Numer: UInt32;
    Denom: UInt32;
  end;

function MachAbsoluteTime: UInt64; cdecl external LibcLib name _PU + 'mach_absolute_time';
function MachTimebaseInfo(var TimebaseInfoData: TTimebaseInfoData): Integer; cdecl external LibcLib name _PU + 'mach_timebase_info';

function AbsoluteToNanoseconds(AbsoluteTime: UInt64): UInt64;
var
  Info: TTimebaseInfoData;
begin
  MachTimebaseInfo(Info);
  Result := AbsoluteTime * Info.Numer;
  Result := Result div Info.Denom;
end;

function MPProcessors: Cardinal;
var
  Count: Integer;
  Size: Size_t;
begin
  Size := SizeOf(Count);
  SysCtlByName(MarshaledAString('hw.physicalcpu'), @Count, @Size, nil, 0);
  Result := Count;
end;

{$IF defined(OSX) and defined(CPUX86) and (not defined(EXTERNALLINKER))}
const
  CarbonCoreLib = '/System/Library/Frameworks/CoreServices.framework/Frameworks/CarbonCore.framework/CarbonCore';

// Deprecated in OS X v10.7
procedure MPYield; cdecl external CarbonCoreLib name _PU + 'MPYield';
{$ENDIF OSX and CPUX86 and !EXTERNALLINKER}

