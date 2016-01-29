{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}


var
  _kCFXMLTreeErrorDescription: Pointer = nil;
  _kCFXMLTreeErrorLineNumber: Pointer = nil;
  _kCFXMLTreeErrorLocation: Pointer = nil;
  _kCFXMLTreeErrorStatusCode: Pointer = nil;

function kCFXMLTreeErrorDescription: CFStringRef;
begin
  if _kCFXMLTreeErrorDescription = nil then
    _kCFXMLTreeErrorDescription := dlsym(CFModule, MarshaledAString('kCFXMLTreeErrorDescription'));
  Result := CFStringRef(_kCFXMLTreeErrorDescription^);
end;

function kCFXMLTreeErrorLineNumber: CFStringRef;
begin
  if _kCFXMLTreeErrorLineNumber = nil then
    _kCFXMLTreeErrorLineNumber := dlsym(CFModule, MarshaledAString('kCFXMLTreeErrorLineNumber'));
  Result := CFStringRef(_kCFXMLTreeErrorLineNumber^);
end;

function kCFXMLTreeErrorLocation: CFStringRef;
begin
  if _kCFXMLTreeErrorLocation = nil then
    _kCFXMLTreeErrorLocation := dlsym(CFModule, MarshaledAString('kCFXMLTreeErrorLocation'));
  Result := CFStringRef(_kCFXMLTreeErrorLocation^);
end;

function kCFXMLTreeErrorStatusCode: CFStringRef;
begin
  if _kCFXMLTreeErrorStatusCode = nil then
    _kCFXMLTreeErrorStatusCode := dlsym(CFModule, MarshaledAString('kCFXMLTreeErrorStatusCode'));
  Result := CFStringRef(_kCFXMLTreeErrorStatusCode^);
end;

