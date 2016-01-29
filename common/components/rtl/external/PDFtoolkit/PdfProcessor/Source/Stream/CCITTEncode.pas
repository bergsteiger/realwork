 { ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit CCITTEncode;

interface

uses
  Classes, Stream, gtTypes, gtObject, EncodeIntf;

//{$IFDEF CCITTENCODE}
type

 (**
  * This class is responsible for encoding of stream into CCITTFax Encoded stream
  *)

  TgtCCITTEncode = class(TgtEncode)
  private
    FStream: TgtStream;
  public
    constructor Create(AStream: TgtStream);
    destructor Destroy; override;
    function Write(OutStream: TgtStream; Count: Cardinal): Cardinal; override;
  end;
//{$ENDIF}

implementation

{ TgtCCITTEncode }

constructor TgtCCITTEncode.Create(AStream: TgtStream);
begin
  FStream := AStream;
end;

destructor TgtCCITTEncode.Destroy;
begin
  inherited;
end;

(**
 * Writes the stream into the output stream after encoding it with CCITTEncod
 *
 * @param InStream the stream that is to be encoded
 * @param OutStream the resulting stream after encoding
 * @param Count number of bytes that need to be encoded
 *
 * @return The number of bytes written into the output stream
 *)

function TgtCCITTEncode.Write(OutStream: TgtStream; Count: Cardinal): Cardinal;
begin
  Result := 0;
//Have to implement
end;

end.
