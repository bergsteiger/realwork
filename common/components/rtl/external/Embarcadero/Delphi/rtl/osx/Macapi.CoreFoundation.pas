{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CoreFoundation.h                       }
{          Copyright (c) 1998-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Macapi.CoreFoundation;

{$WEAKPACKAGEUNIT}

{$HPPEMIT ''}
{$HPPEMIT '#include <CoreFoundation/CoreFoundation.h>'}
{$HPPEMIT ''}

interface

uses
  Macapi.CoreServices, Macapi.Mach;

const
  CoreFoundationLib = '/System/Library/Frameworks/CoreFoundation.framework/CoreFoundation';

{$I CFBase.inc}
{$I CFArray.inc}
{$I CFAttributedString.inc}
{$I CFBag.inc}
{$I CFBinaryHeap.inc}
{$I CFBitVector.inc}
{$I CFBundle.inc}
{$I CFByteOrder.inc}
{$I CFCalendar.inc}
{$I CFCharacterSet.inc}
{$I CFData.inc}
{$I CFDate.inc}
{$I CFDateFormatter.inc}
{$I CFDictionary.inc}
{$I CFError.inc}
{$I CFFileDescriptor.inc}
{$I CFLocale.inc}
{$I CFMachPort.inc}
{$I CFMessagePort.inc}
{$I CFNotificationCenter.inc}
{$I CFNumber.inc}
{$I CFNumberFormatter.inc}
{$I CFPlugIn.inc}
{$I CFPreferences.inc}
{$I CFPropertyList.inc}
{$I CFRunLoop.inc}
{$I CFSet.inc}
{$I CFSocket.inc}
{$I CFStream.inc}
{$I CFString.inc}
{$I CFStringEncodingExt.inc}
{$I CFStringTokenizer.inc}
{$I CFTimeZone.inc}
{$I CFTree.inc}
{$I CFURL.inc}
{$I CFURLAccess.inc}
{$I CFURLEnumerator.inc}
{$I CFUserNotification.inc}
{$I CFUUID.inc}
{$I CFXMLParser.inc}
{$I CFXMLNode.inc}

implementation

uses
  Posix.Dlfcn;

var
  _CFModule: THandle = 0;

function CFModule: THandle;
begin
  if _CFModule = 0 then
  begin
    // Call CFNullGetTypeID to force CoreFoundationLib to be loaded. That
    // will prevent dlopen from loading the module and we can safely save the
    // module handle and call dlclose without CoreCoundationLib being unloaded.
    CFNullGetTypeID;
    _CFModule := dlopen(MarshaledAString(CoreFoundationLib), RTLD_LAZY);
    dlclose(_CFModule);
  end;
  Result := _CFModule;
end;

{$I CFBaseImpl.inc}
{$I CFArrayImpl.inc}
{$I CFBagImpl.inc}
{$I CFBinaryHeapImpl.inc}
{$I CFBundleImpl.inc}
{$I CFByteOrderImpl.inc}
{$I CFDateImpl.inc}
{$I CFDateFormatterImpl.inc}
{$I CFDictionaryImpl.inc}
{$I CFErrorImpl.inc}
{$I CFLocaleImpl.inc}
{$I CFNumberImpl.inc}
{$I CFNumberFormatterImpl.inc}
{$I CFPlugInImpl.inc}
{$I CFPreferencesImpl.inc}
{$I CFRunLoopImpl.inc}
{$I CFSetImpl.inc}
{$I CFStreamImpl.inc}
{$I CFStringImpl.inc}
{$I CFTimeZoneImpl.inc}
{$I CFURLImpl.inc}
{$I CFURLAccessImpl.inc}
{$I CFUserNotificationImpl.inc}
{$I CFXMLParserImpl.inc}


end.
