{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}


var
  _kCFPreferencesAnyApplication: Pointer = nil;
  _kCFPreferencesCurrentApplication: Pointer = nil;
  _kCFPreferencesAnyHost: Pointer = nil;
  _kCFPreferencesCurrentHost: Pointer = nil;
  _kCFPreferencesAnyUser: Pointer = nil;
  _kCFPreferencesCurrentUser: Pointer = nil;

function kCFPreferencesAnyApplication: CFStringRef;
begin
  if _kCFPreferencesAnyApplication = nil then
    _kCFPreferencesAnyApplication := dlsym(CFModule, MarshaledAString('kCFPreferencesAnyApplication'));
  Result := CFStringRef(_kCFPreferencesAnyApplication^);
end;

function kCFPreferencesCurrentApplication: CFStringRef;
begin
  if _kCFPreferencesCurrentApplication = nil then
    _kCFPreferencesCurrentApplication := dlsym(CFModule, MarshaledAString('kCFPreferencesCurrentApplication'));
  Result := CFStringRef(_kCFPreferencesCurrentApplication^);
end;

function kCFPreferencesAnyHost: CFStringRef;
begin
  if _kCFPreferencesAnyHost = nil then
    _kCFPreferencesAnyHost := dlsym(CFModule, MarshaledAString('kCFPreferencesAnyHost'));
  Result := CFStringRef(_kCFPreferencesAnyHost^);
end;

function kCFPreferencesCurrentHost: CFStringRef;
begin
  if _kCFPreferencesCurrentHost = nil then
    _kCFPreferencesCurrentHost := dlsym(CFModule, MarshaledAString('kCFPreferencesCurrentHost'));
  Result := CFStringRef(_kCFPreferencesCurrentHost^);
end;

function kCFPreferencesAnyUser: CFStringRef;
begin
  if _kCFPreferencesAnyUser = nil then
    _kCFPreferencesAnyUser := dlsym(CFModule, MarshaledAString('kCFPreferencesAnyUser'));
  Result := CFStringRef(_kCFPreferencesAnyUser^);
end;

function kCFPreferencesCurrentUser: CFStringRef;
begin
  if _kCFPreferencesCurrentUser = nil then
    _kCFPreferencesCurrentUser := dlsym(CFModule, MarshaledAString('kCFPreferencesCurrentUser'));
  Result := CFStringRef(_kCFPreferencesCurrentUser^);
end;

