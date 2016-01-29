{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit FlateEncode;

interface

uses gtTypes, gtObject, Stream, EncodeIntf;

type

 (**
  * This class is used for encoding a stream in to Flate encoded stream.
  *)

  TgtFlateEncode = class(TgtEncode)
  private
  { private declarations }
    FStream: TgtStream;
  public
  { public declarations }
    constructor Create(AStream: TgtStream);
    destructor Destroy; override;
    function Write(OutStream: TgtStream; Count: Cardinal): Cardinal; overload; override;
    function Write(Buffer: AnsiString; Count: Cardinal): Cardinal; overload; override;
  end;

implementation

uses Classes, gtPDZLIB, StreamExceptions;

{ TgtFlateEncode }

(**
 * Constructor
*)

constructor TgtFlateEncode.Create(AStream: TgtStream);
begin
  FStream := AStream;
end;

(**
 * Destructor
*)

destructor TgtFlateEncode.Destroy;
begin

  inherited;
end;

function TgtFlateEncode.Write(Buffer: AnsiString; Count: Cardinal): Cardinal;
var
  LInputStream, LOutStream: TMemoryStream;
  LCmprStream: TCompressionStream;
begin
  LInputStream := TMemoryStream.Create;
  LOutStream := TMemoryStream.Create;
  LCmprStream := TCompressionStream.Create(clFastest, LOutStream);
  try
    LInputStream.Write(Buffer[1], Count);
    LInputStream.Position := 0;
    LCmprStream.CopyFrom(LInputStream, 0);
    LCmprStream.Free;
    LOutStream.Position := 0;
    LOutStream.Read(Buffer[1], LOutStream.Size);
  finally

    LInputStream.Free;
    LOutStream.Free;
  end;

  Result := FStream.Write(Buffer);
end;

(**
 * Writes the stream into the output stream after encoding it with Flate
 *
 * @param InStream the stream that is to be encoded
 * @param OutStream the resulting stream after encoding
 * @param Count number of bytes that need to be encoded
 *
 * @return The number of bytes written into the output stream
 *
 * @exception ExCompressionError will be raised on error while compressing stream
 *)

function TgtFlateEncode.Write(OutStream: TgtStream; Count: Cardinal): Cardinal;
var
  LCmprStream: TCompressionStream;
  LTempInStream, LTempOutStream: TStream;
begin
  try
    LTempOutStream := OutStream.GetTStream;
    LCmprStream := TCompressionStream.Create(clFastest, LTempOutStream);
    LTempInStream := FStream.GetTStream;
    LCmprStream.CopyFrom(LTempInStream, 0);
    LCmprStream.Free;
    Result := LTempOutStream.Size;
  except
    on E: EZCompressionError do
      raise ExCompressionError.Create(ErrCompression + ' ' + E.Message);
  end;
end;

end.
