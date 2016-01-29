unit PDImageStream;

interface

uses
  Stream, gtTypes;

type
  TgtPDImageStream = class
  private
    FStream: TgtStream; // base stream
    FWidth: Integer; // pixels per line
    FNoComps: Integer; // components per pixel
    FNoBits: Integer; // bits per component
    FNoVals: Integer; // components per line
    FImageLine: Bytes; // line buffer
    FImgIdx: Integer; // current index in imgLine
  public
    constructor Create(AStream: TgtStream; AWidth: Integer; ANoComp: Integer;
      ANoBits: Integer);
    destructor Destroy; override;

    procedure Reset;
    function GetPixel(var APix: Bytes): Boolean;
    function GetLine: Bytes;
    procedure SkipLine;
  end;

implementation

{ TgtPDImageStream }

constructor TgtPDImageStream.Create(AStream: TgtStream; AWidth,
  ANoComp: Integer; ANoBits: Integer);
var
  LLmgLineSize: Integer;
begin
  FStream := AStream;
  FWidth := AWidth;
  FNoComps := ANoComp;
  FNoBits := ANoBits;

  FNoVals := FWidth * FNoComps;
  if (FNoBits = 1) then
    LLmgLineSize := (FNoVals + 7) and (not 7)
  else
    LLmgLineSize := FNoVals;

  SetLength(FImageLine, LLmgLineSize);
  FImgIdx := FNoVals;
end;

destructor TgtPDImageStream.Destroy;
begin
  SetLength(FImageLine, 0);
  inherited;
end;

function TgtPDImageStream.GetLine: Bytes;
var
{$IFDEF VCL7ORABOVE}
  LBuff, LBitMask: UInt64;
{$ELSE}
  LBuff, LBitMask: Int64;
{$ENDIF}
  LBits, LC, LI: Integer;
begin
  if (FNoBits = 1) then
  begin
    LI := 0;
    while (LI < FNoVals) do
    begin
      LC := FStream.GetChar;
      FImageLine[LI + 0] := byte((LC shr 7) and 1);
      FImageLine[LI + 1] := byte((LC shr 6) and 1);
      FImageLine[LI + 2] := byte((LC shr 5) and 1);
      FImageLine[LI + 3] := byte((LC shr 4) and 1);
      FImageLine[LI + 4] := byte((LC shr 3) and 1);
      FImageLine[LI + 5] := byte((LC shr 2) and 1);
      FImageLine[LI + 6] := byte((LC shr 1) and 1);
      FImageLine[LI + 7] := byte(LC and 1);

      Inc(LI, 8);
    end;
  end
  else if (FNoBits = 8) then
  begin
    for LI := 0 to FNoVals - 1 do
    begin
      LC := FStream.GetChar;
      FImageLine[LI] := byte(LC);
    end;
  end
  else
  begin
    LBitMask := (1 shl FNoBits) - 1;
    LBuff := 0;
    LBits := 0;
    for LI := 0 to FNoVals - 1 do
    begin
      if (LBits < FNoBits) then
      begin
        LBuff := ((LBuff shl 8) or (FStream.GetChar and $FF));
        LBits := LBits + 8;
      end;
      FImageLine[LI] := byte((LBuff shr (LBits - FNoBits)) and LBitMask);
      LBits := LBits - FNoBits;
    end;
  end;
  Result := FImageLine;
end;

function TgtPDImageStream.GetPixel(var APix: Bytes): Boolean;
var
  LI: Integer;
begin
  if (FImgIdx >= FNoVals) then
  begin
    GetLine;
    FImgIdx := 0;
  end;

  for LI := 0 to FNoComps - 1 do
  begin
    APix[LI] := FImageLine[LI];
  end;

  Result := True;
end;

procedure TgtPDImageStream.Reset;
begin
  FStream.Reset;
end;

procedure TgtPDImageStream.SkipLine;
var
  LN, LI: Integer;
begin
  LN := (FNoVals * FNoBits + 7) shr 3;
  for LI := 0 to LN - 1 do
    FStream.GetChar;
end;

end.
