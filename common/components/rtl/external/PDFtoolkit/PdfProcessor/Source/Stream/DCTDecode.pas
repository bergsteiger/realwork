{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit DCTDecode;

interface

uses
  Classes, gtObject, gtTypes, DecodeIntf, Stream;

//{$IFDEF DCTDECODE}

const
  // IDCT constants (20.12 fixed point format)
  dctCos1 = 4017; // cos(pi/16)
  dctSin1 = 799; // sin(pi/16)
  dctCos3 = 3406; // cos(3*pi/16)
  dctSin3 = 2276; // sin(3*pi/16)
  dctCos6 = 1567; // cos(6*pi/16)
  dctSin6 = 3784; // sin(6*pi/16)
  dctSqrt2 = 5793; // sqrt(2)
  dctSqrt1d2 = 2896; // sqrt(2) / 2

  // color conversion parameters (16.16 fixed point format)
  dctCrToR = 91881; //  1.4020
  dctCbToG = -22553; // -0.3441363
  dctCrToG = -46802; // -0.71413636
  dctCbToB = 116130; //  1.772

  // clip [-256,511] --> [0,255]
  dctClipOffset = 256;
  dctZigZag: array[0..63] of Integer = (
    0,
    1, 8,
    16, 9, 2,
    3, 10, 17, 24,
    32, 25, 18, 11, 4,
    5, 12, 19, 26, 33, 40,
    48, 41, 34, 27, 20, 13, 6,
    7, 14, 21, 28, 35, 42, 49, 56,
    57, 50, 43, 36, 29, 22, 15,
    23, 30, 37, 44, 51, 58,
    59, 52, 45, 38, 31,
    39, 46, 53, 60,
    61, 54, 47,
    55, 62,
    63);

type
  DCTHuffTable = record
    FirstSym: array[0..16] of Byte;
    FirstCode: array[0..16] of Word;
    NumCodes: array[0..16] of Word;
    Symbol: array[0..255] of Byte;
  end;

  DCTCompInfo = record
    ID: Integer;
    hSample: Integer;
    vSample: Integer;
    QuantTable: Integer;
    prevDC: Integer;
  end;

  DCTScanInfo = record
    Comp: array[0..3] of Boolean;
    NumComps: Integer;
    dcHuffTable: array[0..3] of Integer;
    acHuffTable: array[0..3] of Integer;
    FirstCoeff: Integer;
    LastCoeff: Integer;
    Ah: Integer;
    AL: Integer;
  end;

  (* The DCTDecode filter decodes grayscale or color image data that has been
   * encoded in the JPEG baseline format.
   *)
  TgtDCTDecode = class(TgtDecode)
  private
    FStream: TgtStream;
    { private declarations }
    FProgressive: Boolean;
    FInterleaved: Boolean;
    FWidth: Integer;
    FHeight: Integer;
    FMCUWidth: Integer;
    FMCUHeight: Integer;
    FBufWidth: Integer;
    FBufHeight: Integer;
    FCompInfo: array[0..3] of DCTCompInfo;
    FScanInfo: DCTScanInfo;
    FNumComps: Integer;
    FColorXForm: Integer;
    FGotJFIFMarker: Boolean;
    FGotAdobeMarker: Boolean;
    FRestartInterval: Integer;
    FQuantTables: array[0..3, 0..63] of Word;
    FNumQuantTables: Integer;
    FdcHuffTables: array[0..3] of DCTHuffTable;
    FacHuffTables: array[0..3] of DCTHuffTable;
    FNumDCHuffTables: Integer;
    FNumACHuffTables: Integer;
    FRowBuf: array[0..3, 0..31] of AnsiString;
    FFrameBuf: array[0..3] of AnsiString;
    FComp: Integer;
    FX: Integer;
    FY: Integer;
    FDy: Integer;
    FRestartCtr: Integer;
    FRestartMarker: Integer;
    FEobRun: Integer;
    FInputBuf: Integer;
    FInputBits: Integer;
    FDctClip: array[0..767] of Byte;
    FdctClipInit: Boolean;

    procedure Restart;
    function ReadMCURow: Boolean;
    procedure ReadScan;
    function ReadDataUnit(ADcHuffTable, AAcHuffTable: DCTHuffTable;
      var prevDC: Integer; var Data: array of Integer): Boolean;
    function ReadProgressiveDataUnit(ADcHuffTable, AcHuffTable: DCTHuffTable;
      var precDC: Integer; var Data: array of Integer): Boolean;
    procedure DecodeImage;
    procedure TransformDataUnit(QuantTable: array of Word;
      var DataIn: array of Integer; var DataOut: array of Byte);
    function ReadHuffSym(ATable: DCTHuffTable): Integer;
    function ReadAmp(ASize: Integer): Integer;
    function ReadBit(): Integer;
    function ReadHeader(): Boolean;
    function ReadBaselineSOF(): Boolean;
    function ReadProgressiveSOF(): Boolean;
    function ReadScanInfo(): Boolean;
    function ReadQuantTables(): Boolean;
    function ReadHuffmanTables(): Boolean;
    function ReadRestartInterval(): Boolean;
    function ReadJFIFMarker(): Boolean;
    function ReadAdobeMarker(): Boolean;
    function ReadTrailer(): Boolean;
    function ReadMarker(): Integer;
    function Read16(): Integer;
//    function GetRawStream: Integer;
  public
    constructor Create(Astream: TgtStream; AColorXForm: Integer);
    procedure Close;
    function LookChar: Integer; override;
    function GetChar: Integer; override;
    function GetPosition: Int64; override;
    procedure Reset; override;
    destructor Destroy; override;
  end;
//{$ENDIF}

implementation

//{$IFDEF DCTDECODE}
uses
  gtConstants, StreamConsts, StreamExceptions, SysUtils
{$IFDEF DEBUG}
  , gtLogger
{$ENDIF};

{ TgtDCTDecode }

procedure TgtDCTDecode.Close;
var
  LI, LJ: Integer;
begin
  for LI := 0 to 3 do
  begin
    for LJ := 0 to 31 do
      FRowBuf[LI][LJ] := AnsiChar(#0);
    FFrameBuf[LI] := AnsiChar(#0);
  end;
  inherited;
end;

(**
 * Constructor
 * @param AStream the stream that need to be decoded
 * @param AColorXForm A code specifying the transformation to be performed on
 * the sample values:
 *)

constructor TgtDCTDecode.Create(AStream: TgtStream; AColorXForm: Integer);
var
  LI, LJ: Integer;
begin
  FStream := AStream;
  FColorXForm := AColorXForm;
  FInterleaved := False;
  FProgressive := False;
  FWidth := 0;
  FHeight := 0;
  FMCUWidth := 0;
  FMCUHeight := 0;
  FNumComps := 0;
  FComp := 0;
  FX := 0;
  FY := 0;
  FDy := 0;
  for LI := 0 to 3 do
  begin
    for LJ := 0 to 31 do
      FRowBuf[LI][LJ] := AnsiChar(#0);
    FFrameBuf[LI] := AnsiChar(#0);
  end;
  if not FdctClipInit then
  begin
    for LI := 0 to dctClipOffset - 1 do
      FDctClip[LI] := Byte(#0);
    for LI := dctClipOffset to 511 do
      FDctClip[LI] := Byte(LI);
    for LI := 512 to 767 do
      FDctClip[LI] := Byte(255);
    FdctClipInit := True;
  end;
end;

procedure TgtDCTDecode.DecodeImage;
var
  LDataOut: array[0..63] of Byte;
  LDataIn: array[0..63] of Integer;
  LpY, LpCb, LpCr, LpR, LpG, LpB: Integer;
  Lx1, Ly1, Lx2, Ly2, Lx3, Ly3, Lx4, Ly4, Lx5, Ly5, Lcc, LI, LJ: Integer;
  Lh, Lv, Lhoriz, Lvert, LhSub, LvSub: Integer;
  Lp0, Lp1, Lp2: Integer;

begin
  Ly1 := 0;
  while Ly1 < FBufHeight do
  begin
    Lx1 := 0;
    while Lx1 < FBufWidth do
    begin
      for Lcc := 0 to FNumComps - 1 do
      begin
        Lh := FCompInfo[Lcc].hSample;
        Lv := FCompInfo[Lcc].vSample;
        Lhoriz := FMCUWidth div Lh;
        Lvert := FMCUHeight div Lv;
        LhSub := Lhoriz div 8;
        LvSub := Lvert div 8;
        Ly2 := 0;
        while Ly2 < FMCUHeight do
        begin
          Lx2 := 0;
          while Lx2 < FMCUWidth do
          begin
            // pull out the coded data unit
            LI := 0;
            Lp1 := 0;
            for Ly3 := 0 to 7 do
            begin
              for LJ := 0 to 7 do
                LDataIn[LI + LJ] := integer(FFrameBuf[Lcc][(Ly1 + Ly2) * FBufWidth +
                  (Lx1 + Lx2 + LJ + Lp1) + 1]);
              Lp1 := Lp1 + FBufWidth * LvSub;
              LI := LI + 8;
            end;

            // transform
            TransformDataUnit(FQuantTables[FCompInfo[Lcc].QuantTable], LDataIn,
              LDataOut);

            // store back into frameBuf, doing replication for
            // subsampled components
            Lp1 := 0;
            if (LhSub = 1) and (LvSub = 1) then
            begin
              LI := 0;
              for Ly3 := 0 to 7 do
              begin
                for LJ := 0 to 7 do
                  FFrameBuf[Lcc][(Ly1 + Ly2) * FBufWidth + (Lx1 + Lx2 + LJ + Lp1) + 1]
                    := AnsiChar(LDataOut[LI + LJ] and $FF);
                Lp1 := Lp1 + FBufWidth;
                LI := LI + 8;
              end;
            end
            else
              if (LhSub = 2) and (LvSub = 2) then
              begin
                Lp2 := Lp1 + FBufWidth;
                LI := 0;
                Ly3 := 0;
                while Ly3 < 16 do
                begin
                  for LJ := 0 to 7 do
                  begin
                    FFrameBuf[Lcc][(Ly1 + Ly2) * FBufWidth + (Lx1 + Lx2 + Lp1 +
                      (LJ * 2)) + 1] := AnsiChar(LDataOut[LI + LJ] and $FF);
                    FFrameBuf[Lcc][(Ly1 + Ly2) * FBufWidth + (Lx1 + Lx2 + Lp1 +
                      (LJ * 2) + 2)] := AnsiChar(LDataOut[LI + LJ] and $FF);
                    FFrameBuf[Lcc][(Ly1 + Ly2) * FBufWidth + (Lx1 + Lx2 + Lp2 +
                      (LJ * 2)) + 1] := AnsiChar(LDataOut[LI + LJ] and $FF);
                    FFrameBuf[Lcc][(Ly1 + Ly2) * FBufWidth + (Lx1 + Lx2 + Lp2 +
                      (LJ * 2) + 2)] := AnsiChar(LDataOut[LI + LJ] and $FF);
                  end;
                  Lp1 := Lp1 + FBufWidth;
                  Lp2 := Lp2 + FBufWidth;
                  LI := LI + 8;
                  Ly3 := Ly3 + 2;
                end
              end
              else
              begin
                LI := 0;
//                Ly4 := 0;
                for Ly3 := 0 to 7 do
                begin
                  Lx4 := 0;
                  for Lx3 := 0 to 7 do
                  begin
                    Lp2 := Lp1 + Lx4;
                    for Ly5 := 0 to LvSub - 1 do
                    begin
                      for Lx5 := 0 to LhSub - 1 do
                      begin
                        FFrameBuf[Lcc][(Ly1 + Ly2) * FBufWidth + (Lx1 + Lx2 +
                          Lp2 + Lx5) + 1] := AnsiChar(LDataOut[LI] and $FF);
                      end;
                      Lp2 := Lp2 + FBufWidth;
                    end;
                    Inc(LI);
                    Lx4 := LhSub;
                  end;
                  Lp1 := Lp1 + FBufWidth * LvSub;
//                  Ly4 := Ly4 + LvSub;
                end;
              end;
            Lx2 := Ly2 + Lhoriz;
          end;
          Ly2 := Ly2 + Lvert;
        end;
      end;
      // color space conversion
      if FColorXForm <> 0 then
      begin
        // convert YCbCr to RGB
        if FNumComps = 3 then
        begin
          for Ly2 := 0 to FMCUHeight - 1 do
          begin
            Lp0 := 0;
            Lp1 := 0;
            Lp2 := 0;
            for Lx2 := 0 to FMCUWidth - 1 do
            begin
              LpY := Integer(FFrameBuf[0][(Ly1 + Ly2) * FBufWidth + Lx1 + Lp0 + 1]);
              LpCb := Integer(FFrameBuf[0][(Ly1 + Ly2) * FBufWidth + Lx1 + Lp1 + 1]) - 128;
              LpCr := Integer(FFrameBuf[0][(Ly1 + Ly2) * FBufWidth + Lx1 + Lp2 + 1]) - 128;
              LpR := Integer(((LpY shl 16) + dctCrToR * LpCr + 32768) shr 16);
              FFrameBuf[0][(Ly1 + Ly2) * FBufWidth + Lx1 + Lp0 + 1] :=
                AnsiChar(FDctClip[dctClipOffset + LpR]);
              Inc(Lp0);
              LpG := Integer(((LpY shl 16) + dctCbToG * LpCb + dctCrToG * LpCr + 32768)
                shr 16);
              FFrameBuf[0][(Ly1 + Ly2) * FBufWidth + Lx1 + Lp1 + 1] :=
                AnsiChar(FDctClip[dctClipOffset + LpG]);
              Inc(Lp1);
              LpB := Integer(((LpY shl 16) + dctCbToB * LpCb + 32768) shr 16);
              FFrameBuf[0][(Ly1 + Ly2) * FBufWidth + Lx1 + Lp2 + 1] :=
                AnsiChar(FDctClip[dctClipOffset + LpB]);
              Inc(Lp2);
            end
          end
          // convert YCbCrK to CMYK (K is passed through unchanged)
        end
        else
          if FNumComps = 4 then
          begin
            for Ly2 := 0 to FMCUHeight - 1 do
            begin
              Lp0 := Integer(FFrameBuf[0][(Ly1 + Ly2) * FBufWidth + Lx1 + 1]);
              Lp1 := Integer(FFrameBuf[1][(Ly1 + Ly2) * FBufWidth + Lx1 + 1]);
              Lp2 := Integer(FFrameBuf[2][(Ly1 + Ly2) * FBufWidth + Lx1 + 1]);
              for Lx2 := 0 to FMCUWidth - 1 do
              begin
                LpY := Integer(FFrameBuf[0][(Ly1 + Ly2) * FBufWidth + Lx1 + Lp0 + 1]);
                LpCb := Integer(FFrameBuf[0][(Ly1 + Ly2) * FBufWidth + Lx1 + Lp1 + 1]) - 128;
                LpCr := Integer(FFrameBuf[0][(Ly1 + Ly2) * FBufWidth + Lx1 + Lp2 + 1]) - 128;
                LpR := Integer(((LpY shl 16) + dctCrToR * LpCr + 32768) shr 16);
                FFrameBuf[0][(Ly1 + Ly2) * FBufWidth + Lx1 + Lp0 + 1] := AnsiChar(255 -
                  Integer(FDctClip[dctClipOffset + LpR]));
                Inc(Lp0);
                LpG := Integer(((LpY shl 16) + dctCbToG * LpCb + dctCrToG * LpCr +
                  32768) shr 16);
                FFrameBuf[0][(Ly1 + Ly2) * FBufWidth + Lx1 + Lp1 + 1] := AnsiChar(255 -
                  Integer(FDctClip[dctClipOffset + LpG]));
                Inc(Lp1);
                LpB := Integer(((LpY shl 16) + dctCbToB * LpCb + 32768) shr 16);
                FFrameBuf[0][(Ly1 + Ly2) * FBufWidth + Lx1 + Lp2 + 1] := AnsiChar(255 -
                  Integer(FDctClip[dctClipOffset + LpB]));
                Inc(Lp2);
              end;
            end;
          end;
      end;
      Lx1 := Lx1 + FMCUWidth;
    end;
    Ly1 := Ly1 + FMCUHeight;
  end;
end;

destructor TgtDCTDecode.Destroy;
var
  LI, LJ: Integer;
begin
  Close;
  for LI := 0 to  FNumComps- 1 do
    SetLength(FFrameBuf[LI], 0);
  for LI := 0 to FNumComps - 1 do
    for LJ := 0 to FMCUHeight - 1 do
      SetLength(FRowBuf[LI][LJ], 0);
  inherited;
end;

(*
function TgtDCTDecode.GetRawStream: Integer;
begin
  Result := 0;
end;
*)

  (**
   * Gets a charecter
   * @return A charecter(integer value)
   *)

function TgtDCTDecode.LookChar: Integer;
begin
  if FY >= FHeight then
  begin
    Result := ENDOFFILE;
    Exit;
  end;
  if FProgressive or (not FInterleaved) then
  begin
    Result := Integer(FFrameBuf[FComp][FY * FBufWidth + FX + 1]);
  end
  else
  begin
    if FDy >= FMCUHeight then
    begin
      if not ReadMCURow then
      begin
        FY := FHeight;
        Result := ENDOFFILE;
        Exit;
      end;
      FComp := 0;
      FX := 0;
      FDy := 0;
    end;
    Result := Integer(FRowBuf[FComp][FDy][FX + 1]);
  end;
end;

function TgtDCTDecode.Read16: Integer;
var
  LChar1, LChar2: Integer;
begin
  try
    LChar1 := FStream.GetChar;
  except
    on E: EAccessViolation do
      raise ExInvalidStream.Create(ErrInvalidStream);
  end;
  if (LChar1 = ENDOFFILE) then
  begin
    Result := ENDOFFILE;
    Exit;
  end;
  LChar2 := FStream.GetChar;
  if (LChar2 = ENDOFFILE) then
  begin
    Result := ENDOFFILE;
    Exit;
  end;
  Result := (LChar1 shl 8) + LChar2;
end;

function TgtDCTDecode.ReadAdobeMarker: Boolean;
var
  LLength, LI, LChar: Integer;
  LBuffer: array[0..11] of AnsiChar;
begin
  if not Assigned(FStream) then
    raise ExInvalidStream.Create(ErrInvalidStream);
  LLength := Read16;
  if LLength < 14 then
  begin
{$IFDEF DEBUG}
    Logger.LogInfo('Bad DCT Adobe APP14 marker');
{$ENDIF}
    Result := False;
    Exit;
  end;
  for LI := 0 to 11 do
  begin
    LChar := FStream.GetChar;
    if (LChar = ENDOFFILE) then
    begin
{$IFDEF DEBUG}
      Logger.LogInfo('Bad DCT Adobe APP14 marker');
{$ENDIF}
      Result := False;
      Exit;
    end;
    LBuffer[LI] := AnsiChar(LChar);
  end;
  if (Pos('Adobe', LBuffer) = 0) then
  begin
{$IFDEF DEBUG}
    Logger.LogInfo('Bad DCT Adobe APP14 marker');
{$ENDIF}
    Result := False;
    Exit;
  end;
  FColorXForm := Integer(LBuffer[11]);
  FGotAdobeMarker := True;
  for LI := 14 to LLength - 1 do
  begin
    LChar := FStream.GetChar;
    if LChar = ENDOFFILE then
    begin
{$IFDEF DEBUG}
      Logger.LogInfo('Bad DCT Adobe APP14 marker');
{$ENDIF}
      Result := False;
      Exit;
    end;
  end;
  Result := True;
end;

function TgtDCTDecode.ReadAmp(ASize: Integer): Integer;
var
  LAmp, LBit, LBits: Integer;
begin
  LAmp := 0;
  for LBits := 0 to ASize - 1 do
  begin
    LBit := ReadBit;
    if (LBit = ENDOFFILE) then
    begin
      Result := 9999;
      Exit;
    end;
    LAmp := (LAmp shl 1) + LBit;
  end;
  if LAmp < (1 shl (ASize - 1)) then
    LAmp := LAmp - ((1 shl ASize) - 1);
  Result := LAmp;
end;

function TgtDCTDecode.ReadBaselineSOF: Boolean;
var
  LPrec, LI, LChar: Integer;
begin
  Read16;
  try
    LPrec := FStream.GetChar;
  except
    on E: EAccessViolation do
      raise ExInvalidStream.Create(ErrInvalidStream);
  end;
  FHeight := Read16;
  FWidth := Read16;
  FNumComps := FStream.GetChar;
  if (FNumComps <= 0) or (FNumComps > 4) then
  begin
{$IFDEF DEBUG}
    Logger.LogInfo('Bad number of components in DCT stream');
{$ENDIF}
    Result := False;
    FNumComps := 0;
    Exit;
  end;
  if (LPrec <> 8) then
  begin
{$IFDEF DEBUG}
    Logger.LogInfo('Bad DCT precision');
{$ENDIF}
    Result := False;
    Exit;
  end;
  for LI := 0 to FNumComps - 1 do
  begin
    FCompInfo[LI].id := FStream.GetChar;
    LChar := FStream.GetChar;
    FCompInfo[LI].hSample := Integer((LChar shr 4)) and $0F;
    FCompInfo[LI].vSample := LChar and $0F;
    FCompInfo[LI].quantTable := FStream.GetChar;
  end;
  FProgressive := False;
  Result := True;
end;

function TgtDCTDecode.ReadBit: Integer;
var
  LBit, LChar1, LChar2: Integer;
begin
  if FInputBits = 0 then
  begin
    try
      LChar1 := FStream.GetChar;
    except
      on E: EAccessViolation do
        raise ExInvalidStream.Create(ErrInvalidStream);
    end;
    if LChar1 = ENDOFFILE then
    begin
      Result := ENDOFFILE;
      Exit;
    end;
    if LChar1 = $FF then
    begin
      repeat
        LChar2 := FStream.GetChar;
      until (LChar2 <> $FF);
      if LChar2 <> $00 then
      begin
{$IFDEF DEBUG}
        Logger.LogInfo('Bad DCT data: missing 00 after ff');
{$ENDIF}
        Result := ENDOFFILE;
        Exit;
      end;
    end;
    FInputBuf := LChar1;
    FInputBits := 8;
  end;
  LBit := Integer((FInputBuf shr (FInputBits - 1))) and 1;
  Dec(FInputBits);
  Result := LBit;
end;

  (**
   * Gets a charecter after decoding
   * @return A charecter(integer value)
   *)

function TgtDCTDecode.GetChar: Integer;
var
  LChar: Integer;
begin
  if FY >= FHeight then
  begin
    Result := ENDOFFILE;
    Exit;
  end;
  if FProgressive or (not FInterleaved) then
  begin
    LChar := Integer(FFrameBuf[FComp][FY * FBufWidth + FX + 1]);
    Inc(FComp);
    if FComp = FNumComps then
    begin
      FComp := 0;
      Inc(FX);
      if FX = FWidth then
      begin
        FX := 0;
        Inc(FY);
      end;
    end;
  end
  else
  begin
    if FDy >= FMCUHeight then
    begin
      if not ReadMCURow then
      begin
        FY := FHeight;
        Result := ENDOFFILE;
        Exit;
      end;
      FComp := 0;
      FX := 0;
      FDy := 0;
    end;
    LChar := Integer(FRowBuf[FComp][FDy][FX + 1]);
    Inc(FComp);
    if FComp = FNumComps then
    begin
      FComp := 0;
      Inc(FX);
      if FX = FWidth then
      begin
        FX := 0;
        Inc(FY);
        Inc(FDy);
        if FY = FHeight then
          ReadTrailer;
      end;
    end;
  end;
  Result := LChar;
end;

  (**
   * Gets the position of FStream
   * @return the position of FStream
   * @exception ExInvalidStream if FStream is NULL
   *)

function TgtDCTDecode.GetPosition: Int64;
begin
  try
    Result := FStream.GetPosition;
  except
    on E: EAccessViolation do
      raise ExInvalidStream.Create(ErrInvalidStream);
  end;
end;

function TgtDCTDecode.ReadDataUnit(ADcHuffTable, AAcHuffTable: DCTHuffTable;
  var prevDC: Integer; var Data: array of Integer): Boolean;
var
  LRun, LSize, LAmp, LChar, LI, LJ: Integer;

begin
  LSize := readHuffSym(ADcHuffTable);
  if LSize = 9999 then
  begin
    result := False;
    Exit;
  end;
  if LSize > 0 then
  begin
    LAmp := readAmp(LSize);
    if LAmp = 9999 then
    begin
      result := False;
      Exit;
    end;
  end
  else
  begin
    LAmp := 0;
  end;
  prevDC := prevDC + LAmp;
  data[0] := prevDC;
  for LI := 1 to 63 do
  begin
    data[LI] := 0;
  end;
  LI := 1;
  while LI < 64 do
  begin
    LRun := 0;
    LChar := readHuffSym(AacHuffTable);
    while (LChar = $F0) and (LRun < $30) do
    begin
      LRun := LRun + $10;
      LChar := readHuffSym(AacHuffTable);
    end;
    if LChar = 9999 then
    begin
      result := False;
      Exit;
    end;
    if LChar = $00 then
    begin
      Break;
    end
    else
    begin
      LRun := LRun + (LChar shr 4) and $0F;
      LSize := LChar and $0F;
      LAmp := readAmp(LSize);
      if LAmp = 9999 then
      begin
        result := False;
        Exit;
      end;
      LI := LI + LRun;
      if (LI < 64) then
      begin
        LJ := dctZigZag[LI];
        Inc(LI);
        data[LJ] := LAmp;
      end;
    end;
  end;
  result := True;
end;

function TgtDCTDecode.ReadHeader: Boolean;
var
  LDoScan: Boolean;
  LNum, LChar, LI: Integer;
begin
  // read headers
  LDoScan := False;
  while not LDoScan do
  begin
    LChar := ReadMarker;
    case LChar of
      $C0, $C1: if not ReadBaselineSOF then // SOF0 (sequential)
        begin // SOF1 (extended sequential)
          Result := False;
          Exit;
        end;
      $C2: if not ReadProgressiveSOF then // SOF2 (progressive)
        begin
          Result := False;
          Exit;
        end;
      $C4: if not ReadHuffmanTables then // DHT
        begin
          Result := False;
          Exit;
        end;
      $D8: ; // SOI
      $D9: // EOI
        begin
          Result := False;
          Exit;
        end;
      $DA: if not ReadScanInfo then // SOS
        begin
          Result := False;
          Exit;
        end
        else
          LDoScan := True;
      $DB: if not ReadQuantTables then // DQT
        begin
          Result := False;
          Exit;
        end;
      $DD: if not ReadRestartInterval then // DRI
        begin
          Result := False;
          Exit;
        end;
      $E0: if not ReadJFIFMarker then // APP0
        begin
          Result := False;
          Exit;
        end;
      $EE: if not ReadAdobeMarker then // APP14
        begin
          Result := False;
          Exit;
        end;
      ENDOFFILE:
        begin
{$IFDEF DEBUG}
          Logger.LogInfo('Bad DCT header');
{$ENDIF}
          Result := False;
          Exit;
        end;
    else
      begin
        // skip APPn / COM / etc.
        if LChar >= $E0 then
        begin
          LNum := Read16 - 2;
          try
            for LI := 0 to LNum - 1 do
              FStream.GetChar;
          except
            on E: EAccessViolation do
              raise ExInvalidStream.Create(ErrInvalidStream);
          end;
        end
        else
        begin
{$IFDEF DEBUG}
          Logger.LogInfo('Unknown DCT marker');
{$ENDIF}
          Result := False;
          Exit;
        end;
      end;
    end;
  end;
  Result := True;
end;

function TgtDCTDecode.ReadHuffmanTables: Boolean;
var
  LLength, LIndex, LI, LChar: Integer;
  LCode: Cardinal;
  LSymbol: Byte;
  LFlag: Boolean;
begin
  LLength := Read16 - 2;
  while LLength > 0 do
  begin
    try
      LIndex := FStream.GetChar;
    except
      on E: EAccessViolation do
        raise ExInvalidStream.Create(ErrInvalidStream);
    end;
    Dec(LLength);
    if (LIndex and $0F) >= 4 then
    begin
{$IFDEF DEBUG}
      Logger.LogInfo('Bad DCT Huffman table');
{$ENDIF}
      Result := False;
      Exit;
    end;
    if (LIndex and $10) <> 0 then
    begin
      LIndex := LIndex and $0F;
      if LIndex >= FNumACHuffTables then
        FNumACHuffTables := LIndex + 1;
      LFlag := True;
    end
    else
    begin
      LIndex := LIndex and $0F;
      if LIndex >= FNumDCHuffTables then
        FNumDCHuffTables := LIndex + 1;
      LFlag := False;
    end;
    LSymbol := 0;
    LCode := 0;
    for LI := 1 to 16 do
    begin
      LChar := FStream.GetChar;
      if LFlag then
      begin
        FacHuffTables[LIndex].FirstSym[LI] := LSymbol;
        FacHuffTables[LIndex].FirstCode[LI] := LCode;
        FacHuffTables[LIndex].NumCodes[LI] := LChar;
      end
      else
      begin
        FdcHuffTables[LIndex].FirstSym[LI] := LSymbol;
        FdcHuffTables[LIndex].FirstCode[LI] := LCode;
        FdcHuffTables[LIndex].NumCodes[LI] := LChar;
      end;
      LSymbol := LSymbol + LChar;
      LCode := (LCode + LChar) shl 1;
    end;
    LLength := LLength - 16;
    for LI := 0 to LSymbol - 1 do
    begin
      if LFlag then
        FacHuffTables[LIndex].Symbol[LI] := FStream.GetChar
      else
        FdcHuffTables[LIndex].Symbol[LI] := FStream.GetChar;
    end;
    LLength := LLength - LSymbol;
  end;
  Result := True;
end;

function TgtDCTDecode.ReadHuffSym(ATable: DCTHuffTable): Integer;
var
  LCode: Word;
  LBit, LCodeBits: Integer;
begin
  LCode := 0;
  LCodeBits := 0;
  repeat
    // add a bit to the LCode
    LBit := ReadBit;
    if LBit = ENDOFFILE then
    begin
      Result := 9999;
      Exit;
    end;
    LCode := (LCode shl 1) + LBit;
    Inc(LCodeBits);

    // look up LCode
    if (LCode - ATable.FirstCode[LCodeBits]) < (ATable.NumCodes[LCodeBits]) then
    begin
      LCode := LCode - ATable.FirstCode[LCodeBits];
      Result := ATable.Symbol[ATable.FirstSym[LCodeBits] + LCode];
      Exit;
    end;
  until (LCodeBits >= 16);
{$IFDEF DEBUG}
  Logger.LogInfo('Bad Huffman code in DCT stream');
{$ENDIF}
  Result := 9999;
end;

function TgtDCTDecode.ReadJFIFMarker: Boolean;
var
  LLength, LI, LChar: Integer;
  LBuffer: array[0..4] of AnsiChar;
begin
  LLength := Read16;
  LLength := LLength - 2;
  if LLength >= 5 then
  begin
    for LI := 0 to 4 do
    begin
      try
        LChar := FStream.GetChar;
      except
        on E: EAccessViolation do
          raise ExInvalidStream.Create(ErrInvalidStream);
      end;
      if LChar = ENDOFFILE then
      begin
{$IFDEF DEBUG}
        Logger.LogInfo('Bad DCT APP0 marker');
{$ENDIF}
        Result := False;
        Exit;
      end;
      LBuffer[LI] := AnsiChar(LChar);
    end;
    LLength := LLength - 5;
    if (Pos('JFIF\0', LBuffer) = 0) then
      FGotJFIFMarker := True;
  end;
  while LLength > 0 do
  begin
    LChar := FStream.GetChar;
    if LChar = ENDOFFILE then
    begin
{$IFDEF DEBUG}
      Logger.LogInfo('Bad DCT APP0 marker');
{$ENDIF}
      Result := False;
      Exit;
    end;
    Dec(LLength);
  end;
  Result := True;
//  Finalize(LBuffer);
end;

function TgtDCTDecode.ReadMarker: Integer;
var
  LChar: Integer;
begin
  try
    repeat
      repeat
        LChar := FStream.GetChar;
      until ((LChar = $FF) or (LChar = ENDOFFILE));
      repeat
        LChar := FStream.GetChar;
      until (LChar <> $FF);
    until (LChar <> $00);
  except
    on E: EAccessViolation do
      raise ExInvalidStream.Create(ErrInvalidStream);
  end;
  Result := LChar;
end;

function TgtDCTDecode.ReadMCURow: Boolean;
var
  LData1: array[0..63] of Integer;
  LData2: array[0..63] of Byte;
  LpY, LpCb, LpCr, LpR, LpG, LpB, Lh, Lv, Lhoriz, Lvert, LhSub, LvSub,
    Lx1, Lx2, Ly2, Lx3, Ly3, Lx4, Ly4, Lx5, Ly5, Lcc, LI, LChar, LJ: Integer;
begin
  Lx1 := 0;
  while Lx1 < FWidth do
  begin
    // deal with restart marker
    if (FRestartInterval > 0) and (FRestartCtr = 0) then
    begin
      LChar := ReadMarker;
      if LChar <> FRestartMarker then
      begin
{$IFDEF DEBUG}
        Logger.LogInfo('Bad DCT data: incorrect restart marker');
{$ENDIF}
        Result := False;
        Exit;
      end;
      Inc(FRestartMarker);
      if (FRestartMarker = $D8) then
        FRestartMarker := $D0;
      restart();
    end;

    // read one MCU
    for Lcc := 0 to FNumComps - 1 do
    begin
      Lh := FCompInfo[Lcc].hSample;
      Lv := FCompInfo[Lcc].vSample;
      Lhoriz := FMcuWidth div Lh;
      Lvert := FMCUHeight div Lv;
      LhSub := Lhoriz div 8;
      LvSub := Lvert div 8;
      Ly2 := 0;
      while Ly2 < FMCUHeight do
      begin
        Lx2 := 0;
        while Lx2 < FMcuWidth do
        begin
          if not ReadDataUnit(FDcHuffTables[FScanInfo.dcHuffTable[Lcc]],
            FacHuffTables[FScanInfo.acHuffTable[Lcc]], FCompInfo[Lcc].prevDC,
            LData1) then
          begin
            result := False;
            Exit;
          end;
          TransformDataUnit(FQuantTables[FCompInfo[Lcc].QuantTable],
            LData1, LData2);
          if (LhSub = 1) and (LvSub = 1) then
          begin
            LI := 0;
            for Ly3 := 0 to 7 do
            begin
              for LJ := 0 to 7 do
                FRowBuf[Lcc][Ly2 + Ly3][Lx1 + Lx2 + LJ + 1] := AnsiChar(LData2[LI + LJ]);
              LI := LI + 8;
            end;
          end
          else
            if (LhSub = 2) and (LvSub = 2) then
            begin
              Ly3 := 0;
              LI := 0;
              while Ly3 < 16 do
              begin
                for LJ := 0 to 7 do
                begin
                  FRowBuf[Lcc][Ly2 + Ly3][Lx1 + Lx2 + (LJ * 2) + 1] :=
                    AnsiChar(LData2[LI + LJ]);
                  FRowBuf[Lcc][Ly2 + Ly3][Lx1 + Lx2 + (LJ * 2) + 2] :=
                    AnsiChar(LData2[LI + LJ]);
                  FRowBuf[Lcc][Ly2 + Ly3 + 1][Lx1 + Lx2 + (LJ * 2) + 1] :=
                    AnsiChar(LData2[LI + LJ]);
                  FRowBuf[Lcc][Ly2 + Ly3 + 1][Lx1 + Lx2 + (LJ * 2) + 2] :=
                    AnsiChar(LData2[LI + LJ]);
                end;
                Ly3 := Ly3 + 2;
                LI := LI + 8;
              end;
            end
            else
            begin
              LI := 0;
              Ly4 := 0;
              for Ly3 := 0 to 7 do
              begin
                Lx4 := 0;
                for Lx3 := 0 to 7 do
                begin
                  for Ly5 := 0 to LvSub - 1 do
                    for Lx5 := 0 to LhSub - 1 do
                      FRowBuf[Lcc][Ly2 + Ly4 + Ly5][Lx1 + Lx2 + Lx4 + Lx5 + 1] := AnsiChar(LData2[LI]);
                  Inc(LI);
                  Lx4 := Lx4 + LhSub;
                end;
                Ly4 := Ly4 + LvSub;
              end;
            end;
          Lx2 := Lx2 + Lhoriz;
        end;
        Ly2 := Ly2 + Lvert;
      end;
    end;
    Dec(FRestartCtr);

    // color space conversion
    if FColorXForm <> 0 then
    begin
      // convert YCbCr to RGB
      if FNumComps = 3 then
      begin
        for Ly2 := 0 to FMCUHeight - 1 do
        begin
          for Lx2 := 0 to FMcuWidth - 1 do
          begin
            LpY := Smallint(FRowBuf[0][Ly2][Lx1 + Lx2 + 1]);
            LpCb := Smallint(FRowBuf[1][Ly2][Lx1 + Lx2 + 1]) - 128;
            LpCr := Smallint(FRowBuf[2][Ly2][Lx1 + Lx2 + 1]) - 128;
            LpR := (((LpY shl 16) + dctCrToR * LpCr + 32768) shr 16);
            FRowBuf[0][Ly2][Lx1 + Lx2 + 1] := AnsiChar(FDctClip[dctClipOffset + LpR]);
            LpG := Smallint(((LpY shl 16) + dctCbToG * LpCb + dctCrToG * LpCr + 32768) shr 16);
            FRowBuf[1][Ly2][Lx1 + Lx2 + 1] := AnsiChar(FDctClip[dctClipOffset + LpG]);
            LpB := Smallint(((LpY shl 16) + dctCbToB * LpCb + 32768) shr 16);
            FRowBuf[2][Ly2][Lx1 + Lx2 + 1] := AnsiChar(FDctClip[dctClipOffset + LpB]);
          end;
        end;
      // convert YCbCrK to CMYK (K is passed through unchanged)
      end
      else
        if FNumComps = 4 then
        begin
          for Ly2 := 0 to FMCUHeight - 1 do
          begin
            for Lx2 := 0 to FMcuWidth - 1 do
            begin
              LpY := Smallint(FRowBuf[0][Ly2][Lx1 + Lx2 + 1]);
              LpCb := Smallint(FRowBuf[1][Ly2][Lx1 + Lx2 + 1]) - 128;
              LpCr := Smallint(FRowBuf[2][Ly2][Lx1 + Lx2 + 1]) - 128;
              LpR := Smallint(((LpY shl 16) + dctCrToR * LpCr + 32768) shr 16);
              FRowBuf[0][Ly2][Lx1 + Lx2 + 1] := AnsiChar(255 - (FDctClip[dctClipOffset + LpR]));
              LpG := Smallint(((LpY shl 16) + dctCbToG * LpCb + dctCrToG * LpCr + 32768) shr 16);
              FRowBuf[1][Ly2][Lx1 + Lx2 + 1] := AnsiChar(255 - (FDctClip[dctClipOffset + LpG]));
              LpB := Smallint(((LpY shl 16) + dctCbToB * LpCb + 32768) shr 16);
              FRowBuf[2][Ly2][Lx1 + Lx2 + 1] := AnsiChar(255 - (FDctClip[dctClipOffset + LpB]));
            end;
          end;
        end;
    end;
    Lx1 := Lx1 + FMcuWidth;
  end;
  result := True;
end;

function TgtDCTDecode.ReadProgressiveDataUnit(ADcHuffTable,
  AcHuffTable: DCTHuffTable; var precDC: Integer; var Data: array of Integer): Boolean;
var
  LRun, LSize, LAmp, LBit, LChar, LI, LJ, LK: Integer;
begin
  // get the DC coefficient
  LI := FScanInfo.FirstCoeff;
  if LI = 0 then
  begin
    if FScanInfo.Ah = 0 then
    begin
      LSize := ReadHuffSym(ADcHuffTable);
      if LSize = 9999 then
      begin
        Result := False;
        Exit;
      end;
      if LSize > 0 then
      begin
        LAmp := ReadAmp(LSize);
        if LAmp = 9999 then
        begin
          Result := False;
          Exit;
        end
      end
      else
      begin
        LAmp := 0;
      end;
      precDC := precDC + LAmp;
      Data[0] := Data[0] + (precDC shl FScanInfo.AL);
    end
    else
    begin
      LBit := ReadBit;
      if LBit = 9999 then
      begin
        Result := False;
        Exit;
      end;
      data[0] := data[0] + (LBit shl FScanInfo.AL);
    end;
    Inc(LI);
  end;
  if FScanInfo.LastCoeff = 0 then
  begin
    Result := True;
    Exit;
  end;

  // check for an EOB LRun
  if FEobRun > 0 then
  begin
    while LI <= FScanInfo.LastCoeff do
    begin
      LJ := dctZigZag[LI];
      Inc(LI);
      if data[LJ] <> 0 then
      begin
        LBit := ReadBit;
        if LBit = ENDOFFILE then
        begin
          Result := False;
          Exit;
        end;
        if LBit <> 0 then
        begin
          data[LJ] := data[LJ] + (1 shl FScanInfo.AL);
        end;
      end;
    end;
    Dec(FEobRun);
    Result := True;
    Exit;
  end;

  // read the AC coefficients
  while LI <= FScanInfo.LastCoeff do
  begin
    LChar := ReadHuffSym(AcHuffTable);
    if LChar = 9999 then
    begin
      Result := False;
      Exit;
    end;

    // ZRL
    if LChar = $F0 then
    begin
      LK := 0;
      while LK < 16 do
      begin
        LJ := dctZigZag[LI];
        Inc(LI);
        if Data[LJ] = 0 then
        begin
          Inc(LK);
        end
        else
        begin
          LBit := ReadBit;
          if LBit = ENDOFFILE then
          begin
            Result := False;
            Exit;
          end;
          if LBit <> 0 then
          begin
            data[LJ] := data[LJ] + (1 shl FScanInfo.AL);
          end;
        end;
      end;

    // EOB LRun
    end
    else
      if (LChar and $0F) = $00 then
      begin
        LJ := LChar shr 4;
        FEobRun := 0;
        for LK := 0 to LJ - 1 do
        begin
          LBit := ReadBit;
          if LBit = ENDOFFILE then
          begin
            Result := False;
            Exit;
          end;
          FEobRun := (FEobRun shl 1) or LBit;
        end;
        FEobRun := FEobRun + (1 shl LJ);
        while LI <= FScanInfo.LastCoeff do
        begin
          LJ := dctZigZag[LI];
          Inc(LI);
          if Data[LJ] <> 0 then
          begin
            LBit := ReadBit;
            if LBit = ENDOFFILE then
            begin
              Result := False;
              Exit;
            end;
            if LBit <> 0 then
            begin
              data[LJ] := data[LJ] + (1 shl FScanInfo.AL);
            end;
          end;
        end;
        Dec(FEobRun);
        break;

    // zero LRun and one AC coefficient
      end
      else
      begin
        LRun := (LChar shr 4) and $0F;
        LSize := LChar and $0F;
        LAmp := readAmp(LSize);
        if LAmp = 9999 then
        begin
          Result := False;
          Exit;
        end;
        LK := 0;
        repeat
          LJ := dctZigZag[LI];
          Inc(LI);
          while data[LJ] <> 0 do
          begin
            LBit := readBit;
            if LBit = ENDOFFILE then
            begin
              Result := False;
              Exit;
            end;
            if LBit <> 0 then
            begin
              data[LJ] := data[LJ] + (1 shl FScanInfo.AL);
            end;
            LJ := dctZigZag[LI];
            Inc(LJ);
          end;
          Inc(LK);
        until (LK > LRun);
        data[LJ] := LAmp shl FScanInfo.al;
      end;
  end;
  Result := True;
end;

function TgtDCTDecode.ReadProgressiveSOF: Boolean;
var
  LPrec, LI, LChar: Integer;
begin
  Read16;
  try
    LPrec := FStream.GetChar;
  except
    on E: EAccessViolation do
      raise ExInvalidStream.Create(ErrInvalidStream);
  end;
  FHeight := Read16;
  FWidth := Read16;
  FNumComps := FStream.GetChar;
  if (FNumComps <= 0) or (FNumComps > 4) then
  begin
{$IFDEF DEBUG}
    Logger.LogInfo('Bad number of components in DCT stream');
{$ENDIF}
    Result := False;
    FNumComps := 0;
    Exit;
  end;
  if (LPrec <> 8) then
  begin
{$IFDEF DEBUG}
    Logger.LogInfo('Bad DCT precision');
{$ENDIF}
    Result := False;
    Exit;
  end;
  for LI := 0 to FNumComps - 1 do
  begin
    FCompInfo[LI].id := FStream.GetChar;
    LChar := FStream.GetChar;
    FCompInfo[LI].hSample := (LChar shr 4) and $0F;
    FCompInfo[LI].vSample := LChar and $0F;
    FCompInfo[LI].quantTable := FStream.GetChar;
  end;
  FProgressive := True;
  Result := True;
end;

function TgtDCTDecode.ReadQuantTables: Boolean;
var
  LLength, LPrec, LI, LIndex: Integer;
begin
  LLength := Read16 - 2;
  while LLength > 0 do
  begin
    try
      LIndex := FStream.GetChar;
    except
      on E: EAccessViolation do
        raise ExInvalidStream.Create(ErrInvalidStream);
    end;
    LPrec := (LIndex shr 4) and $0F;
    LIndex := LIndex and $0F;
    if (LPrec > 1) or (LIndex >= 4) then
    begin
{$IFDEF DEBUG}
      Logger.LogInfo('Bad DCT quantization table');
{$ENDIF}
      Result := False;
      Exit;
    end;
    if LIndex = FNumQuantTables then
      FNumQuantTables := LIndex + 1;
    for LI := 0 to 63 do
      if LPrec <> 0 then
        FQuantTables[LIndex][dctZigZag[LI]] := Word(Read16)
      else
        FQuantTables[LIndex][dctZigZag[LI]] := Word(FStream.GetChar);
    if LPrec <> 0 then
      LLength := LLength - 129
    else
      LLength := LLength - 65;
  end;
  Result := True;
end;

function TgtDCTDecode.ReadRestartInterval: Boolean;
var
  LLength: Integer;
begin
  LLength := Read16;
  if LLength <> 4 then
  begin
{$IFDEF DEBUG}
    Logger.LogInfo('Bad DCT restart interval');
{$ENDIF}
    Result := False;
    Exit;
  end;
  FRestartInterval := Read16;
  Result := True;
end;

procedure TgtDCTDecode.ReadScan;
var
  LData: array[0..63] of Integer;
  Lx1, Ly1, Ldx1, Ldy1, Lx2, Ly2, Ly3, Lcc, LI, LJ, Lh, Lv, Lhoriz, Lvert, LvSub,
    Lp1, LChar: Integer;
begin
  if FScanInfo.NumComps = 1 then
  begin
    for Lcc := 0 to FNumComps - 1 do
    begin
      if FScanInfo.Comp[Lcc] then
      begin
        break;
      end;
    end;
    Ldx1 := FMCUWidth div FCompInfo[Lcc].hSample;
    Ldy1 := FMCUHeight div FCompInfo[Lcc].vSample;
  end
  else
  begin
    Ldx1 := FMCUWidth;
    Ldy1 := FMCUHeight;
  end;
  Ly1 := 0;
  while Ly1 < FHeight do
  begin
    Lx1 := 0;
    while Lx1 < FWidth do
    begin
      // deal with restart marker
      if (FRestartInterval > 0) and (FRestartCtr = 0) then
      begin
        LChar := readMarker();
        if LChar <> FRestartInterval then
        begin
{$IFDEF DEBUG}
          Logger.LogInfo('Bad DCT data: incorrect restart marker');
{$ENDIF}
          Exit;
        end;
        Inc(FRestartMarker);
        if FRestartMarker = $D8 then
        begin
          FRestartMarker := $D0;
        end;
        restart();
      end;

      // read one MCU
      for Lcc := 0 to FNumComps - 1 do
      begin
        if not FScanInfo.Comp[Lcc] then
        begin
          Continue;
        end;
        Lh := FCompInfo[Lcc].hSample;
        Lv := FCompInfo[Lcc].vSample;
        Lhoriz := FMCUWidth div Lh;
        Lvert := FMCUHeight div Lv;
        LvSub := Lvert div 8;
        Ly2 := 0;
        while Ly2 < Ldy1 do
        begin
          Lx2 := 0;
          while Lx2 < Ldx1 do
          begin
            // pull out the current values
            LI := 0;
            LP1 := 0;
            for Ly3 := 0 to 7 do
            begin
              for LJ := 0 to 7 do
                LData[LI + LJ] := Integer(FframeBuf[Lcc][(Ly1 + Ly2) * FBufWidth
                  + (Lx1 + Lx2 + Lp1 + LJ) + 1]);
              Lp1 := Lp1 + FBufWidth * LvSub;
              LI := LI + 8;
            end;

            // read one data unit
            if FProgressive then
            begin
              if not ReadProgressiveDataUnit(
                FdcHuffTables[FScanInfo.dcHuffTable[Lcc]],
                FacHuffTables[FScanInfo.acHuffTable[Lcc]],
                FCompInfo[Lcc].prevDC,
                LData) then
              begin
                Exit;
              end;
            end
            else
            begin
              if not ReadDataUnit(
                FdcHuffTables[FScanInfo.dcHuffTable[Lcc]],
                FacHuffTables[FScanInfo.acHuffTable[Lcc]],
                FCompInfo[Lcc].prevDC,
                LData) then
              begin
                Exit;
              end;
            end;

            // add the data unit into frameBuf
            LI := 0;
            LP1 := 0;
            for Ly3 := 0 to 7 do
            begin
              for LJ := 0 to 7 do
                FFrameBuf[Lcc][(Ly1 + Ly2) * FBufWidth + (Lx1 + Lx2 + Lp1 + LJ) + 1]
                  := AnsiChar(LData[LI + LJ]);
              Lp1 := Lp1 + FBufWidth * LvSub;
              LI := LI + 8;
            end;
            Lx2 := Lx2 + Lhoriz;
          end;
          Ly2 := Ly2 + Lvert;
        end;
      end;
      Lx1 := Lx1 + Ldx1;
    end;
    Dec(FRestartCtr);
    Ly1 := Ly1 + Ldy1
  end;
end;

function TgtDCTDecode.ReadScanInfo: Boolean;
var
  LLength, LID, LChar, LI, LJ: Integer;
begin
  LLength := Read16 - 2;
  try
    FScanInfo.NumComps := FStream.GetChar;
  except
    on E: EAccessViolation do
      raise ExInvalidStream.Create(ErrInvalidStream);
  end;
  if (FScanInfo.NumComps <= 0) or (FScanInfo.NumComps > 4) then
  begin
{$IFDEF DEBUG}
    Logger.LogInfo('Bad number of components in DCT stream');
{$ENDIF}
    Result := False;
    FScanInfo.NumComps := 0;
    Exit;
  end;
  Dec(LLength);
  if LLength <> (2 * FScanInfo.NumComps + 3) then
  begin
{$IFDEF DEBUG}
    Logger.LogInfo('Bad DCT scan info block');
{$ENDIF}
    Result := False;
    Exit;
  end;
  FScanInfo.NumComps := FNumComps;
  FInterleaved := Boolean(FScanInfo.NumComps);
  for LJ := 0 to FNumComps - 1 do
    FScanInfo.Comp[LJ] := False;

  for LI := 0 to FScanInfo.NumComps - 1 do
  begin
    LID := FStream.GetChar;
    // some (broken) DCT streams reuse ID numbers, but at least they
    // keep the components in order, so we check compInfo[LI] first to
    // work around the problem
    if LID = FCompInfo[LI].ID then
      LJ := LI
    else
    begin
      for LJ := 0 to FNumComps - 1 do
        if LID = FCompInfo[LJ].ID then
          Break;
      if LJ = FNumComps then
      begin
{$IFDEF DEBUG}
        Logger.LogInfo('Bad DCT component ID in scan info block');
{$ENDIF}
        Result := False;
        Exit;
      end;
    end;
    FScanInfo.Comp[LJ] := True;
    LChar := FStream.GetChar;
    FScanInfo.dcHuffTable[LJ] := (LChar shr 4) and $0F;
    FScanInfo.acHuffTable[LJ] := (LChar and $0F);
  end;
  FScanInfo.firstCoeff := FStream.GetChar;
  FScanInfo.lastCoeff := FStream.GetChar;
  LChar := FStream.GetChar;
  FScanInfo.Ah := (LChar shr 4) and $0F;
  FScanInfo.AL := (LChar and $0F);
  Result := True;
end;

function TgtDCTDecode.ReadTrailer: Boolean;
var
  LChar: Integer;
begin
  LChar := ReadMarker;
  if LChar <> $D9 then // EOI
  begin
{$IFDEF DEBUG}
    Logger.LogInfo('Bad DCT trailer');
{$ENDIF}
    Result := False;
    Exit;
  end;
  Result := True;
end;

(**
 * Resets the Stream to its defaults
 * @exception ExOutofMemory if memory is FULL
 *)

procedure TgtDCTDecode.Reset;
var
  LI, LJ: Integer;
begin
  FStream.Reset;

  FInterleaved := False;
  FProgressive := False;
  FWidth := 0;
  FHeight := 0;
  FNumQuantTables := 0;
  FNumDCHuffTables := 0;
  FNumACHuffTables := 0;
  FGotJFIFMarker := False;
  FGotAdobeMarker := False;
  FRestartInterval := 0;
  if not ReadHeader then
  begin
    FY := FHeight;
    Exit;
  end;

  // compute MCU size
  if FNumComps = 1 then
  begin
    FCompInfo[0].hSample := 1;
    FCompInfo[0].vSample := 1;
  end;
  FMCUWidth := FCompInfo[0].hSample;
  FMCUHeight := FCompInfo[0].vSample;
  for LI := 1 to FNumComps - 1 do
  begin
    if (FCompInfo[LI].hSample > FMCUWidth) then
      FMCUWidth := FCompInfo[LI].hSample;
    if (FCompInfo[LI].vSample > FMCUHeight) then
      FMCUHeight := FCompInfo[LI].vSample;
  end;
  FMCUWidth := FMCUWidth * 8;
  FMCUHeight := FMCUHeight * 8;

  // figure out color transform
  if FColorXForm = -1 then
  begin
    if FNumComps = 3 then
    begin
      if FGotJFIFMarker then
        FColorXForm := 1
      else
        if (FCompInfo[0].ID = 82) and (FCompInfo[1].ID = 71) and
          (FCompInfo[2].ID = 66) then // ASCII "RGB"
          FColorXForm := 0
        else
          FColorXForm := 1
    end
    else
      FColorXForm := 0;
  end;

  if FProgressive or (not FInterleaved) then
  begin
    // allocate a buffer for the whole image
    FBufWidth := ((FWidth + FMCUWidth - 1) div FMCUWidth) * FMCUWidth;
    FBufHeight := ((FHeight + FMCUHeight - 1) div FMCUHeight) * FMCUHeight;
    try
      for LI := 0 to FNumComps - 1 do
        SetLength(FFrameBuf[LI], FBufWidth * FBufWidth * sizeof(integer));
    except
      // Catch Out of Memory Exception
      on E: EOutOfResources do
        raise ExOutofMemory.Create(ErrOutofMemory);
    end;

    // read the image data
    repeat
      FRestartMarker := $D0;
      Restart;
      ReadScan;
    until (not ReadHeader);

    // decode
    DecodeImage();

    // initialize counters
    FComp := 0;
    FX := 0;
    FY := 0;
  end
  else
  begin
    // allocate a buffer for one row of MCUs
    FBufWidth := ((FWidth + FMCUWidth - 1) div FMCUWidth) * FMCUWidth;
    try
      for LI := 0 to FNumComps - 1 do
        for LJ := 0 to FMCUHeight - 1 do
          SetLength(FRowBuf[LI][LJ], FBufWidth);
    except
      // Catch Out of Memory Exception
      on E: EOutOfResources do
        raise ExOutofMemory.Create(ErrOutofMemory);
    end;

    // initialize counters
    FComp := 0;
    FX := 0;
    FY := 0;
    FDy := FMCUHeight;
    FRestartMarker := $D0;
    Restart;
  end;
end;

procedure TgtDCTDecode.Restart;
var
  LI: Integer;
begin
  FInputBits := 0;
  FRestartCtr := FRestartInterval;
  for LI := 0 to FNumComps - 1 do
    FCompInfo[LI].prevDC := 0;
  FEobRun := 0;
end;

// Transform one data unit -- this performs the dequantization and
// IDCT steps.  This IDCT algorithm is taken from:
//   Christoph Loeffler, Adriaan Ligtenberg, George S. Moschytz,
//   "Practical Fast 1-D DCT Algorithms with 11 Multiplications",
//   IEEE Intl. Conf. on Acoustics, Speech & Signal Processing, 1989,
//   988-991.

procedure TgtDCTDecode.TransformDataUnit(QuantTable: array of Word;
  var DataIn: array of Integer; var DataOut: array of Byte);
var
  LV0, LV1, LV2, LV3, LV4, LV5, LV6, LV7, LI, LJ, LT: Smallint;
begin
  // dequant
  for LI := 0 to 63 do
    DataIn[LI] := DataIn[LI] * QuantTable[LI];

  // inverse DCT on rows
  LI := 0;
  while LI < 64 do
  begin
    // check for all-zero AC coefficients
    if (dataIn[1 + LI] = 0) and (dataIn[2 + LI] = 0) and (dataIn[3 + LI] = 0) and
      (dataIn[4 + LI] = 0) and (dataIn[5 + LI] = 0) and (dataIn[6 + LI] = 0)
      and (dataIn[7 + LI] = 0) then
    begin
      LT := Smallint((dctSqrt2 * dataIn[0 + LI] + 512) shr 10);
      for LJ := 0 to 7 do
        dataIn[LJ + LI] := LT;
      LI := LI + 8;
      Continue;
    end;

    // stage 4
    LV0 := Smallint((dctSqrt2 * dataIn[0 + LI] + 128) shr 8);
    LV1 := Smallint((dctSqrt2 * dataIn[4 + LI] + 128) shr 8);
    LV2 := dataIn[2 + LI];
    LV3 := dataIn[6 + LI];
    LV4 := Smallint((dctSqrt1d2 * (dataIn[1 + LI] - dataIn[7 + LI]) + 128) shr 8);
    LV7 := Smallint((dctSqrt1d2 * (dataIn[1 + LI] + dataIn[7 + LI]) + 128) shr 8);
    LV5 := Smallint(dataIn[3 + LI] shl 4);
    LV6 := Smallint(dataIn[5 + LI] shl 4);

    // stage 3
    LT := Smallint((LV0 - LV1 + 1) shr 1);
    LV0 := Smallint((LV0 + LV1 + 1) shr 1);
    LV1 := LT;
    LT := Smallint((LV2 * dctSin6 + LV3 * dctCos6 + 128) shr 8);
    LV2 := Smallint((LV2 * dctCos6 - LV3 * dctSin6 + 128) shr 8);
    LV3 := LT;
    LT := Smallint((LV4 - LV6 + 1) shr 1);
    LV4 := Smallint((LV4 + LV6 + 1) shr 1);
    LV6 := LT;
    LT := Smallint((LV7 + LV5 + 1) shr 1);
    LV5 := Smallint((LV7 - LV5 + 1) shr 1);
    LV7 := LT;

    // stage 2
    LT := Smallint((LV0 - LV3 + 1) shr 1);
    LV0 := Smallint((LV0 + LV3 + 1) shr 1);
    LV3 := LT;
    LT := Smallint((LV1 - LV2 + 1) shr 1);
    LV1 := Smallint((LV1 + LV2 + 1) shr 1);
    LV2 := LT;
    LT := Smallint((LV4 * dctSin3 + LV7 * dctCos3 + 2048) shr 12);
    LV4 := Smallint((LV4 * dctCos3 - LV7 * dctSin3 + 2048) shr 12);
    LV7 := LT;
    LT := Smallint((LV5 * dctSin1 + LV6 * dctCos1 + 2048) shr 12);
    LV5 := Smallint((LV5 * dctCos1 - LV6 * dctSin1 + 2048) shr 12);
    LV6 := LT;

    // stage 1
    dataIn[0 + LI] := LV0 + LV7;
    dataIn[7 + LI] := LV0 - LV7;
    dataIn[1 + LI] := LV1 + LV6;
    dataIn[6 + LI] := LV1 - LV6;
    dataIn[2 + LI] := LV2 + LV5;
    dataIn[5 + LI] := LV2 - LV5;
    dataIn[3 + LI] := LV3 + LV4;
    dataIn[4 + LI] := LV3 - LV4;

    LI := LI + 8;
  end;

  // inverse DCT on columns
  for LI := 0 to 7 do
  begin
    // check for all-zero AC coefficients
    if (dataIn[1 * 8 + LI] = 0) and (dataIn[2 * 8 + LI] = 0) and
      (dataIn[3 * 8 + LI] = 0) and (dataIn[4 * 8 + LI] = 0) and
      (dataIn[5 * 8 + LI] = 0) and (dataIn[6 * 8 + LI] = 0) and
      (dataIn[7 * 8 + LI] = 0) then
    begin
      LT := Smallint((dctSqrt2 * dataIn[LI + 0] + 8192) shr 14);
      for LJ := 0 to 7 do
        dataIn[LJ * 8 + LI] := LT;
      Continue;
    end;

    // stage 4
    LV0 := Smallint((dctSqrt2 * dataIn[0 * 8 + LI] + 2048) shr 12);
    LV1 := Smallint((dctSqrt2 * dataIn[4 * 8 + LI] + 2048) shr 12);
    LV2 := dataIn[2 * 8 + LI];
    LV3 := dataIn[6 * 8 + LI];
    LV4 := Smallint((dctSqrt1d2 * (dataIn[1 * 8 + LI] - dataIn[7 * 8 + LI]) + 2048) shr 12);
    LV7 := Smallint((dctSqrt1d2 * (dataIn[1 * 8 + LI] + dataIn[7 * 8 + LI]) + 2048) shr 12);
    LV5 := dataIn[3 * 8 + LI];
    LV6 := dataIn[5 * 8 + LI];

    // stage 3
    LT := Smallint((LV0 - LV1 + 1) shr 1);
    LV0 := Smallint((LV0 + LV1 + 1) shr 1);
    LV1 := LT;
    LT := Smallint((LV2 * dctSin6 + LV3 * dctCos6 + 2048) shr 12);
    LV2 := Smallint((LV2 * dctCos6 - LV3 * dctSin6 + 2048) shr 12);
    LV3 := LT;
    LT := Smallint((LV4 - LV6 + 1) shr 1);
    LV4 := Smallint((LV4 + LV6 + 1) shr 1);
    LV6 := LT;
    LT := Smallint((LV7 + LV5 + 1) shr 1);
    LV5 := Smallint((LV7 - LV5 + 1) shr 1);
    LV7 := LT;

    // stage 2
    LT := Smallint((LV0 - LV3 + 1) shr 1);
    LV0 := Smallint((LV0 + LV3 + 1) shr 1);
    LV3 := LT;
    LT := Smallint((LV1 - LV2 + 1) shr 1);
    LV1 := Smallint((LV1 + LV2 + 1) shr 1);
    LV2 := LT;
    LT := Smallint((LV4 * dctSin3 + LV7 * dctCos3 + 2048) shr 12);
    LV4 := Smallint((LV4 * dctCos3 - LV7 * dctSin3 + 2048) shr 12);
    LV7 := LT;
    LT := Smallint((LV5 * dctSin1 + LV6 * dctCos1 + 2048) shr 12);
    LV5 := Smallint((LV5 * dctCos1 - LV6 * dctSin1 + 2048) shr 12);
    LV6 := LT;

    // stage 1
    dataIn[0 * 8 + LI] := LV0 + LV7;
    dataIn[7 * 8 + LI] := LV0 - LV7;
    dataIn[1 * 8 + LI] := LV1 + LV6;
    dataIn[6 * 8 + LI] := LV1 - LV6;
    dataIn[2 * 8 + LI] := LV2 + LV5;
    dataIn[5 * 8 + LI] := LV2 - LV5;
    dataIn[3 * 8 + LI] := LV3 + LV4;
    dataIn[4 * 8 + LI] := LV3 - LV4;
  end;

  // convert to 8-bit integers
  for LI := 0 to 63 do
    DataOut[LI] := FDctClip[Smallint(dctClipOffset + 128 + ((dataIn[LI] + 8)
      shr 4))];
end;

//{$ENDIF}
end.
