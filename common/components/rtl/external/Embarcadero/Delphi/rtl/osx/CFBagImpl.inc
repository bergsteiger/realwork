{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}


var
  _kCFTypeBagCallBacks: Pointer = nil;
  _kCFCopyStringBagCallBacks: Pointer = nil;

function kCFTypeBagCallBacks: CFBagCallBacks;
begin
  if _kCFTypeBagCallBacks = nil then
    _kCFTypeBagCallBacks := dlsym(CFModule, MarshaledAString('kCFTypeBagCallBacks'));
  Result := CFBagCallBacks(_kCFTypeBagCallBacks^);
end;

function kCFCopyStringBagCallBacks: CFBagCallBacks;
begin
  if _kCFCopyStringBagCallBacks = nil then
    _kCFCopyStringBagCallBacks := dlsym(CFModule, MarshaledAString('kCFCopyStringBagCallBacks'));
  Result := CFBagCallBacks(_kCFCopyStringBagCallBacks^);
end;

