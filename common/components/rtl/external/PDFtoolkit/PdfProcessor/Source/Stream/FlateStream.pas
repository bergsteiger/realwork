{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit FlateStream;

interface

uses
  Classes, Stream, FilterStream;

//{$IFDEF FLATE}
type

 (**
  * This class is responsible for encoding and decoding of Flate stream
  *)

  TgtFlateStream = class(TgtFilterStream)
  private
  public
    constructor Create(AStream: TgtStream; APredictor: Integer;
      AColumns: Integer; AColors: Integer; ABits: Integer;
      AStreamOwned: Boolean = False);
    destructor Destroy; override;

    function GetType: TgtStreamType; override;
    function GetSize: Cardinal; override;
  end;
//{$ENDIF}

implementation

uses gtMethods, FlateEncode, FlateDecode;

{ TgtFlateStream }

(**
 * Constructor
 * @param AStream the stream that need to be decoded
 * @param APredictor a code that selects the predictor algorithm
 * @param AColumns The number of samples in each row.
 * @param AColors The number of interleaved color components per sample.
 * @param ABits The number of bits used to represent each color component in a
          sample. Valid values are 1, 2, 4, 8, 16
 * @param AStreamOwned a flag which indicates whether stream is owned by this class
 *)

constructor TgtFlateStream.Create(AStream: TgtStream; APredictor, AColumns,
  AColors, ABits: Integer; AStreamOwned: Boolean);
begin
  FRef := 1;
  FStream := AStream;
  FStreamOwned := AStreamOwned;
  FDecoder := TgtFlateDecode.Create(Self, AStream, APredictor,
    AColumns, AColors, ABits);

  FEncoder := TgtFlateEncode.Create(AStream);
end;

(**
 * Destructor
 *)

destructor TgtFlateStream.Destroy;
begin
  if FStreamOwned then
    FreeObject(FStream);
  FreeObject(FEncoder);
  FreeObject(FDecoder);
  inherited;
end;

function TgtFlateStream.GetSize: Cardinal;
begin
  Result := 0;
end;

function TgtFlateStream.GetType: TgtStreamType;
begin
  Result := stFlate;
end;

end.
