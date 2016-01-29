{**********************************************************}
{                                                          }
{           CodeGear Delphi Runtime Library                }
{                                                          }
{ Delphi-Objective-C Bridge                                }
{ Interfaces for Cocoa framework CoreTelephony             }
{                                                          }
{ Copyright (c) 2010, Apple Inc. All rights reserved.      }
{                                                          }
{ Translator: Embarcadero Technologies, Inc.               }
{   Copyright(c) 2012-2013 Embarcadero Technologies, Inc.  }
{                                                          }
{**********************************************************}

unit iOSapi.CoreTelephony;

interface

uses Macapi.ObjectiveC, iOSapi.CocoaTypes, iOSapi.Foundation;


// ===== External functions =====

const
  libCoreTelephony = '/System/Library/Frameworks/CoreTelephony.framework/CoreTelephony';


type
{$M+}
// ===== Forward declarations =====

  CTCarrier = interface;
  CTTelephonyNetworkInfo = interface;
  CTCall = interface;
  CTCallCenter = interface;

// ===== Interface declarations =====

  CTCarrierClass = interface(NSObjectClass)
    ['{FA14F6EF-18EF-4AE0-A115-5D5819B05A32}']
  end;
  CTCarrier = interface(NSObject)
    ['{7FF111BF-7573-4BD2-881F-0B614DD5C01E}']
    function allowsVOIP: Boolean; cdecl;
    function carrierName: NSString; cdecl;
    function isoCountryCode: NSString; cdecl;
    function mobileCountryCode: NSString; cdecl;
    function mobileNetworkCode: NSString; cdecl;
  end;
  TCTCarrier = class(TOCGenericImport<CTCarrierClass, CTCarrier>)  end;

  TCellularProviderNotifier = procedure(const Data: CTCarrier) of object;
  CTTelephonyNetworkInfoClass = interface(NSObjectClass)
    ['{28EB8488-EE8F-4967-B8A8-6BF96AD4382D}']
  end;
  CTTelephonyNetworkInfo = interface(NSObject)
    ['{F75CE940-A78E-4C64-812E-0576386B582D}']
    function subscriberCellularProvider: CTCarrier; cdecl;
    procedure setSubscriberCellularProviderDidUpdateNotifier(Handler: TCellularProviderNotifier); cdecl;
  end;
  TCTTelephonyNetworkInfo = class(TOCGenericImport<CTTelephonyNetworkInfoClass, CTTelephonyNetworkInfo>)  end;

  CTCallClass = interface(NSObjectClass)
    ['{1FA8C69C-57FA-4607-ACBA-547C9636312F}']
  end;
  CTCall = interface(NSObject)
    ['{31625956-A516-437B-A385-7DF292D6FB5A}']
    function callID: NSString; cdecl;
    function callState: NSString; cdecl;
  end;
  TCTCall = class(TOCGenericImport<CTCallClass, CTCall>)  end;

  TCallEventHandler = procedure(const Data: CTCall) of object;
  CTCallCenterClass = interface(NSObjectClass)
    ['{A28B0E07-ED5A-4C05-82DA-E9FE4073E14D}']
  end;
  CTCallCenter = interface(NSObject)
    ['{0FDB7AC7-B379-4E20-8D72-F1C11EA32EB6}']
    procedure setCallEventHandler(EventHandler: TCallEventHandler); cdecl;
    function currentCalls: NSSet; cdecl;
  end;
  TCTCallCenter = class(TOCGenericImport<CTCallCenterClass, CTCallCenter>)  end;

// exported string consts

function CTCallStateDialing: NSString;
function CTCallStateIncoming: NSString;
function CTCallStateConnected: NSString;
function CTCallStateDisconnected: NSString;

implementation

const
  CoreTelephonyFwk: string = '/System/Library/Frameworks/CoreTelephony.framework/CoreTelephony';

function CTCallStateDialing: NSString;
begin
  Result := CocoaNSStringConst(CoreTelephonyFwk, 'CTCallStateDialing');
end;

function CTCallStateIncoming: NSString;
begin
  Result := CocoaNSStringConst(CoreTelephonyFwk, 'CTCallStateIncoming');
end;

function CTCallStateConnected: NSString;
begin
  Result := CocoaNSStringConst(CoreTelephonyFwk, 'CTCallStateConnected');
end;

function CTCallStateDisconnected: NSString;
begin
  Result := CocoaNSStringConst(CoreTelephonyFwk, 'CTCallStateDisconnected');
end;

end.
