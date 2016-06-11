{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}


var
  _kCFTypeSetCallBacks: Pointer = nil;
  _kCFCopyStringSetCallBacks: Pointer = nil;

function kCFTypeSetCallBacks: CFSetCallBacks;
begin
  if _kCFTypeSetCallBacks = nil then
    _kCFTypeSetCallBacks := dlsym(CFModule, MarshaledAString('kCFTypeSetCallBacks'));
  Result := CFSetCallBacks(_kCFTypeSetCallBacks^);
end;

function kCFCopyStringSetCallBacks: CFSetCallBacks;
begin
  if _kCFCopyStringSetCallBacks = nil then
    _kCFCopyStringSetCallBacks := dlsym(CFModule, MarshaledAString('kCFCopyStringSetCallBacks'));
  Result := CFSetCallBacks(_kCFCopyStringSetCallBacks^);
end;

