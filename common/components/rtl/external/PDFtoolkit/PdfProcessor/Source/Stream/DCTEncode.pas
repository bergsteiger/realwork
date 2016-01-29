{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit DCTEncode;

interface

uses
  Classes, gtObject, gtTypes, EncodeIntf, Stream;

//{$IFDEF DCTENCODE}
type
  TgtDCTEncode = class(TgtEncode)
  private
    { private declarations }
    FStream: TgtStream;
  public
    { public declarations }
    constructor create(AStream: TgtStream);
    destructor Destroy; override;
    function Write(OutStream: TgtStream; Count: Cardinal): Cardinal; override;
  end;
//{$ENDIF}

implementation

{ TgtDCTEncode }

constructor TgtDCTEncode.create(AStream: TgtStream);
begin
  FStream := AStream;
end;

destructor TgtDCTEncode.Destroy;
begin

  inherited;
end;

function TgtDCTEncode.Write(OutStream: TgtStream; Count: Cardinal): Cardinal;
begin
  Result := 0;
end;

end.
