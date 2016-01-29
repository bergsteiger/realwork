{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit MemoryStream;

interface

uses
  Classes, Stream, BaseStream, gtTypes;

type
  TgtMemoryStream = class(TgtBaseStream)
  private
  { private declarations }
    FMemStream: TMemoryStream;
    FStart: LongWord;
    FLength: LongWord;
    FSavedPos: Integer;
    FLimited: Boolean;
    FisSaved: Boolean;
    FIsOwned: Boolean;
  public
  { public declarations }
    constructor Create(AMemStream: TMemoryStream; AStart: LongWord; ALength:
      LongWord; ALimited: Boolean; AIsOwned: Boolean = True);
    function MakeSubStream(AStart: Longint; ALength: Longint;
      ALimited: Boolean): TgtStream; override;
    destructor Destroy; override;

    function GetTStream: TStream; override;
    function Write(const Buffer: Bytes; Count: Cardinal): Cardinal; overload; override;
    function Write(AByte: Byte): Cardinal; overload; override;

    procedure Reset; override;
    procedure Close; override;
    function GetChar: Integer; override;
    function LookChar: Integer; override;
    function GetPosition: Int64; override;
    procedure SetPosition(APosition: LongInt; ADirection: TSeekOrigin); override;
    function GetStart: Longint; override;
    procedure MoveStart(Delta: Int64); override;
    function GetSize: Cardinal; override;
    function GetType: TgtStreamType; override;

  end;

implementation

uses
  StreamConsts, gtMethods;

{ TgtMemoryStream }

procedure TgtMemoryStream.Close;
begin
  inherited;
  if FisSaved then
  begin
    FMemStream.Position := FStart;
    FisSaved := False;
  end;
end;

constructor TgtMemoryStream.Create(AMemStream: TMemoryStream; AStart,
  ALength: LongWord; ALimited: Boolean; AIsOwned: Boolean);
begin
  FRef := 1;
  FMemStream := AMemStream;
  FStart := AStart;
  FLength := ALength;
  FSavedPos := 0;
  FLimited := ALimited;
  FisSaved := False;
  FMemStream.Position := FStart;
  FIsOwned := AIsOwned;
end;

destructor TgtMemoryStream.Destroy;
begin
  Close;
  if FIsOwned then
    FreeObject(FMemStream);
  inherited;  
end;

function TgtMemoryStream.GetPosition: Int64;
begin
  Result := FMemStream.Position;
end;

function TgtMemoryStream.GetSize: Cardinal;
begin
  Result := FMemStream.Size;
end;

function TgtMemoryStream.GetStart: Longint;
begin
  Result := FStart;
end;

function TgtMemoryStream.GetTStream: TStream;
begin
  Result := FMemStream;
end;

function TgtMemoryStream.GetType: TgtStreamType;
begin
  Result := stFile;
end;

function TgtMemoryStream.LookChar: Integer;
var
  LChar: AnsiChar;
begin
  Result := ENDOFFILE;
  if ((not FLimited) or (FMemStream.Position < FStart + FLength)) then
  begin
    if FMemStream.Read(LChar, 1) > 0 then
    begin
      Result := Ord(LChar);
      FMemStream.Position := FMemStream.Position - 1;
    end;
  end;
end;

function TgtMemoryStream.MakeSubStream(AStart, ALength: Integer;
  ALimited: Boolean): TgtStream;
begin
  Result := TgtMemoryStream.Create(FMemStream, AStart, ALength, ALimited);
end;

procedure TgtMemoryStream.MoveStart(Delta: Int64);
begin
  inherited;
  FStart := FStart + Delta;
  FMemStream.Position := FStart;
end;

function TgtMemoryStream.GetChar: Integer;
var
  LChar: AnsiChar;
begin
  Result := ENDOFFILE;
  if ((not FLimited) or (FMemStream.Position < FStart + FLength)) then
  begin
    if FMemStream.Read(LChar, 1) > 0 then
      Result := Ord(LChar)
  end;
end;

procedure TgtMemoryStream.Reset;
begin
//  inherited;
  FSavedPos := FMemStream.Position;
  FMemStream.Position := FStart;
  FisSaved := True;
end;

procedure TgtMemoryStream.SetPosition(APosition: Integer;
  ADirection: TSeekOrigin);
begin
//  inherited;
  FMemStream.Seek(APosition, Word(ADirection));
end;

function TgtMemoryStream.Write(const Buffer: Bytes; Count: Cardinal): Cardinal;
begin
  Result := FMemStream.Write(Buffer[0], Count);
end;

function TgtMemoryStream.Write(AByte: Byte): Cardinal;
begin
  Result := FMemStream.Write(AByte, 1);
end;

end.
