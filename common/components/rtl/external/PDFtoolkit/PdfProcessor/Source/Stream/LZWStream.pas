{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit LZWStream;

interface

uses
  Classes, Stream, FilterStream, LZWEncode, LZWDecode;

//{$IFDEF LZW}
type
  TgtLZWStream = class(TgtFilterStream)
  private
    {Private Declarations}
  public
     { public declarations }
    constructor Create(AStream: TgtStream; StreamOwned: Boolean;
      APredictor: Integer; AColumns: Integer; AColor: Integer;
      ABits: Integer; AEarlyChange: Integer);
    destructor Destroy; override;

    function GetType: TgtStreamType; override;
    function GetSize: Cardinal; override;

  end;
//{$ENDIF}

implementation

uses
  gtMethods;

{ TgtLZWStream }

(**
 * Constructor
 * @param AStream that need to be decoded
 * @param AStreamOwned a flag which indicates whether stream is owned by this class
 * @param APredictor A code that selects the predictor algorithm, if any
 * @param AColumns The number of samples in each row. Default value: 1
 * @param AColor The number of interleaved color components per sample
 * @param ABits The number of bits used to represent each color component in a
 *          sample. Default value: 8.
 * @param AEarlyChange An indication of when to increase the code length.
 *)

constructor TgtLZWStream.Create(AStream: TgtStream; StreamOwned: Boolean;
  APredictor, AColumns, AColor, ABits, AEarlyChange: Integer);
begin
  FStream := AStream;
  FStreamOwned := StreamOwned;
  FEncoder := TgtLZWEncode.Create(Astream);
  FRef := 1;
  FDecoder := TgtLZWDecode.Create(Self, AStream, APredictor, AColumns,
    AColor, ABits, AEarlyChange);
end;


destructor TgtLZWStream.Destroy;
begin
  if FStreamOwned then
    FreeObject(FStream);
  FreeObject(FEncoder);
  FreeObject(FDecoder);
  inherited;
end;

function TgtLZWStream.GetSize: Cardinal;
begin
  Result := 0;
end;

function TgtLZWStream.GetType: TgtStreamType;
begin
  Result := stLZW;
end;

end.
