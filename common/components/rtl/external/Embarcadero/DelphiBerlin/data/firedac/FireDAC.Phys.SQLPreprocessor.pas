{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{            FireDAC db command preprocessor            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.SQLPreprocessor;

interface

uses
  System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Param,
  FireDAC.Phys.Intf;

type
  TFDPhysPreprocessorInstr = (piCreateParams, piCreateMacros,
    piExpandParams, piExpandMacros, piExpandEscapes, piParseSQL,
    piTransformQuestions, piTransformEOLs);
  TFDPhysPreprocessorInstrs = set of TFDPhysPreprocessorInstr;

  TFDPhysPreprocessor = class(TObject)
  private
    // control
    FConnMetadata: IFDPhysConnectionMetadata;
    FParams: TFDParams;
    FMacrosUpd, FMacrosRead: TFDMacros;
    FInstrs: TFDPhysPreprocessorInstrs;
    FDesignMode: Boolean;
    FNameDelims1, FNameDelims2: TFDByteSet;
    FParamMark: TFDPhysParamMark;
    FNested: Boolean;
    // runtime
    FPrevCh, FCh: Char;
    FSource, FDestination: String;
    FSourceLen: Integer;
    FSrcIndex, FCommitedIndex, FDestinationIndex: Integer;
    FInComment1, FInComment2,
      FInStr1, FInStr2, FInStr3,
      FInMySQLConditional, FInProgramBlock: Boolean;
    FInNames: TFDPhysNameQuoteLevels;
    FEscapeLevel, FBraceLevel, FParamCount, FSkipEscapes: Integer;
    FParamCache: TFDStringList;
    FDestStack: TFDStringList;
    FTokens: TFDStringList;
    FQuoteTags: TFDStringList;
    FSQLCommandKind: TFDPhysCommandKind;
    FSQLFromValue: String;
    FSQLOrderByPos: Integer;
    FSQLValuesPos: Integer;
    FSQLValuesPosEnd: Integer;
    FSQLLimitSkip: Integer;
    FSQLLimitRows: Integer;
    FInIntoEscape,
    FWasIntoEscape: Boolean;
    procedure Commit(ASkip: Integer = 0);
    procedure Uncommit(AChars: Integer);
    procedure WriteStr(const AStr: String);
    procedure PushWriter;
    function PopWriter: String;
    function GetChar: Char;
    procedure PutBack;
    procedure SkipWS;
    function ProcessIdentifier(ADotAllowed: Boolean; var AIsQuoted: Boolean): String;
    procedure ProcessParam;
    procedure ProcessQuestion;
    procedure ProcessMacro(AFirstCh: Char);
    function ProcessEscape: TFDPhysEscapeKind;
    function TranslateEscape(var AEscape: TFDPhysEscapeData): String;
    function ProcessCommand: String;
    procedure ParseDestination;
    procedure Missed(const AStr: String);
    procedure ProcessQuoteTag;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Init;
    procedure Execute;
    // R/W
    property ConnMetadata: IFDPhysConnectionMetadata read FConnMetadata write FConnMetadata;
    property Source: String read FSource write FSource;
    property Destination: String read FDestination;
    property Params: TFDParams read FParams write FParams;
    property MacrosUpd: TFDMacros read FMacrosUpd write FMacrosUpd;
    property MacrosRead: TFDMacros read FMacrosRead write FMacrosRead;
    property Instrs: TFDPhysPreprocessorInstrs read FInstrs write FInstrs;
    property DesignMode: Boolean read FDesignMode write FDesignMode;
    // R/O
    property SQLCommandKind: TFDPhysCommandKind read FSQLCommandKind;
    property SQLFromValue: String read FSQLFromValue;
    property SQLOrderByPos: Integer read FSQLOrderByPos;
    property SQLValuesPos: Integer read FSQLValuesPos;
    property SQLValuesPosEnd: Integer read FSQLValuesPosEnd;
    property SQLLimitSkip: Integer read FSQLLimitSkip;
    property SQLLimitRows: Integer read FSQLLimitRows;
  end;

implementation

uses
  System.SysUtils, Data.DB, System.Character,
  FireDAC.Stan.Util, FireDAC.Stan.Error, FireDAC.Stan.Consts;

{ ---------------------------------------------------------------------------- }
{ TFDPhysPreprocessor                                                          }
{ ---------------------------------------------------------------------------- }
constructor TFDPhysPreprocessor.Create;
begin
  inherited Create;
  FDestStack := TFDStringList.Create;
  FParamCache := TFDStringList.Create(dupAccept, True, False);
  FTokens := TFDStringList.Create;
  FQuoteTags := TFDStringList.Create;
  FSQLLimitSkip := -1;
  FSQLLimitRows := -1;
end;

{ ---------------------------------------------------------------------------- }
destructor TFDPhysPreprocessor.Destroy;
begin
  FDFreeAndNil(FTokens);
  FDFreeAndNil(FParamCache);
  FDFreeAndNil(FDestStack);
  FDFreeAndNil(FQuoteTags);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDPhysPreprocessor.Init;
begin
  FTokens.Clear;
  FParamCache.Clear;
  FDestStack.Clear;
  FQuoteTags.Clear;
  FDestination := '';
  FSQLFromValue := '';
  FSQLOrderByPos := 0;
  FSQLValuesPos := 0;
  FSQLValuesPosEnd := 0;
  FSQLCommandKind := skUnknown;
  FSQLLimitSkip := -1;
  FSQLLimitRows := -1;
  FInComment1 := False;
  FInMySQLConditional := False;
  FInComment2 := False;
  FInStr1 := False;
  FInStr2 := False;
  FInStr3 := False;
  FInNames := [];
  FInProgramBlock := False;
  FSrcIndex := 0;
  FCommitedIndex := 0;
  FEscapeLevel := 0;
  FBraceLevel := 0;
  FParamCount := 0;
  FCh := #0;
  FPrevCh := #0;
  FWasIntoEscape := False;
end;

{ ---------------------------------------------------------------------------- }
procedure TFDPhysPreprocessor.Execute;
var
  i: Integer;
  eQuote: TFDPhysNameQuoteLevel;
begin
  ASSERT(not ((MacrosRead = nil) and (piExpandMacros in Instrs) or
     (MacrosUpd = nil) and (piCreateMacros in Instrs) or
     (Params = nil) and (Instrs * [piCreateParams, piExpandParams] <> []) or
     (ConnMetadata = nil) and (Instrs * [piExpandEscapes, piParseSQL] <> [])));
  if FSource = '' then
    Exit;
  Include(FInstrs, piTransformQuestions);
  FNameDelims1 := [];
  FNameDelims2 := [];
  if ConnMetadata <> nil then begin
    for eQuote := Low(TFDPhysNameQuoteLevel) to High(TFDPhysNameQuoteLevel) do begin
      Include(FNameDelims1, Byte(ConnMetadata.NameQuoteChar[eQuote, nsLeft]));
      Include(FNameDelims2, Byte(ConnMetadata.NameQuoteChar[eQuote, nsRight]));
    end;
    FNameDelims1 := FNameDelims1 - [0, Byte(' ')];
    FNameDelims2 := FNameDelims2 - [0, Byte(' ')];
    if (Params <> nil) and (Params.BindMode = pbByNumber) then
      FParamMark := ConnMetadata.PositionedParamMark
    else
      FParamMark := ConnMetadata.NamedParamMark;
  end;
  FDestinationIndex := 1;
  SetLength(FDestination, 512);
  FSourceLen := Length(FSource);

  if piCreateParams in Instrs then begin
    for i := 0 to Params.Count - 1 do
      FParamCache.AddObject(AnsiUpperCase(Params[i].Name), Params[i]);
    FParamCount := Params.Count;
    Params.BeginUpdate;
  end;
  if ([piCreateParams, piExpandParams] * Instrs <> []) and
     not FNested then
    Params.Markers.Clear;
  try
    FDestination := ProcessCommand;
    if piParseSQL in Instrs then begin
      if FEscapeLevel > 0 then
        Missed('}');
      ParseDestination;
    end;
  finally
    if piCreateParams in Instrs then
      Params.EndUpdate;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPreprocessor.Missed(const AStr: String);
begin
  FDException(Self, [S_FD_LPhys], er_FD_AccPrepMissed, [AStr]);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPreprocessor.Commit(ASkip: Integer = 0);
var
  iLen: Integer;
begin
  iLen := FSrcIndex - FCommitedIndex + ASkip;
  if FCommitedIndex + iLen >= FSourceLen then
    iLen := FSourceLen - FCommitedIndex;
  if iLen > 0 then begin
    while FDestinationIndex + iLen - 1 > Length(FDestination) do
      SetLength(FDestination, Length(FDestination) * 2);
    Move((PChar(FSource) + FCommitedIndex)^,
      (PChar(FDestination) + FDestinationIndex - 1)^, iLen * SizeOf(Char));
    FDestinationIndex := FDestinationIndex + iLen;
  end;
  FCommitedIndex := FSrcIndex;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPreprocessor.Uncommit(AChars: Integer);
begin
  Dec(FCommitedIndex, AChars);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPreprocessor.WriteStr(const AStr: String);
var
  iLen: Integer;
begin
  iLen := Length(AStr);
  if iLen > 0 then begin
    while FDestinationIndex + iLen - 1 > Length(FDestination) do
      SetLength(FDestination, Length(FDestination) * 2);
    Move(PChar(AStr)^, (PChar(FDestination) + FDestinationIndex - 1)^, iLen * SizeOf(Char));
    FDestinationIndex := FDestinationIndex + iLen;
  end;
  FCommitedIndex := FSrcIndex;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPreprocessor.PushWriter;
begin
  FDestStack.AddInt(FDestination, FDestinationIndex);
  SetLength(FDestination, 512);
  FDestinationIndex := 1;
  FCommitedIndex := FSrcIndex;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPreprocessor.PopWriter: String;
begin
  Commit;
  Result := Copy(FDestination, 1, FDestinationIndex - 1);
  FDestination := FDestStack[FDestStack.Count - 1];
  FDestinationIndex := FDestStack.Ints[FDestStack.Count - 1];
  FDestStack.Delete(FDestStack.Count - 1);
  FCommitedIndex := FSrcIndex;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPreprocessor.GetChar: Char;
begin
  Inc(FSrcIndex);
  if FSrcIndex > FSourceLen then
    Result := #0
  else
    Result := FSource[FSrcIndex];
  FPrevCh := FCh;
  FCh := Result;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPreprocessor.PutBack;
begin
  Dec(FSrcIndex);
  FPrevCh := FSource[FSrcIndex];
  FCh := FPrevCh;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPreprocessor.SkipWS;
var
  ch: Char;
begin
  repeat
    ch := GetChar;
  until (ch > ' ') or (ch = #0);
  if ch <> #0 then
    PutBack;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPreprocessor.ProcessIdentifier(ADotAllowed: Boolean; var AIsQuoted: Boolean): String;
var
  aBuff: array [0 .. 255] of Char;
  i: Integer;
  eQuote: TFDPhysNameQuoteLevel;

  function ProcessQuotedDelim(ADelim1, ADelim2: Char; var AName: String): Boolean;
  begin
    Result := False;
    if not FDInSet(ADelim1, [#0, ' ']) and (FCh = ADelim1) then begin
      AIsQuoted := True;
      repeat
        Inc(i);
        if i = 256 then
          FDException(Self, [S_FD_LPhys], er_FD_AccPrepTooLongIdent, []);
        aBuff[i] := GetChar;
      until FDInSet(aBuff[i], [#0, ADelim2]);
      SetString(AName, aBuff, i);
      Result := True;
    end
  end;

begin
  Result := '';
  AIsQuoted := False;
  i := -1;
  if ConnMetadata <> nil then begin
    GetChar;
    for eQuote := Low(TFDPhysNameQuoteLevel) to High(TFDPhysNameQuoteLevel) do
      if ProcessQuotedDelim(ConnMetadata.NameQuoteChar[eQuote, nsLeft],
                            ConnMetadata.NameQuoteChar[eQuote, nsRight], Result) then
        Exit;
    PutBack;
  end;
  repeat
    Inc(i);
    if i = 256 then
      FDException(Self, [S_FD_LPhys], er_FD_AccPrepTooLongIdent, []);
    aBuff[i] := GetChar;
  until not (FDInSet(aBuff[i], ['0'..'9', 'a'..'z', 'A'..'Z', '#', '$', '_']) or
             ADotAllowed and (aBuff[i] = '.')) and not aBuff[i].IsLetter;
  PutBack;
  SetString(Result, aBuff, i);
  Result := AnsiUpperCase(Result);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPreprocessor.ProcessParam;
var
  sName, sSubst: String;
  lIsQuoted: Boolean;
  oPar: TFDParam;
  iPar: Integer;
  cPrevCh, cCh: Char;

  procedure BuildSubstName;
  begin
    if (ConnMetadata.ParamNameMaxLength > 0) and (Length(sName) > ConnMetadata.ParamNameMaxLength - 1) then begin
      if oPar <> nil then
        iPar := oPar.Index
      else if iPar <> -1 then begin
        oPar := TFDParam(FParamCache.Objects[iPar]);
        iPar := oPar.Index;
      end
      else
        iPar := Params.Count;
      Inc(iPar);
      sSubst := Copy(sSubst, 1, ConnMetadata.ParamNameMaxLength - 2 -
        Length(IntToStr(iPar))) + '_' + IntToStr(iPar);
    end
    else
      oPar := Params.FindParam(sName);
    if lIsQuoted then
      sSubst := ':' + ConnMetadata.QuoteObjName(sSubst, npObject)
    else
      sSubst := ':' + sSubst;
  end;

begin
  cPrevCh := FPrevCh;
  cCh := GetChar;
  if FDInSet(cCh, ['=', ' ', #13, #10, #9, #0]) or
     (Byte(cPrevCh) in FNameDelims1) or (Byte(cPrevCh) in FNameDelims2) or
     FDInSet(cPrevCh, ['0'..'9', 'a'..'z', 'A'..'Z', '#', '$', '_']) then begin
    // skip:
    // - PL/SQL assignment operator - :=
    // - TSQL label - name:
    // - Informix - catalog:schema.object
    // - if before ':' is an identifier
  end
  else if cCh = ':' then
    if (ConnMetadata.Kind in [TFDRDBMSKinds.PostgreSQL, TFDRDBMSKinds.MSSQL,
                              TFDRDBMSKinds.Advantage, TFDRDBMSKinds.Informix]) or
       (ConnMetadata.Kind = TFDRDBMSKinds.SQLite) and FNested then begin
      // skip:
      // - PostgreSQL, Informix ::
      // - MSSQL SELECT ... FROM ::fn_xxxx()
      // - ADS SELECT ::conn.TransactionCount FROM system.iota
      // - SQLite SELECT xxxx AS "nm&1", &1=::type
    end
    else
      Commit(-1)
  else begin
    Commit(-2);
    PutBack;
    lIsQuoted := False;
    if ConnMetadata.Kind = TFDRDBMSKinds.Oracle then begin
      sName := ProcessIdentifier(False, lIsQuoted);
      // skip:
      // - Oracle triggers :new. / :old.
      if GetChar = '.' then begin
        UnCommit(2);
        Commit(0);
        Exit;
      end
      else
        PutBack;
    end
    else
      sName := ProcessIdentifier(True, lIsQuoted);
    iPar := -1;
    oPar := nil;
    sSubst := sName;
    if piCreateParams in Instrs then begin
      iPar := FParamCache.IndexOf(AnsiUpperCase(sName));
      if (Params.BindMode = pbByNumber) or (iPar = -1) then begin
        BuildSubstName;
        if (oPar = nil) or (Params.BindMode = pbByNumber) then begin
          oPar := Params.Add;
          oPar.Name := sName;
          if Params.BindMode = pbByNumber then
            oPar.Position := Params.Count;
          oPar.IsCaseSensitive := lIsQuoted;
          FParamCache.AddObject(AnsiUpperCase(sName), oPar);
        end;
      end
      else begin
        sSubst := ':' + sSubst;
        oPar := TFDParam(FParamCache.Objects[iPar]);
      end;
      if oPar.ParamType in [ptUnknown, ptInput] then
        if FInIntoEscape then
          oPar.ParamType := ptInputOutput
        else if DesignMode then
          oPar.ParamType := ptInput;
    end
    else if FParamMark = prName then begin
      // The following is needed, when piCreateParams is not included, but a SQL
      // will be written in any case. So, we should take into account ParamNameMaxLength
      // and lIsQuoted for prName markers.
      oPar := FParams.FindParam(sName);
      BuildSubstName;
    end
    else
      sSubst := ':' + sSubst;
    if piExpandParams in Instrs then begin
      Params.Markers.Add(sName);
      case FParamMark of
      prQMark:
        sSubst := '?';
      prNumber:
        begin
          Inc(FParamCount);
          sSubst := ':' + IntToStr(FParamCount);
        end;
      prDollar:
        if Params.BindMode = pbByNumber then begin
          Inc(FParamCount);
          sSubst := '$' + IntToStr(FParamCount);
        end
        else begin
          if oPar = nil then
            oPar := FParams.FindParam(sName);
          if oPar <> nil then
            sSubst := '$' + IntToStr(oPar.Index + 1)
          else
            sSubst := '$0';
        end;
      prQNumber:
        begin
          Inc(FParamCount);
          sSubst := '?' + IntToStr(FParamCount);
        end;
      end;
    end;
    WriteStr(sSubst);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPreprocessor.ProcessQuestion;
var
  sSubst: String;
  oPar: TFDParam;
begin
  if FParamMark = prQNumber then
    Exit;
  Commit(-1);
  sSubst := '?';
  if piExpandParams in Instrs then
    Params.BindMode := pbByNumber;
  if piCreateParams in Instrs then begin
    oPar := Params.Add;
    if DesignMode then
      oPar.ParamType := ptInput;
    if Params.BindMode = pbByNumber then
      oPar.Position := Params.Count;
  end;
  if piExpandParams in Instrs then
    case FParamMark of
    prName,
    prNumber:
      begin
        Inc(FParamCount);
        sSubst := ':' + IntToStr(FParamCount);
      end;
    prDollar:
      begin
        Inc(FParamCount);
        sSubst := '$' + IntToStr(FParamCount);
      end;
    prQNumber:
      begin
        Inc(FParamCount);
        sSubst := '?' + IntToStr(FParamCount);
      end;
    end;
  WriteStr(sSubst);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPreprocessor.ProcessMacro(AFirstCh: Char);
var
  sName: String;
  oMacro: TFDMacro;
  lIsRaw, lIsQuoted, lProcessRes: Boolean;
  sRes: String;
  i: Integer;
  oPP: TFDPhysPreprocessor;
  cCh: Char;
begin
  lIsRaw := (AFirstCh = '!');
  cCh := GetChar;
  if FDInSet(cCh, ['=', '&', ' ', #13, #10, #9, #0]) then begin
    // skip:
    // - !=, &=, &&, & operators
    // - delimiters
  end
  else if cCh = AFirstCh then
    Commit(-1)
  else begin
    if piExpandMacros in Instrs then
      Commit(-2);
    PutBack;
    lIsQuoted := False;
    sName := ProcessIdentifier(False, lIsQuoted);
    if (MacrosUpd <> nil) and (piCreateMacros in Instrs) then begin
      oMacro := MacrosUpd.FindMacro(sName);
      if oMacro = nil then begin
        oMacro := TFDMacro.Create(MacrosUpd);
        oMacro.Name := sName;
        if lIsRaw then
          oMacro.DataType := mdRaw
        else
          oMacro.DataType := mdIdentifier;
      end;
    end
    else
      oMacro := nil;
    if piExpandMacros in Instrs then begin
      if (MacrosUpd <> MacrosRead) or
         (oMacro = nil) and not (piCreateMacros in Instrs) then
        oMacro := MacrosRead.FindMacro(sName);
      if oMacro <> nil then begin
        sRes := oMacro.SQL;
        lProcessRes := False;
        for i := 1 to Length(sRes) do
          if FDInSet(sRes[i], ['!', '&', ':', '{']) then begin
            lProcessRes := True;
            Break;
          end;
        if lProcessRes then begin
          oPP := TFDPhysPreprocessor.Create;
          try
            oPP.FNested := True;
            oPP.ConnMetadata := ConnMetadata;
            oPP.Params := Params;
            oPP.MacrosUpd := MacrosUpd;
            oPP.MacrosRead := MacrosRead;
            oPP.Instrs := Instrs - [piParseSQL];
            oPP.DesignMode := DesignMode;
            oPP.Source := sRes;
            oPP.Execute;
            sRes := oPP.Destination;
          finally
            FDFree(oPP);
          end;
        end;
        WriteStr(sRes);
      end
      else
        WriteStr('');
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPreprocessor.ProcessQuoteTag;
var
  aBuff: array [0 .. 255] of Char;
  i, iPrevSrcIndex: Integer;
  sTag: String;
begin
  iPrevSrcIndex := FSrcIndex;
  i := -1;
  repeat
    Inc(i);
    if i = 256 then
      FDException(Self, [S_FD_LPhys], er_FD_AccPrepTooLongIdent, []);
    aBuff[i] := GetChar;
  until not FDInSet(aBuff[i], ['0'..'9', 'a'..'z', 'A'..'Z', '#', '_']);
  if aBuff[i] <> '$' then begin
    FSrcIndex := iPrevSrcIndex - 1;
    GetChar;
  end
  else begin
    SetString(sTag, aBuff, i);
    if (FQuoteTags.Count > 0) and (FQuoteTags[FQuoteTags.Count - 1] = sTag) then
      FQuoteTags.Delete(FQuoteTags.Count - 1)
    else
      FQuoteTags.Add(sTag);
    FInStr3 := FQuoteTags.Count > 0;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPreprocessor.ProcessEscape: TFDPhysEscapeKind;

  procedure ErrorEmptyName;
  begin
    FDException(Self, [S_FD_LPhys], er_FD_AccEscapeEmptyName, []);
  end;

var
  sKind: String;
  lTemp: Boolean;
  rEsc: TFDPhysEscapeData;
  iPrevSrcIndex, iCnt: Integer;
  ePrevInstrs: TFDPhysPreprocessorInstrs;
begin
  // check for GUID and $DEFINE
  iPrevSrcIndex := FSrcIndex;
  iCnt := 0;
  while FDInSet(GetChar, ['0' .. '9', 'a' .. 'f', 'A' .. 'F', '-', '$']) do
    Inc(iCnt);
  if iCnt > 3 then begin
    Commit(0);
    Result := eskText;
    Exit;
  end;
  FSrcIndex := iPrevSrcIndex;

  // it is rather escape sequence
  Commit(-1);
  Inc(FEscapeLevel);
  SkipWS;
  lTemp := False;
  sKind := UpperCase(ProcessIdentifier(False, lTemp));
  SkipWS;
  if sKind = 'E' then begin
    rEsc.FKind := eskFloat;
    SetLength(rEsc.FArgs, 1);
    rEsc.FArgs[0] := ProcessCommand;
  end
  else if sKind = 'D' then begin
    rEsc.FKind := eskDate;
    SetLength(rEsc.FArgs, 1);
    rEsc.FArgs[0] := ProcessCommand;
  end
  else if sKind = 'T' then begin
    rEsc.FKind := eskTime;
    SetLength(rEsc.FArgs, 1);
    rEsc.FArgs[0] := ProcessCommand;
  end
  else if sKind = 'DT' then begin
    rEsc.FKind := eskDateTime;
    SetLength(rEsc.FArgs, 1);
    rEsc.FArgs[0] := ProcessCommand;
  end
  else if sKind = 'ID' then begin
    rEsc.FKind := eskIdentifier;
    SetLength(rEsc.FArgs, 1);
    rEsc.FArgs[0] := ProcessCommand;
  end
  else if sKind = 'L' then begin
    rEsc.FKind := eskBoolean;
    SetLength(rEsc.FArgs, 1);
    rEsc.FArgs[0] := ProcessCommand;
  end
  else if sKind = 'S' then begin
    rEsc.FKind := eskString;
    SetLength(rEsc.FArgs, 1);
    PushWriter;
    repeat
      case GetChar of
      '!', '&':
        if Instrs * [piExpandMacros, piCreateMacros] <> [] then begin
          ProcessMacro(FCh);
          GetChar;
        end;
      '\':
        begin
          Commit(-1);
          GetChar;
          if FCh = '}' then
            GetChar;
        end;
      end;
    until (FCh = '}') or (FCh = #0);
    if FCh <> #0 then
      PutBack;
    rEsc.FArgs[0] := PopWriter;
  end
  else if sKind = 'ESCAPE' then begin
    rEsc.FKind := eskEscape;
    SkipWS;
    GetChar;
    if FCh <> '''' then
      Missed('''');
    SetLength(rEsc.FArgs, 2);
    rEsc.FArgs[0] := GetChar;
    GetChar;
    if FCh <> '''' then
      Missed('''');
    SkipWS;
    rEsc.FArgs[1] := ProcessCommand;
  end
  else if (sKind = 'INTO') or (sKind = 'RETURNING_VALUES') or (sKind = 'RETURNING') then begin
    if FInIntoEscape then
      Missed('}');
    rEsc.FKind := eskInto;
    SetLength(rEsc.FArgs, 1);
    FInIntoEscape := True;
    try
      rEsc.FArgs[0] := ProcessCommand;
    finally
      FInIntoEscape := False;
      FWasIntoEscape := True;
    end;
  end
  else if sKind = 'IF' then begin
    rEsc.FKind := eskIF;
    SetLength(rEsc.FArgs, 1);
    ePrevInstrs := Instrs;
    Instrs := Instrs - [piExpandParams, piCreateParams];
    try
      rEsc.FArgs[0] := ProcessCommand;
    finally
      Instrs := ePrevInstrs;
    end;
  end
  else if sKind = 'FI' then
    rEsc.FKind := eskFI
  else if sKind = 'IIF' then begin
    rEsc.FKind := eskIIF;
    GetChar;
    if FCh <> '(' then
      Missed('(');
    Inc(FBraceLevel);
    repeat
      GetChar;
      if not ((FCh = ')') or (FCh = #0)) then begin
        SetLength(rEsc.FArgs, Length(rEsc.FArgs) + 2);
        PutBack;
        rEsc.FArgs[Length(rEsc.FArgs) - 2] := ProcessCommand;
        GetChar;
        if FCh <> ')' then begin
          rEsc.FArgs[Length(rEsc.FArgs) - 1] := ProcessCommand;
          GetChar;
        end;
      end;
    until (FCh = ')') or (FCh = #0);
    if FCh = ')' then
      Dec(FBraceLevel);
    if rEsc.FArgs[Length(rEsc.FArgs) - 1] = '' then
      SetLength(rEsc.FArgs, Length(rEsc.FArgs) - 1);
    SkipWS;
  end
  else if sKind = 'STATIC' then begin
    rEsc.FKind := eskText;
    WriteStr('{static}');
  end
  else begin
    rEsc.FKind := eskFunction;
    if sKind = 'FN' then
      rEsc.FName := ProcessIdentifier(False, lTemp)
    else
      rEsc.FName := sKind;
    if rEsc.FName = '' then
      ErrorEmptyName;
    SkipWS;
    GetChar;
    if FCh <> '(' then
      Missed('(');
    Inc(FBraceLevel);
    repeat
      GetChar;
      if FCh <> ')' then begin
        PutBack;
        SetLength(rEsc.FArgs, Length(rEsc.FArgs) + 1);
        rEsc.FArgs[Length(rEsc.FArgs) - 1] := ProcessCommand;
        GetChar;
      end;
    until (FCh = ')') or (FCh = #0);
    if FCh = ')' then
      Dec(FBraceLevel);
    SkipWS;
  end;
  if GetChar <> '}' then
    Missed('}');
  Dec(FEscapeLevel);
  Result := rEsc.FKind;
  if Result = eskIF then
    if TranslateEscape(rEsc) = '' then begin
      ePrevInstrs := Instrs;
      Instrs := Instrs - [piExpandMacros, piExpandParams, piCreateParams];
      Inc(FSkipEscapes);
      try
        ProcessCommand;
      finally
        Dec(FSkipEscapes);
        Instrs := ePrevInstrs;
      end;
    end
    else
      WriteStr(ProcessCommand)
  else if FSkipEscapes = 0 then
    WriteStr(TranslateEscape(rEsc));
end;

{-------------------------------------------------------------------------------}
function TFDPhysPreprocessor.TranslateEscape(var AEscape: TFDPhysEscapeData): String;
begin
  Result := ConnMetadata.TranslateEscapeSequence(AEscape);
  if (AEscape.FKind = eskFunction) and (AEscape.FFunc = efLIMIT) then
    if Length(AEscape.FArgs) = 2 then begin
      FSQLLimitSkip := StrToInt(AEscape.FArgs[0]);
      FSQLLimitRows := StrToInt(AEscape.FArgs[1]);
    end
    else
      FSQLLimitRows := StrToInt(AEscape.FArgs[0]);
end;

{-------------------------------------------------------------------------------}
function TFDPhysPreprocessor.ProcessCommand: String;
var
  iEnterBraceLevel: Integer;
  eQuote: TFDPhysNameQuoteLevel;
  cQuote1, cQuote2: Char;
begin
  PushWriter;
  iEnterBraceLevel := FBraceLevel;
  repeat
    case GetChar of
    '}':
      if (piExpandEscapes in Instrs) and
         not FInComment1 and not FInComment2 and not FInStr1 and not FInStr2 and (FInNames = []) then
        Break;
    '(':
      if not FInComment1 and not FInComment2 and not FInStr1 and not FInStr2 and (FInNames = []) then
        Inc(FBraceLevel);
    ')':
      if not FInComment1 and not FInComment2 and not FInStr1 and not FInStr2 and (FInNames = []) then begin
        if (FEscapeLevel > 0) and (FBraceLevel = iEnterBraceLevel) then
          Break;
        Dec(FBraceLevel);
      end;
    '\':
      // mkMySQL, mkDB2, mkASA, mkPostgreSQL - support '\' as escape character
      if (FInStr1 or FInStr2 or FInStr3 or (FInNames <> [])) and
         (ConnMetadata <> nil) and (ConnMetadata.BackslashEscSupported) then
        GetChar;
    '/':
      begin
        GetChar;
        if not FInComment1 and not FInComment2 and not FInStr1 and not FInStr2 and not FInStr3 and (FInNames = []) and (FCh = '*') then
          if ConnMetadata.Kind = TFDRDBMSKinds.MySQL then begin
            GetChar;
            if FCh = '!' then
              FInMySQLConditional := True
            else begin
              PutBack;
              FInComment1 := True;
            end
          end
          else
            FInComment1 := True
        else
          PutBack;
      end;
    '*':
      begin
        GetChar;
        if not FInComment2 and not FInStr1 and not FInStr2 and not FInStr3 and (FInNames = []) and (FCh = '/') then
          if FInMySQLConditional then
            FInMySQLConditional := False
          else
            FInComment1 := False
        else
          PutBack;
      end;
    '-':
      begin
        GetChar;
        if not FInComment1 and not FInStr1 and not FInStr2 and not FInStr3 and (FInNames = []) and (FCh = '-') then
          FInComment2 := True
        else
          PutBack;
      end;
    '''':
      if not FInComment1 and not FInComment2 and (FInNames = []) and not FInStr2 and not FInStr3 and
         ((GetChar <> '''') or not FInStr1) then begin
        PutBack;
        FInStr1 := not FInStr1;
      end;
    #13, #10:
      begin
        if not FInComment1 and FInComment2 then
          FInComment2 := False;
        if piTransformEOLs in Instrs then
          case ConnMetadata.LineSeparator of
          elPosix
          {$IFDEF POSIX}, elDefault {$ENDIF}: // #10
            if FCh = #13 then begin
              Commit(-1);
              if GetChar <> #10 then begin
                PutBack;
                WriteStr(#10);
              end;
            end
            else begin
              Commit(0);
              if GetChar = #13 then
                Commit(-1)
              else
                PutBack;
            end;
          elWindows
          {$IFDEF MSWINDOWS}, elDefault {$ENDIF}: // #13#10
            if FCh = #10 then begin
              Commit(-1);
              if GetChar <> #13 then
                PutBack
              else
                Commit(-1);
              WriteStr(#13#10);
            end
            else begin
              Commit(0);
              if GetChar = #10 then
                Commit(0)
              else begin
                PutBack;
                WriteStr(#10);
              end;
            end;
          end;
      end;
    ':':
      if not FInComment1 and not FInComment2 and not FInStr1 and not FInStr2 and not FInStr3 and (FInNames = []) and
         not FInProgramBlock and (Instrs * [piExpandParams, piCreateParams] <> []) then
        ProcessParam;
    '?':
      if not FInComment1 and not FInComment2 and not FInStr1 and not FInStr2 and not FInStr3 and (FInNames = []) and
         (piTransformQuestions in Instrs) and (Instrs * [piExpandParams, piCreateParams] <> []) then
        ProcessQuestion;
    '{':
      if not FInComment1 and not FInComment2 and not FInStr1 and not FInStr2 and (FInNames = []) and
         (piExpandEscapes in Instrs) then
        if ProcessEscape = eskFI then begin
          if FCh = '}' then
            GetChar;
          Break;
        end;
    ',':
      if not FInComment1 and not FInComment2 and not FInStr1 and not FInStr2 and (FInNames = []) then
        if (iEnterBraceLevel > 0) and (iEnterBraceLevel = FBraceLevel) then
          Break;
    '!', '&':
      if Instrs * [piExpandMacros, piCreateMacros] <> [] then
        ProcessMacro(FCh);
    '$':
      if (ConnMetadata <> nil) and (ConnMetadata.Kind = TFDRDBMSKinds.PostgreSQL) then
        ProcessQuoteTag;
    'a'..'z', 'A'..'Z':
      if (ConnMetadata <> nil) and (ConnMetadata.Kind in [TFDRDBMSKinds.Interbase, TFDRDBMSKinds.Firebird]) and
         not FInComment1 and not FInComment2 and not FInStr1 and not FInStr2 and not FInStr3 and (FInNames = []) and
         not FInProgramBlock then begin
        FInProgramBlock := FDInSet(FCh, ['B', 'b']) and FDInSet(GetChar, ['E', 'e']) and
          FDInSet(GetChar, ['G', 'g']) and FDInSet(GetChar, ['I', 'i']) and FDInSet(GetChar, ['N', 'n']) and
          not FDInSet(GetChar, ['0'..'9', 'a'..'z', 'A'..'Z', '#', '$', '_']);
        while FDInSet(FCh, ['0'..'9', 'a'..'z', 'A'..'Z', '#', '$', '_']) do
          GetChar;
        PutBack;
      end;
    ';':
      if not FInComment1 and not FInComment2 and not FInStr1 and not FInStr2 and not FInStr3 and (FInNames = []) and
         not FInProgramBlock and not FInMySQLConditional and (FBraceLevel = 0) then
        FParamCount := 0;
    else
      if (FCh = '"') and not (Byte('"') in FNameDelims1) then begin
        if not FInComment1 and not FInComment2 and (FInNames = []) and not FInStr1 and not FInStr3 and
           ((GetChar <> '"') or not FInStr2) then begin
          PutBack;
          FInStr2 := not FInStr2;
        end;
      end
      else if ((Byte(FCh) in FNameDelims1) or (Byte(FCh) in FNameDelims2)) and
              not FInComment1 and not FInComment2 and not FInStr1 and not FInStr2 and not FInStr3 then
        for eQuote := Low(TFDPhysNameQuoteLevel) to High(TFDPhysNameQuoteLevel) do begin
          cQuote1 := ConnMetadata.NameQuoteChar[eQuote, nsLeft];
          cQuote2 := ConnMetadata.NameQuoteChar[eQuote, nsRight];
          if FCh = cQuote1 then begin
            if cQuote1 = cQuote2 then
              if eQuote in FInNames then
                Exclude(FInNames, eQuote)
              else
                Include(FInNames, eQuote)
            else
              Include(FInNames, eQuote);
            Break;
          end
          else if FCh = cQuote2 then begin
            if cQuote1 = cQuote2 then
              if eQuote in FInNames then
                Exclude(FInNames, eQuote)
              else
                Include(FInNames, eQuote)
            else
              Exclude(FInNames, eQuote);
            Break;
          end;
        end;
    end;
  until (FCh = #0);
  if FCh <> #0 then
    PutBack;
  Result := PopWriter;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPreprocessor.ParseDestination;
var
  iPos, iLen: Integer;
  lFirstWord: Boolean;
  iFromStartedPos, iFromEndedPos, iCmdStartedPos: Integer;
  ch, cQuote1, cQuote2: Char;
  eQuote: TFDPhysNameQuoteLevel;
  oPP: TFDPhysPreprocessor;

  function CheckKeyword(const AKwd: String): Boolean;
  var
    c1: Char;
  begin
    c1 := AKwd[1];
    Result := FDInSet(ch, [c1, Char(Word(c1) or $0020)]) and
      (CompareText(Copy(FDestination, iPos, Length(AKwd)), AKwd) = 0) and
      (iPos + Length(AKwd) <= Length(FDestination)) and
      not FDInSet(FDestination[iPos + Length(AKwd)], ['a' .. 'z', 'A' .. 'Z', '0' .. '9', '#', '$', '_'])
  end;

  procedure SkipKeyword(ALen: Integer);
  begin
    Inc(iPos, ALen);
    while (iPos <= Length(FDestination)) and
          FDInSet(FDestination[iPos], [' ', #13, #10, #9]) do
      Inc(iPos);
  end;

  function ProcessQuotedDelim(ADelim1, ADelim2: Char): Boolean;
  begin
    Result := False;
    if not FDInSet(ADelim1, [#0, ' ']) then
      while FDestination[iPos] = ADelim1 do begin
        Result := True;
        repeat
          Inc(iPos);
        until (iPos > Length(FDestination)) or
              FDInSet(FDestination[iPos], [ADelim2, #0]);
        if (iPos <= Length(FDestination)) and
           (FDestination[iPos] = ADelim2) then begin
          Inc(iPos);
          if (iPos <= Length(FDestination)) and (FDestination[iPos] = '.') then
            Inc(iPos)
          else
            Break;
        end
        else
          Break;
      end;
  end;

begin
  iPos := 1;
  iLen := Length(FDestination);
  lFirstWord := True;
  iFromStartedPos := 0;
  iFromEndedPos := 0;
  FBraceLevel := 0;
  FInComment1 := False;
  FInMySQLConditional := False;
  FInComment2 := False;
  FInStr1 := False;
  FInStr2 := False;
  FInNames := [];
  FBraceLevel := 0;
  while iPos <= iLen do begin
    ch := FDestination[iPos];
    case ch of
    '(':
        if not FInComment1 and not FInComment2 and not FInStr1 and not FInStr2 and (FInNames = []) then begin
          Inc(FBraceLevel);
          if (FBraceLevel = 1) and (iFromStartedPos <> 0) and (FDestination[iFromStartedPos] <> '(') and
             (iFromEndedPos = 0) then
            iFromEndedPos := iPos - 1;
        end;
    ')':
      if not FInComment1 and not FInComment2 and not FInStr1 and not FInStr2 and (FInNames = []) then begin
        Dec(FBraceLevel);
        if (FBraceLevel = 0) and (iFromStartedPos <> 0) and (FDestination[iFromStartedPos] = '(') and
           (iFromEndedPos = 0) then
          iFromEndedPos := iPos;
        if (FBraceLevel = 0) and (FSQLValuesPos <> 0) and (FSQLValuesPosEnd = 0) then
          FSQLValuesPosEnd := iPos;
      end;
    '/':
      begin
        Inc(iPos);
        if not FInComment1 and not FInComment2 and not FInStr1 and not FInStr2 and (FInNames = []) and (FDestination[iPos] = '*') then begin
          if (FBraceLevel = 0) and (iFromStartedPos <> 0) and (iFromEndedPos = 0) then
            iFromEndedPos := iPos - 2;
          if ConnMetadata.Kind = TFDRDBMSKinds.MySQL then begin
            Inc(iPos);
            if FDestination[iPos] = '!' then
              FInMySQLConditional := True
            else begin
              Dec(iPos);
              FInComment1 := True;
            end
          end
          else
            FInComment1 := True;
        end
        else
          Dec(iPos);
      end;
    '*':
      begin
        Inc(iPos);
        if not FInComment2 and not FInStr1 and not FInStr2 and (FInNames = []) and (FDestination[iPos] = '/') then
          if FInMySQLConditional then
            FInMySQLConditional := False
          else
            FInComment1 := False
        else
          Dec(iPos);
      end;
    '-':
      begin
        Inc(iPos);
        if not FInComment1 and not FInStr1 and not FInStr2 and (FInNames = []) and (FDestination[iPos] = '-') then begin
          if (FBraceLevel = 0) and (iFromStartedPos <> 0) and (iFromEndedPos = 0) then
            iFromEndedPos := iPos - 2;
          FInComment2 := True;
        end
        else
          Dec(iPos);
      end;
    '''':
      if not FInComment1 and not FInComment2 and (FInNames = []) and not FInStr2 then
        FInStr1 := not FInStr1;
    #13, #10, ' ', #9, ',', ';':
      begin
        if FDInSet(ch, [#13, #10]) then
          if not FInComment1 and FInComment2 then
            FInComment2 := False;
        if not FInComment1 and not FInComment2 and not FInStr1 and not FInStr2 and (FInNames = []) and
           (iFromStartedPos <> 0) and (iFromEndedPos = 0) and (FBraceLevel = 0) then
          iFromEndedPos := iPos - 1;
      end;
    'A' .. 'Z', 'a' .. 'z':
      if not FInComment1 and not FInComment2 and not FInStr1 and not FInStr2 and (FInNames = []) and
         (FBraceLevel = 0) and ((iPos = 1) or (FDestination[iPos - 1] <= ' ')) then begin
        if lFirstWord then begin
          iCmdStartedPos := iPos;
          repeat
            Inc(iPos);
          until (iPos > Length(FDestination)) or
                not FDInSet(FDestination[iPos], ['A' .. 'Z', 'a' .. 'z', '0' .. '9', '_']);
          FTokens.Add(UpperCase(Copy(FDestination, iCmdStartedPos, iPos - iCmdStartedPos)));
          FSQLCommandKind := ConnMetadata.GetSQLCommandKind(FTokens);
          Dec(iPos);
        end
        else if FSQLCommandKind in [skSelect, skSelectForLock, skSelectForUnLock] then begin
          if CheckKeyword('INTO') then begin
            // Special handling of SELECT INTO, which is more INSERT, than SELECT.
            // Because does not return a resultset and inserts the new records
            // (modifies DB).
            FTokens.Add('INTO');
            FSQLCommandKind := ConnMetadata.GetSQLCommandKind(FTokens);
          end
          else if (FSQLFromValue = '') and (
                    (iFromStartedPos = 0) and CheckKeyword('FROM') or
                    (iFromStartedPos <> 0) and (ConnMetadata <> nil) and
                      (ConnMetadata.Kind = TFDRDBMSKinds.PostgreSQL) and CheckKeyword('ONLY')) then begin
            SkipKeyword(4);
            if (ConnMetadata <> nil) and (iPos <= Length(FDestination)) then begin
              iFromStartedPos := iPos;
              for eQuote := Low(TFDPhysNameQuoteLevel) to High(TFDPhysNameQuoteLevel) do
                if ProcessQuotedDelim(ConnMetadata.NameQuoteChar[eQuote, nsLeft],
                                      ConnMetadata.NameQuoteChar[eQuote, nsRight]) then
                  Break;
            end;
            Dec(iPos);
          end
          else if (FSQLOrderByPos = 0) and CheckKeyword('ORDER BY') then begin
            FSQLOrderByPos := iPos;
            Inc(iPos, 7);
          end;
        end
        else if (FSQLCommandKind in [skDelete, skInsert, skMerge, skUpdate]) and
                CheckKeyword('RETURNING') then begin
          // Special handling of INSERT RETURNING without {INTO}, which is more
          // SELECT FOR UPDATE, than INSERT. Because returns a resultset and
          // inserts the new records (modifies DB).
          FTokens.Add('RETURNING');
          if FWasIntoEscape then
            FTokens.Add('INTO');
          FSQLCommandKind := ConnMetadata.GetSQLCommandKind(FTokens);
        end
        else if (FSQLValuesPos = 0) and CheckKeyword('VALUES') then begin
          FSQLValuesPos := iPos;
          Inc(iPos, 5);
        end;
        if FSQLCommandKind <> skNotResolved then
          lFirstWord := False;
      end;
    else
      if (ch = '"') and not (Byte('"') in FNameDelims1) then begin
        if not FInComment1 and not FInComment2 and (FInNames = []) and not FInStr1 then
          FInStr2 := not FInStr2;
      end
      else if (Byte(ch) in FNameDelims1) or (Byte(ch) in FNameDelims2) then begin
        for eQuote := Low(TFDPhysNameQuoteLevel) to High(TFDPhysNameQuoteLevel) do begin
          cQuote1 := ConnMetadata.NameQuoteChar[eQuote, nsLeft];
          cQuote2 := ConnMetadata.NameQuoteChar[eQuote, nsRight];
          if ch = cQuote1 then begin
            if cQuote1 = cQuote2 then
              if eQuote in FInNames then
                Exclude(FInNames, eQuote)
              else
                Include(FInNames, eQuote)
            else
              Include(FInNames, eQuote);
            Break;
          end
          else if ch = cQuote2 then begin
            if cQuote1 = cQuote2 then
              if eQuote in FInNames then
                Exclude(FInNames, eQuote)
              else
                Include(FInNames, eQuote)
            else
              Exclude(FInNames, eQuote);
            Break;
          end;
        end;
      end
    end;
    Inc(iPos);
  end;
  if (FSQLCommandKind = skNotResolved) and (FTokens.Count > 0) and
     (FTokens[FTokens.Count - 1] <> '') then begin
    FTokens.Add('');
    FSQLCommandKind := ConnMetadata.GetSQLCommandKind(FTokens);
  end;
  if iFromStartedPos <> 0 then begin
    if iFromEndedPos = 0 then
      iFromEndedPos := iPos - 1;
    FSQLFromValue := Copy(FDestination, iFromStartedPos, iFromEndedPos - iFromStartedPos + 1);
    if (Length(FSQLFromValue) > 0) and
       (FSQLFromValue[1] = '(') and (FSQLFromValue[Length(FSQLFromValue)] = ')') then begin
      oPP := TFDPhysPreprocessor.Create;
      try
        oPP.FNested := True;
        oPP.ConnMetadata := ConnMetadata;
        oPP.Instrs := [piParseSQL];
        oPP.DesignMode := DesignMode;
        oPP.Source := Copy(FSQLFromValue, 2, Length(FSQLFromValue) - 2);
        oPP.Execute;
        FSQLFromValue := oPP.SQLFromValue;
      finally
        FDFree(oPP);
      end;
    end;
  end;
end;

end.
