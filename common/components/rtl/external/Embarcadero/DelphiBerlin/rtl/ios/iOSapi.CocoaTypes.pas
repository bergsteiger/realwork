{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit iOSapi.CocoaTypes;

interface

type
{$M+}
  NSUInteger = LongWord;
  PNSUInteger = ^NSUInteger;
  NSInteger = LongInt;
  PNSInteger = ^NSInteger;
  NSTimeInterval = Double;
  PNSTimeInterval = ^NSTimeInterval;
  {$IF defined(CPU32BITS)}
  CGFloat = Single;
  {$ELSEIF defined(CPU64BITS)}
  CGFloat = Double;
  {$ENDIF}
  PCGFloat = ^CGFloat;
  PUInt16 = ^Int16;

implementation

end.
