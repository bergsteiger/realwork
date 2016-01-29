{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit JPXStream;

interface

uses
  Classes, Stream, FilterStream, JPXDecode;

type
  TgtJPXStream = class(TgtFilterStream)
    constructor Create(AStream: TgtStream; AStreamOwned: Boolean = False);
    destructor Destroy; override;

    function GetType: TgtStreamType; override;
    function GetSize: Cardinal; override;
  end;

implementation

{ TgtJPXStream }

constructor TgtJPXStream.Create(AStream: TgtStream; AStreamOwned: Boolean);
begin
  FRef := 1;
  FStream := AStream;
  FStreamOwned := AStreamOwned;

  FDecoder := TgtJPXDecode.Create(AStream);
  FEncoder := nil;
end;

destructor TgtJPXStream.Destroy;
begin
  inherited;
end;

function TgtJPXStream.GetSize: Cardinal;
begin
  Result := 0;
end;

function TgtJPXStream.GetType: TgtStreamType;
begin
  Result := stJPX;
end;

end.
