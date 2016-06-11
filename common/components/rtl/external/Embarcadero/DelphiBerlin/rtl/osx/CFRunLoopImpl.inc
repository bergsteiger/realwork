{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

var
  _kCFRunLoopDefaultMode: Pointer = nil;
  _kCFRunLoopCommonModes: Pointer = nil;

function kCFRunLoopDefaultMode: CFStringRef;
begin
  if _kCFRunLoopDefaultMode = nil then
    _kCFRunLoopDefaultMode := dlsym(CFModule, MarshaledAString('kCFRunLoopDefaultMode'));
  Result := CFStringRef(_kCFRunLoopDefaultMode^);
end;

function kCFRunLoopCommonModes: CFStringRef;
begin
  if _kCFRunLoopCommonModes = nil then
    _kCFRunLoopCommonModes := dlsym(CFModule, MarshaledAString('kCFRunLoopCommonModes'));
  Result := CFStringRef(_kCFRunLoopCommonModes^);
end;
