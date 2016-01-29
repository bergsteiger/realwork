{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}


var
  _kCFBooleanTrue: Pointer = nil;
  _kCFBooleanFalse: Pointer = nil;

  _kCFNumberPositiveInfinity: Pointer = nil;
  _kCFNumberNegativeInfinity: Pointer = nil;
  _kCFNumberNaN: Pointer = nil;

function kCFBooleanTrue: CFBooleanRef;
begin
  if _kCFBooleanTrue = nil then
    _kCFBooleanTrue := dlsym(CFModule, MarshaledAString('kCFBooleanTrue'));
  Result := CFBooleanRef(_kCFBooleanTrue^);
end;

function kCFBooleanFalse: CFBooleanRef;
begin
  if _kCFBooleanFalse = nil then
    _kCFBooleanFalse := dlsym(CFModule, MarshaledAString('kCFBooleanFalse'));
  Result := CFBooleanRef(_kCFBooleanFalse^);
end;

function kCFNumberPositiveInfinity: CFNumberRef;
begin
  if _kCFNumberPositiveInfinity = nil then
    _kCFNumberPositiveInfinity := dlsym(CFModule, MarshaledAString('kCFNumberPositiveInfinity'));
  Result := CFNumberRef(_kCFNumberPositiveInfinity^);
end;

function kCFNumberNegativeInfinity: CFNumberRef;
begin
  if _kCFNumberNegativeInfinity = nil then
    _kCFNumberNegativeInfinity := dlsym(CFModule, MarshaledAString('kCFNumberNegativeInfinity'));
  Result := CFNumberRef(_kCFNumberNegativeInfinity^);
end;

function kCFNumberNaN: CFNumberRef;
begin
  if _kCFNumberNaN = nil then
    _kCFNumberNaN := dlsym(CFModule, MarshaledAString('kCFNumberNaN'));
  Result := CFNumberRef(_kCFNumberNaN^);
end;


