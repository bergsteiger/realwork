unit JPXDecode;

interface

uses
  Classes, Stream, FilterStream, gtObject, DecodeIntf, gtTypes;


type
  TgtJPXDecode = class(TgtDecode)
  private
    FStream: TgtStream;
    FDecodeBuf: AnsiString;
    FDecodeBufLen: Integer;
    FBufIndex: Integer;
    FWidth: Integer;
    FHeight: Integer;      
  public
    constructor Create(AStream: TgtStream);
    destructor Destroy; override;
    function LookChar: Integer; override;
    function GetChar: Integer; override;
    procedure Reset; override;
  end;

//function decodeJpx(InStr: PAnsiChar; InStrLen: Integer; OutStr: PAnsiChar;
//  OutLen: PInteger; Width: PInteger; Height: PInteger): Integer; stdcall;

implementation

//function decodeJpx; external 'gtlib32.dll';

{ TgtJPXDecode }

constructor TgtJPXDecode.Create(AStream: TgtStream);
begin
//  FStream := AStream;
//  FDecodeBufLen := 0;
//  FBufIndex := 0;
end;

destructor TgtJPXDecode.Destroy;
begin
//  SetLength(FDecodeBuf, 0);
  inherited;
end;

function TgtJPXDecode.GetChar: Integer;
begin
//  Result := -1;
//  if FBufIndex < FDecodeBufLen then
//  begin
//    Inc(FBufIndex);
//    Result := Integer(FDecodeBuf[FBufIndex]);
//  end;
end;

function TgtJPXDecode.LookChar: Integer;
begin
//  Result := -1;
//  if FBufIndex < FDecodeBufLen then
//  begin
//    Result := Integer(FDecodeBuf[FBufIndex]);
//  end;
end;

procedure TgtJPXDecode.Reset;
//var
//  C: Integer;
//  LStrBuf: AnsiString;
//  I: Integer;
begin
  inherited;
//  if FDecodeBufLen = 0 then
//  begin
//    FStream.Reset;
//
//    SetLength(LStrBuf, FStream.GetSize);
//    I := 1;
//    C := FStream.GetChar;
//    while C <> -1 do
//    begin
//      LStrBuf[I] := AnsiChar(C);
//
//      C := FStream.GetChar;
//      Inc(I);
//    end;
//
//    decodeJpx(PAnsiChar(LStrBuf), I - 1, nil, @FDecodeBufLen, @FWidth, @FHeight);
//
//    SetLength(FDecodeBuf, FDecodeBufLen);
//    decodeJpx(PAnsiChar(LStrBuf), I - 1, PAnsiChar(FDecodeBuf), @FDecodeBufLen, @FWidth,
//      @FHeight);
//
//    SetLength(LStrBuf, 0);
//  end
//  else
//    FBufIndex := 0;
end;

end.
