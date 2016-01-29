{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit iOSapi.CocoaTypes;

interface

uses
  Macapi.ObjectiveC, Macapi.ObjCRuntime;

type
{$M+}
  NSUInteger = Longword;
  PNSUInteger = ^NSUInteger;
  NSInteger = Integer;
  PNSInteger = ^NSInteger;
  NSTimeInterval = Double;
  PNSTimeInterval = ^NSTimeInterval;
  CGFloat = Single;


// Base Cocoa NSObject
  NSObjectClass = interface(IObjectiveCClass)
    ['{84CDD025-E02A-4128-B1AC-35A7A5A4643B}']
    procedure cancelPreviousPerformRequestsWithTarget(target: Pointer); cdecl;
  end;
  NSObject = interface(IObjectiveCInstance)
    ['{C8CC567E-50C3-461C-BAA7-AD96D2CDC5C6}']
    procedure retain; cdecl;
    procedure release; cdecl;
    function retainCount: Integer; cdecl;
    function isKindOfClass(cls: Pointer): Boolean; cdecl;
    function isMemberOfClass(cls: Pointer): Boolean; cdecl;
    procedure performSelector(aSelector: SEL; withObject: Pointer; afterDelay: NSTimeInterval); cdecl;
  end;
  TNSObject = class(TOCGenericImport<NSObjectClass, NSObject>) end;

implementation

end.
