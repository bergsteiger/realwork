{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}


var
  _kCFTimeZoneSystemTimeZoneDidChangeNotification: Pointer = nil;

function kCFTimeZoneSystemTimeZoneDidChangeNotification: CFStringRef;
begin
  if _kCFTimeZoneSystemTimeZoneDidChangeNotification = nil then
    _kCFTimeZoneSystemTimeZoneDidChangeNotification := dlsym(CFModule, MarshaledAString('kCFTimeZoneSystemTimeZoneDidChangeNotification'));
  Result := _kCFTimeZoneSystemTimeZoneDidChangeNotification;
end;
