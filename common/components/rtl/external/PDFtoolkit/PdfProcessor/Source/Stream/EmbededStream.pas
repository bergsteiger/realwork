{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit EmbededStream;

interface

uses
  Classes, Stream, BaseStream, gtTypes;

type
  TgtEmbededStream = class(TgtBaseStream)
  private
    { private declarations }
    FStream: TgtStream;
    FLength: Longint;
    FLimited: Boolean;
  public
    { public declarations }
    constructor Create(AStream: TgtStream; ALength: Integer; ALimited: Boolean);
    destructor Destroy; override;
    function MakeSubStream(AStart: Longint; ALength: Longint;
      ALimited: Boolean): TgtStream; override;
    function GetStart: Longint; override;

    procedure Reset; override;
    function LookChar: Integer; override;
    function GetType: TgtStreamType; override;
    function GetChar: Integer; override;
    function GetPosition: Int64; override;
    procedure MoveStart(Delta: Int64); override;
    function Read(var Buffer: Bytes; Count: Cardinal): Cardinal; override;
    function Write(const Buffer: Bytes; Count: Cardinal): Cardinal; override;
    procedure SetPosition(APosition: LongInt; ADirection: TSeekOrigin); override;
    function GetSize: Cardinal; override;


  end;

implementation

uses
  StreamConsts
{$IFDEF DEBUG}
  , gtLogger
{$ENDIF};

{ TgtEmbedStream }

constructor TgtEmbededStream.Create(AStream: TgtStream; ALength: Integer;
  ALimited: Boolean);
begin
  FStream := AStream;
  FLength := ALength;
  FLimited := ALimited;
  FRef := 1;
end;

destructor TgtEmbededStream.Destroy;
begin

  inherited;
end;

function TgtEmbededStream.GetPosition: Int64;
begin
  Result := FStream.GetPosition;
end;

function TgtEmbededStream.GetSize: Cardinal;
begin
  Result := FLength;
end;

function TgtEmbededStream.GetStart: Longint;
begin
{$IFDEF DEBUG}
  Logger.LogError('Internal: called GetStart() on EmbedStream');
{$ENDIF}
  Result := 0;
end;

function TgtEmbededStream.GetType: TgtStreamType;
begin
  Result := stWeird;
end;

function TgtEmbededStream.LookChar: Integer;
begin
  if FLimited and (FLength = 0) then
    Result := EndofFile
  else
    Result := FStream.LookChar;
end;

function TgtEmbededStream.MakeSubStream(AStart, ALength: Longint;
  ALimited: Boolean): TgtStream;
begin
{$IFDEF DEBUG}
  Logger.LogError('Internal: called MakeSubStream() on EmbedStream');
{$ENDIF}
  Result := nil;
end;

procedure TgtEmbededStream.MoveStart(Delta: Int64);
begin
{$IFDEF DEBUG}
  Logger.LogError('Internal: called MoveStart() on EmbedStream');
{$ENDIF}
end;

function TgtEmbededStream.Read(var Buffer: Bytes; Count: Cardinal): Cardinal;
begin
  Result := 0;
end;

function TgtEmbededStream.GetChar: Integer;
begin
  if FLimited and (FLength = 0) then
    Result := EndofFile
  else
  begin
    Dec(FLength);
    Result := FStream.GetChar;
  end;
end;

procedure TgtEmbededStream.Reset;
begin
  inherited;
//  FStream.Reset;
end;

procedure TgtEmbededStream.SetPosition(APosition: Integer;
  ADirection: TSeekOrigin);
begin
{$IFDEF DEBUG}
  Logger.LogError('Internal: called SetPosition() on EmbedStream');
{$ENDIF}
end;

function TgtEmbededStream.Write(const Buffer: Bytes; Count: Cardinal): Cardinal;
begin
  Result := 0;
end;

end.
