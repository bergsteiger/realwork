{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{      FireDAC SQL script engine standard commands      }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$HPPEMIT LINKUNIT}

unit FireDAC.Comp.ScriptCommands;

interface

{-------------------------------------------------------------------------------}
implementation

uses
  System.SysUtils, System.Classes, Data.DB, Data.FmtBCD, System.Variants,
  FireDAC.Stan.Intf, FireDAC.Stan.Param, FireDAC.Stan.Consts, FireDAC.Stan.Util,
    FireDAC.Stan.Error, FireDAC.Stan.Option, FireDAC.Stan.Async,
  FireDAC.DatS,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Comp.Client, FireDAC.Comp.Script, FireDAC.Comp.BatchMove,
    FireDAC.Comp.BatchMove.Text, FireDAC.Comp.BatchMove.SQL;

type
  TFDSQLScriptCommand = class;
  TFDPLSQLScriptCommand = class;
  TFDRunScriptCommand = class;
  TFDAcceptScriptCommand = class;
  TFDConnectScriptCommand = class;
  TFDDefineScriptCommand = class;
  TFDDisconnectScriptCommand = class;
  TFDExecuteScriptCommand = class;
  TFDExitScriptCommand = class;
  TFDHostScriptCommand = class;
  TFDShowTextScriptCommand = class;
  TFDPauseScriptCommand = class;
  TFDPromptScriptCommand = class;
  TFDPrintScriptCommand = class;
  TFDSetScriptCommand = class;
  TFDSpoolScriptCommand = class;
  TFDUndefineScriptCommand = class;
  TFDVariableScriptCommand = class;
  TFDHelpScriptCommand = class;
  TFDRemarkScriptCommand = class;
  TFDCopyScriptCommand = class;
  TFDDelimiterScriptCommand = class;
  TFDIBCreateDBScriptCommand = class;
  TFDIBDropDBScriptCommand = class;

  TFDSQLScriptCommand = class(TFDScriptCommand)
  private
    FSQL: String;
    FIsPLSQL: Boolean;
    procedure DumpParams;
    procedure DumpTableHeader(ATable: TFDDatSTable; var ALinesPrinted: Integer);
    function DumpValue(const AValue: Variant; AColumn: TFDDatSColumn): String;
    procedure DumpTableRows(ATable: TFDDatSTable; var ALinesPrinted: Integer);
    procedure DumpServerOutput;
    function PadVal(AColumn: TFDDatSColumn; const AVal: String; APadChar: Char = ' '): String;
    procedure DumpMacros;
    function DumpVarBytes(const AVal: Variant): String;
    procedure LoadBlobFileParams(AParams: TFDParams);
  public
{$IFDEF FireDAC_MONITOR}
    function Dump: String; override;
{$ENDIF}
    function Parse(const AKwd: String): Boolean; override;
    procedure Execute(); override;
    property SQL: String read FSQL;
  end;

  TFDPLSQLScriptCommand = class(TFDSQLScriptCommand)
  public
    constructor Create(AParser: TFDScriptParser; AEngine: TFDScript); override;
{$IFDEF FireDAC_MONITOR}
    function Dump: String; override;
{$ENDIF}
  end;

  TFDRunScriptCommand = class(TFDScriptCommand)
  private
    FFileName: String;
    FArguments: TStrings;
    FUseParentPath: Boolean;
    procedure InternalExecute(ARealExecute: Boolean);
  public
    constructor Create(AParser: TFDScriptParser; AEngine: TFDScript); override;
    destructor Destroy; override;
{$IFDEF FireDAC_MONITOR}
    function Dump(): String; override;
{$ENDIF}
    class function Help(): String; override;
    class procedure Keywords(AKwds: TStrings); override;
    function Parse(const AKwd: String): Boolean; override;
    procedure Execute(); override;
    procedure Validate(); override;
    property FileName: String read FFileName;
    property Arguments: TStrings read FArguments;
    property UseParentPath: Boolean read FUseParentPath;
  end;

  TFDAcceptScriptCommand = class(TFDScriptCommand)
  private
    FVariable: String;
    FDataType: TFieldType;
    FFmt: String;
    FDef: String;
    FPrompt: String;
    FHide: Boolean;
  public
{$IFDEF FireDAC_MONITOR}
    function Dump(): String; override;
{$ENDIF}
    class function Help(): String; override;
    class procedure Keywords(AKwds: TStrings); override;
    function Parse(const AKwd: String): Boolean; override;
    procedure Execute(); override;
    property Variable: String read FVariable;
    property DataType: TFieldType read FDataType;
    property Fmt: String read FFmt;
    property Def: String read FDef;
    property Prompt: String read FPrompt;
    property Hide: Boolean read FHide;
  end;

  TFDConnectScriptCommand = class(TFDScriptCommand)
  private
    FConnectString: String;
  public
{$IFDEF FireDAC_MONITOR}
    function Dump(): String; override;
{$ENDIF}
    class function Help(): String; override;
    class procedure Keywords(AKwds: TStrings); override;
    function Parse(const AKwd: String): Boolean; override;
    procedure Execute(); override;
    property ConnectString: String read FConnectString;
  end;

  TFDDefineScriptCommand = class(TFDScriptCommand)
  private
    FMode: Integer;
    FName: String;
    FSValue: String;
  public
{$IFDEF FireDAC_MONITOR}
    function Dump(): String; override;
{$ENDIF}
    class function Help(): String; override;
    class procedure Keywords(AKwds: TStrings); override;
    function Parse(const AKwd: String): Boolean; override;
    procedure Execute(); override;
    // -1 - show defs, 0 - show def, 1 - set def
    property Mode: Integer read FMode;
    property Name: String read FName;
    property Value: String read FSValue;
  end;

  TFDDisconnectScriptCommand = class(TFDScriptCommand)
  public
{$IFDEF FireDAC_MONITOR}
    function Dump(): String; override;
{$ENDIF}
    class function Help(): String; override;
    class procedure Keywords(AKwds: TStrings); override;
    procedure Execute(); override;
  end;

  TFDExecuteScriptCommand = class(TFDSQLScriptCommand)
  private
    FBlock: String;
  public
{$IFDEF FireDAC_MONITOR}
    function Dump(): String; override;
{$ENDIF}
    class function Help(): String; override;
    class procedure Keywords(AKwds: TStrings); override;
    function Parse(const AKwd: String): Boolean; override;
    procedure Execute(); override;
    property Block: String read FBlock;
  end;

  TFDExitScriptCommandAction = (eaNone, eaCommit, eaRollback);
  TFDExitScriptCommand = class(TFDScriptCommand)
  private
    FAction: TFDExitScriptCommandAction;
  public
{$IFDEF FireDAC_MONITOR}
    function Dump(): String; override;
{$ENDIF}
    class function Help(): String; override;
    class procedure Keywords(AKwds: TStrings); override;
    function Parse(const AKwd: String): Boolean; override;
    procedure Execute(); override;
    procedure Validate(); override;
    property Action: TFDExitScriptCommandAction read FAction;
  end;

  TFDHostScriptCommand = class(TFDScriptCommand)
  private
    FCommand: String;
  public
{$IFDEF FireDAC_MONITOR}
    function Dump(): String; override;
{$ENDIF}
    class function Help(): String; override;
    class procedure Keywords(AKwds: TStrings); override;
    function Parse(const AKwd: String): Boolean; override;
    procedure Execute(); override;
    property Command: String read FCommand;
  end;

  TFDShowTextScriptCommand = class(TFDScriptCommand)
  private
    FText: String;
  public
    property Text: String read FText;
  end;

  TFDPauseScriptCommand = class(TFDShowTextScriptCommand)
  public
{$IFDEF FireDAC_MONITOR}
    function Dump(): String; override;
{$ENDIF}
    class function Help(): String; override;
    class procedure Keywords(AKwds: TStrings); override;
    function Parse(const AKwd: String): Boolean; override;
    procedure Execute(); override;
  end;

  TFDPromptScriptCommand = class(TFDShowTextScriptCommand)
  public
{$IFDEF FireDAC_MONITOR}
    function Dump(): String; override;
{$ENDIF}
    class function Help(): String; override;
    class procedure Keywords(AKwds: TStrings); override;
    function Parse(const AKwd: String): Boolean; override;
    procedure Execute(); override;
  end;

  TFDPrintScriptCommand = class(TFDScriptCommand)
  private
    FVars: TStrings;
  public
    constructor Create(AParser: TFDScriptParser; AEngine: TFDScript); override;
    destructor Destroy; override;
{$IFDEF FireDAC_MONITOR}
    function Dump(): String; override;
{$ENDIF}
    class function Help(): String; override;
    class procedure Keywords(AKwds: TStrings); override;
    function Parse(const AKwd: String): Boolean; override;
    procedure Execute(); override;
    property Vars: TStrings read FVars;
  end;

  TFDSetScriptCommandKind = (skNone, skArraySize, skAutoCommit, skAutoPrint,
    skBlobFile, skCharacterSet, skClientLib, skCmdSep, skDropNonexistObj,
    skDefine, skEcho, skEncoding, skFeedback, skHeading, skLineSize, skLong,
    skParamArraySize, skPageSize, skScan, skServerOutput, skSQLDialect,
    skTermout, skTiming, skBreakOnError, skIgnoreError, skTrimConsole,
    skTrimSpool, skVerify);

  TFDSetScriptCommandItem = class(TObject)
  private
    FSetKind: TFDSetScriptCommandKind;
    FIValue: Integer;
    FSValue: String;
    FEchoCommands: TFDScriptEchoCommands;
  end;
  TFDSetScriptCommandItems = array of TFDSetScriptCommandItem;

  TFDSetScriptCommand = class(TFDScriptCommand)
  private
    FItems: TFDSetScriptCommandItems;
  public
    constructor Create(AParser: TFDScriptParser; AEngine: TFDScript); override;
    destructor Destroy; override;
    function AddItem(ASetKind: TFDSetScriptCommandKind; AIValue: Integer = 0;
      ASValue: String = ''; AEchoCommands: TFDScriptEchoCommands = ecNone): TFDSetScriptCommandItem;
{$IFDEF FireDAC_MONITOR}
    function Dump(): String; override;
{$ENDIF}
    class function Help(): String; override;
    class procedure Keywords(AKwds: TStrings); override;
    function Parse(const AKwd: String): Boolean; override;
    procedure Execute(); override;
    procedure Validate(); override;
    property Items: TFDSetScriptCommandItems read FItems;
  end;

  TFDSpoolScriptCommand = class(TFDScriptCommand)
  private
    FMode: Integer;
    FFileName: String;
    FAppend: Boolean;
  public
{$IFDEF FireDAC_MONITOR}
    function Dump(): String; override;
{$ENDIF}
    class function Help(): String; override;
    class procedure Keywords(AKwds: TStrings); override;
    function Parse(const AKwd: String): Boolean; override;
    procedure Execute(); override;
    // -1 - off, 0 - show, 1 - file
    property Mode: Integer read FMode;
    property Append: Boolean read FAppend;
    property FileName: String read FFileName;
  end;

  TFDUndefineScriptCommand = class(TFDScriptCommand)
  private
    FVars: TStrings;
  public
    constructor Create(AParser: TFDScriptParser; AEngine: TFDScript); override;
    destructor Destroy; override;
{$IFDEF FireDAC_MONITOR}
    function Dump(): String; override;
{$ENDIF}
    class function Help(): String; override;
    class procedure Keywords(AKwds: TStrings); override;
    function Parse(const AKwd: String): Boolean; override;
    procedure Execute(); override;
    property Vars: TStrings read FVars;
  end;

  TFDVariableScriptCommand = class(TFDScriptCommand)
  private
    FMode: Integer;
    FVariable: String;
    FDataType: TFieldType;
    FSize: Integer;
    FTableSize: Integer;
    FParamType: TParamType;
    FValue: String;
  public
{$IFDEF FireDAC_MONITOR}
    function Dump(): String; override;
{$ENDIF}
    class function Help(): String; override;
    class procedure Keywords(AKwds: TStrings); override;
    function Parse(const AKwd: String): Boolean; override;
    procedure Execute(); override;
    // -1 - show vars, 0 - show var, 1 - def var
    property Mode: Integer read FMode;
    property Variable: String read FVariable;
    property DataType: TFieldType read FDataType;
    property Size: Integer read FSize;
    property TableSize: Integer read FTableSize;
    property ParamType: TParamType read FParamType;
    property Value: String read FValue;
  end;

  TFDHelpScriptCommand = class(TFDScriptCommand)
  public
{$IFDEF FireDAC_MONITOR}
    function Dump(): String; override;
{$ENDIF}
    class function Help(): String; override;
    class procedure Keywords(AKwds: TStrings); override;
    procedure Execute(); override;
  end;

  TFDRemarkScriptCommand = class(TFDScriptCommand)
  private
    FText: String;
  public
{$IFDEF FireDAC_MONITOR}
    function Dump(): String; override;
{$ENDIF}
    class function Help(): String; override;
    class procedure Keywords(AKwds: TStrings); override;
    function Parse(const AKwd: String): Boolean; override;
    property Text: String read FText;
  end;

  TFDCopyScriptCommand = class(TFDScriptCommand)
  private
    FBatchMove: TFDBatchMove;
    FSrcConnection: TFDConnection;
    FDestConnection: TFDConnection;
    FSrcConnStr: String;
    FDestConnStr: String;
    FConfigFile: String;
    FConfigParams: String;
    FLogToSpool: Boolean;
    procedure DumpServerOutput;
  public
    constructor Create(AParser: TFDScriptParser; AEngine: TFDScript); override;
    destructor Destroy; override;
{$IFDEF FireDAC_MONITOR}
    function Dump(): String; override;
{$ENDIF}
    class function Help(): String; override;
    class procedure Keywords(AKwds: TStrings); override;
    function Parse(const AKwd: String): Boolean; override;
    procedure Execute(); override;
    procedure AbortJob(const AWait: Boolean); override;
  end;

  TFDDelimiterScriptCommand = class(TFDScriptCommand)
  private
    FCmdSep: String;
  public
{$IFDEF FireDAC_MONITOR}
    function Dump(): String; override;
{$ENDIF}
    class function Help(): String; override;
    class procedure Keywords(AKwds: TStrings); override;
    function Parse(const AKwd: String): Boolean; override;
    procedure Execute(); override;
    procedure Validate(); override;
    property CmdSep: String read FCmdSep;
  end;

  TFDIBCreateDBScriptCommand = class(TFDScriptCommand)
  private
    FDB, FUser, FPwd, FPageSize, FCharset: String;
  public
{$IFDEF FireDAC_MONITOR}
    function Dump: String; override;
{$ENDIF}
    class procedure Keywords(AKwds: TStrings); override;
    function Parse(const AKwd: String): Boolean; override;
    procedure Execute(); override;
    property DB: String read FDB;
    property User: String read FUser;
    property Pwd: String read FPwd;
    property PageSize: String read FPageSize;
    property Charset: String read FCharset;
  end;

  TFDIBDropDBScriptCommand = class(TFDScriptCommand)
  public
{$IFDEF FireDAC_MONITOR}
    function Dump: String; override;
{$ENDIF}
    class procedure Keywords(AKwds: TStrings); override;
    function Parse(const AKwd: String): Boolean; override;
    procedure Execute(); override;
  end;

