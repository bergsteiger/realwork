{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}


var
  _kCFAbsoluteTimeIntervalSince1970: Pointer = nil;
  _kCFAbsoluteTimeIntervalSince1904: Pointer = nil;

function kCFAbsoluteTimeIntervalSince1970: CFTimeInterval;
begin
  if _kCFAbsoluteTimeIntervalSince1970 = nil then
    _kCFAbsoluteTimeIntervalSince1970 := dlsym(CFModule, MarshaledAString('kCFAbsoluteTimeIntervalSince1970'));
  Result := CFTimeInterval(_kCFAbsoluteTimeIntervalSince1970^);
end;

function kCFAbsoluteTimeIntervalSince1904: CFTimeInterval;
begin
  if _kCFAbsoluteTimeIntervalSince1904 = nil then
    _kCFAbsoluteTimeIntervalSince1904 := dlsym(CFModule, MarshaledAString('kCFAbsoluteTimeIntervalSince1904'));
  Result := CFTimeInterval(_kCFAbsoluteTimeIntervalSince1904^);
end;

