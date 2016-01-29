unit FileStream;

interface

uses
  Classes, Stream, BaseStream, gtTypes;

const
  FileBufferSize = 256;

type
  TgtFileStream = class(TgtBaseStream)
  private
    FFile: TFileStream;
    FStart: Cardinal;
    FLength: Cardinal;
    FLimited: Boolean;
    FBuffer: array[0..FileBufferSize - 1] of AnsiChar;
    FBufferIndex: Cardinal;
    FBufferCount: Cardinal;
    FBufferPos: Cardinal;
    FSavedPos: Cardinal;
    FIsSaved: Boolean;

    FPosition: Cardinal;
    FAbsPos: Cardinal;

    function FillBuffer: Boolean;
  public
    constructor Create(FileStream: TFileStream; AStart: LongWord; ALength:
      LongWord; ALimited: Boolean);
    function MakeSubStream(AStart: Longint; ALength: Longint;
      ALimited: Boolean): TgtStream; override;
    destructor Destroy; override;

    function Write(const Buffer: Bytes; Count: Cardinal): Cardinal; overload; override;
    function Write(AByte: Byte): Cardinal; overload; override;

    function GetTStream: TStream; override;
    function GetType: TgtStreamType; override;

    procedure Reset; override;
    procedure Close; override;
    function GetChar: Integer; override;
    function LookChar: Integer; override;
    function GetPosition: Int64; override;
    procedure SetPosition(APosition: LongInt; ADirection: TSeekOrigin); override;
    function GetStart: Longint; override;
    procedure MoveStart(Delta: Int64); override;
    function GetSize: Cardinal; override;
  end;

implementation

uses
  StreamConsts;

{ TgtFileStream }

procedure TgtFileStream.Close;
begin
  inherited;
//  if FisSaved then
//  begin
  FFile.Position := FStart;
//    FisSaved := False;
//  end;
end;

constructor TgtFileStream.Create(FileStream: TFileStream; AStart,
  ALength: LongWord; ALimited: Boolean);
begin
  FRef := 1;
  FFile := FileStream;
  FStart := AStart;
  FLimited := ALimited;
  FLength := ALength;
  FBufferIndex := 0;
  FBufferCount := 0;
  FBufferPos := FStart;
  FSavedPos := 0;
  FIsSaved := False;
  FFile.Position := FStart;
  FAbsPos := FStart;

  FPosition := FStart;
end;

destructor TgtFileStream.Destroy;
begin
  Close;
  inherited;
end;

function TgtFileStream.FillBuffer: Boolean;
var
  LCount: Cardinal;
begin
  FBufferPos := FBufferPos + FBufferCount - FBufferIndex;

  if FLimited and ((FAbsPos >= FStart + FLength) or
    (FPosition + FBufferIndex >= FStart + FLength)) then
  begin
    Result := False;
    Exit;
  end;

  if FLimited and (FAbsPos + FileBufferSize > FStart + FLength) then
    LCount := FStart + FLength - FAbsPos
  else
    LCount := FileBufferSize;

  FFile.Position := FAbsPos;
  LCount := FFile.Read(FBuffer[0], LCount);
  FPosition := FPosition + FBufferIndex;
  FAbsPos := FAbsPos + LCount;

  FBufferIndex := 0;
  FBufferCount := LCount;

  if LCount = 0 then
    Result := False
  else
    Result := True;
end;

function TgtFileStream.GetPosition: Int64;
begin
  if (FBufferPos + FBufferIndex > 0) then
    Result := FPosition + FBufferIndex //FBufferPos + FBufferIndex          //Read Mode
  else
    Result := FFile.Position;
end;

function TgtFileStream.GetSize: Cardinal;
begin
  Result := FFile.Size;
end;

function TgtFileStream.GetStart: Longint;
begin
  Result := FStart;
end;

function TgtFileStream.GetTStream: TStream;
begin
  Result := FFile;
end;

function TgtFileStream.GetType: TgtStreamType;
begin
  Result := stFile;
end;

function TgtFileStream.LookChar: Integer;
begin
  if (FBufferIndex >= FBufferCount) and not FillBuffer then
    Result := ENDOFFILE
  else
    Result := Ord(FBuffer[FBufferIndex]);
end;

function TgtFileStream.MakeSubStream(AStart, ALength: Integer;
  ALimited: Boolean): TgtStream;
begin
  Result := TgtFileStream.Create(FFile, AStart, ALength, ALimited);
end;

procedure TgtFileStream.MoveStart(Delta: Int64);
begin
  inherited;
  FStart := FStart + Delta;
  FBufferIndex := 0;
  FBufferCount := 0;
  FBufferPos := FStart;

  FPosition := FStart;
end;

function TgtFileStream.GetChar: Integer;
begin
  if (FBufferIndex >= FBufferCount) and not FillBuffer then
    Result := ENDOFFILE
  else
  begin
    Result := Ord(FBuffer[FBufferIndex]);
    Inc(FBufferIndex);
  end;
end;

procedure TgtFileStream.Reset;
begin
//  inherited;
  FSavedPos := FFile.Position;
  FFile.Position := FStart;
  FAbsPos := FStart;

  FisSaved := True;

  FBufferIndex := 0;
  FBufferCount := 0;
  FBufferPos := FStart;

  FPosition := FStart;
end;

procedure TgtFileStream.SetPosition(APosition: Integer;
  ADirection: TSeekOrigin);
begin
//  inherited;
  FFile.Seek(APosition, Word(ADirection));
  FAbsPos := FFile.Position;

  FBufferPos := FFile.Position;
  FPosition := FBufferPos;

  FBufferIndex := 0;
  FBufferCount := 0;
end;

function TgtFileStream.Write(AByte: Byte): Cardinal;
begin
  Result := FFile.Write(AByte, 1);
end;

function TgtFileStream.Write(const Buffer: Bytes; Count: Cardinal): Cardinal;
begin
  Result := FFile.Write(Buffer[0], Count);
end;

end.
