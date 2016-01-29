{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit CCITTStream;

interface

uses
  Classes, Stream, FilterStream;

//{$IFDEF CCITT}
type
  TgtCCITTStream = class(TgtFilterStream)
  private
  public
    constructor Create(AStream: TgtStream; AEncoding: Integer;
      AEndOfLine: Boolean; AByteAlign: Boolean; AColumns: Integer;
      ARows: Integer; AEndOfBlock: Boolean; ABlack: Boolean;
      AStreamOwned: Boolean = False);
    destructor Destroy; override;

    function GetType: TgtStreamType; override;
    function GetSize: Cardinal; override;
  end;
//{$ENDIF}

implementation

uses gtMethods, CCITTEncode, CCITTDecode;

{ TgtCCITTStream }

(**
 * Constructor
 * @param AStream that need to be decoded
 * @param AEncoding a code identifying the encoding scheme used
 * @param AEndOfLine A flag indicating whether end-of-line bit patterns are
          required to be present in the encoding.
 * @param AByteAlign A flag indicating whether the filter expects extra 0 bits
          before each encoded line so that the line begins on a byte boundary.
 * @param AColumns The width of the image in pixels.
 * @param ARows The height of the image in scan lines.
 * @param ABlack a flag indicating whether 1 bits are to be interpreted as black
          pixels and 0 bits as white pixels.
 * @param AStreamOwned a flag indicating whether the stream is owned by the class
 *)

constructor TgtCCITTStream.Create(AStream: TgtStream; AEncoding: Integer;
  AEndOfLine, AByteAlign: Boolean; AColumns, ARows: Integer; AEndOfBlock,
  ABlack: Boolean; AStreamOwned: Boolean);
begin
  FRef := 1;  
  FStream := AStream;
  FStreamOwned := AStreamOwned;
  FDecoder := TgtCCITTDecode.Create(AStream, AEncoding, AEndOfLine, AByteAlign,
    AColumns, ARows, AEndOfBlock, ABlack);
  FEncoder := TgtCCITTEncode.Create(AStream);
end;

(**
 * Destructor
 *)

destructor TgtCCITTStream.Destroy;
begin
  if FStreamOwned then
    FreeObject(FStream);
  FreeObject(FDecoder);
  FreeObject(FEncoder);
  inherited;
end;

function TgtCCITTStream.GetSize: Cardinal;
begin
  Result := 0;
end;

function TgtCCITTStream.GetType: TgtStreamType;
begin
  Result := stCCITTFax;
end;

end.
