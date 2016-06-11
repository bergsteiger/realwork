{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.Rect;

interface

(*$HPPEMIT '#include <android/rect.h>' *)

{$I Androidapi.inc}

type
  ARect = record
    left: Int32;
    top: Int32;
    right: Int32;
    bottom: Int32;
  end;
  {$EXTERNALSYM ARect}
  PARect = ^ARect;
  
implementation

end.

