{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit RunLengthStream;

interface

uses
  Classes, Stream, FilterStream;

//{$IFDEF RUNLENGTH}
type

 (**
  * This class is responsible for encoding and decoding of RunLength stream
  *)

  TgtRunLengthStream = class(TgtFilterStream)
  private
  public
    constructor Create(AStream: TgtStream; AStreamOwned: Boolean = False);
    destructor Destroy; override;

    function GetType: TgtStreamType; override;
    function GetSize: Cardinal; override;
  end;
//{$ENDIF}

implementation

uses gtMethods, RunLengthEncode, RunLengthDecode;

{ TgtRunLengthStream }

(**
 * Constructor
 * @param AStream is the stream that need to be encoded with RunLength
 * @param AStreamOwned this flag detarmines that if the class owns the stream or not
 *)

constructor TgtRunLengthStream.Create(AStream: TgtStream;
  AStreamOwned: Boolean);
begin
  FRef := 1;
  FStream := AStream;
  FStreamOwned := AStreamOwned;
  FDecoder := TgtRunLengthDecode.Create(AStream);
  FEncoder := TgtRunLengthEncode.Create(AStream);
end;

destructor TgtRunLengthStream.Destroy;
begin
  if FStreamOwned then
    FreeObject(FStream);
  FreeObject(FDecoder);
  FreeObject(FEncoder);
  inherited;
end;

function TgtRunLengthStream.GetSize: Cardinal;
begin
  Result := 0;
end;

function TgtRunLengthStream.GetType: TgtStreamType;
begin
  Result := stRunLength;
end;

end.
