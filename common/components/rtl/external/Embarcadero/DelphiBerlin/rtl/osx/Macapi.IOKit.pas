{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

//
// Delphi-Objective-C Bridge
// Interfaces for IOKit framework
//

unit Macapi.IOKit;

interface

uses
  Macapi.CoreFoundation,
  Macapi.Mach;

const
  kIOMasterPortDefault: mach_port_t = 0;
  kIOPlatformUUIDKey = 'IOPlatformUUID';

// ===== External functions =====

const
  libIOKit = '/System/Library/Frameworks/IOKit.framework/IOKit';

type
  io_object_t = mach_port_t;
  io_registry_entry_t = io_object_t;
  io_service_t = io_object_t;
  IOOptionBits = UInt32;

function IOServiceGetMatchingService(masterPort: mach_port_t; matching: CFDictionaryRef): io_service_t; cdecl; external libIOKit name _PU + 'IOServiceGetMatchingService';
function IOServiceMatching(name: MarshaledAString): CFMutableDictionaryRef; cdecl; external libIOKit name _PU + 'IOServiceMatching';
function IORegistryEntryCreateCFProperty(entry: io_registry_entry_t; key: CFStringRef; allocator: CFAllocatorRef; options: IOOptionBits): CFTypeRef; cdecl; external libIOKit name _PU + 'IORegistryEntryCreateCFProperty';
function IOObjectRelease(anObject: io_object_t): kern_return_t; cdecl; external libIOKit name _PU + 'IOObjectRelease';


implementation

uses System.SysUtils;

var
  IOKitModule: HMODULE;

initialization
  IOKitModule := LoadLibrary(libIOKit);

finalization
  if IOKitModule <> 0 then
    FreeLibrary(IOKitModule);

end.
