{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}


var
  _kCFTypeDictionaryKeyCallBacks: Pointer = nil;
  _kCFCopyStringDictionaryKeyCallBacks: Pointer = nil;
  _kCFTypeDictionaryValueCallBacks: Pointer = nil;

function kCFTypeDictionaryKeyCallBacks: CFDictionaryKeyCallBacks;
begin
  if _kCFTypeDictionaryKeyCallBacks = nil then
    _kCFTypeDictionaryKeyCallBacks := dlsym(CFModule, MarshaledAString('kCFTypeDictionaryKeyCallBacks'));
  Result := CFDictionaryKeyCallBacks(_kCFTypeDictionaryKeyCallBacks^);
end;

function kCFCopyStringDictionaryKeyCallBacks: CFDictionaryKeyCallBacks;
begin
  if _kCFCopyStringDictionaryKeyCallBacks = nil then
    _kCFCopyStringDictionaryKeyCallBacks := dlsym(CFModule, MarshaledAString('kCFCopyStringDictionaryKeyCallBacks'));
  Result := CFDictionaryKeyCallBacks(_kCFCopyStringDictionaryKeyCallBacks^);
end;

function kCFTypeDictionaryValueCallBacks: CFDictionaryValueCallBacks;
begin
  if _kCFTypeDictionaryValueCallBacks = nil then
    _kCFTypeDictionaryValueCallBacks := dlsym(CFModule, MarshaledAString('kCFTypeDictionaryValueCallBacks'));
  Result := CFDictionaryValueCallBacks(_kCFTypeDictionaryValueCallBacks^);
end;

