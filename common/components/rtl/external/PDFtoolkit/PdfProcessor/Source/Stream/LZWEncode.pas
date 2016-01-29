{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit LZWEncode;

interface
uses
  Classes, gtObject, gtTypes, EncodeIntf, Stream;

//{$IFDEF LZWENCODE}
type
  TgtLZWEncode = class(TgtEncode)
  private
    { private declarations }
    FStream: TgtStream;
  public
    { public declarations }
    constructor create(AStream: TgtStream);
    function Write(OutStream: TgtStream; Count: Cardinal): Cardinal; override;
  end;
//{$ENDIF}

implementation

{ TgtLZWEncode }

constructor TgtLZWEncode.create(AStream: TgtStream);
begin
  FStream := AStream;
end;

function TgtLZWEncode.Write(OutStream: TgtStream; Count: Cardinal): Cardinal;
begin
  Result := 0;
end;

end.
