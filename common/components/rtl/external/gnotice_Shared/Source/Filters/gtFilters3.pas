{*****************************************************************************}
{                                                                             }
{  Gnostice Shared Filter Library                                             }
{                                                                             }
{  Copyright © 2002-2008 Gnostice Information Technologies Private Limited    }
{  http://www.gnostice.com                                                    }
{                                                                             }
{*****************************************************************************}
{$I ..\gtSharedDefines.inc}
unit gtFilters3;

interface

uses Classes, SysUtils, gtClasses3, gtUtils3
  {$IFDEF WIN32} ,gtdzlib3{$ENDIF} {$IFDEF WIN64} ,System.ZLib{$ENDIF};

type
  TgtFilter = class
  protected
    function Encode(AStream: TMemoryStream; ALevel: TCompressionLevel):
      TMemoryStream; overload; virtual;
    function Encode(const AString: String; ALevel: TCompressionLevel):
      String; overload; virtual;

    function Encode(AStream: TMemoryStream): TMemoryStream; overload; virtual;
    function Encode(const AString: String): String; overload; virtual;

    function Decode(AStream: TMemoryStream):
      TMemoryStream; overload; virtual; abstract;
    function Decode(const AString: String): String; overload; virtual; abstract;
  end;

  TgtAscii85Filter = class(TgtFilter)
  public
    function Encode(AStream: TMemoryStream): TMemoryStream; overload; override;
    function Decode(AStream: TMemoryStream): TMemoryStream; overload; override;
    function Encode(const AString: String): String; overload; override;
    function Decode(const AString: String): String; overload; override;
  end;

  TgtAsciiHexFilter = class(TgtFilter)
  public
    function Encode(AStream: TMemoryStream): TMemoryStream; overload; override;
    function Decode(AStream: TMemoryStream): TMemoryStream; overload; override;
    function Encode(const AString: String): String; overload; override;
    function Decode(const AString: String): String; overload; override;
  end;

  TgtFlateFilter = class(TgtFilter)
  public
    function Encode(AStream: TMemoryStream; ALevel: TCompressionLevel):
      TMemoryStream; overload; override;
    function Decode(AStream: TMemoryStream): TMemoryStream; overload; override;
    function Encode(const AString: String; ALevel: TCompressionLevel):
      String; overload; override;
    function Decode(const AString: String): String; overload; override;
  end;

  TgtRLEFilter = class(TgtFilter)
  public
    function Encode(AStream: TMemoryStream): TMemoryStream; overload; override;
    function Decode(AStream: TMemoryStream): TMemoryStream; overload; override;
    function Encode(const AString: String): String; overload; override;
    function Decode(const AString: String): String; overload; override;
  end;
  TgtLZWFilter= class(TgtFilter)
  private
    LZWDictionary: TStringList;
    procedure InitializeTable;
  public
    constructor Create;
    destructor Destroy; override;
    function Decode(AStream: TMemoryStream): TMemoryStream; overload; override;
    function Decode(const AString: String): String; overload; override;
  end;
implementation

{ TgtFlateFilter }

function TgtFlateFilter.Decode(AStream: TMemoryStream): TMemoryStream;
var
  LDeCmprStream: TDecompressionStream;
  LBuf: Pointer;
  LCnt: Cardinal;
begin
  AStream.Position := 0;
  Result := TMemoryStream.Create;
  LDeCmprStream := TDecompressionStream.Create(AStream);
  LBuf := AllocMem(10240);
  repeat
    LCnt := LDeCmprStream.Read(LBuf^, 10240);
    Result.Write(PChar(LBuf^), LCnt);
  until (LCnt < 10240);
  FreeMemory(LBuf);
  LDeCmprStream.Free;
  Result.Position := 0;
end;

function TgtFlateFilter.Decode(const AString: String): String;
var
  LInMem, LOutMem: TMemoryStream;
  LSize: Cardinal;
  LDecoded: TMemoryStream;
begin
  LInMem := TMemoryStream.Create;
  LOutMem := TMemoryStream.Create;
  if Length(AString) = 0 then
    Exit;
  LInMem.Write(AString[1], Length(AString));
  LDecoded := Decode(LInMem);
  LOutMem.CopyFrom(LDecoded, 0);
  FreeAndNil(LDecoded);
  FreeAndNil(LInMem);
  LSize := LOutMem.Size;
  LOutMem.Position := 0;
  SetLength(Result, LSize);
  LOutMem.Read(Result[1], LSize);
  FreeAndNil(LOutMem);
end;

function TgtFlateFilter.Encode(AStream: TMemoryStream;
  ALevel: TCompressionLevel): TMemoryStream;
var
  LCmprStream: TCompressionStream;
begin
  Result := TMemoryStream.Create;
  LCmprStream := TCompressionStream.Create(ALevel, Result);
  AStream.Position := 0;
  LCmprStream.CopyFrom(AStream, 0);
  LCmprStream.Free;
  Result.Position := 0;
end;

function TgtFlateFilter.Encode(const AString: String;
  ALevel: TCompressionLevel): String;
var
  LInMem, LOutMem: TMemoryStream;
  LEncoded: TMemoryStream;
  LSize: Cardinal;
begin
  LInMem := TMemoryStream.Create;
  LOutMem := TMemoryStream.Create;
  if Length(AString) > 0 then
    LInMem.Write(AString[1], Length(AString));
  LEncoded := Encode(LInMem, ALevel);
  LOutMem.CopyFrom(LEncoded, 0);
  FreeAndNil(LEncoded);
  LSize := LOutMem.Size;
  LOutMem.Position := 0;
  SetLength(Result, LSize);
  LOutMem.Read(Result[1], LSize);
  FreeAndNil(LOutMem);
  FreeAndNil(LInMem);
end;

{ TgtAsciiHexFilter }

function TgtAsciiHexFilter.Decode(AStream: TMemoryStream): TMemoryStream;
var
  LFirstByte: Boolean;
  LMemStream, LOut: TgtExtMemStream;
  LSize: Int64;
  LJ, LK: String;
begin
  LMemStream := TgtExtMemStream.Create;
  LOut := TgtExtMemStream.Create;
  LMemStream.CopyFrom(AStream, 0);
  LSize := LMemStream.Size;
  LMemStream.Position := LSize - 1;
  if (LMemStream.ReadString(1) <> '>') then
    raise Exception.Create('EndOfData marker is wrong');
  LMemStream.Position := 0; LFirstByte := False; LK := '';
  repeat
    LFirstByte := not LFirstByte;
    LJ := (UpperCase(String(LMemStream.ReadString(1))));
    if (LJ = '>') then begin
      if (LFirstByte) then
        LOut.WriteByte(Byte(StrToIntDef('$' + LK + '0', 0) and $FF));
    end
    else if ((LJ = ' ') or (LJ = #10) or (LJ = #13) or (LJ = #9)) then begin
      Continue;
    end
    else begin
    {$IFDEF gtDelphi2009Up}
      if (not (SysUtils.CharInSet(LJ[1],['0'..'9'])) or (SysUtils.CharInSet(LJ[1],['A'..'F']))) then
    {$ELSE}
      if (not ((LJ[1] in ['0'..'9']) or (LJ[1] in ['A'..'F']))) then
    {$ENDIF}
        raise Exception.Create('Illeagal character within stream');
      if (not LFirstByte) then
        LOut.WriteByte(Byte(StrToIntDef('$' + LK + LJ, 0) and $FF))
      else LK := LJ;
    end;
  until (((LSize-1) = LMemStream.Position) or (LJ = '>'));
  Result := TMemoryStream.Create;
  Result.CopyFrom(LOut, 0);
  LOut.Free;
  LMemStream.Free;
end;

function TgtAsciiHexFilter.Decode(const AString: String): String;
var
  LInMemStream, LOutMemStream: TgtExtMemStream;
  LSize: Int64;
  LATemp : AnsiString;
begin
  LInMemStream := TgtExtMemStream.Create;
  LOutMemStream := TgtExtMemStream.Create;
  LATemp := AnsiString(AString);
  LInMemStream.Write(LATemp[1], Length(AString));
  LOutMemStream.CopyFrom(Decode(LInMemStream), 0);
  LSize := LOutMemStream.Size;
  LOutMemStream.Position := 0;
  Result := String(LOutMemStream.ReadString(LSize));
end;

function TgtAsciiHexFilter.Encode(AStream: TMemoryStream): TMemoryStream;
var
  LStr: String;
  LSize: Int64;
  LInMem: TgtExtMemStream;
begin
  Result := TMemoryStream.Create;
  LInMem := TgtExtMemStream.Create;
  LInMem.CopyFrom(AStream, 0);
  LSize := LInMem.Size;
  LInMem.Position := 0;
  LStr := Encode(String(LInMem.ReadString(LSize)));
  Result.Write(LStr[1], Length(LStr));
end;

function TgtAsciiHexFilter.Encode(const AString: String): String;
begin
  Result := UpperCase(String(GetHexOfStr(AnsiString(Result)) + '>'));
end;

{ TgtAscii85Filter }

function TgtAscii85Filter.Decode(AStream: TMemoryStream): TMemoryStream;
const
  Pow85: array[0..4] of Int64 = (85*85*85*85, 85*85*85, 85*85, 85, 1);
var
  LMemStream, LOut: TgtExtMemStream;
  LSize: Int64;
  L4Bytes: array[0..3] of Byte;
  LDecimal, LTmp: Int64;
  LI, LCount: Integer;
  LJ: Byte;
begin
  LMemStream := TgtExtMemStream.Create;
  LOut := TgtExtMemStream.Create;
  LMemStream.CopyFrom(AStream, 0);
  LSize := LMemStream.Size;
  LMemStream.Position := LSize - 2;
  if (LMemStream.ReadString(2) <> '~>') then
    raise Exception.Create('EndOfData marker is wrong');
  LMemStream.Position := 0; LCount := 0; LDecimal := 0;
  while ((LSize-2) <> LMemStream.Position) do begin
    LJ := LMemStream.ReadByte;
    if (LJ = Ord('z')) then begin
      if (LCount <> 0) then
        raise Exception.Create('"z" found at inappropriate position');
      LOut.WriteULong(0);
    end
    else if ((LJ = Ord(' ')) or (LJ = $0A) or (LJ = $0D) or (LJ = $09)) then begin
      Continue;
    end
    else begin
      if ((LJ < Ord('!')) or (LJ > Ord('u'))) then
        raise Exception.Create('Illeagal character within stream');
      LDecimal := LDecimal + ((LJ - 33) * Pow85[LCount]);
      Inc(LCount);
      if (LCount = 5) then begin
        LTmp := LDecimal;
        L4Bytes[0] := 0; L4Bytes[1] := 0; L4Bytes[2] := 0; L4Bytes[3] := 0;
        LI := 3;
        while LTmp <> 0 do begin
          L4Bytes[LI] := L4Bytes[LI] + (LTmp mod 256);
          LTmp := LTmp div 256;
          Dec(LI);
        end;
        LOut.Write(L4Bytes, 4);
        LCount := 0;
        LDecimal := 0;
      end;
    end;
  end;
  if (LCount = 1) then
    raise Exception.Create('Single Final Character')
  else if (LCount > 1) then begin
    LTmp := LDecimal;
    L4Bytes[0] := 0; L4Bytes[1] := 0; L4Bytes[2] := 0; L4Bytes[3] := 0;
    LI := 3;
    while LTmp <> 0 do begin
      L4Bytes[LI] := L4Bytes[LI] + (LTmp mod 256);
      LTmp := LTmp div 256;
      Dec(LI);
    end;
    for LI := (LCount-1) to 3 do begin
      if L4Bytes[LI] <> 0 then begin
        Inc(L4Bytes[LCount-2]);
        Break;
      end;
    end;
    LOut.Write(L4Bytes, LCount-1);
  end;
  Result := TMemoryStream.Create;
  Result.CopyFrom(LOut, 0);
  LOut.Free;
  LMemStream.Free;
end;

function TgtAscii85Filter.Decode(const AString: String): String;
var
  LInMemStream, LOutMemStream: TgtExtMemStream;
  LSize: Int64;
  LDecoded: TMemoryStream;
  LATemp : AnsiString;
begin
  LInMemStream := TgtExtMemStream.Create;
  LOutMemStream := TgtExtMemStream.Create;
  LATemp := AnsiString(AString);
  LInMemStream.Write(LATemp[1], Length(AString));
  LDecoded := Decode(LInMemStream);
  LOutMemStream.CopyFrom(LDecoded, 0);
  FreeAndNil(LDecoded);
  LSize := LOutMemStream.Size;
  LOutMemStream.Position := 0;
  Result := String(LOutMemStream.ReadString(LSize));
  FreeAndNil(LOutMemStream);
  FreeAndNil(LInMemStream);
end;

function TgtAscii85Filter.Encode(AStream: TMemoryStream): TMemoryStream;
var
  LMemStream, LOut: TgtExtMemStream;
  LSize: Int64;
  L5Bytes: array[0..4] of Byte;
  LDecimal, LTmp: Int64;
  LI, LCount: Integer;
begin
  LMemStream := TgtExtMemStream.Create;
  LOut := TgtExtMemStream.Create;
  LMemStream.CopyFrom(AStream, 0);
  LSize := LMemStream.Size;
  LMemStream.Position := 0;
  LCount := -1; LDecimal := 0;
  while (LSize <> LMemStream.Position) do begin
    Inc(LCount);
    case LCount of
      0: LDecimal := LDecimal + LMemStream.ReadByte * 256 * 256 * 256;
      1: LDecimal := LDecimal + LMemStream.ReadByte * 256 * 256;
      2: LDecimal := LDecimal + LMemStream.ReadByte * 256;
      3: begin
        LDecimal := LDecimal + LMemStream.ReadByte;
        if (LDecimal = 0) then LOut.WriteByte(Ord('z'))
        else begin
          LTmp := LDecimal;
          LI := 4;
          L5Bytes[0] := 33; L5Bytes[1] := 33; L5Bytes[2] := 33;
          L5Bytes[3] := 33; L5Bytes[4] := 33;
          while LTmp <> 0 do begin
            L5Bytes[LI] := L5Bytes[LI] + (LTmp mod 85);
            LTmp := LTmp div 85;
            Dec(LI);
          end;
          LOut.Write(L5Bytes, 5);
        end;
        LCount := -1;
        LDecimal := 0;
      end;
    end;
  end;
  if (LCount <> -1) then begin
    LTmp := LDecimal;
    LI := 4;
    L5Bytes[0] := 33; L5Bytes[1] := 33; L5Bytes[2] := 33;
    L5Bytes[3] := 33; L5Bytes[4] := 33;
    while LTmp <> 0 do begin
      L5Bytes[LI] := L5Bytes[LI] + (LTmp mod 85);
      LTmp := LTmp div 85;
      Dec(LI);
    end;
    LOut.Write(L5Bytes, LCount+2);
  end;
  LOut.WriteString('~>');
  Result := TMemoryStream.Create;
  Result.CopyFrom(LOut, 0);
  LOut.Free;
  LMemStream.Free;
end;

function TgtAscii85Filter.Encode(const AString: String): String;
var
  LInMemStream, LOutMemStream: TgtExtMemStream;
  LTemp: TMemoryStream;
  LSize: Int64;
  LATemp : AnsiString;
begin
  LInMemStream := TgtExtMemStream.Create;
  LOutMemStream := TgtExtMemStream.Create;
  LATemp := AnsiString(AString);
  LInMemStream.Write(LATemp[1], Length(AString));
  LTemp := Encode(LInMemStream);
  LOutMemStream.CopyFrom(LTemp, 0);
  FreeAndNil(LTemp);
  LSize := LOutMemStream.Size;
  LOutMemStream.Position := 0;
  Result := String(LOutMemStream.ReadString(LSize));
  FreeAndNil(LOutMemStream);
  FreeAndNil(LInMemStream);
end;

{ TgtRLEFilter }

function TgtRLEFilter.Decode(AStream: TMemoryStream): TMemoryStream;
var
  LInStr, LOutStr: String;
  LSize: Int64;
begin
  Result := TMemoryStream.Create;
  LSize := AStream.Size;
  AStream.Position := 0;
  SetLength(LInStr, LSize);
  AStream.Read(LInStr[1], LSize);
  LOutStr := Decode(LInStr);
  Result.Write(LOutStr[1], Length(LOutStr));
  Result.Position := 0;
end;

function TgtRLEFilter.Decode(const AString: String): String;
var
  LI: Int64;
  LJ, LK: Byte;
begin
  Result := ''; LI := 1;
  if (AString[Length(AString)] <> #128) then
    raise Exception.Create('EndOfData Marker is wrong');
  while LI < Length(AString) do begin
    LJ := Ord(AString[LI]);
    if (LJ in [0..127]) then begin
      if ((LI+LJ+2) > Length(AString)) then
        raise Exception.Create('Unexpected EndOfFile found');
      Result := Result + System.Copy(AString, LI+1, LJ+1);
      Inc(LI, LJ+2);
    end
    else if (LJ in [129..255]) then begin
      if ((LI+2) > Length(AString)) then
        raise Exception.Create('Unexpected EndOfFile found');
      for LK := 1 to (257-LJ) do Result := Result + AString[LI+1];
      Inc(LI, 2);
    end
    else raise Exception.Create('Premature EndOfData Marker found');
  end;
end;

function TgtRLEFilter.Encode(const AString: String): String;
var
  i, RCnt, LCnt : Integer;
  BoolRep : Boolean;
  RRun, LRun: String;
begin
  Result := '';
  RRun := AString[1];
  RCnt := 1;
  BoolRep := True;
  i := 2;
  while (i <= Length(AString)) do begin
    if (AString[i] = AString[i-1]) then begin
      RRun := AString[i];
      Inc(RCnt);
      if ((RCnt > 2) and (Length(LRun) > 0)) then begin
        LCnt := Length(LRun);
        while (LCnt > 128) do begin
          Result := Result + Chr(127) + System.Copy(LRun, 1, 128);
          LRun := System.Copy(LRun, 129, LCnt);
          LCnt := LCnt - 128;
        end;
        Result := Result + Chr(LCnt-1) + LRun;
        LRun := '';
        BoolRep := True;
      end;
    end
    else begin
      if (RCnt > 2) then begin
        while (RCnt > 128) do begin
          Result := Result + Chr(129) + RRun;
          RCnt := RCnt - 128;
        end;
        Result := Result + Chr(257-RCnt) + RRun;
        RRun := AString[i];
        RCnt := 1;
      end
      else if (RCnt = 2) then begin
        if (BoolRep) then begin
          Result := Result + Chr(257-RCnt) + RRun;
          RRun := AString[i];
          RCnt := 1;
        end
        else begin
          if ((i = Length(AString)) or (AString[i] <> AString[i+1])) then begin
            LRun := LRun + RRun + RRun;
            RRun := AString[i];
            RCnt := 1;
            BoolRep := False;
          end
          else begin
            LCnt := Length(LRun);
            while (LCnt > 128) do begin
              Result := Result + Chr(127) + System.Copy(LRun, 1, 128);
              LRun := System.Copy(LRun, 129, LCnt);
              LCnt := LCnt - 128;
            end;
            Result := Result + Chr(LCnt-1) + LRun;
            LRun := '';
            Result := Result + Chr(257-RCnt) + RRun;
            BoolRep := True;
            RRun := AString[i];
            RCnt := 1;
          end;
        end;
      end
      else if (RCnt = 1) then begin
        LRun := LRun + RRun;
        BoolRep := False;
        RRun := AString[i];
      end;
    end;
    Inc(i);
  end; // end-while
  if (RCnt = 1) then begin
    LRun := LRun + RRun;
  end;
  if (Length(LRun) > 0) then begin
    LCnt := Length(LRun);
    while (LCnt > 128) do begin
      Result := Result + Chr(127) + System.Copy(LRun, 1, 128);
      LRun := System.Copy(LRun, 129, LCnt);
      LCnt := LCnt - 128;
    end;
    Result := Result + Chr(LCnt-1) + LRun;
  end;
  if (RCnt > 1) then begin
    while (RCnt > 128) do begin
      Result := Result + Chr(129) + RRun;
      RCnt := RCnt - 128;
    end;
    Result := Result + Chr(257-RCnt) + RRun;
  end;
  Result := Result + #128; // EndOfData Marker
end;

function TgtRLEFilter.Encode(AStream: TMemoryStream): TMemoryStream;
var
  LInStr, LOutStr: String;
  LSize: Int64;
begin
  Result := TMemoryStream.Create;
  LSize := AStream.Size;
  AStream.Position := 0;
  SetLength(LInStr, LSize);
  AStream.Read(LInStr[1], LSize);
  LOutStr := Encode(LInStr);
  Result.Write(LOutStr[1], Length(LOutStr));
  Result.Position := 0;
end;

{ TgtFilter }

function TgtFilter.Encode(AStream: TMemoryStream;
  ALevel: TCompressionLevel): TMemoryStream;
begin
  Result := nil;
end;

function TgtFilter.Encode(const AString: String;
  ALevel: TCompressionLevel): String;
begin
  Result := '';
end;

function TgtFilter.Encode(AStream: TMemoryStream): TMemoryStream;
begin
  Result := nil;
end;

function TgtFilter.Encode(const AString: String): String;
begin
  Result := '';
end;

{ TgtLZWFilter }

function TgtLZWFilter.Decode(AStream: TMemoryStream): TMemoryStream;
var
  LStream : TMemoryStream;
  Lstr, LDecompressedString: String;
begin
  Result := TMemoryStream.Create;
  LStream := TMemoryStream.Create;
  LStream.LoadFromStream(AStream);
  SetLength(Lstr,LStream.Size);
  LStream.Read(Lstr[1],LStream.Size);
  LDecompressedString:= Decode(Lstr);
  Result.Write(LDecompressedString[1],Length(LDecompressedString));
  FreeAndNil(LStream);
end;

constructor TgtLZWFilter.Create;
begin
  inherited;
  InitializeTable;
end;

function TgtLZWFilter.Decode(const AString: String): String;
const
  Buffer_Max=24;
  ClearTableCode= 256;
  EndOfTableCode= 257;
  MaskArray: array[0..3] of Integer= (511, 1023, 2047, 4095);
var
  LFirst_Char_Of_CurrentCode: Char;
  LDecompressedString, LTemp, Ltemp1: String;
  LBufferSize, CodeLength, LMask, LStreamLength, LOldCode: Integer;
  LBuffer, LCode: Cardinal;
begin
  Result :='';
  LStreamLength:=1;
  LDecompressedString :='';
  CodeLength :=9;
  LMask:=0;
  LOldCode := 999999999;
  LTemp:='';
  Ltemp1:='';
  LFirst_Char_Of_CurrentCode :='A';
  LBufferSize :=0;
  LBuffer:=0;
  InitializeTable;
  while(LStreamLength< Length(AString)) do
  begin
    while(LBufferSize <= (Buffer_max-8)) do
    begin
      LBuffer := LBuffer shl 8;
      LBuffer := LBuffer or Cardinal((Char(AString[LStreamLength])));
      LBufferSize := LBufferSize+8;
      Inc(LStreamLength);
    end;
    while(LBufferSize>= CodeLength) do
    begin
      LCode:= (LBuffer shr (LBufferSize-CodeLength)) and MaskArray[LMask];
      LBufferSize := LBufferSize-CodeLength;
      if(LCode=ClearTableCode) then
      begin
        InitializeTable;
        CodeLength :=9;
      end
      else if(LCode=EndOfTableCode) then
      begin
        LStreamLength := Length(AString);
        Break;
      end
      else
      begin
        // Checking wether the code is present in Dictionary or not
        if(LCode >= Cardinal(LZWDictionary.Count)) then
        begin
          LTemp:= LZWDictionary.Strings[LOldCode];
          LTemp:= LTemp+ LFirst_Char_Of_CurrentCode;
        end
        else// Here we found the String corresponding to the code
          LTemp:=LZWDictionary.Strings[LCode];
        // We have added this pattern to decompressed String
        LDecompressedString := LDecompressedString+LTemp;
        // Now we are going to add new pattern
        LFirst_Char_Of_CurrentCode := Ltemp[1];
        if(LOldCode<LZWDictionary.Count) then
          Ltemp1 := LZWDictionary[LOldCode];
        Ltemp1 := LTemp1+LFirst_Char_Of_CurrentCode;
        LZWDictionary.Insert(LZWDictionary.Count, Ltemp1);
        Ltemp1 :='';
        LOldCode := LCode;
        case LZWDictionary.Count of
          511,1023,2047:
          begin
            Inc(CodeLength);
            Inc(LMask);
          end;
          4095:
          begin
            InitializeTable;
            LMask:=0;
          end;
          else
            Break;
        end; // end of case statement
      end;
    end;
  end;
  Result := LDecompressedString;
end;

destructor TgtLZWFilter.Destroy;
begin
  LZWDictionary.Clear;
  FreeAndNil(LZWDictionary);
  inherited;
end;

procedure TgtLZWFilter.InitializeTable;
var
  LI: Integer;
begin
  if not Assigned(LZWDictionary) then
    LZWDictionary := TStringList.Create
  else
    LZWDictionary.Clear;
  for LI:= 0 to 255 do
  begin
    LZWDictionary.Insert(LI,Char(LI));
  end;
  LZWDictionary.Insert(256,Char(256));
end;
end.