{-------------------------------------------------------------------------------}
{ TFDSQLScriptCommand                                                           }
{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TFDSQLScriptCommand.Dump: String;
begin
  Result := '<SQL> [' + FSQL + ']';
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
function TFDSQLScriptCommand.Parse(const AKwd: String): Boolean;
begin
  FSQL := AKwd;
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDSQLScriptCommand.DumpVarBytes(const AVal: Variant): String;
var
  iLen, i, iText: Integer;
  b: Byte;
  sChar: String;
begin
  if not VarIsArray(AVal) then begin
    Result := VarToStr(AVal);
    Exit;
  end;
  iText := 1;
  iLen := VarArrayHighBound(AVal, 1);
  i := 0;
  SetLength(Result, (iLen + 1) * 4);
  while i <= iLen do begin
    b := AVal[i];
    if (b < Ord(' ')) and not ((b = 13) or (b = 10) or (b = 9)) then begin
      sChar := '#' + IntToStr(b);
      Move(sChar[1], Result[iText], Length(sChar) * SizeOf(Char));
      Inc(iText, Length(sChar));
    end
    else begin
      Result[iText] := Char(b);
      Inc(iText);
    end;
    Inc(i);
  end;
  SetLength(Result, iText - 1);
end;

{-------------------------------------------------------------------------------}
function TFDSQLScriptCommand.PadVal(AColumn: TFDDatSColumn; const AVal: String;
  APadChar: Char): String;
var
  iDispWidth: Integer;
begin
  if AColumn.DataType in [dtAnsiString, dtWideString, dtByteString,
                          dtBlob, dtMemo, dtWideMemo, dtXML,
                          dtHBlob, dtHMemo, dtWideHMemo,
                          dtHBFile] then
    iDispWidth := Engine.ScriptOptions.MaxStringWidth
  else
    iDispWidth := AColumn.DisplayWidth;
  if iDispWidth < Length(AColumn.Caption) then
    iDispWidth := Length(AColumn.Caption);
  if Length(AVal) > iDispWidth then
    Result := Copy(AVal, 1, iDispWidth - 4) + ' ...'
  else
    Result := AVal;
  if AColumn.DataType in [dtAnsiString, dtWideString, dtByteString,
                          dtBlob, dtMemo, dtWideMemo, dtXML,
                          dtHBlob, dtHMemo, dtWideHMemo,
                          dtHBFile] then
    Result := Result + StringOfChar(APadChar, iDispWidth - Length(Result))
  else
    Result := StringOfChar(APadChar, iDispWidth - Length(Result)) + Result;
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLScriptCommand.DumpParams;
var
  oCol: TFDDatSColumn;
  i: Integer;
  oPar: TFDParam;
  eDataType: TFDDataType;
  iSize: LongWord;
  iPrec: Integer;
  iScale: Integer;
  eAttrs: TFDDataAttributes;
begin
  oCol := TFDDatSColumn.Create;
  try
    for i := 0 to EngineIntf.CommandIntf.Params.Count - 1 do begin
      oPar := EngineIntf.CommandIntf.Params[i];
      EngineIntf.CommandIntf.Options.FormatOptions.FieldDef2ColumnDef(
        oPar.DataType, oPar.Size, oPar.Precision, oPar.NumericScale,
        eDataType, iSize, iPrec, iScale, eAttrs);
      oCol.Caption := oPar.Name;
      oCol.DataType := eDataType;
      oCol.Size := iSize;
      oCol.Precision := iPrec;
      oCol.Scale := iScale;
      oCol.Attributes := eAttrs;
      EngineIntf.ConPut(oPar.DisplayName + ':' + DumpValue(oPar.Value, oCol), soParam);
    end;
  finally
    FDFree(oCol);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLScriptCommand.DumpTableHeader(ATable: TFDDatSTable; var ALinesPrinted: Integer);
var
  c: Integer;
  s: String;
begin
                                  
  s := '';
  for c := 0 to ATable.Columns.Count - 1 do begin
    if c > 0 then
      s := s + '  ';
    s := s + PadVal(ATable.Columns[c], ATable.Columns[c].Name);
  end;
  EngineIntf.ConPut(s, soData);
  Inc(ALinesPrinted);
  s := '';
  for c := 0 to ATable.Columns.Count - 1 do begin
    if c > 0 then
      s := s + '  ';
    s := s + PadVal(ATable.Columns[c], '', '-');
  end;
  EngineIntf.ConPut(s, soData);
  Inc(ALinesPrinted);
end;

{-------------------------------------------------------------------------------}
function TFDSQLScriptCommand.DumpValue(const AValue: Variant; AColumn: TFDDatSColumn): String;
var
  dt: TDateTime;
begin
  if AColumn.DataType in [dtByteString, dtBlob, dtHBlob, dtHBFile] then
    Result := PadVal(AColumn, DumpVarBytes(AValue))
  else if AColumn.DataType <> dtTime then
    Result := PadVal(AColumn, VarToStr(AValue))
  else begin
    dt := VarAsType(AValue, varDate);
    // Delphi does not support negative time value
    if dt < 0 then
      Result := PadVal(AColumn, '-' + TimeToStr(dt))
    else
      Result := PadVal(AColumn, TimeToStr(dt));
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLScriptCommand.DumpTableRows(ATable: TFDDatSTable; var ALinesPrinted: Integer);
var
  i: Integer;
  c: Integer;
  s: String;
  oCol: TFDDatSColumn;
  oRow: TFDDatSRow;
begin
                                  
  for i := 0 to ATable.Rows.Count - 1 do begin
    if (ALinesPrinted = 0) and
       Engine.ScriptOptions.ColumnHeadings and (Engine.ScriptOptions.PageSize > 0) then
      DumpTableHeader(ATable, ALinesPrinted);
    s := '';
    for c := 0 to ATable.Columns.Count - 1 do begin
      oCol := ATable.Columns[c];
      oRow := ATable.Rows[i];
      if c > 0 then
        s := s + '  ';
      s := s + DumpValue(oRow.GetData(c), oCol);
    end;
    EngineIntf.ConPut(s, soData);
    Inc(ALinesPrinted);
    if ALinesPrinted >= Engine.ScriptOptions.PageSize - 1 then begin
      EngineIntf.ConPut('', soSeparator);
      ALinesPrinted := 0;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLScriptCommand.DumpServerOutput;
var
  i: Integer;
begin
  if not (EngineIntf.ConnectionIntf.Options.ResourceOptions as TFDTopResourceOptions).ServerOutput or
     (EngineIntf.ConnectionIntf.Messages = nil) or (EngineIntf.ConnectionIntf.Messages.ErrorCount = 0) then
    Exit;
  for i := 0 to EngineIntf.ConnectionIntf.Messages.ErrorCount - 1 do
    EngineIntf.ConPut(EngineIntf.ConnectionIntf.Messages[i].Message, soServerOutput);
  EngineIntf.ConPut('', soSeparator);
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLScriptCommand.DumpMacros;
var
  oSrc, oDest: TFDStringList;
  i: Integer;
begin
  oSrc := TFDStringList.Create;
  oDest := TFDStringList.Create;
  try
    oSrc.Text := AdjustLineBreaks(FSQL, tlbsCRLF);
    oDest.Text := AdjustLineBreaks(EngineIntf.CommandIntf.SQLText, tlbsCRLF);
    for i := 0 to oSrc.Count - 1 do
      if oSrc[i] <> oDest[i] then begin
        EngineIntf.ConPut(Format('old %d:%s', [i + 1, oSrc[i]]), soMacro);
        EngineIntf.ConPut(Format('new %d:%s', [i + 1, oDest[i]]), soMacro);
      end;
  finally
    FDFree(oSrc);
    FDFree(oDest);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLScriptCommand.LoadBlobFileParams(AParams: TFDParams);
var
  i: Integer;
  s: String;
  oStr: TStream;
  iPos, iLen: LongWord;
  oText: TFDTextFile;
begin
  for i := 0 to AParams.Count - 1 do begin
    s := AParams[i].Name;
    if (Length(s) = 18) and FDInSet(s[1], ['h', 'H']) and (s[10] = '_') then begin
      iPos := StrToInt('$' + Copy(s, 2, 8));
      iLen := StrToInt('$' + Copy(s, 11, 8));
      oText := nil;
      EngineIntf.GetText(Engine.ScriptOptions.BlobFile, smRead, oText);
      try
        oStr := oText.Stream;
        oStr.Position := iPos;
        oStr.ReadBuffer(AParams[i].SetBlobRawData(iLen, nil, 0)^, iLen);
      finally
        EngineIntf.ReleaseText(Engine.ScriptOptions.BlobFile, smRead, oText);
      end;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLScriptCommand.Execute();
var
  iRows: LongWord;
  iLinesPrinted: Integer;
  dwStartTime: LongWord;
  dwExecTime: LongWord;
  lOpen: Boolean;
  sFeedback: String;
  eCmdKind: TFDPhysCommandKind;
  lWasRowset: Boolean;
  oExc: EFDException;
  oCmd: IFDPhysCommand;
  oFtch: TFDFetchOptions;
  oRes: TFDResourceOptions;
begin
  EngineIntf.CheckCommand;
  EngineIntf.CheckStartTransaction;
  oCmd := EngineIntf.CommandIntf;
  oCmd.Disconnect;

  oFtch := oCmd.Options.FetchOptions;
  oFtch.AutoClose := False;
  oFtch.AutoFetchAll := afAll;
  oFtch.Items := oFtch.Items - [fiMeta];

  oRes := oCmd.Options.ResourceOptions;
  if oRes.CmdExecMode = amAsync then
    oRes.CmdExecMode := amBlocking;
  oRes.DirectExecute := True;
  oRes.MacroCreate := False;
  oRes.MacroExpand := Engine.ScriptOptions.MacroExpand;
  oRes.Persistent := False;

  lOpen := Engine.ScriptOptions.ParamArraySize = 1;
  lWasRowset := False;
  dwExecTime := 0;
  dwStartTime := TThread.GetTickCount();
  eCmdKind := skUnknown;
  try
    try
      try
        oCmd.CommandText := FSQL;
        oCmd.Params.AssignValues(Engine.Params);
        if Engine.ScriptOptions.BlobFile <> '' then
          LoadBlobFileParams(oCmd.Params);
        oCmd.Prepare;
        eCmdKind := oCmd.CommandKind;
        if Engine.ScriptOptions.Verify then
          DumpMacros;
        while oCmd.State <> csInactive do begin
          if lOpen then begin
            iRows := 0;
            iLinesPrinted := 0;
            oCmd.Open;
            if oCmd.State <> csOpen then
              Break;
            lWasRowset := True;
            oCmd.Define(EngineIntf.Table, mmReset);
            repeat
              EngineIntf.ConLockUpdate;
              try
                EngineIntf.Table.Clear;
                oCmd.Fetch(EngineIntf.Table, False);
                Inc(iRows, EngineIntf.Table.Rows.Count);
                DumpTableRows(EngineIntf.Table, iLinesPrinted);
              finally
                EngineIntf.ConUnlockUpdate;
              end;
            until EngineIntf.Table.Rows.Count = 0;
            if iLinesPrinted > 0 then
              EngineIntf.ConPut('', soSeparator);
            if Engine.ScriptOptions.FeedbackCommands then
              if iRows = 0 then
                EngineIntf.ConPut('no rows selected.', soCommand)
              else if iRows = 1 then
                EngineIntf.ConPut('1 row selected.', soCommand)
              else
                EngineIntf.ConPut(IntToStr(iRows) + ' rows selected.', soCommand);
          end
          else
            oCmd.Execute(Engine.ScriptOptions.ParamArraySize, 0);
          oCmd.NextRecordSet := True;
          oCmd.Close;
          lOpen := True;
        end;
        Engine.Params.AssignValues(oCmd.Params, [ptOutput .. ptResult]);
      finally
        dwExecTime := TThread.GetTickCount() - dwStartTime;
        if Engine.ScriptOptions.RaisePLSQLErrors and
           (EngineIntf.ConnectionIntf.Messages <> nil) and
           // ORA-24344: Compiled with errors
           (EngineIntf.ConnectionIntf.Messages[0].ErrorCode = 24344) then begin
          oExc := nil;
          EngineIntf.ConnectionIntf.Messages.Duplicate(oExc);
          raise oExc;
        end;
        if (EngineIntf.ConnectionIntf <> nil) and
           (EngineIntf.ConnectionIntf.Options.ResourceOptions as TFDTopResourceOptions).ServerOutput then
          DumpServerOutput;
      end;
    finally
      EngineIntf.Table.Reset;
      oCmd.AbortJob(True);
      oCmd.NextRecordSet := False;
      oCmd.Disconnect;
    end;
  except
    on E: EFDDBEngineException do begin
      if (E.Kind = ekObjNotExists) and Engine.ScriptOptions.DropNonexistObj and
         ((eCmdKind = skUnknown) and (oCmd.CommandKind in [skDrop, skAlter]) or (eCmdKind in [skDrop, skAlter])) then begin
        if Engine.ScriptOptions.FeedbackCommands then
          if E[0].ObjName <> '' then
            EngineIntf.ConPut('[' + E[0].ObjName + '] does not exists.', soCommand)
          else
            EngineIntf.ConPut('Object does not exists. ', soCommand);
      end
      else
        raise;
    end;
  end;
  EngineIntf.CheckCommit(False);
  if Engine.ScriptOptions.FeedbackCommands then begin
    sFeedback := '';
    if not lWasRowset then
      if oCmd.RowsAffectedReal then
        if oCmd.RowsAffected = 0 then
          sFeedback := 'no rows processed'
        else if oCmd.RowsAffected = 1 then
          sFeedback := '1 row processed'
        else
          sFeedback := IntToStr(oCmd.RowsAffected) + ' rows processed'
      else
        sFeedback := 'Ok';
    if Engine.ScriptOptions.Timing then begin
      if sFeedback <> '' then
        sFeedback := sFeedback + ' ';
      sFeedback := sFeedback + Format('[%.2d:%.2d:%.2d.%.3d]', [
        (dwExecTime div 3600000) mod 60, (dwExecTime div 60000) mod 60,
        (dwExecTime div 1000) mod 60, dwExecTime mod 1000]);
    end;
    if sFeedback <> '' then begin
      sFeedback := sFeedback + '.';
      EngineIntf.ConPut(sFeedback, soCommand);
    end;
  end;
  if Engine.ScriptOptions.AutoPrintParams then
    DumpParams;
//      EngineIntf.ConPut('');
end;

{-------------------------------------------------------------------------------}
{ TFDPLSQLScriptCommand                                                         }
{-------------------------------------------------------------------------------}
constructor TFDPLSQLScriptCommand.Create(AParser: TFDScriptParser;
  AEngine: TFDScript);
begin
  inherited Create(AParser, AEngine);
  FIsPLSQL := True;
end;

{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TFDPLSQLScriptCommand.Dump: String;
begin
  Result := '<PL/SQL> [' + FSQL + ']';
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{ TFDRunScriptCommand                                                           }
{-------------------------------------------------------------------------------}
constructor TFDRunScriptCommand.Create(AParser: TFDScriptParser;
  AEngine: TFDScript);
begin
  inherited Create(AParser, AEngine);
  FArguments := TFDStringList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TFDRunScriptCommand.Destroy;
begin
  FDFreeAndNil(FArguments);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TFDRunScriptCommand.Dump(): String;
var
  i: Integer;
begin
  if not FUseParentPath then
    Result := '<@> [' + FFileName + ']'
  else
    Result := '<@@> [' + FFileName + ']';
  for i := 0 to FArguments.Count - 1 do
    Result := Result + ' [' + FArguments[i] + ']';
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
class function TFDRunScriptCommand.Help(): String;
begin
  Result := '(@ | @@ | START | INput) <script> <arguments> - starts execution of specified script';
end;

{-------------------------------------------------------------------------------}
class procedure TFDRunScriptCommand.Keywords(AKwds: TStrings);
begin
  AKwds.Add('@');
  AKwds.Add('@@');
  AKwds.Add('START');
  AKwds.Add('INput');
end;

{-------------------------------------------------------------------------------}
function TFDRunScriptCommand.Parse(const AKwd: String): Boolean;
var
  s: String;
begin
  if not Parser.WasBeginningOfLine then begin
    Result := False;
    Exit;
  end;
  FUseParentPath := True;
  if Parser.Ch = '@' then
    Parser.GetChar
  else
    FUseParentPath := False;
  FFileName := Parser.GetString();
  while True do begin
    s := Parser.GetString();
    if s = '' then
      Break;
    FArguments.Add(s);
  end;
  Result := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDRunScriptCommand.InternalExecute(ARealExecute: Boolean);
var
  oParser: TFDScriptParser;
  oArgs: TFDStringList;
  oText: TFDTextFile;
  sFileName: String;
begin
  if (ExtractFilePath(FFileName) = '') and FUseParentPath then
    sFileName := ExtractFilePath(Parser.FileName) + FFileName
  else
    sFileName := FFileName;
  sFileName := EngineIntf.ExpandString(sFileName);
  oText := nil;
  oArgs := nil;
  EngineIntf.GetText(sFileName, smRead, oText);
  if oText <> nil then
    try
      oParser := TFDScriptParser.Create(sFileName, Self, oText, Engine.ScriptOptions);
      try
        if Arguments.Count > 0 then begin
          oArgs := TFDStringList.Create;
          oArgs.SetStrings(Engine.Arguments);
          Engine.Arguments.SetStrings(Arguments);
        end;
        oParser.TotalSize := Parser.TotalSize;
        if ARealExecute then
          EngineIntf.ExecuteAll(oParser)
        else
          EngineIntf.ValidateAll(oParser);
      finally
        if oArgs <> nil then begin
          Engine.Arguments.SetStrings(oArgs);
          FDFree(oArgs);
        end;
        Parser.TotalSize := oParser.TotalSize;
        FDFree(oParser);
      end;
    finally
      EngineIntf.ReleaseText(sFileName, smRead, oText);
    end;
end;

{-------------------------------------------------------------------------------}
procedure TFDRunScriptCommand.Execute();
begin
  InternalExecute(True);
end;

{-------------------------------------------------------------------------------}
procedure TFDRunScriptCommand.Validate();
begin
  InternalExecute(False);
end;

{-------------------------------------------------------------------------------}
{ TFDAcceptScriptCommand                                                        }
{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TFDAcceptScriptCommand.Dump(): String;
begin
  Result := '<accept> [var="' + Variable + '", dt=' + FieldTypeNames[DataType];
  if Fmt <> '' then
    Result := Result + ', fmt="' + Fmt + '"';
  if Def <> '' then
    Result := Result + ', def="' + Def + '"';
  if Prompt <> '' then
    Result := Result + ', pr="' + Prompt + '"';
  if Hide then
    Result := Result + ', hide';
  Result := Result + ']';
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
class function TFDAcceptScriptCommand.Help(): String;
begin
  Result := 'ACCept <var> (NUMber|CHAR|DATE) [FORmat <fmt>] [DEFault <def>]'#13#10 +
            '    [PROmpt ''<prompt>'' | NOPRompt] [HIDE] - asks user to enter a variable value';
end;

{-------------------------------------------------------------------------------}
class procedure TFDAcceptScriptCommand.Keywords(AKwds: TStrings);
begin
  AKwds.Add('ACCept');
end;

{-------------------------------------------------------------------------------}
function TFDAcceptScriptCommand.Parse(const AKwd: String): Boolean;
var
  ucS: String;
begin
  FVariable := Parser.GetIdentifier;
  if Variable = '' then
    FDException(Engine, [S_FD_LComp, S_FD_LComp_PScr], er_FD_ScrAccMustSpecVar, []);
  FDataType := ftUnknown;
  while True do begin
    ucS := Parser.GetUCWord;
    if ucS = '' then
      Break;
    if FDKeywordMatch(ucS, 'NUMBER', 3) then
      FDataType := ftFmtBCD
    else if FDKeywordMatch(ucS, 'CHAR', 4) then
      FDataType := ftString
    else if FDKeywordMatch(ucS, 'DATE', 4) then
      FDataType := ftDateTime
    else if FDKeywordMatch(ucS, 'FORMAT', 3) then
      FFmt := Parser.GetString
    else if FDKeywordMatch(ucS, 'DEFAULT', 3) then
      FDef := Parser.GetString
    else if FDKeywordMatch(ucS, 'PROMPT', 3) then
      FPrompt := Parser.GetString
    else if FDKeywordMatch(ucS, 'NOPROMPT', 4) then
      FPrompt := ''
    else if FDKeywordMatch(ucS, 'HIDE', 4) then
      FHide := True;
  end;
  Result := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDAcceptScriptCommand.Execute();
var
  oPar: TFDParam;
  sVal: String;
  rBcd: TBcd;
  rFS: TFormatSettings;
begin
  oPar := Engine.Params.ParamByName(EngineIntf.ExpandString(Variable));
  sVal := oPar.AsString;
  if sVal = '' then
    sVal := Def;
  EngineIntf.ConGet(EngineIntf.ExpandString(Prompt), sVal);
  sVal := EngineIntf.ExpandString(sVal);
  if DataType <> ftUnknown then begin
    oPar.Clear();
    oPar.DataType := DataType;
  end;
  case oPar.DataType of
  ftFmtBCD:
    begin
      FDStr2BCD(PChar(sVal), Length(sVal), rBcd, FormatSettings.DecimalSeparator);
      oPar.AsFmtBCD := rBcd;
    end;
  ftFloat:
    oPar.AsFloat := FDStr2Float(sVal, FormatSettings.DecimalSeparator);
  ftString:
    oPar.AsString := sVal;
  ftDateTime:
    if Fmt = '' then
      oPar.AsDateTime := StrToDateTime(sVal)
    else begin
      rFS := TFormatSettings.Create;
      rFS.ShortDateFormat := EngineIntf.ExpandString(Fmt);
      oPar.AsDateTime := StrToDateTime(sVal, rFS);
    end;
  else
    ASSERT(False);
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDConnectScriptCommand                                                       }
{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TFDConnectScriptCommand.Dump: String;
begin
  Result := '<connect> [' + FConnectString + ']';
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
class function TFDConnectScriptCommand.Help(): String;
begin
  Result := 'CONnect <FireDAC connection string> - connects to the specified DBMS';
end;

{-------------------------------------------------------------------------------}
class procedure TFDConnectScriptCommand.Keywords(AKwds: TStrings);
begin
  AKwds.Add('CONnect');
end;

{-------------------------------------------------------------------------------}
function TFDConnectScriptCommand.Parse(const AKwd: String): Boolean;
begin
  FConnectString := Parser.GetLine();
  Result := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDConnectScriptCommand.Execute();
var
  oMAIntf: IFDMoniAdapter;
  sName: String;
  vValue: Variant;
  eKind: TFDMoniAdapterItemKind;
  i: Integer;
begin
  EngineIntf.CloseConnection;
  try
    EngineIntf.OpenConnection(EngineIntf.ExpandString(ConnectString));
  except
    on E: Exception do
      EngineIntf.ConPut(E.Message, soError);
  end;
  if (EngineIntf.ConnectionIntf <> nil) and (EngineIntf.ConnectionIntf.State = csConnected) then begin
    EngineIntf.ConPut('Connected to', soConnect);
    EngineIntf.UpdateCommandSeparator;
    if Engine.ScriptOptions.FeedbackCommands then begin
      oMAIntf := EngineIntf.ConnectionIntf as IFDMoniAdapter;
      for i := 0 to oMAIntf.ItemCount - 1 do begin
        oMAIntf.GetItem(i, sName, vValue, eKind);
        if eKind = ikSessionInfo then
          EngineIntf.ConPut(sName + ' = ' + VarToStr(vValue), soConnect);
      end;
    end;
  end
  else
    EngineIntf.ConPut('Not logged on', soConnect);
end;

{-------------------------------------------------------------------------------}
{ TFDDefineScriptCommand                                                        }
{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TFDDefineScriptCommand.Dump: String;
begin
  Result := '<define> [';
  case FMode of
  -1: Result := Result + 'show all';
  0: Result := Result + 'show def="' + FName + '"';
  1: Result := Result + 'set def="' + FName + '", val="' + FSValue + '"';
  end;
  Result := Result + ']';
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
class function TFDDefineScriptCommand.Help(): String;
begin
  Result := 'DEFine [<name> | <name>=<value>] - prints all, the specified or sets the specified macro value';
end;

{-------------------------------------------------------------------------------}
class procedure TFDDefineScriptCommand.Keywords(AKwds: TStrings);
begin
  AKwds.Add('DEFine');
end;

{-------------------------------------------------------------------------------}
function TFDDefineScriptCommand.Parse(const AKwd: String): Boolean;
begin
  FName := Parser.GetIdentifier();
  if FName = '' then
    FMode := -1
  else begin
    Parser.SkipWS;
    if Parser.Ch = '=' then begin
      FMode := 1;
      Parser.GetChar;
      FSValue := Parser.GetString();
      if FSValue = '' then
        FDException(Engine, [S_FD_LComp, S_FD_LComp_PScr], er_FD_ScrDefReqValue, []);
    end
    else begin
      FMode := 0;
      Parser.UnGetChar;
    end;
  end;
  Result := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDDefineScriptCommand.Execute();
var
  i: Integer;
  oMac: TFDMacro;
begin
  case FMode of
  -1:
    for i := 0 to Engine.Macros.Count - 1 do
      EngineIntf.ConPut('DEFINE ' + Engine.Macros[i].Name + ' = ' + Engine.Macros[i].AsRaw, soMacro);
  0:
    begin
      oMac := Engine.Macros.FindMacro(EngineIntf.ExpandString(Name));
      if oMac = nil then
        EngineIntf.ConPut('Symbol ' + Name + ' is UNDEFINED', soMacro)
      else
        EngineIntf.ConPut('DEFINE ' + oMac.Name + ' = ' + oMac.AsRaw, soMacro);
    end;
  1:
    begin
      oMac := Engine.Macros.FindMacro(EngineIntf.ExpandString(Name));
      if oMac = nil then begin
        oMac := TFDMacro(Engine.Macros.Add);
        oMac.Name := EngineIntf.ExpandString(Name);
      end;
      oMac.AsRaw := EngineIntf.ExpandString(Value);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDDisconnectScriptCommand                                                    }
{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TFDDisconnectScriptCommand.Dump: String;
begin
  Result := '<disconnect>';
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
class function TFDDisconnectScriptCommand.Help(): String;
begin
  Result := 'DISconnect - disconnects from the DBMS';
end;

{-------------------------------------------------------------------------------}
class procedure TFDDisconnectScriptCommand.Keywords(AKwds: TStrings);
begin
  AKwds.Add('DISconnect');
end;

{-------------------------------------------------------------------------------}
procedure TFDDisconnectScriptCommand.Execute();
begin
  EngineIntf.CloseConnection;
  EngineIntf.ConPut('Not logged on', soConnect);
end;

{-------------------------------------------------------------------------------}
{ TFDExecuteScriptCommand                                                       }
{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TFDExecuteScriptCommand.Dump: String;
begin
  Result := '<execute> [' + FBlock + ']';
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
class function TFDExecuteScriptCommand.Help(): String;
begin
  Result := '(EXECute | CALL) <procedure> - executes the specified stored procedure';
end;

{-------------------------------------------------------------------------------}
class procedure TFDExecuteScriptCommand.Keywords(AKwds: TStrings);
begin
  AKwds.Add('EXECute');
  AKwds.Add('CALL');
end;

{-------------------------------------------------------------------------------}
function TFDExecuteScriptCommand.Parse(const AKwd: String): Boolean;
begin
  // Ignore ADS EXECUTE PROCEDURE, FB EXECUTE BLOCK, PgSQL and MSSQL EXECUTE
  if FDKeywordMatch(AKwd, 'EXECUTE', 4) and
     (EngineIntf.RDBMSKind in [TFDRDBMSKinds.Advantage,
                               TFDRDBMSKinds.Firebird,
                               TFDRDBMSKinds.PostgreSQL,
                               TFDRDBMSKinds.MSSQL,
                               TFDRDBMSKinds.Informix]) then
    Result := False
  // Ignore NexusDB, DB2 and MySQL CALL
  else if FDKeywordMatch(AKwd, 'CALL', 4) and
     (EngineIntf.RDBMSKind in [TFDRDBMSKinds.NexusDB,
                               TFDRDBMSKinds.DB2,
                               TFDRDBMSKinds.MySQL]) then
    Result := False
  else begin
    FBlock := Parser.GetLine();
    Result := True;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDExecuteScriptCommand.Execute();
var
  oGen: IFDPhysCommandGenerator;
begin
  EngineIntf.CheckCommand;
  EngineIntf.ConnectionIntf.CreateCommandGenerator(oGen, nil);
  FSQL := oGen.GenerateCall(FBlock);
  inherited Execute();
end;

{-------------------------------------------------------------------------------}
{ TFDExitScriptCommand                                                          }
{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TFDExitScriptCommand.Dump(): String;
begin
  case FAction of
  eaCommit:   Result := '<commit, exit>';
  eaRollback: Result := '<rollback, exit>';
  eaNone:     Result := '<exit>';
  end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
class function TFDExitScriptCommand.Help(): String;
begin
  Result := 'EXIT - stops script execution and commit changes'#13#10 +
            'QUIT - stops script execution and rollback changes'#13#10 +
            'STOP - stops script execution';
end;

{-------------------------------------------------------------------------------}
class procedure TFDExitScriptCommand.Keywords(AKwds: TStrings);
begin
  AKwds.Add('EXIT');
  AKwds.Add('QUIT');
  AKwds.Add('STOP');
end;

{-------------------------------------------------------------------------------}
function TFDExitScriptCommand.Parse(const AKwd: String): Boolean;
begin
  if FDKeywordMatch(AKwd, 'EXIT', 4) then
    FAction := eaCommit
  else if FDKeywordMatch(AKwd, 'QUIT', 4) then
    FAction := eaRollback
  else
    FAction := eaNone;
  Result := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDExitScriptCommand.Execute();
begin
  if EngineIntf.ConnectionIntf <> nil then
    case FAction of
    eaCommit:
      while EngineIntf.ConnectionIntf.Transaction.Active do
        EngineIntf.ConnectionIntf.Transaction.Commit;
    eaRollback:
      while EngineIntf.ConnectionIntf.Transaction.Active do
        EngineIntf.ConnectionIntf.Transaction.Rollback;
    end;
  Engine.Finished := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDExitScriptCommand.Validate;
begin
  Engine.Finished := True;
end;

{-------------------------------------------------------------------------------}
{ TFDHostScriptCommand                                                          }
{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TFDHostScriptCommand.Dump(): String;
begin
  Result := '<host> [' + Command + ']';
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
class function TFDHostScriptCommand.Help(): String;
begin
  Result := '(HOst | !! | SHELL) <command> - executes host command';
end;

{-------------------------------------------------------------------------------}
class procedure TFDHostScriptCommand.Keywords(AKwds: TStrings);
begin
  AKwds.Add('HOst');
  AKwds.Add('SHELL');
  AKwds.Add('!!');
end;

{-------------------------------------------------------------------------------}
function TFDHostScriptCommand.Parse(const AKwd: String): Boolean;
begin
  FCommand := Parser.GetLine();
  Result := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDHostScriptCommand.Execute();
begin
  EngineIntf.ExecuteHostCommand(EngineIntf.ExpandString(Command));
end;

{-------------------------------------------------------------------------------}
{ TFDPauseScriptCommand                                                         }
{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TFDPauseScriptCommand.Dump(): String;
begin
  Result := '<pause> [' + Text + ']';
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
class function TFDPauseScriptCommand.Help(): String;
begin
  Result := 'PAUse <prompt> - pauses script execution';
end;

{-------------------------------------------------------------------------------}
class procedure TFDPauseScriptCommand.Keywords(AKwds: TStrings);
begin
  AKwds.Add('PAUse');
end;

{-------------------------------------------------------------------------------}
function TFDPauseScriptCommand.Parse(const AKwd: String): Boolean;
begin
  FText := Parser.GetLine();
  Result := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDPauseScriptCommand.Execute();
begin
  EngineIntf.ConPause(EngineIntf.ExpandString(Text));
end;

{-------------------------------------------------------------------------------}
{ TFDPromptScriptCommand                                                        }
{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TFDPromptScriptCommand.Dump(): String;
begin
  Result := '<prompt> [' + Text + ']';
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
class function TFDPromptScriptCommand.Help(): String;
begin
  Result := 'PROmpt <prompt> - prints specified text';
end;

{-------------------------------------------------------------------------------}
class procedure TFDPromptScriptCommand.Keywords(AKwds: TStrings);
begin
  AKwds.Add('PROmpt');
end;

{-------------------------------------------------------------------------------}
function TFDPromptScriptCommand.Parse(const AKwd: String): Boolean;
begin
  FText := Parser.GetLine();
  Result := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDPromptScriptCommand.Execute();
begin
  EngineIntf.ConPut(EngineIntf.ExpandString(Text), soUserOutput);
end;

{-------------------------------------------------------------------------------}
{ TFDPrintScriptCommand                                                         }
{-------------------------------------------------------------------------------}
constructor TFDPrintScriptCommand.Create(AParser: TFDScriptParser;
  AEngine: TFDScript);
begin
  inherited Create(AParser, AEngine);
  FVars := TFDStringList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TFDPrintScriptCommand.Destroy;
begin
  FDFreeAndNil(FVars);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TFDPrintScriptCommand.Dump(): String;
var
  i: Integer;
begin
  Result := '<print> [';
  for i := 0 to Vars.Count - 1 do begin
    if i > 0 then
      Result := Result + ', ';
    Result := Result + IntToStr(i) + '="' + Vars[i] + '"';
  end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
class function TFDPrintScriptCommand.Help(): String;
begin
  Result := 'PRInt <var 1> [..., <varN>] - prints value of the specified variables';
end;

{-------------------------------------------------------------------------------}
class procedure TFDPrintScriptCommand.Keywords(AKwds: TStrings);
begin
  AKwds.Add('PRInt');
end;

{-------------------------------------------------------------------------------}
function TFDPrintScriptCommand.Parse(const AKwd: String): Boolean;
begin
  Result := not ((EngineIntf.RDBMSKind = TFDRDBMSKinds.MSSQL) and (UpperCase(AKwd) = 'PRINT'));
  if Result then
    Vars.AddStrings(Parser.GetLine().Split([',', ' ', #9], ExcludeEmpty));
end;

{-------------------------------------------------------------------------------}
procedure TFDPrintScriptCommand.Execute();
var
  i, j, iWidth: Integer;
  oPar: TFDParam;
  lAlignRight: Boolean;

  function PadStr(const AStr: String; AWidth: Integer; ARight: Boolean): String;
  begin
    if ARight then
      Result := Copy(StringOfChar(' ', AWidth - Length(AStr)) + AStr, 1, AWidth)
    else
      Result := Copy(AStr + StringOfChar(' ', AWidth - Length(AStr)), 1, AWidth);
  end;

begin
  for i := 0 to Vars.Count - 1 do
    try
      oPar := Engine.Params.ParamByName(EngineIntf.ExpandString(Vars[i]));
      iWidth := 20;
      lAlignRight := False;
      case oPar.DataType of
      ftFmtBCD,
      ftBCD,
      ftCurrency,
      ftFloat,
      ftInteger,
      ftSmallint,
      ftWord,
      ftAutoInc,
      ftLargeint:
        begin
          if oPar.Precision > 0 then
            iWidth := oPar.Precision;
          lAlignRight := True;
        end;
      ftWideString,
      ftString:
        if oPar.Size > 0 then
          iWidth := oPar.Size;
      end;
      EngineIntf.ConPut(PadStr(oPar.Name, iWidth, lAlignRight), soParam);
      EngineIntf.ConPut(StringOfChar('-', iWidth), soParam);
      EngineIntf.ConPut(PadStr(oPar.AsString, iWidth, lAlignRight), soParam);
      if oPar.ArraySize > 1 then
        for j := 1 to oPar.ArraySize - 1 do
          EngineIntf.ConPut(Format('  [%d]: %s', [j, PadStr(oPar.AsStrings[j], iWidth, lAlignRight)]), soParam);
      EngineIntf.ConPut('', soSeparator);
    except
      on E: Exception do
        EngineIntf.ConPut(E.Message, soError);
    end;
end;

{-------------------------------------------------------------------------------}
{ TFDSetScriptCommand                                                           }
{-------------------------------------------------------------------------------}
constructor TFDSetScriptCommand.Create(AParser: TFDScriptParser;
  AEngine: TFDScript);
begin
  inherited Create(AParser, AEngine);
end;

{-------------------------------------------------------------------------------}
destructor TFDSetScriptCommand.Destroy;
var
  i: Integer;
begin
  for i := 0 to Length(FItems) - 1 do
    FDFree(FItems[i]);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDSetScriptCommand.AddItem(ASetKind: TFDSetScriptCommandKind;
  AIValue: Integer; ASValue: String; AEchoCommands: TFDScriptEchoCommands): TFDSetScriptCommandItem;
begin
  SetLength(FItems, Length(FItems) + 1);
  Result := TFDSetScriptCommandItem.Create;
  FItems[Length(FItems) - 1] := Result;
  Result.FSetKind := ASetKind;
  Result.FIValue := AIValue;
  Result.FSValue := ASValue;
  Result.FEchoCommands := AEchoCommands;
end;

{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TFDSetScriptCommand.Dump(): String;
var
  s: String;
  i: Integer;
  oItem: TFDSetScriptCommandItem;
begin
  Result := '<set> [';
  s := '';
  for i := 0 to Length(FItems) - 1 do begin
    if i > 0 then
      s := s + ', ';
    oItem := FItems[i];
    case oItem.FSetKind of
    skNone:           ;
    skArraySize:      s := s + 'arraysize=' + IntToStr(oItem.FIValue);
    skAutoCommit:     s := s + 'autocommit=' + IntToStr(oItem.FIValue);
    skAutoPrint:      s := s + 'autoprint=' + IntToStr(oItem.FIValue);
    skBlobFile:       s := s + 'blobfile=' + oItem.FSValue;
    skCharacterSet:   s := s + 'characterset=' + oItem.FSValue;
    skClientLib:      s := s + 'clientlib=' + oItem.FSValue;
    skCmdSep:         s := s + 'cmdsep=' + oItem.FSValue;
    skDefine:         s := s + 'define=' + IntToStr(oItem.FIValue);
    skEcho:           s := s + 'echo=' + IntToStr(oItem.FIValue);
    skEncoding:       s := s + 'encoding=' + IntToStr(oItem.FIValue);
    skFeedback:       s := s + 'feedback=' + IntToStr(oItem.FIValue);
    skHeading:        s := s + 'heading=' + IntToStr(oItem.FIValue);
    skLineSize:       s := s + 'linesize=' + IntToStr(oItem.FIValue);
    skLong:           s := s + 'long=' + IntToStr(oItem.FIValue);
    skParamArraySize: s := s + 'paramarraysize=' + IntToStr(oItem.FIValue);
    skPageSize:       s := s + 'pagesize=' + IntToStr(oItem.FIValue);
    skScan:           s := s + 'scan=' + IntToStr(oItem.FIValue);
    skServerOutput:   s := s + 'serveroutput=' + IntToStr(oItem.FIValue);
    skSQLDialect:     s := s + 'sqldialect=' + IntToStr(oItem.FIValue);
    skTermout:        s := s + 'termout=' + IntToStr(oItem.FIValue);
    skTiming:         s := s + 'timing=' + IntToStr(oItem.FIValue);
    skBreakOnError:   s := s + 'breakonerror=' + IntToStr(oItem.FIValue);
    skIgnoreError:    s := s + 'ignoreerror=' + IntToStr(oItem.FIValue);
    skTrimConsole:    s := s + 'trimconsole=' + IntToStr(oItem.FIValue);
    skTrimSpool:      s := s + 'trimspool=' + IntToStr(oItem.FIValue);
    skVerify:         s := s + 'verify=' + IntToStr(oItem.FIValue);
    end;
  end;
  Result := Result + s + ']';
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
class function TFDSetScriptCommand.Help(): String;
// show
begin
  Result := 'SET - sets script execution mode'#13#10 +
            '    ARRAY <value> - specifies the rowset size'#13#10 +
            '    AUTOcommit OFF|ON|<value> - set auto commit off, on or to commit each N commands'#13#10+
            '    AUTOPrint OFF|ON - show variable values after command execution'#13#10 +
            '    BREAK OFF|ON - stop script execution on error'#13#10 +
            '    (CHARACTERset | NAMES) <value> - specifies client character set'#13#10 +
            '    CLIENTlib <value> - specifies driver CLI library'#13#10 +
            '    (CMDSeparator | TERMinator) <value> - specifies commands separator. TERM is for IB/FB only'#13#10 +
            '    (DEFine | SCAN) OFF|ON - controls macros expansion'#13#10 +
            '    DROPnonexistent ON|OFF - allow to drop non existent objects'#13#10 +
            '    ECHO OFF|(ON [SQL|ALL] [TRIM 50|<value>]) - shows command text before it execution with optional trimming'#13#10 +
            '    ENCoding ANSI | UTF8 | UTF16 - sets text file encoding'#13#10 +
            '    (FEEDback|COUNT) 6|<value>|OFF|ON - show feedback after command execution'#13#10 +
            '    HEAding OFF|ON - show column names for dataset'#13#10 +
            '    LINESize 0|<value> - set line width'#13#10 +
            '    (WIDTH|LONG) 80|<value> - show specified amount of characters for character or binary values'#13#10 +
            '    PAGESize 24|<value> - set the page size when printing dataset'#13#10 +
            '    PARAMARRAY 1|<value> - specifies the size of parameters array'#13#10 +
            '    SERVEROUTPUT OFF|(ON [SIZE <value>]) - show server output after command execution'#13#10 +
            '    SQL DIALECT <value> - specifies the SQL dialect. For IB/FB connection only'#13#10 +
            '    (TERMout|CONsole) OFF|ON - output command execution result to console'#13#10 +
            '    TIMing OFF|ON - show command executin time'#13#10 +
            '    TRIMout OFF|ON - trim spaces from strings at console output'#13#10 +
            '    TRIMSpool ON|OFF - trim spaces from strings at spool output'#13#10 +
            '    VERify OFF|ON - show SQL command before execution with substituted macros';
end;

{-------------------------------------------------------------------------------}
class procedure TFDSetScriptCommand.Keywords(AKwds: TStrings);
begin
  AKwds.Add('SET');
end;

{-------------------------------------------------------------------------------}
function TFDSetScriptCommand.Parse(const AKwd: String): Boolean;
var
  ucS, s: String;
  iLastBmk: Integer;
  oItem: TFDSetScriptCommandItem;
  lEQREquired: Boolean;
begin
  while True do begin
    ucS := Parser.GetUCWord;
    if ucS = '' then
      Break;

    Parser.SkipWS;
    iLastBmk := Parser.GetBookmark;
    lEQREquired := False;
    if Parser.Ch = ':' then begin
      Parser.GetChar;
      lEQREquired := True;
    end;
    if Parser.Ch = '=' then
      Parser.GetChar
    else if lEQREquired then
      Parser.SetBookmark(iLastBmk);

    if FDKeywordMatch(ucS, 'ARRAY', 5) then
      // n
      AddItem(skArraySize, Parser.GetNumber(15))
    else if FDKeywordMatch(ucS, 'AUTOCOMMIT', 4) then
      // OFF(-1) | ON(1) | n
      AddItem(skAutoCommit, Parser.GetNumber(1))
    else if FDKeywordMatch(ucS, 'AUTOPRINT', 5) then
      // OFF(-1) | ON(1)
      AddItem(skAutoPrint, Parser.GetOnOff)
    else if FDKeywordMatch(ucS, 'BLOBFILE', 8) then
      // file name
      AddItem(skBlobFile, 0, Parser.GetString(True))
    else if FDKeywordMatch(ucS, 'CHARACTERSET', 9) or FDKeywordMatch(ucS, 'NAMES', 5) then
      // charset
      AddItem(skCharacterSet, 0, Parser.GetString(True))
    else if FDKeywordMatch(ucS, 'CLIENTLIB', 6) then
      // clientlib
      AddItem(skClientLib, 0, Parser.GetString(True))
    else if FDKeywordMatch(ucS, 'CMDSEPARATOR', 4) or
            FDKeywordMatch(ucS, 'TERMINATOR', 4) and
              (EngineIntf.RDBMSKind in [TFDRDBMSKinds.Interbase, TFDRDBMSKinds.Firebird]) then begin
      // ';' | c | OFF(-1) | ON(ord(';'))
      s := Parser.GetString(True);
      if UpperCase(s) = 'OFF' then
        s := #255
      else if UpperCase(s) = 'ON' then
        s := ''
      else if s = '' then
        s := Parser.ScriptOptions.CommandSeparator;
      AddItem(skCmdSep, 0, s)
    end
    else if FDKeywordMatch(ucS, 'DEFINE', 3) or FDKeywordMatch(ucS, 'SCAN', 4) then
      // SQL*Plus: '&' | c | OFF(-1) | ON(ord('&'))
      // FireDAC: OFF(-1) | ON(1)
      AddItem(skDefine, Parser.GetOnOff)
    else if FDKeywordMatch(ucS, 'DROPNONEXISTENT', 4) then
      // OFF(-1) | ON(1)
      AddItem(skDropNonexistObj, Parser.GetOnOff)
    else if FDKeywordMatch(ucS, 'ECHO', 4) then begin
      // OFF(-1) | ON(1) [SQL|ALL] [TRIM <size>]
      oItem := AddItem(skEcho, Parser.GetOnOff);
      if oItem.FIValue = 1 then begin
        oItem.FEchoCommands := ecAll;
        oItem.FIValue := 50;
        while True do begin
          iLastBmk := Parser.GetBookmark;
          ucS := Parser.GetUCWord;
          if ucS = 'SQL' then
            oItem.FEchoCommands := ecSQL
          else if ucS = 'ALL' then
            oItem.FEchoCommands := ecAll
          else if ucS = 'TRIM' then
            oItem.FIValue := Parser.GetNumber
          else begin
            Parser.SetBookmark(iLastBmk);
            Break;
          end;
        end;
      end
      else
        oItem.FEchoCommands := ecNone;
    end
    else if FDKeywordMatch(ucS, 'ENCODING', 3) then begin
      oItem := AddItem(skEncoding);
      ucS := Parser.GetUCWord;
      if FDKeyWordMatch(ucS, 'UTF8', 4) then
        oItem.FIValue := Integer(ecUTF8)
      else if FDKeyWordMatch(ucS, 'UTF16', 5) then
        oItem.FIValue := Integer(ecUTF16)
      else
        oItem.FIValue := Integer(ecANSI);
    end
    else if FDKeywordMatch(ucS, 'FEEDBACK', 4) or FDKeywordMatch(ucS, 'COUNT', 5) then
      // 6 | n | OFF(-1) | ON(6)
      AddItem(skFeedback, Parser.GetNumber(6))
    else if FDKeywordMatch(ucS, 'HEADING', 3) then
      // OFF(-1) | ON(1)
      AddItem(skHeading, Parser.GetOnOff)
    else if FDKeywordMatch(ucS, 'LINESIZE', 5) then
      // 0 | n
      AddItem(skLineSize, Parser.GetNumber(0))
    else if FDKeywordMatch(ucS, 'LONG', 4) or FDKeywordMatch(ucS, 'WIDTH', 5) then
      // 80 | n
      AddItem(skLong, Parser.GetNumber(80))
    else if FDKeywordMatch(ucS, 'PARAMARRAY', 10) then
      // n
      AddItem(skParamArraySize, Parser.GetNumber(1))
    else if FDKeywordMatch(ucS, 'PAGESIZE', 5) then
      // n
      AddItem(skPageSize, Parser.GetNumber(24))
    else if FDKeywordMatch(ucS, 'SERVEROUTPUT', 9) then begin
      // [OFF | ON] [SIZE n]
      oItem := AddItem(skServerOutput, Parser.GetOnOff);
      iLastBmk := Parser.GetBookmark;
      ucS := Parser.GetUCWord;
      if FDKeywordMatch(ucS, 'SIZE', 4) then
        oItem.FIValue := Parser.GetNumber
      else begin
        oItem.FIValue := 1024;
        Parser.SetBookmark(iLastBmk);
      end;
    end
    else if FDKeywordMatch(ucS, 'SQL', 3) then begin
      // DIALECT n
      oItem := AddItem(skSQLDialect);
      iLastBmk := Parser.GetBookmark;
      ucS := Parser.GetUCWord;
      if ucS = 'DIALECT' then
        oItem.FIValue := Parser.GetNumber(3)
      else begin
        oItem.FIValue := 3;
        Parser.SetBookmark(iLastBmk);
      end;
    end
    else if FDKeywordMatch(ucS, 'TERMOUT', 4) or FDKeywordMatch(ucS, 'CONSOLE', 3) then
      // OFF(-1) | ON(1)
      AddItem(skTermout, Parser.GetOnOff)
    else if FDKeywordMatch(ucS, 'TIMING', 3) then
      // OFF(-1) | ON(1)
      AddItem(skTiming, Parser.GetOnOff)
    else if FDKeywordMatch(ucS, 'BREAK', 5) then
      // OFF(-1) | ON(1)
      AddItem(skBreakOnError, Parser.GetOnOff)
    else if FDKeywordMatch(ucS, 'IGNORE', 6) then
      // OFF(-1) | ON(1)
      AddItem(skIgnoreError, Parser.GetOnOff)
    else if FDKeywordMatch(ucS, 'TRIMOUT', 4) then
      // OFF(-1) | ON(1)
      AddItem(skTrimConsole, Parser.GetOnOff)
    else if FDKeywordMatch(ucS, 'TRIMSPOOL', 5) then
      // OFF(-1) | ON(1)
      AddItem(skTrimSpool, Parser.GetOnOff)
    else if FDKeywordMatch(ucS, 'VERIFY', 3) then
      // OFF(-1) | ON(1)
      AddItem(skVerify, Parser.GetOnOff)

    // ********************************************************
    // ******** just ignore next SET's ************************
    else if FDKeywordMatch(ucS, 'NUMWIDTH', 3) then
      // n
      Parser.GetNumber
    else if FDKeywordMatch(ucS, 'TAB', 3) then
      // OFF(-1) | ON(1)
      Parser.GetOnOff;

  end;
  Result := Length(FItems) > 0;
end;

{-------------------------------------------------------------------------------}
procedure TFDSetScriptCommand.Execute();
var
  i: Integer;
  oItem: TFDSetScriptCommandItem;
  oRes: TFDTopResourceOptions;
begin
  for i := 0 to Length(FItems) - 1 do begin
    oItem := FItems[i];
    case oItem.FSetKind of
    skArraySize:
      begin
        EngineIntf.CheckCommand;
        EngineIntf.CommandIntf.Options.FetchOptions.RowsetSize := oItem.FIValue;
      end;
    skAutoCommit:
      begin
        if EngineIntf.ConnectionIntf = nil then
          Engine.Connection.TxOptions.AutoCommit := (oItem.FIValue >= 1)
        else begin
          EngineIntf.CheckCommand;
          EngineIntf.CheckCommit(True);
          EngineIntf.ConnectionIntf.Transaction.Options.AutoCommit := (oItem.FIValue >= 1);
        end;
        if oItem.FIValue >= 1 then
          Engine.ScriptOptions.CommitEachNCommands := oItem.FIValue
        else
          Engine.ScriptOptions.CommitEachNCommands := 0;
        Engine.ProcessedAfterCommit := 0;
      end;
    skAutoPrint:
      Engine.ScriptOptions.AutoPrintParams := (oItem.FIValue = 1);
    skBlobFile:
      Engine.ScriptOptions.BlobFile := oItem.FSValue;
    skCharacterSet:
      Engine.ScriptOptions.CharacterSet := oItem.FSValue;
    skClientLib:
      Engine.ScriptOptions.ClientLib := oItem.FSValue;
    skCmdSep:
      begin
        Parser.ScriptOptions.CommandSeparator := oItem.FSValue;
        EngineIntf.UpdateCommandSeparator;
      end;
    skDropNonexistObj:
      Engine.ScriptOptions.DropNonexistObj := (oItem.FIValue = 1);
    skEcho:
      begin
        Engine.ScriptOptions.EchoCommandTrim := 0;
        Engine.ScriptOptions.EchoCommands := oItem.FEchoCommands;
        if oItem.FEchoCommands <> ecNone then
          Engine.ScriptOptions.EchoCommandTrim := oItem.FIValue;
      end;
    skEncoding:
      Engine.ScriptOptions.FileEncoding := TFDEncoding(oItem.FIValue);
    skFeedback:
      Engine.ScriptOptions.FeedbackCommands := (oItem.FIValue > 0);
    skHeading:
      Engine.ScriptOptions.ColumnHeadings := (oItem.FIValue > 0);
    skLineSize:
      Engine.ScriptOptions.LineSize := oItem.FIValue;
    skLong:
      Engine.ScriptOptions.MaxStringWidth := oItem.FIValue;
    skParamArraySize:
      begin
        Engine.ScriptOptions.ParamArraySize := oItem.FIValue;
        Engine.Params.ArraySize := oItem.FIValue;
      end;
    skPageSize:
      Engine.ScriptOptions.PageSize := oItem.FIValue;
    skDefine,
    skScan:
      Engine.ScriptOptions.MacroExpand := (oItem.FIValue > 0);
    skServerOutput:
      begin
        EngineIntf.CheckCommand;
        oRes := EngineIntf.ConnectionIntf.Options.ResourceOptions as TFDTopResourceOptions;
        if oItem.FIValue > 1 then
          oRes.ServerOutputSize := oItem.FIValue;
        oRes.ServerOutput := (oItem.FIValue > 0);
      end;
    skSQLDialect:
      Engine.ScriptOptions.SQLDialect := oItem.FIValue;
    skTermout:
      Engine.ScriptOptions.ConsoleOutput := (oItem.FIValue > 0);
    skTiming:
      Engine.ScriptOptions.Timing := (oItem.FIValue > 0);
    skBreakOnError:
      Engine.ScriptOptions.BreakOnError := (oItem.FIValue > 0);
    skIgnoreError:
      Engine.ScriptOptions.IgnoreError := (oItem.FIValue > 0);
    skTrimConsole:
      Engine.ScriptOptions.TrimConsole := (oItem.FIValue > 0);
    skTrimSpool:
      Engine.ScriptOptions.TrimSpool := (oItem.FIValue > 0);
    skVerify:
      Engine.ScriptOptions.Verify := (oItem.FIValue > 0);
    else
      ASSERT(False);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDSetScriptCommand.Validate();
var
  i: Integer;
  oItem: TFDSetScriptCommandItem;
begin
  for i := 0 to Length(FItems) - 1 do begin
    oItem := FItems[i];
    case oItem.FSetKind of
    skCmdSep:
      begin
        Parser.ScriptOptions.CommandSeparator := oItem.FSValue;
        EngineIntf.UpdateCommandSeparator;
      end;
    skEncoding:
      Engine.ScriptOptions.FileEncoding := TFDEncoding(oItem.FIValue);
    skBreakOnError:
      Engine.ScriptOptions.BreakOnError := (oItem.FIValue > 0);
    skIgnoreError:
      Engine.ScriptOptions.IgnoreError := (oItem.FIValue > 0);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDSpoolScriptCommand                                                         }
{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TFDSpoolScriptCommand.Dump: String;
begin
  Result := '<spool> [';
  case FMode of
  -1: Result := Result + 'off';
   0: Result := Result + 'show';
   1:
    begin
      Result := Result + 'on fl="' + FileName + '"';
      if Append then
        Result := Result + ', append';
    end;
  end;
  Result := Result + ']';
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
class function TFDSpoolScriptCommand.Help(): String;
begin
  Result := '(SPOol | OUTput) [OFF|[APPend] <spool name>] - turns spooling off, print it status'#13#10 +
            '                                               or redirect it to the name';
end;

{-------------------------------------------------------------------------------}
class procedure TFDSpoolScriptCommand.Keywords(AKwds: TStrings);
begin
  AKwds.Add('SPOol');
  AKwds.Add('OUTput');
end;

{-------------------------------------------------------------------------------}
function TFDSpoolScriptCommand.Parse(const AKwd: String): Boolean;
var
  iLastBmk: Integer;
  ucS: string;
begin
  iLastBmk := Parser.GetBookmark;
  ucS := Parser.GetUCWord;
  if ucS = 'OFF' then
    FMode := -1
  else if ucS = '' then
    FMode := 0
  else begin
    FMode := 1;
    FAppend := FDKeyWordMatch(ucS, 'APPEND', 3);
    if not FAppend then
      Parser.SetBookmark(iLastBmk);
    FFileName := Parser.GetLine();
    if FFileName = '' then
      FMode := -1;
  end;
  Result := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDSpoolScriptCommand.Execute();
begin
  case FMode of
  -1:
    begin
      Engine.ScriptOptions.SpoolOutput := smNone;
      EngineIntf.UpdateSpool;
    end;
   0:
    if Engine.ScriptOptions.SpoolOutput <> smNone then
      EngineIntf.ConPut('currently spooling to ' + Engine.ScriptOptions.SpoolFileName, soInfo)
    else
      EngineIntf.ConPut('not spooling currently', soInfo);
   1:
    begin
      if FAppend then
        Engine.ScriptOptions.SpoolOutput := smOnAppend
      else
        Engine.ScriptOptions.SpoolOutput := smOnReset;
      Engine.ScriptOptions.SpoolFileName := EngineIntf.ExpandString(FileName);
      EngineIntf.UpdateSpool;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDUndefineScriptCommand                                                      }
{-------------------------------------------------------------------------------}
constructor TFDUndefineScriptCommand.Create(AParser: TFDScriptParser;
  AEngine: TFDScript);
begin
  inherited Create(AParser, AEngine);
  FVars := TFDStringList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TFDUndefineScriptCommand.Destroy;
begin
  FDFreeAndNil(FVars);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TFDUndefineScriptCommand.Dump(): String;
var
  i: Integer;
begin
  Result := '<undefine> [';
  for i := 0 to FVars.Count - 1 do begin
    if i > 0 then
      Result := Result + ', ';
    Result := Result + IntToStr(i) + '="' + FVars[i] + '"';
  end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
class function TFDUndefineScriptCommand.Help(): String;
begin
  Result := 'UNDEFine <var1> [..., <varN>] - undefines specified macros';
end;

{-------------------------------------------------------------------------------}
class procedure TFDUndefineScriptCommand.Keywords(AKwds: TStrings);
begin
  AKwds.Add('UNDEFine');
end;

{-------------------------------------------------------------------------------}
function TFDUndefineScriptCommand.Parse(const AKwd: String): Boolean;
begin
  Vars.AddStrings(Parser.GetLine().Split([',', ' ', #9], ExcludeEmpty));
  Result := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDUndefineScriptCommand.Execute();
var
  i: Integer;
  oMac: TFDMacro;
begin
  for i := 0 to Vars.Count - 1 do begin
    oMac := Engine.Macros.FindMacro(EngineIntf.ExpandString(Vars[i]));
    if oMac <> nil then
      FDFree(oMac);
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDVariableScriptCommand                                                      }
{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TFDVariableScriptCommand.Dump(): String;
begin
  Result := '<variable> [';
  case FMode of
  -1: Result := Result + 'show all';
  0: Result := Result + 'show var="' + Variable + '"';
  1: Result := Result + 'set var="' + Variable + '", dt=' + FieldTypeNames[DataType] +
      ', sz=' + IntToStr(Size) + ', tabsz=' + IntToStr(TableSize) + ', partp=' +
      InttoStr(Integer(ParamType)) + ', val=' + FValue;
  end;
  Result := Result + ']';
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
class function TFDVariableScriptCommand.Help(): String;
begin
  Result := 'VARiable [<name> (NUMber|CHAR|NCHAR) [(<size>)]] [TABle <size>]'#13#10 +
            '    [IN|OUT|INOUT] [=<value>] - prints all variables or defines variable';
end;

{-------------------------------------------------------------------------------}
class procedure TFDVariableScriptCommand.Keywords(AKwds: TStrings);
begin
  AKwds.Add('VARiable');
end;

{-------------------------------------------------------------------------------}
function TFDVariableScriptCommand.Parse(const AKwd: String): Boolean;
var
  ucS: String;
begin
  FVariable := Parser.GetIdentifier();
  if FVariable = '' then
    // print all
    FMode := -1
  else begin
    ucS := Parser.GetUCWord;
    if ucS = '' then begin
      // print var
      FMode := 0;
      Parser.UnGetChar;
    end
    else begin
      // declare var
      FMode := 1;
      while ucS <> '' do begin
        if FDKeyWordMatch(ucS, 'NUMBER', 3) then
          FDataType := ftFmtBCD
        else if FDKeyWordMatch(ucS, 'CHAR', 4) or FDKeyWordMatch(ucS, 'NCHAR', 5) or
                FDKeyWordMatch(ucS, 'VARCHAR2', 7) or FDKeyWordMatch(ucS, 'NVARCHAR2', 8) then begin
          if ucS[1] = 'N' then
            FDataType := ftWideString
          else
            FDataType := ftString;
          FSize := -1;
          Parser.SkipWS;
          if Parser.Ch = '(' then begin
            Parser.GetChar;
            FSize := Parser.GetNumber;
            Parser.SkipWS;
            if Parser.Ch <> ')' then
              FDException(Engine, [S_FD_LComp, S_FD_LComp_PScr], er_FD_ScrVarMissedCloseBrace, []);
            Parser.GetChar;
          end;
        end
        else if FDKeyWordMatch(ucS, 'TABLE', 3) then
          FTableSize := Parser.GetNumber
        else if FDKeyWordMatch(ucS, 'INPUT', 2) then
          FParamType := ptInput
        else if FDKeyWordMatch(ucS, 'OUTPUT', 3) then
          FParamType := ptOutput
        else if FDKeyWordMatch(ucS, 'INOUT', 3) then
          FParamType := ptInputOutput
        else
          FDException(Engine, [S_FD_LComp, S_FD_LComp_PScr], er_FD_ScrVarUnsupType, []);
        ucS := Parser.GetUCWord;
      end;
      if Parser.Ch = '=' then begin
        Parser.GetChar;
        Parser.SkipWS;
        FValue := Parser.GetString();
      end;
    end;
  end;
  Result := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDVariableScriptCommand.Execute();
var
  i: Integer;
  sVar: String;
  oPar: TFDParam;

  procedure PrintPar(APar: TFDParam);
  var
    s: String;
  begin
    EngineIntf.ConPut('variable     ' + APar.Name, soParam);
    case APar.DataType of
      ftFmtBCD,
      ftFloat:      s := 'NUMBER';
      ftString:     s := 'CHAR(' + IntToStr(APar.Size) + ')';
      ftWideString: s := 'NCHAR(' + IntToStr(APar.Size) + ')';
      else          s := FieldTypeNames[APar.DataType];
    end;
    EngineIntf.ConPut('datatype     ' + s, soParam);
    if APar.ParamType <> ptUnknown then begin
      case APar.ParamType of
        ptInput:       s := 'INPUT';
        ptOutput:      s := 'OUTPUT';
        ptInputOutput: s := 'INOUT';
      end;
      EngineIntf.ConPut('direction    ' + s, soParam);
    end;
    if APar.ArraySize <> 1 then
      EngineIntf.ConPut('array size' + IntToStr(APar.ArraySize), soParam);
  end;

begin
  case FMode of
  -1:
    for i := 0 to Engine.Params.Count - 1 do begin
      if i > 0 then
        EngineIntf.ConPut('', soSeparator);
      PrintPar(Engine.Params[i]);
    end;
   0:
    PrintPar(Engine.Params.ParamByName(EngineIntf.ExpandString(Variable)));
   1:
    begin
      sVar := EngineIntf.ExpandString(Self.Variable);
      oPar := Engine.Params.FindParam(sVar);
      if oPar = nil then begin
        oPar := Engine.Params.Add;
        oPar.Name := sVar;
      end;
      if (oPar.DataType = ftUnknown) or (DataType <> ftUnknown) then
        oPar.DataType := DataType;
      if (ParamType = ptUnknown) and (EngineIntf.RDBMSKind = TFDRDBMSKinds.Oracle) then
        FParamType := ptInputOutput;
      if (oPar.ParamType = ptUnknown) or (ParamType <> ptUnknown) then
        oPar.ParamType := ParamType;
      if (oPar.Size = 0) or (Size <> 0) then
        oPar.Size := Size;
      if TableSize <> 0 then begin
        oPar.ArrayType := atTable;
        oPar.ArraySize := TableSize;
      end
      else
        oPar.ArraySize := Engine.ScriptOptions.ParamArraySize;
      if FValue <> '' then
        if CompareText(FValue, 'null') = 0 then
          oPar.Clear()
        else
          oPar.Value := FValue;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDHelpScriptCommand                                                          }
{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TFDHelpScriptCommand.Dump(): String;
begin
  Result := '<help>';
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
class function TFDHelpScriptCommand.Help(): String;
begin
  Result := 'HELP - shows help for all registered commands';
end;

{-------------------------------------------------------------------------------}
class procedure TFDHelpScriptCommand.Keywords(AKwds: TStrings);
begin
  AKwds.Add('HELP');
  AKwds.Add('?');
end;

{-------------------------------------------------------------------------------}
procedure TFDHelpScriptCommand.Execute();
var
  i: Integer;
  oReg: TFDScriptCommandRegistry;
begin
  oReg := FDScriptCommandRegistry();
  for i := 0 to oReg.Count - 1 do
    EngineIntf.ConPut(oReg.Commands[i].Help(), soInfo);
end;

{-------------------------------------------------------------------------------}
{ TFDRemarkScriptCommand                                                        }
{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TFDRemarkScriptCommand.Dump(): String;
begin
  Result := '<remark> [' + FText + ']';
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
class function TFDRemarkScriptCommand.Help(): String;
begin
  Result := 'REMark <text> - adds comment to the script';
end;

{-------------------------------------------------------------------------------}
class procedure TFDRemarkScriptCommand.Keywords(AKwds: TStrings);
begin
  AKwds.Add('REMark');
end;

{-------------------------------------------------------------------------------}
function TFDRemarkScriptCommand.Parse(const AKwd: String): Boolean;
begin
  FText := Parser.GetLine;
  Result := True;
end;

{-------------------------------------------------------------------------------}
{ TFDCopyScriptCommand                                                          }
{-------------------------------------------------------------------------------}
constructor TFDCopyScriptCommand.Create(AParser: TFDScriptParser; AEngine: TFDScript);
begin
  inherited Create(AParser, AEngine);
  FBatchMove := TFDBatchMove.Create(nil);
  FBatchMove.Options := [poIdentityInsert];
  FSrcConnection := TFDConnection.Create(nil);
  FDestConnection := TFDConnection.Create(nil);
end;

{-------------------------------------------------------------------------------}
destructor TFDCopyScriptCommand.Destroy;
begin
  FDFreeAndNil(FBatchMove);
  FDFreeAndNil(FSrcConnection);
  FDFreeAndNil(FDestConnection);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TFDCopyScriptCommand.Dump: String;
begin
  Result := '';
                                                             
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
class function TFDCopyScriptCommand.Help: String;
begin
  Result := 'COPY FROM (FILE ''<file>'' | TABle ''<table name>'' [CONnect ''<connection>''])'#13#10 +
            '     TO   (FILE ''<file>'' | TABle ''<table name>'' [CONnect ''<connection>''])'#13#10 +
            '     [TRUNCate | CLEar | ALWAYSinsert | APPend | UPDate | APPENDUPDate | DELete]'#13#10 +
            '     [LOG  (OFF | (SPOol|OUTput) | ([APPend] <log file name>)]'#13#10 +
            '     [USING FILE ''config file'' | PARAMS ''<definition>''] - move data between databases or text files';
end;

{-------------------------------------------------------------------------------}
class procedure TFDCopyScriptCommand.Keywords(AKwds: TStrings);
begin
  AKwds.Add('COPY');
end;

{-------------------------------------------------------------------------------}
function TFDCopyScriptCommand.Parse(const AKwd: String): Boolean;
var
  iPrevBmk, iPrevBmk2: Integer;
  ucS: String;
begin
  // Source
  ucS := Parser.GetUCWord;
  if ucS <> 'FROM' then
    Parser.InvalidSyntax;
  ucS := Parser.GetUCWord;
  if ucS = 'FILE' then begin
    FBatchMove.Reader := TFDBatchMoveTextReader.Create(FBatchMove);
    TFDBatchMoveTextReader(FBatchMove.Reader).FileName := Parser.GetString();
  end
  else if FDKeyWordMatch(ucS, 'TABLE', 3) then begin
    FBatchMove.Reader := TFDBatchMoveSQLReader.Create(FBatchMove);
    TFDBatchMoveSQLReader(FBatchMove.Reader).TableName := Parser.GetString();
    iPrevBmk := Parser.GetBookmark;
    ucS := Parser.GetUCWord;
    if FDKeyWordMatch(ucS, 'CONNECT', 3) then begin
      TFDBatchMoveSQLReader(FBatchMove.Reader).Connection := FSrcConnection;
      FSrcConnStr := Parser.GetString();
    end
    else
      Parser.SetBookmark(iPrevBmk);
  end;

  // Destination
  ucS := Parser.GetUCWord;
  if ucS <> 'TO' then
    Parser.InvalidSyntax;
  ucS := Parser.GetUCWord;
  if ucS = 'FILE' then begin
    FBatchMove.Writer := TFDBatchMoveTextWriter.Create(FBatchMove);
    TFDBatchMoveTextWriter(FBatchMove.Writer).FileName := Parser.GetString();
  end
  else if FDKeyWordMatch(ucS, 'TABLE', 3) then begin
    FBatchMove.Writer := TFDBatchMoveSQLWriter.Create(FBatchMove);
    TFDBatchMoveSQLWriter(FBatchMove.Writer).TableName := Parser.GetString();
    iPrevBmk := Parser.GetBookmark;
    ucS := Parser.GetUCWord;
    if FDKeyWordMatch(ucS, 'CONNECT', 3) then begin
      TFDBatchMoveSQLWriter(FBatchMove.Writer).Connection := FDestConnection;
      FDestConnStr := Parser.GetString();
    end
    else
      Parser.SetBookmark(iPrevBmk);
  end;

  // Mode
  iPrevBmk := Parser.GetBookmark;
  ucS := Parser.GetUCWord;
  if FDKeyWordMatch(ucS, 'CLEAR', 3) then begin
    FBatchMove.Options := FBatchMove.Options + [poClearDest];
    FBatchMove.Mode := dmAlwaysInsert;
  end
  else if FDKeyWordMatch(ucS, 'TRUNCATE', 5) then begin
    FBatchMove.Options := FBatchMove.Options + [poClearDest, poClearDestNoUndo];
    FBatchMove.Mode := dmAlwaysInsert;
  end
  else if FDKeyWordMatch(ucS, 'ALWAYSINSERT', 6) then
    FBatchMove.Mode := dmAlwaysInsert
  else if FDKeyWordMatch(ucS, 'APPEND', 3) then
    FBatchMove.Mode := dmAppend
  else if FDKeyWordMatch(ucS, 'UPDATE', 3) then
    FBatchMove.Mode := dmUpdate
  else if FDKeyWordMatch(ucS, 'APPENDUPDATE', 9) then
    FBatchMove.Mode := dmAppendUpdate
  else if FDKeyWordMatch(ucS, 'DELETE', 3) then
    FBatchMove.Mode := dmDelete
  else begin
    FBatchMove.Options := FBatchMove.Options + [poClearDest, poClearDestNoUndo];
    FBatchMove.Mode := dmAlwaysInsert;
    Parser.SetBookmark(iPrevBmk);
  end;

  // Log file
  iPrevBmk := Parser.GetBookmark;
  ucS := Parser.GetUCWord;
  if ucS = 'LOG' then begin
    iPrevBmk2 := Parser.GetBookmark;
    ucS := Parser.GetUCWord;
    if ucS = 'OFF' then
      FBatchMove.LogFileAction := laNone
    else if FDKeyWordMatch(ucS, 'SPOOL', 3) or FDKeyWordMatch(ucS, 'OUTPUT', 3) then begin
      FBatchMove.LogFileAction := laAppend;
      FLogToSpool := True;
    end
    else begin
      if FDKeyWordMatch(ucS, 'APPEND', 3) then
        FBatchMove.LogFileAction := laAppend
      else begin
        FBatchMove.LogFileAction := laCreate;
        Parser.SetBookmark(iPrevBmk2);
      end;
      FBatchMove.LogFileName := Parser.GetString();
    end;
  end
  else begin
    FBatchMove.LogFileAction := laNone;
    Parser.SetBookmark(iPrevBmk);
  end;

  // Config file
  iPrevBmk := Parser.GetBookmark;
  ucS := Parser.GetUCWord;
  if ucS = 'USING' then begin
    ucS := Parser.GetUCWord;
    if ucS = 'FILE' then
      FConfigFile := Parser.GetString()
    else if ucS = 'PARAMS' then
      FConfigParams := Parser.GetString()
    else
      Parser.InvalidSyntax;
  end
  else
    Parser.SetBookmark(iPrevBmk);
  Result := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDCopyScriptCommand.DumpServerOutput;
var
  i: Integer;
begin
  if not (EngineIntf.ConnectionIntf.Options.ResourceOptions as TFDTopResourceOptions).ServerOutput or
     (EngineIntf.ConnectionIntf.Messages = nil) or (EngineIntf.ConnectionIntf.Messages.ErrorCount = 0) then
    Exit;
  for i := 0 to EngineIntf.ConnectionIntf.Messages.ErrorCount - 1 do
    EngineIntf.ConPut(EngineIntf.ConnectionIntf.Messages[i].Message, soServerOutput);
  EngineIntf.ConPut('', soSeparator);
end;

{-------------------------------------------------------------------------------}
procedure TFDCopyScriptCommand.Execute;
var
  oStr: TStream;
  sFeedback: String;
  dwStartTime: LongWord;
  dwExecTime: LongWord;

  procedure SetupSQLDriver(ADriver: TFDBatchMoveSQLDriver;
    AConnection: TFDConnection; const AConnStr: String);
  begin
    if ADriver.Connection = nil then begin
      ADriver.Connection := Engine.Connection;
      ADriver.Transaction := Engine.Transaction;
    end;
    ADriver.TableName := EngineIntf.ExpandString(Trim(ADriver.TableName));
    if AConnStr <> '' then begin
      AConnection.Close;
      AConnection.ResultConnectionDef.Params.Clear;
      AConnection.ResultConnectionDef.ParseString(EngineIntf.ExpandString(AConnStr));
      AConnection.LoginPrompt := False;
      AConnection.Close;
    end;
  end;

  procedure SetupTextDriver(ADriver: TFDBatchMoveTextDriver; AReader: Boolean);
  var
    s: String;
    oDef: TFDTextDataDef;

    function DefineFileName(const ADir, AFile, AExt: String): String;
    begin
      Result := AFile;
      if (ExtractFilePath(Result) = '') and (ADir <> '') then
        Result := FDNormPath(ADir) + Result;
      if (ExtractFileExt(Result) = '') and (AExt <> '') then
        Result := Result + '.' + AExt;
      Result := EngineIntf.ExpandString(Result);
    end;

  begin
    s := EngineIntf.ExpandString(ADriver.FileName);
    if AReader then begin
      if not FileExists(s) then begin
        s := DefineFileName(Engine.ScriptOptions.DefaultDataPath, s, 'csv');
        if not FileExists(s) then
          s := DefineFileName(Engine.ScriptOptions.DefaultDataPath, s, 'txt');
      end;
    end
    else
      s := DefineFileName(Engine.ScriptOptions.DefaultDataPath, s, 'txt');
    ADriver.FileName := s;
    oDef := ADriver.DataDef;
    oDef.RecordFormat := rfSemicolonDoubleQuote;
    oDef.WithFieldNames := True;
    oDef.FormatSettings.DecimalSeparator := '.';
    oDef.FormatSettings.DateSeparator := '-';
    oDef.FormatSettings.TimeSeparator := ':';
    oDef.FormatSettings.ShortDateFormat := 'yyyy/mm/dd';
    oDef.FormatSettings.ShortTimeFormat := 'hh:mm:ss';
  end;

begin
  if FBatchMove.Reader is TFDBatchMoveSQLDriver then
    SetupSQLDriver(TFDBatchMoveSQLDriver(FBatchMove.Reader), FSrcConnection, FSrcConnStr)
  else if FBatchMove.Reader is TFDBatchMoveTextDriver then
    SetupTextDriver(TFDBatchMoveTextDriver(FBatchMove.Reader), True);

  if FBatchMove.Writer is TFDBatchMoveSQLDriver then
    SetupSQLDriver(TFDBatchMoveSQLDriver(FBatchMove.Writer), FDestConnection, FDestConnStr)
  else if FBatchMove.Writer is TFDBatchMoveTextDriver then
    SetupTextDriver(TFDBatchMoveTextDriver(FBatchMove.Writer), False);

  if FConfigFile <> '' then begin
    oStr := TBufferedFileStream.Create(EngineIntf.ExpandString(FConfigFile),
      fmOpenRead or fmShareDenyWrite);
    try
      oStr.ReadComponent(FBatchMove);
    finally
      FDFree(oStr);
    end;
  end
  else if FConfigParams <> '' then begin
    oStr := TStringStream.Create(EngineIntf.ExpandString(FConfigParams));
    try
      oStr.ReadComponent(FBatchMove);
    finally
      FDFree(oStr);
    end;
  end;

  if Engine.ScriptOptions.CommitEachNCommands > 0 then
    FBatchMove.CommitCount := Engine.ScriptOptions.CommitEachNCommands
  else
    FBatchMove.CommitCount := 100;
  if Engine.ScriptOptions.BreakOnError then
    FBatchMove.MaxErrors := 0
  else
    FBatchMove.MaxErrors := -1;
  FBatchMove.LogFileName := EngineIntf.ExpandString(FBatchMove.LogFileName);

  if FLogToSpool then
    if Engine.ScriptOptions.SpoolOutput <> smNone then begin
      FBatchMove.LogFileName := EngineIntf.ExpandString(Engine.LastSpoolFileName);
      Engine.ScriptOptions.SpoolOutput := smOnAppend;
      EngineIntf.CloseSpool;
    end
    else
      FBatchMove.LogFileAction := laNone;

  if Engine.ScriptOptions.FeedbackCommands then begin
    sFeedback := '';
    case FBatchMove.Mode of
    dmAlwaysInsert: sFeedback := 'Insert data into';
    dmAppend:       sFeedback := 'Append data into';
    dmUpdate:       sFeedback := 'Update data in';
    dmAppendUpdate: sFeedback := 'Append or update data in';
    dmDelete:       sFeedback := 'Delete data in';
    end;
    if FBatchMove.Writer is TFDBatchMoveTextDriver then
      sFeedback := sFeedback + ' file ' + TFDBatchMoveTextDriver(FBatchMove.Writer).FileName
    else if FBatchMove.Writer is TFDBatchMoveSQLDriver then
      sFeedback := sFeedback + ' table ' + TFDBatchMoveSQLDriver(FBatchMove.Writer).ActualTableName;
    sFeedback := sFeedback + ' from ';
    if FBatchMove.Reader is TFDBatchMoveTextDriver then
      sFeedback := sFeedback + ' file ' + TFDBatchMoveTextDriver(FBatchMove.Reader).FileName
    else if FBatchMove.Reader is TFDBatchMoveSQLDriver then
      sFeedback := sFeedback + ' table ' + TFDBatchMoveSQLDriver(FBatchMove.Reader).ActualTableName;
    sFeedback := sFeedback + ' ...';
    EngineIntf.ConPut(sFeedback, soCommand);
  end;

  try
    dwStartTime := TThread.GetTickCount();
    FBatchMove.Execute;
    dwExecTime := TThread.GetTickCount() - dwStartTime;
  finally
    if (EngineIntf.ConnectionIntf.Options.ResourceOptions as TFDTopResourceOptions).ServerOutput then
      DumpServerOutput;

    if FLogToSpool then
      if Engine.ScriptOptions.SpoolOutput <> smNone then
        EngineIntf.UpdateSpool;
  end;

  if Engine.ScriptOptions.FeedbackCommands then begin
    sFeedback := Format('Rows read: %d. Rows written: %d (inserted: %d, updated: %d, deleted: %d)'#13#10,
      [FBatchMove.ReadCount, FBatchMove.WriteCount, FBatchMove.InsertCount,
       FBatchMove.UpdateCount, FBatchMove.DeleteCount]);
    if FBatchMove.ErrorCount = 0 then
      sFeedback := sFeedback + 'Ok'
    else
      sFeedback := sFeedback + Format('Errors: %d', [FBatchMove.ErrorCount]);
    if Engine.ScriptOptions.Timing then
      sFeedback := sFeedback + Format(' [%.2d:%.2d:%.2d.%.3d]', [
        (dwExecTime div 3600000) mod 60, (dwExecTime div 60000) mod 60,
        (dwExecTime div 1000) mod 60, dwExecTime mod 1000]);
    sFeedback := sFeedback + '.';
    EngineIntf.ConPut(sFeedback, soCommand);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDCopyScriptCommand.AbortJob(const AWait: Boolean);
begin
  FBatchMove.AbortJob;
end;

{-------------------------------------------------------------------------------}
{ TFDDelimiterScriptCommand                                                     }
{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TFDDelimiterScriptCommand.Dump: String;
begin
  Result := '<delimiter> [' + FCmdSep + ']';
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
class function TFDDelimiterScriptCommand.Help: String;
begin
  Result := 'DELIMiter <text> - sets script command delimiter';
end;

{-------------------------------------------------------------------------------}
class procedure TFDDelimiterScriptCommand.Keywords(AKwds: TStrings);
begin
  AKwds.Add('DELIMiter')
end;

{-------------------------------------------------------------------------------}
function TFDDelimiterScriptCommand.Parse(const AKwd: String): Boolean;
begin
  FCmdSep := Parser.GetStringInFull;
  Result := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDDelimiterScriptCommand.Execute();
begin
  Parser.ScriptOptions.CommandSeparator := FCmdSep;
  EngineIntf.UpdateCommandSeparator;
end;

{-------------------------------------------------------------------------------}
procedure TFDDelimiterScriptCommand.Validate();
begin
  Execute();
end;

{-------------------------------------------------------------------------------}
{ TFDIBCreateDBScriptCommand                                                    }
{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TFDIBCreateDBScriptCommand.Dump: String;
begin
  Result := '<create IB database> [' + FDB + ']';
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
class procedure TFDIBCreateDBScriptCommand.Keywords(AKwds: TStrings);
begin
  AKwds.Add('CREATE DATABASE');
end;

{-------------------------------------------------------------------------------}
function TFDIBCreateDBScriptCommand.Parse(const AKwd: String): Boolean;
var
  ucS: String;
begin
  if not (EngineIntf.RDBMSKind in [TFDRDBMSKinds.Interbase, TFDRDBMSKinds.Firebird]) then begin
    Result := False;
    Exit;
  end;
  Result := True;
  FDB := Parser.GetString(True);
  while True do begin
    Parser.SkipWSLF;
    ucS := Parser.GetUCWord;
    if ucS = '' then
      Break;
    if FDKeywordMatch(ucS, 'USER', 4) then
      FUser := Parser.GetString(True)
    else if FDKeywordMatch(ucS, 'PASSWORD', 8) then
      FPwd := Parser.GetString(True)
    else if FDKeywordMatch(ucS, 'PAGE_SIZE', 9) then
      FPageSize := Parser.GetString(True)
    else if FDKeywordMatch(ucS, 'DEFAULT', 7) then begin
      ucS := Parser.GetUCWord;
      if ucS = 'CHARACTER' then begin
        ucS := Parser.GetUCWord;
        if ucS = 'SET' then
          FCharset := Parser.GetString(True);
      end;
    end
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDIBCreateDBScriptCommand.Execute;
var
  oDef: IFDStanConnectionDef;
begin
  Engine.Connection.Close;
  oDef := Engine.Connection.ResultConnectionDef;
  oDef.AsString[S_FD_ConnParam_IB_OpenMode] := 'Create';
  oDef.Params.Database := EngineIntf.ExpandString(FDB);
  oDef.Params.UserName := EngineIntf.ExpandString(FUser);
  oDef.Params.Password := EngineIntf.ExpandString(FPwd);
  oDef.AsString[S_FD_ConnParam_IB_PageSize] := EngineIntf.ExpandString(FPageSize);
  EngineIntf.OpenConnection('');
  EngineIntf.ConPut('Database created', soCommand);
end;

{-------------------------------------------------------------------------------}
{ TFDIBDropDBScriptCommand                                                      }
{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TFDIBDropDBScriptCommand.Dump: String;
begin
  Result := '<drop IB database>';
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
class procedure TFDIBDropDBScriptCommand.Keywords(AKwds: TStrings);
begin
  AKwds.Add('DROP DATABASE');
end;

{-------------------------------------------------------------------------------}
function TFDIBDropDBScriptCommand.Parse(const AKwd: String): Boolean;
begin
  Result := EngineIntf.RDBMSKind in [TFDRDBMSKinds.Interbase, TFDRDBMSKinds.Firebird];
end;

{-------------------------------------------------------------------------------}
procedure TFDIBDropDBScriptCommand.Execute;
var
  prevChanging: TNotifyEvent;
  oDef: IFDStanConnectionDef;
begin
  oDef := Engine.Connection.ResultConnectionDef;
  prevChanging := oDef.OnChanging;
  oDef.OnChanging := nil;
  try
    oDef.AsYesNo[S_FD_ConnParam_IB_DropDatabase] := True;
    Engine.Connection.Close;
  finally
    oDef.AsYesNo[S_FD_ConnParam_IB_DropDatabase] := False;
    oDef.OnChanging := prevChanging;
  end;
  EngineIntf.ConPut('Database droped', soCommand);
end;

{-------------------------------------------------------------------------------}
initialization
  FDScriptCommandRegistry().DefaultSQLCommandClass := TFDSQLScriptCommand;
  FDScriptCommandRegistry().DefaultPLSQLCommandClass := TFDPLSQLScriptCommand;

  FDScriptCommandRegistry().AddCommand(TFDRunScriptCommand);
  FDScriptCommandRegistry().AddCommand(TFDAcceptScriptCommand);
  FDScriptCommandRegistry().AddCommand(TFDConnectScriptCommand);
  FDScriptCommandRegistry().AddCommand(TFDCopyScriptCommand);
  FDScriptCommandRegistry().AddCommand(TFDDefineScriptCommand);
  FDScriptCommandRegistry().AddCommand(TFDDelimiterScriptCommand);
  FDScriptCommandRegistry().AddCommand(TFDDisconnectScriptCommand);
  FDScriptCommandRegistry().AddCommand(TFDExecuteScriptCommand);
  FDScriptCommandRegistry().AddCommand(TFDExitScriptCommand);
  FDScriptCommandRegistry().AddCommand(TFDHelpScriptCommand);
  FDScriptCommandRegistry().AddCommand(TFDHostScriptCommand);
  FDScriptCommandRegistry().AddCommand(TFDPauseScriptCommand);
  FDScriptCommandRegistry().AddCommand(TFDPromptScriptCommand);
  FDScriptCommandRegistry().AddCommand(TFDPrintScriptCommand);
  FDScriptCommandRegistry().AddCommand(TFDRemarkScriptCommand);
  FDScriptCommandRegistry().AddCommand(TFDSetScriptCommand);
  FDScriptCommandRegistry().AddCommand(TFDSpoolScriptCommand);
  FDScriptCommandRegistry().AddCommand(TFDUndefineScriptCommand);
  FDScriptCommandRegistry().AddCommand(TFDVariableScriptCommand);
  FDScriptCommandRegistry().AddCommand(TFDIBCreateDBScriptCommand);
  FDScriptCommandRegistry().AddCommand(TFDIBDropDBScriptCommand);

end.
