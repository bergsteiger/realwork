{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit DCTStream;

interface

uses
  Classes, Stream, FilterStream;

//{$IFDEF DCT}
type
  TgtDCTStream = class(TgtFilterStream)
  private
    { private declarations }
  public
    { public declarations }
    constructor Create(Astream: TgtStream; StreamOwned: Boolean;
      AColorXForm: Integer);
    destructor Destroy; override;

    function GetType: TgtStreamType; override;
    function Stream: TgtStream;
    function GetSize: Cardinal; override;

  end;
//{$ENDIF}

implementation

//{$IFDEF DCT}
uses
  gtMethods, DCTDecode, DCTEncode;

{ TgtDCTStream }

(**
 * Constructor
 * @param AStream the stream that need to be decoded
 * @param AStreamOwned a flag which indicates whether stream is owned by this class
 * @param AColorXForm A code specifying the transformation to be performed on
 * the sample values:
 *)

constructor TgtDCTStream.Create(Astream: TgtStream; StreamOwned: Boolean;
  AColorXForm: Integer);
begin
  FRef := 1;
  FStream := Astream;
  FStreamOwned := StreamOwned;
  FEncoder := TgtDCTEncode.Create(Astream);
  FDecoder := TgtDCTDecode.Create(Astream, AColorXForm);
end;

destructor TgtDCTStream.Destroy;
begin
  FreeObject(FEncoder);
  FreeObject(FDecoder);
  inherited;
end;

function TgtDCTStream.GetSize: Cardinal;
begin
  Result := 0;
end;

function TgtDCTStream.GetType: TgtStreamType;
begin
  Result := stDCT;
end;

function TgtDCTStream.Stream: TgtStream;
begin
  Result := FStream;
end;

//{$ENDIF}
end.
