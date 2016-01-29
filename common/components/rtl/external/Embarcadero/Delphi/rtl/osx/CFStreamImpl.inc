{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}


var
  _kCFStreamPropertyDataWritten: Pointer = nil;
  _kCFStreamPropertyFileCurrentOffset: Pointer = nil;
  _kCFStreamPropertyAppendToFile: Pointer = nil;
  _kCFStreamPropertySocketNativeHandle: Pointer = nil;
  _kCFStreamPropertySocketRemoteHostName: Pointer = nil;
  _kCFStreamPropertySocketRemotePortNumber: Pointer = nil;

function kCFStreamPropertyDataWritten: CFStringRef;
begin
  if _kCFStreamPropertyDataWritten = nil then
    _kCFStreamPropertyDataWritten := dlsym(CFModule, MarshaledAString('kCFStreamPropertyDataWritten'));
  Result := CFStringRef(_kCFStreamPropertyDataWritten^);
end;

function kCFStreamPropertyFileCurrentOffset: CFStringRef;
begin
  if _kCFStreamPropertyFileCurrentOffset = nil then
    _kCFStreamPropertyFileCurrentOffset := dlsym(CFModule, MarshaledAString('kCFStreamPropertyFileCurrentOffset'));
  Result := CFStringRef(_kCFStreamPropertyFileCurrentOffset^);
end;

function kCFStreamPropertyAppendToFile: CFStringRef;
begin
  if _kCFStreamPropertyAppendToFile = nil then
    _kCFStreamPropertyAppendToFile := dlsym(CFModule, MarshaledAString('kCFStreamPropertyAppendToFile'));
  Result := CFStringRef(_kCFStreamPropertyAppendToFile^);
end;

function kCFStreamPropertySocketNativeHandle: CFStringRef;
begin
  if _kCFStreamPropertySocketNativeHandle = nil then
    _kCFStreamPropertySocketNativeHandle := dlsym(CFModule, MarshaledAString('kCFStreamPropertySocketNativeHandle'));
  Result := CFStringRef(_kCFStreamPropertySocketNativeHandle^);
end;

function kCFStreamPropertySocketRemoteHostName: CFStringRef;
begin
  if _kCFStreamPropertySocketRemoteHostName = nil then
    _kCFStreamPropertySocketRemoteHostName := dlsym(CFModule, MarshaledAString('kCFStreamPropertySocketRemoteHostName'));
  Result := CFStringRef(_kCFStreamPropertySocketRemoteHostName^);
end;

function kCFStreamPropertySocketRemotePortNumber: CFStringRef;
begin
  if _kCFStreamPropertySocketRemotePortNumber = nil then
    _kCFStreamPropertySocketRemotePortNumber := dlsym(CFModule, MarshaledAString('kCFStreamPropertySocketRemotePortNumber'));
  Result := CFStringRef(_kCFStreamPropertySocketRemotePortNumber^);
end;

