{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit ASCIIHexStream;

interface

uses
  Classes, Stream, FilterStream;

//{$IFDEF ASCIIHEX}
type

(**
 * This class is responsible for decoding and encoding of Streams in ASCIIHex
 *)

  TgtASCIIHexStream = class(TgtFilterStream)
  private
  public
    constructor Create(AStream: TgtStream);
    destructor Destroy; override;
    function GetType: TgtStreamType; override;
    function GetSize: Cardinal; override;
  end;

//{$ENDIF}

implementation

uses gtMethods, ASCIIHexEncode, ASCIIHexDecode;

{ TgtASCIIHexStream }

(**
 * Constructor
 * @param AStream the stream that need to be decoded or encoded using ASCIIHex
 *        algorithm
 *)

constructor TgtASCIIHexStream.Create(AStream: TgtStream);
begin
  FRef := 1;
  FStream := AStream;
  FDecoder := TgtASCIIHexDecode.Create(AStream);
  FEncoder := TgtASCIIHexEncode.Create(AStream);
end;

(**
 * Destructor
 *)

destructor TgtASCIIHexStream.Destroy;
begin
  FreeObject(FDecoder);
  FreeObject(FEncoder);
  inherited;
end;

function TgtASCIIHexStream.GetSize: Cardinal;
begin
  Result := 0;
end;

function TgtASCIIHexStream.GetType: TgtStreamType;
begin
  Result := stASCIIHex;
end;

end.
