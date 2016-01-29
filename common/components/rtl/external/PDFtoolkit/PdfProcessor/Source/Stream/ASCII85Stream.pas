{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit ASCII85Stream;

interface

uses
  Classes, Stream, FilterStream, ASCII85Decode, ASCII85Encode;

//{$IFDEF ASCII85}

type
  TgtASCII85Stream = class(TgtFilterStream)
  private
    { private declarations }

  public
    { public declarations }
    constructor Create(Astream: TgtStream; StreamOwned: Boolean);
    destructor Destroy; override;
    function GetType: TgtStreamType; override;
    function GetSize: Cardinal; override;
  end;

//{$ENDIF}

implementation

uses
  gtMethods;

//{$IFDEF ASCII85}
  { TgtASCII85Stream }

constructor TgtASCII85Stream.Create(Astream: TgtStream; StreamOwned: Boolean);
begin
  FRef := 1;
  FStream := Astream;
  FStreamOwned := StreamOwned;
  FEncoder := TgtASCII85Encode.Create(FStream);
  FDecoder := TgtASCII85Decode.Create(FStream);
end;

destructor TgtASCII85Stream.Destroy;
begin
  if FStreamOwned then
    FreeObject(FStream);
  FreeObject(FEncoder);
  FreeObject(FDecoder);
  inherited;
end;

function TgtASCII85Stream.GetSize: Cardinal;
begin
  Result := 0;
end;

function TgtASCII85Stream.GetType: TgtStreamType;
begin
  Result := stASCII85;
end;

//{$ENDIF}
end.
