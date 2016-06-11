{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{         FireDAC expression evaluation engine          }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$HPPEMIT LINKUNIT}

unit FireDAC.Stan.Expr;

interface

uses
  System.Classes,
  FireDAC.Stan.Intf;

const
  C_FD_FAny = Char('*');
  C_FD_FAnsi = Char('a');
  C_FD_FUni = Char('u');
  C_FD_FStr = Char('s');
  C_FD_FDate = Char('d');
  C_FD_FInt = Char('i');
  C_FD_FFloat = Char('f');
  C_FD_FNum = Char('n');

type
  TFDExpressionFunction = function (const AArgs: array of Variant): Variant;
  TFDExpressionFieldFunction = function (const AArgs: array of Variant;
    AExpr: IFDStanExpressionEvaluator): Variant;
  TFDExpressionFunctionDesc = class (TObject)
  private
    FName: String;
    FScopeKind: TFDExpressionScopeKind;
    FScopeKindArg: Integer;
    FDataType: TFDDataType;
    FDataTypeArg: Integer;
    FArgMin: Integer;
    FArgMax: Integer;
    FArgTypeFamiles: String;
    FCall: Pointer;
  public
    property Name: String read FName;
    property ScopeKind: TFDExpressionScopeKind read FScopeKind;
    property ScopeKindArg: Integer read FScopeKindArg;
    property DataType: TFDDataType read FDataType;
    property DataTypeArg: Integer read FDataTypeArg;
    property ArgMin: Integer read FArgMin;
    property ArgMax: Integer read FArgMax;
    property ArgTypeFamiles: String read FArgTypeFamiles;
    property Call: Pointer read FCall;
  end;

  TFDExpressionCompare = function (AStr1: Pointer; ALen1: Integer;
    AStr2: Pointer; ALen2: Integer; ANoCase: Boolean): Integer;
  TFDExpressionCollation = class
  private
    FName: String;
    FCalls: array [ecUTF8 .. ecANSI] of TFDExpressionCompare;
    function GetCall(AEncoding: TFDEncoding): TFDExpressionCompare;
  public
    property Name: String read FName;
    property Calls[AEncoding: TFDEncoding]: TFDExpressionCompare read GetCall;
  end;

  TFDExpressionManager = class(TObject)
  private
    FFunctions: TStringList;
    FCollations: TStringList;
    function GetFunctionCount: Integer;
    function GetFunctions(AIndex: Integer): TFDExpressionFunctionDesc;
    function GetCollationCount: Integer;
    function GetCollations(AIndex: Integer): TFDExpressionCollation;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddSynonym(const AName, ASynonym: String);
    procedure AddFunction(const AName: String; AScopeKind: TFDExpressionScopeKind;
      AScopeKindArg: Integer; ADataType: TFDDataType; ADataTypeArg: Integer;
      AArgMin: Integer; AArgMax: Integer; const AArgTypeFamiles: String; ACall: Pointer);
    procedure RemoveFunction(const AName: String);
    procedure AddCollation(const AName: String; AEncoding: TFDEncoding;
      ACall: TFDExpressionCompare);
    procedure RemoveCollation(const AName: String; AEncoding: TFDEncoding);
    function FindFunction(const AName: String): Integer;
    function FindCollation(const AName: String; AEncoding: TFDEncoding): Integer;
    property FunctionCount: Integer read GetFunctionCount;
    property Functions[AIndex: Integer]: TFDExpressionFunctionDesc read GetFunctions;
    property CollationCount: Integer read GetCollationCount;
    property Collations[AIndex: Integer]: TFDExpressionCollation read GetCollations;
  end;

  function FDStrIsNull(const V: Variant): Boolean;
  function FDStrToVar(const S: String): Variant;
  function FDExpressionManager(): TFDExpressionManager;

{-------------------------------------------------------------------------------}
implementation

uses
{$IFDEF MSWINDOWS}
  // Preventing from "Inline has not expanded"
  Winapi.Windows,
{$ENDIF}
  System.SysUtils, System.Variants,
  FireDAC.Stan.Util, FireDAC.Stan.Error, FireDAC.Stan.Consts, FireDAC.Stan.Factory;

type
  TFDExpressionToken = (etEnd, etSymbol, etName, etLiteral,  etLParen, etRParen,
    etLCBracket, etRCBracket, etEQ, etNE, etGE, etLE, etGT, etLT, etCONCAT, etADD,
    etSUB, etMUL, etDIV, etComma, etLIKE, etISNULL, etISNOTNULL, etIN, etNOTIN,
    etANY, etSOME, etALL, etNOTLIKE, etBETWEEN, etNOTBETWEEN, etNULL);

  TFDExpressionOperator = (canNOTDEFINED, canASSIGN, canOR, canAND, canNOT,
    canEQ, canNE, canGE, canLE, canGT, canLT, canLIKE, canISBLANK, canNOTBLANK,
    canIN, canCONCAT, canADD, canSUB, canMUL, canDIV, canNOTIN, canANY,
    canALL, canNOTLIKE, canBETWEEN, canNOTBETWEEN);

  TFDExpressionNodeKind = (enUnknown, enField, enConst, enOperator, enFunc);

  PFDExpressionNode = ^TFDExpressionNode;
  TFDExpressionNode = record
    FNext: PFDExpressionNode;
    FLeft: PFDExpressionNode;
    FRight: PFDExpressionNode;
    FDataType: TFDDataType;
    FScopeKind: TFDExpressionScopeKind;
    FKind: TFDExpressionNodeKind;
    FOperator: TFDExpressionOperator;
    FData: Variant;
    FFuncInd: Integer;
    FFuncArgs: array of Variant;
    FColumnInd: Integer;
    FArgs: array of PFDExpressionNode;
    FPartial: Boolean;
  end;

  TFDExpression = class(TInterfacedObject, IFDStanExpressionEvaluator)
  private
    FRoot, FNodes: PFDExpressionNode;
    FSubAggregates: array of PFDExpressionNode;
    FDataSource: IFDStanExpressionDataSource;
    FOptions: TFDExpressionOptions;
    function NewNode(AKind: TFDExpressionNodeKind; AOperator: TFDExpressionOperator;
      const AData: Variant; ALeft, ARight: PFDExpressionNode;
      AFuncInd: Integer): PFDExpressionNode;
    procedure ClearNodes;
    function InternalEvaluate(ANode: PFDExpressionNode): Variant;
  protected
    // IFDStanExpressionEvaluator
    function HandleNotification(AKind, AReason: Word; AParam1, AParam2: NativeInt): Boolean;
    function Evaluate: Variant;
    function GetSubAggregateCount: Integer;
    function GetSubAggregateKind(AIndex: Integer): TFDAggregateKind;
    function EvaluateSubAggregateArg(AIndex: Integer): Variant;
    function GetDataSource: IFDStanExpressionDataSource;
    function GetDataType: TFDDataType;
  public
    constructor Create(AOptions: TFDExpressionOptions;
      const ADataSource: IFDStanExpressionDataSource);
{$IFDEF FireDAC_DEBUG}
    procedure Dump(AStrs: TStrings);
{$ENDIF}
    destructor Destroy; override;
  end;

  TFDExprParserBmk = record
    FSourcePtr: PChar;
    FToken: TFDExpressionToken;
    FTokenString: String;
    FCurPtr: PChar;
  end;

  TFDExpressionParser = class(TFDObject, IFDStanExpressionParser)
  private
    FExpression: TFDExpression;
    FText: String;
    FSourcePtr: PChar;
    FTokenPtr: PChar;
    FTokenString: String;
    FUCTokenString: String;
    FToken: TFDExpressionToken;
    FLiteralType: TFDDataType;
    FLiteralValue: Variant;
    FParserOptions: TFDParserOptions;
    FDataSource: IFDStanExpressionDataSource;
    FFixedColumnName: String;
    class function IsBLOB(DataType: TFDDataType): Boolean; static;
    class function IsBoolean(DataType: TFDDataType): Boolean; static;
    class function IsNumeric(DataType: TFDDataType): Boolean; static;
    class function IsString(DataType: TFDDataType): Boolean; static;
    class function IsTemporal(DataType: TFDDataType): Boolean; static;
    procedure NextToken;
    function ParseExpr: PFDExpressionNode;
    function ParseExpr2: PFDExpressionNode;
    function ParseExpr3: PFDExpressionNode;
    function ParseExpr4: PFDExpressionNode;
    function ParseExpr5(AEnableList: Boolean): PFDExpressionNode;
    function ParseExpr6: PFDExpressionNode;
    function ParseExpr7: PFDExpressionNode;
    function TokenName: String;
    function TokenSymbolIs(const S: String): Boolean;
    function TokenSymbolPartialIs(const S: String): Boolean;
    function TokenSymbolIsFunc(const S: String): Integer;
    procedure GetFuncResultInfo(Node: PFDExpressionNode);
    procedure TypeCheckArithOp(Node: PFDExpressionNode);
    procedure GetScopeKind(Root, Left, Right : PFDExpressionNode);
    procedure SaveState(out ABmk: TFDExprParserBmk; ACurPtr: PChar);
    procedure RestoreState(const ABmk: TFDExprParserBmk; out ACurPtr: PChar);
    procedure FixupFieldNode(ANode: PFDExpressionNode; const AColumnName: String);
  protected
    // IFDStanExpressionParser
    function Prepare(const ADataSource: IFDStanExpressionDataSource;
      const AExpression: String; AOptions: TFDExpressionOptions;
      AParserOptions: TFDParserOptions; const AFixedColumnName: String): IFDStanExpressionEvaluator;
    function GetDataSource: IFDStanExpressionDataSource;
  end;

var
  rDateTimeFS: TFormatSettings;

{-------------------------------------------------------------------------------}
{ Standard functions                                                            }
{-------------------------------------------------------------------------------}
function FDStrIsNull(const V: Variant): Boolean;
var
  tp: Integer;
begin
  tp := (VarType(V) and varTypeMask);
  Result := (tp = varEmpty) or (tp = varNull) or
    ((tp = varUString) or (tp = varString) or (tp = varOleStr)) and (V = '');
end;

{-------------------------------------------------------------------------------}
function FDStrToVar(const S: String): Variant;
begin
  if S = '' then
    Result := Null
  else
    Result := S;
end;

{-------------------------------------------------------------------------------}
function FunLike(const AStr, AMask: Variant; ANoCase: Boolean;
  AManyCharsMask, AOneCharMask, AEscapeChar: Char): Variant;
begin
  if VarIsNull(AStr) or VarIsNull(AMask) then
    Result := False
  else
    Result := FDStrLike(AStr, AMask, ANoCase, AManyCharsMask, AOneCharMask, AEscapeChar);
end;

{-------------------------------------------------------------------------------}
function FunUpper(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else
    Result := AnsiUpperCase(AArgs[0]);
end;

{-------------------------------------------------------------------------------}
function FunLower(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else
    Result := AnsiLowerCase(AArgs[0]);
end;

{-------------------------------------------------------------------------------}
function FunSubstring(const AArgs: array of Variant): Variant;
var
  s: String;
  ind, cnt: Integer;
begin
  if FDStrIsNull(AArgs[0]) or FDStrIsNull(AArgs[1]) then
    Result := Null
  else begin
    s := AArgs[0];
    ind := AArgs[1];
    if ind < 0 then
      ind := Length(s) + ind + 1;
    if Length(AArgs) = 2 then
      cnt := Length(s)
    else if FDStrIsNull(AArgs[2]) or (AArgs[2] <= 0) then begin
      Result := Null;
      Exit;
    end
    else
      cnt := AArgs[2];
    Result := FDStrToVar(Copy(s, ind, cnt));
  end;
end;

{-------------------------------------------------------------------------------}
type
  TFDTrimMode = set of (tmLeft, tmRight);

function InternalTrim(const AArgs: array of Variant; AMode: TFDTrimMode): Variant;
var
  I, L: Integer;
  sWhere, sWhat: String;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else begin
    sWhere := AArgs[0];
    if Length(AArgs) = 2 then begin
      if FDStrIsNull(AArgs[1]) then begin
        Result := Null;
        Exit;
      end
      else
        sWhat := AArgs[1];
    end
    else
      sWhat := ' ';
    L := Length(sWhere);
    I := 1;
    if tmLeft in AMode then
      while (I <= L) and (StrScan(PChar(sWhat), sWhere[I]) <> nil) do
        Inc(I);
    if I > L then
      sWhere := ''
    else begin
      if tmRight in AMode then
        while (L >= I) and (StrScan(PChar(sWhat), sWhere[L]) <> nil) do
          Dec(L);
      sWhere := Copy(sWhere, I, L - I + 1);
    end;
    Result := FDStrToVar(sWhere);
  end;
end;

{-------------------------------------------------------------------------------}
function FunTrim(const AArgs: array of Variant): Variant;
begin
  Result := InternalTrim(AArgs, [tmLeft, tmRight]);
end;

{-------------------------------------------------------------------------------}
function FunTrimLeft(const AArgs: array of Variant): Variant;
begin
  Result := InternalTrim(AArgs, [tmLeft]);
end;

{-------------------------------------------------------------------------------}
function FunTrimRight(const AArgs: array of Variant): Variant;
begin
  Result := InternalTrim(AArgs, [tmRight]);
end;

{-------------------------------------------------------------------------------}
function FunYear(const AArgs: array of Variant): Variant;
var
  Y, M, D: Word;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else begin
    Y := 0;
    M := 0;
    D := 0;
    DecodeDate(AArgs[0], Y, M, D);
    Result := Y;
  end;
end;

{-------------------------------------------------------------------------------}
function FunMonth(const AArgs: array of Variant): Variant;
var
  Y, M, D: Word;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else begin
    Y := 0;
    M := 0;
    D := 0;
    DecodeDate(AArgs[0], Y, M, D);
    Result := M;
  end;
end;

{-------------------------------------------------------------------------------}
function FunDay(const AArgs: array of Variant): Variant;
var
  Y, M, D: Word;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else begin
    Y := 0;
    M := 0;
    D := 0;
    DecodeDate(AArgs[0], Y, M, D);
    Result := D;
  end;
end;

{-------------------------------------------------------------------------------}
function FunHour(const AArgs: array of Variant): Variant;
var
  H, M, S, MS: Word;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else begin
    H := 0;
    M := 0;
    S := 0;
    MS := 0;
    DecodeTime(AArgs[0], H, M, S, MS);
    Result := H;
  end;
end;

{-------------------------------------------------------------------------------}
function FunMinute(const AArgs: array of Variant): Variant;
var
  H, M, S, MS: Word;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else begin
    H := 0;
    M := 0;
    S := 0;
    MS := 0;
    DecodeTime(AArgs[0], H, M, S, MS);
    Result := M;
  end;
end;

{-------------------------------------------------------------------------------}
function FunSecond(const AArgs: array of Variant): Variant;
var
  H, M, S, MS: Word;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else begin
    H := 0;
    M := 0;
    S := 0;
    MS := 0;
    DecodeTime(AArgs[0], H, M, S, MS);
    Result := S;
  end;
end;

{-------------------------------------------------------------------------------}
function FunGetDate(const AArgs: array of Variant): Variant;
begin
  Result := Now;
end;

{-------------------------------------------------------------------------------}
function FunDate(const AArgs: array of Variant): Variant;
var
  d: Double;
  V: Variant;
  tp: Integer;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else begin
    V := AArgs[0];
    tp := VarType(V);
    if (tp = varString) or (tp = varOleStr) or (tp = varUString) then
      Result := StrToDate(V)
    else begin
      d := Trunc(Double(V));
      Result := TDateTime(d);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function FunTime(const AArgs: array of Variant): Variant;
var
  dt: TDateTime;
  V: Variant;
  tp: Integer;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else begin
    V := AArgs[0];
    tp := VarType(V);
    if (tp = varString) or (tp = varOleStr) or (tp = varUString) then
      Result := StrToTime(V)
    else begin
      dt := V;
      Result := dt - Trunc(dt);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function FunCmpFileName(const AArgs: array of Variant): Variant;
var
  sName1, sName2, sFile1, sFile2, sExt1, sExt2: String;
begin
  if FDStrIsNull(AArgs[0]) or FDStrIsNull(AArgs[1]) then
    Result := False
  else begin
    sName1 := AArgs[0];
    sName2 := AArgs[1];
    sFile1 := FDExtractFileNameNoPath(sName1);
    sFile2 := FDExtractFileNameNoPath(sName2);
    sExt1 := ExtractFileExt(sName1);
    sExt2 := ExtractFileExt(sName2);
    Result := (CompareText(sFile1, sFile2) = 0) and
      ((sExt1 = '') or (CompareText(sExt1, sExt2) = 0));
  end;
end;

{-------------------------------------------------------------------------------}
function FunCmpFilePath(const AArgs: array of Variant): Variant;
var
  sPath1, sPath2: String;
begin
  if FDStrIsNull(AArgs[0]) or FDStrIsNull(AArgs[1]) then
    Result := False
  else begin
    sPath1 := FDNormPath(AArgs[0]);
    sPath2 := FDNormPath(AArgs[1]);
    Result := (sPath1 = '') or (CompareText(sPath1, sPath2) = 0);
  end;
end;

{-------------------------------------------------------------------------------}
function FunAggSum(const AArgs: array of Variant): Variant;
begin
  Result := akSum;
end;

{-------------------------------------------------------------------------------}
function FunAggAvg(const AArgs: array of Variant): Variant;
begin
  Result := akAvg;
end;

{-------------------------------------------------------------------------------}
function FunAggCount(const AArgs: array of Variant): Variant;
begin
  Result := akCount;
end;

{-------------------------------------------------------------------------------}
function FunAggMin(const AArgs: array of Variant): Variant;
begin
  Result := akMin;
end;

{-------------------------------------------------------------------------------}
function FunAggMax(const AArgs: array of Variant): Variant;
begin
  Result := akMax;
end;

{-------------------------------------------------------------------------------}
function FunAggFirst(const AArgs: array of Variant): Variant;
begin
  Result := akFirst;
end;

{-------------------------------------------------------------------------------}
function FunAggLast(const AArgs: array of Variant): Variant;
begin
  Result := akLast;
end;

{-------------------------------------------------------------------------------}
function FunIIF(const AArgs: array of Variant): Variant;
begin
  // it is handled internally by evaluator
  Result := Unassigned;
  ASSERT(False);
end;

{-------------------------------------------------------------------------------}
{ TFDExpression                                                                 }
{-------------------------------------------------------------------------------}
constructor TFDExpression.Create(AOptions: TFDExpressionOptions;
  const ADataSource: IFDStanExpressionDataSource);
begin
  inherited Create;
  FOptions := AOptions;
  FDataSource := ADataSource;
  FSubAggregates := nil;
end;

{-------------------------------------------------------------------------------}
destructor TFDExpression.Destroy;
begin
  ClearNodes;
  FSubAggregates := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDExpression.GetSubAggregateCount: Integer;
begin
  Result := Length(FSubAggregates);
end;

{-------------------------------------------------------------------------------}
function TFDExpression.GetSubAggregateKind(AIndex: Integer): TFDAggregateKind;
var
  pNode: PFDExpressionNode;
  pFunc: TFDExpressionFunctionDesc;
begin
  pNode := FSubAggregates[AIndex];
  pFunc := FDExpressionManager().Functions[pNode^.FFuncInd];
  Result := TFDExpressionFunction(pFunc.FCall)([]);
end;

{-------------------------------------------------------------------------------}
function TFDExpression.HandleNotification(AKind, AReason: Word; AParam1, AParam2: NativeInt): Boolean;
begin
                                                                                  
  Result := False;
end;

{-------------------------------------------------------------------------------}
function TFDExpression.GetDataSource: IFDStanExpressionDataSource;
begin
  Result := FDataSource;
end;

{-------------------------------------------------------------------------------}
function TFDExpression.GetDataType: TFDDataType;
begin
  Result := FRoot^.FDataType;
end;

{-------------------------------------------------------------------------------}
function TFDExpression.NewNode(AKind: TFDExpressionNodeKind;
  AOperator: TFDExpressionOperator; const AData: Variant;
  ALeft, ARight: PFDExpressionNode; AFuncInd: Integer): PFDExpressionNode;
begin
  New(Result);
  Result^.FNext := FNodes;
  Result^.FKind := AKind;
  Result^.FOperator := AOperator;
  Result^.FData := AData;
  Result^.FLeft := ALeft;
  Result^.FRight := ARight;
  SetLength(Result^.FArgs, 0);
  Result^.FDataType := dtUnknown;
  Result^.FScopeKind := ckUnknown;
  Result^.FFuncInd := AFuncInd;
  SetLength(Result^.FFuncArgs, 0);
  Result^.FColumnInd := -1;
  Result^.FPartial := False;
  if (AKind = enFunc) and (FDExpressionManager().Functions[AFuncInd].FScopeKind = ckAgg) then begin
    SetLength(FSubAggregates, Length(FSubAggregates) + 1);
    FSubAggregates[Length(FSubAggregates) - 1] := Result;
  end;
  FNodes := Result;
end;

{-------------------------------------------------------------------------------}
procedure TFDExpression.ClearNodes;
var
  Node: PFDExpressionNode;
begin
  FSubAggregates := nil;
  while FNodes <> nil do begin
    Node := FNodes;
    FNodes := Node^.FNext;
    Dispose(Node);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDExpression.InternalEvaluate(ANode: PFDExpressionNode): Variant;
var
  l, r: Variant;
  i: Integer;
  pR: PFDExpressionNode;
  esc: String;
  pFunc: TFDExpressionFunctionDesc;

  procedure EvalError(const AMsg: String);
  begin
    FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprEvalError, [AMsg]);
  end;

  function VarIsString(const V: Variant): Boolean;
  var
    tp: Integer;
  begin
    tp := VarType(V);
    Result := (tp = varString) or (tp = varOleStr) or (tp = varUString);
  end;

  procedure UpperCaseLR;
  begin
    if VarIsString(l) then
      l := AnsiUpperCase(l);
    if VarIsString(r) then
      r := AnsiUpperCase(r);
  end;

  function PartialEQ(AForce: Boolean): Boolean;
  var
    sL, sR: String;
    ln, lnL, lnR: Integer;
    partial: Boolean;
  begin
    if VarIsString(l) and VarIsString(r) then begin
      sL := l;
      sR := r;
      lnL := Length(sL);
      lnR := Length(sR);
      if l <> '' then begin
        partial := False;
        if sL[lnL] = '*' then begin
          partial := True;
          Dec(lnL);
        end;
        if r <> '' then begin
          if sR[lnR] = '*' then begin
            partial := True;
            Dec(lnR);
          end;
          if partial or AForce then begin
            ln := lnR;
            if ln > lnL then
              ln := lnL;
            if lnL < lnR then
              Result := False
            else if (ekNoCase in FOptions) then
              Result := ({$IFDEF FireDAC_NOLOCALE_DATA} StrLIComp {$ELSE} AnsiStrLIComp {$ENDIF}
                         (PChar(sL), PChar(sR), ln) = 0)
            else
              Result := ({$IFDEF FireDAC_NOLOCALE_DATA} StrLComp {$ELSE} AnsiStrLComp {$ENDIF}
                         (PChar(sL), PChar(sR), ln) = 0);
            Exit;
          end;
        end;
      end;
      if (ekNoCase in FOptions) then
        Result := ({$IFDEF FireDAC_NOLOCALE_DATA} CompareText {$ELSE} AnsiCompareText {$ENDIF}
                   (sL, sR) = 0)
      else
        Result := ({$IFDEF FireDAC_NOLOCALE_DATA} CompareStr {$ELSE} AnsiCompareStr {$ENDIF}
                   (sL, sR) = 0);
    end
    else begin
      UpperCaseLR;
      Result := l = r;
    end;
  end;

  function EvaluteNodeValue(ANode: PFDExpressionNode): Variant;
  begin
    if ANode^.FKind = enField then
      Result := FDataSource.VarData[ANode^.FColumnInd]
    else if ANode^.FKind = enConst then
      Result := ANode^.FData
    else
      Result := InternalEvaluate(ANode);
  end;

begin
  try
    case ANode^.FKind of
    enUnknown:
      ;
    enField:
      Result := FDataSource.VarData[ANode^.FColumnInd];
    enConst:
      Result := ANode^.FData;
    enOperator:
      case ANode^.FOperator of
      canNOTDEFINED:
        ;
      canASSIGN:
        FDataSource.VarData[ANode^.FRight^.FColumnInd] := EvaluteNodeValue(ANode^.FLeft);
      canOR:
        Result := Boolean(EvaluteNodeValue(ANode^.FLeft)) or Boolean(EvaluteNodeValue(ANode^.FRight));
      canAND:
        Result := Boolean(EvaluteNodeValue(ANode^.FLeft)) and Boolean(EvaluteNodeValue(ANode^.FRight));
      canNOT:
        Result := not Boolean(EvaluteNodeValue(ANode^.FLeft));
      canEQ, canNE, canGE, canLE, canGT, canLT:
        begin
          l := EvaluteNodeValue(ANode^.FLeft);
          pR := ANode^.FRight;
          if pR^.FOperator in [canANY, canALL] then begin
            for i := 0 to Length(pR^.FArgs) - 1 do begin
              r := EvaluteNodeValue(pR^.FArgs[i]);
              if (ekNoCase in FOptions) and (ekPartial in FOptions) then
                UpperCaseLR;
              case ANode^.FOperator of
                canEQ:
                  if ekPartial in FOptions then
                    Result := PartialEQ(ANode^.FPartial)
                  else
                    Result := l = r;
                canNE: Result := l <> r;
                canGE: Result := l >= r;
                canLE: Result := l <= r;
                canGT: Result := l > r;
                canLT: Result := l < r;
              end;
              if (pR^.FOperator = canANY) and Result or
                 (pR^.FOperator = canALL) and not Result then
                Break;
            end;
          end
          else begin
            r := EvaluteNodeValue(ANode^.FRight);
            if (ekNoCase in FOptions) and (ekPartial in FOptions) then
              UpperCaseLR;
            case ANode^.FOperator of
              canEQ:
                if ekPartial in FOptions then
                  Result := PartialEQ(ANode^.FPartial)
                else
                  Result := l = r;
              canNE:
                if ekPartial in FOptions then
                  Result := not PartialEQ(ANode^.FPartial)
                else
                  Result := l <> r;
              canGE: Result := l >= r;
              canLE: Result := l <= r;
              canGT: Result := l > r;
              canLT: Result := l < r;
            end;
          end;
        end;
      canLIKE, canNOTLIKE:
        begin
          if Length(ANode^.FArgs) > 0 then
            esc := EvaluteNodeValue(ANode^.FArgs[0])
          else
            esc := #9;
          Result := FunLike(EvaluteNodeValue(ANode^.FLeft), EvaluteNodeValue(ANode^.FRight),
                            ekNoCase in FOptions, '%', '_', esc[1]);
          if ANode^.FOperator = canNOTLIKE then
            Result := not Result;
        end;
      canISBLANK, canNOTBLANK:
        begin
          if ANode^.FLeft^.FKind = enField then
            Result := FDStrIsNull(FDataSource.VarData[ANode^.FLeft^.FColumnInd])
          else
            Result := FDStrIsNull(EvaluteNodeValue(ANode^.FLeft));
          if ANode^.FOperator = canNOTBLANK then
            Result := not Result;
        end;
      canIN, canNOTIN:
        begin
          Result := False;
          l := EvaluteNodeValue(ANode^.FLeft);
          for i := 0 to Length(ANode^.FArgs) - 1 do
            if l = EvaluteNodeValue(ANode^.FArgs[i]) then begin
              Result := True;
              Break;
            end;
          if ANode^.FOperator = canNOTIN then
            Result := not Result;
        end;
      canCONCAT, canADD:
        Result := EvaluteNodeValue(ANode^.FLeft) + EvaluteNodeValue(ANode^.FRight);
      canSUB:
        Result := EvaluteNodeValue(ANode^.FLeft) - EvaluteNodeValue(ANode^.FRight);
      canMUL:
        Result := EvaluteNodeValue(ANode^.FLeft) * EvaluteNodeValue(ANode^.FRight);
      canDIV:
        Result := EvaluteNodeValue(ANode^.FLeft) / EvaluteNodeValue(ANode^.FRight);
      canBETWEEN, canNOTBETWEEN:
        begin
          l := EvaluteNodeValue(ANode^.FLeft);
          Result := (l >= EvaluteNodeValue(ANode^.FArgs[0])) and
                    (l <= EvaluteNodeValue(ANode^.FArgs[1]));
          if ANode^.FOperator = canNOTBETWEEN then
            Result := not Result;
        end;
      end;
    enFunc:
      begin
        pFunc := FDExpressionManager().Functions[ANode^.FFuncInd];
        if pFunc.FScopeKind = ckAgg then
          Result := FDataSource.SubAggregateValue[FDIndexOf(Pointer(FSubAggregates), -1, ANode)]
        else if pFunc.FCall = @FunIIF then begin
          r := EvaluteNodeValue(ANode^.FArgs[0]);
          if FDStrIsNull(r) then
            Result := Null
          else if r then
            Result := EvaluteNodeValue(ANode^.FArgs[1])
          else
            Result := EvaluteNodeValue(ANode^.FArgs[2]);
        end
        else begin
          for i := 0 to Length(ANode^.FArgs) - 1 do
            ANode^.FFuncArgs[i] := EvaluteNodeValue(ANode^.FArgs[i]);
          if pFunc.FScopeKind = ckField then
            Result := TFDExpressionFieldFunction(pFunc.FCall)(ANode^.FFuncArgs, Self)
          else
            Result := TFDExpressionFunction(pFunc.FCall)(ANode^.FFuncArgs);
        end;
      end;
    end;
  except
    on E: Exception do
      if E is EFDException then
        raise
      else
        EvalError(E.Message);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDExpression.Evaluate: Variant;
begin
  Result := InternalEvaluate(FRoot);
end;

{-------------------------------------------------------------------------------}
function TFDExpression.EvaluateSubAggregateArg(AIndex: Integer): Variant;
var
  pNode: PFDExpressionNode;
begin
  pNode := FSubAggregates[AIndex];
  if Length(pNode^.FArgs) = 0 then
    Result := '*'
  else
    Result := InternalEvaluate(pNode^.FArgs[0]);
end;

{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_DEBUG}
procedure TFDExpression.Dump(AStrs: TStrings);
const
  enk2s: array[TFDExpressionNodeKind] of String = (
    'enUnknown', 'enField', 'enConst', 'enOperator', 'enFunc');
  bool2s: array[Boolean] of String = (
    'False', 'True');
  esk2s: array[TFDExpressionScopeKind] of String = (
    'ckUnknown', 'ckField', 'ckAgg', 'ckConst'
  );
  co2s: array[TFDExpressionOperator] of String = (
    'canNOTDEFINED', 'canASSIGN', 'canOR', 'canAND', 'canNOT', 'canEQ', 'canNE',
    'canGE', 'canLE', 'canGT', 'canLT', 'canLIKE', 'canISBLANK', 'canNOTBLANK',
    'canIN', 'canCONCAT', 'canADD', 'canSUB', 'canMUL', 'canDIV', 'canNOTIN',
    'canANY', 'canALL', 'canNOTLIKE', 'canBETWEEN', 'canNOTBETWEEN'
  );

  function Var2Text(const AValue: Variant): String;
  begin
    if VarIsEmpty(AValue) then
      Result := 'Unassigned'
    else if VarIsNull(AValue) then
      Result := 'Null'
    else
      Result := AValue;
  end;

  procedure DumpNode(ANode: PFDExpressionNode; AIndent: Integer; AList: TStrings);
  var
    st: String;
    i: Integer;
  begin
    st := '';
    for i := 1 to AIndent do
      st := st + ' ';
    AList.Add(st +
      'FKind: ' + enk2s[ANode^.FKind] + ' ' +
      'FOper: ' + co2s[ANode^.FOperator] + ' ' +
      'FData tp: ' + IntToStr(VarType(ANode^.FData)) + ' ' +
      'FData vl: ' + Var2Text(ANode^.FData) + ' ' +
      'FDataType: ' + C_FD_DataTypeNames[ANode^.FDataType] + ' ' +
      'FScopeKind: ' + esk2s[ANode^.FScopeKind]
    );
    if Length(ANode^.FArgs) > 0 then begin
      AList.Add(st + 'ARGS:');
      for i := 0 to Length(ANode^.FArgs) - 1 do
        DumpNode(ANode^.FArgs[i], AIndent + 2, AList);
    end;
    if ANode^.FLeft <> nil then begin
      AList.Add(st + 'LEFT:');
      DumpNode(ANode^.FLeft, AIndent + 2, AList);
    end;
    if ANode^.FRight <> nil then begin
      AList.Add(st + 'RIGHT:');
      DumpNode(ANode^.FRight, AIndent + 2, AList);
    end;
  end;

begin
  AStrs.Clear;
  if FRoot <> nil then
    DumpNode(FRoot, 0, AStrs)
  else
    AStrs.Add('-= EMPTY =-');
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{ TFDExpressionParser                                                           }
{-------------------------------------------------------------------------------}
class function TFDExpressionParser.IsNumeric(DataType: TFDDataType): Boolean;
begin
  Result := DataType in [
    dtSByte, dtInt16, dtInt32, dtInt64,
    dtByte, dtUInt16, dtUInt32, dtUInt64,
    dtSingle, dtDouble, dtExtended, dtCurrency, dtBCD, dtFmtBCD];
end;

{-------------------------------------------------------------------------------}
class function TFDExpressionParser.IsTemporal(DataType: TFDDataType): Boolean;
begin
  Result := DataType in [dtDateTime, dtTime, dtDate, dtDateTimeStamp,
    dtTimeIntervalFull, dtTimeIntervalYM, dtTimeIntervalDS];
end;

{-------------------------------------------------------------------------------}
class function TFDExpressionParser.IsString(DataType: TFDDataType): Boolean;
begin
  Result := DataType in [dtAnsiString, dtWideString, dtGUID];
end;

{-------------------------------------------------------------------------------}
class function TFDExpressionParser.IsBLOB(DataType: TFDDataType): Boolean;
begin
  Result := DataType in (C_FD_BlobTypes + [dtByteString]);
end;

{-------------------------------------------------------------------------------}
class function TFDExpressionParser.IsBoolean(DataType: TFDDataType): Boolean;
begin
  Result := DataType = dtBoolean;
end;

{-------------------------------------------------------------------------------}
function TFDExpressionParser.Prepare(const ADataSource: IFDStanExpressionDataSource;
  const AExpression: String; AOptions: TFDExpressionOptions;
  AParserOptions: TFDParserOptions; const AFixedColumnName: String):
  IFDStanExpressionEvaluator;
var
  Root, DefField: PFDExpressionNode;
begin
  if AExpression = '' then
    FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprEmpty, []);
  FExpression := TFDExpression.Create(AOptions, ADataSource);
  try
    FFixedColumnName := AFixedColumnName;
    FDataSource := ADataSource;
    FParserOptions := AParserOptions;
    FText := AExpression;
    FSourcePtr := PChar(FText);
    NextToken;
    Root := ParseExpr;
    if FToken <> etEnd then
      FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprTermination, []);
    if (poAggregate in FParserOptions) and (Root^.FScopeKind <> ckAgg) then
      FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprMBAgg, []);
    if (not (poAggregate in FParserOptions)) and (Root^.FScopeKind = ckAgg) then
      FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprCantAgg, []);
    if (poDefaultExpr in FParserOptions) and (AFixedColumnName <> '') then begin
      DefField := FExpression.NewNode(enField, canNOTDEFINED, AFixedColumnName,
        nil, nil, -1);
      FixupFieldNode(DefField, AFixedColumnName);
      if IsTemporal(DefField^.FDataType) and IsString(Root^.FDataType) or
         IsBoolean(DefField^.FDataType) and IsString(Root^.FDataType) then
        Root^.FDataType := DefField^.FDataType;
      if not (
          (Root^.FDataType = dtUnknown) or
          (Root^.FKind = enConst) and VarIsNull(Root^.FData) or
          IsTemporal(DefField^.FDataType) and IsTemporal(Root^.FDataType) or
          IsNumeric(DefField^.FDataType) and IsNumeric(Root^.FDataType) or
          IsString(DefField^.FDataType) and IsString(Root^.FDataType) or
          IsBoolean(DefField^.FDataType) and IsBoolean(Root^.FDataType)
         ) then
        FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprTypeMis, []);
      Root := FExpression.NewNode(enOperator, canASSIGN, Unassigned, Root,
        DefField, -1);
    end;
    if not ((poAggregate in FParserOptions) or (poDefaultExpr in FParserOptions) or
            IsBoolean(Root^.FDataType)) then
      FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprIncorrect, []);
    FExpression.FRoot := Root;
    Result := FExpression;
  except
    FDFreeAndNil(FExpression);
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDExpressionParser.GetDataSource: IFDStanExpressionDataSource;
begin
  Result := FDataSource;
end;

{-------------------------------------------------------------------------------}
procedure TFDExpressionParser.FixupFieldNode(ANode: PFDExpressionNode; const AColumnName: String);
begin
  if ANode^.FKind = enField then begin
    if poFieldNameGiven in FParserOptions then
      ANode^.FColumnInd := FDataSource.VarIndex[FFixedColumnName];
    if ANode^.FColumnInd = -1 then
      ANode^.FColumnInd := FDataSource.VarIndex[AColumnName];
    if ANode^.FColumnInd = -1 then
      FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ColumnDoesnotFound,
        [AColumnName]);
    ANode^.FDataType := FDataSource.VarType[ANode^.FColumnInd];
    ANode^.FScopeKind := FDataSource.VarScope[ANode^.FColumnInd];
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDExpressionParser.SaveState(out ABmk: TFDExprParserBmk; ACurPtr: PChar);
begin
  ABmk.FSourcePtr := FSourcePtr;
  ABmk.FToken := FToken;
  ABmk.FTokenString := FTokenString;
  ABmk.FCurPtr := ACurPtr;
end;

{-------------------------------------------------------------------------------}
procedure TFDExpressionParser.RestoreState(const ABmk: TFDExprParserBmk; out ACurPtr: PChar);
begin
  FSourcePtr := ABmk.FSourcePtr;
  FToken := ABmk.FToken;
  FTokenString := ABmk.FTokenString;
  FUCTokenString := UpperCase(ABmk.FTokenString);
  ACurPtr := ABmk.FCurPtr;
end;

{-------------------------------------------------------------------------------}
procedure TFDExpressionParser.NextToken;
var
  P, TokenStart: PChar;
  L: Integer;
  StrBuf: array[0..255] of Char;
  PrevToken: TFDExpressionToken;
  PrevTokenStr: String;
  ch2: Char;
  sign: Double;
  bmk: TFDExprParserBmk;

  procedure Skip(ASet: TFDCharSet);
  begin
    while (P^ <> #0) and FDInSet(P^, ASet) do
      Inc(P);
  end;

  procedure SkipWS;
  begin
    while (P^ <> #0) and (P^ <= ' ') do
      Inc(P);
  end;

  procedure SkpiWhileNot(ASet: TFDCharSet);
  begin
    while (P^ <> #0) and not FDInSet(P^, ASet) do
      Inc(P);
  end;

  procedure ExtractToken(ASet: TFDCharSet);
  begin
    SkipWS;
    TokenStart := P;
    Skip(ASet);
    SetString(FTokenString, TokenStart, P - TokenStart);
    FUCTokenString := AnsiUpperCase(FTokenString);
  end;

  procedure ExtractWord;
  begin
    ExtractToken(['A'..'Z', 'a'..'z']);
  end;

begin
  PrevToken := FToken;
  PrevTokenStr := FUCTokenString;
  FTokenString := '';
  P := FSourcePtr;
  SkipWS;
  // /* comment */
  if (P^ <> #0) and (P^ = '/') and (P[1] <> #0) and (P[1] = '*') then begin
    Inc(P, 2);
    SkpiWhileNot(['*']);
    if (P^ = '*') and (P[1] <> #0) and (P[1] = '/') then
      Inc(P, 2)
    else
      FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprInvalidChar,
        [String(P)]);
  end
  // -- comment
  else if (P^ <> #0) and (P^ = '-') and (P[1] <> #0) and (P[1] = '-') then begin
    Inc(P, 2);
    SkpiWhileNot([#13, #10]);
  end;
  SkipWS;
  FTokenPtr := P;

  case P^ of
  'A'..'Z', 'a'..'z':
    begin
      ExtractToken(['A'..'Z', 'a'..'z', '0'..'9', '$', '#', '_', '.']);
      FToken := etSymbol;
      if FUCTokenString = 'NOT' then begin
        SaveState(bmk, P);
        ExtractWord;
        if FUCTokenString = 'IN' then
          FToken := etNOTIN
        else if FUCTokenString = 'LIKE' then
          FToken := etNOTLIKE
        else if FUCTokenString = 'BETWEEN' then
          FToken := etNOTBETWEEN
        else
          RestoreState(bmk, P);
      end
      else if FUCTokenString = 'LIKE' then
        FToken := etLIKE
      else if FUCTokenString = 'IN' then
        FToken := etIN
      else if FUCTokenString = 'ANY' then
        FToken := etANY
      else if FUCTokenString = 'SOME' then
        FToken := etSOME
      else if FUCTokenString = 'ALL' then
        FToken := etALL
      else if FUCTokenString = 'BETWEEN' then
        FToken := etBETWEEN
      else if FUCTokenString = 'IS' then begin
        ExtractWord;
        if FUCTokenString = 'NOT' then begin
          ExtractWord;
          if FUCTokenString = 'NULL' then
            FToken := etISNOTNULL;
        end
        else if FUCTokenString = 'NULL' then
          FToken := etISNULL;
        if FToken = etSYMBOL then
          FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_InvalidKeywordUse, []);
      end
      else if FUCTokenString = 'NULL' then
        FToken := etNULL;
    end;
  '[', '"', '`':
    begin
      if P^ = '[' then
        ch2 := ']'
      else
        ch2 := P^;
      Inc(P);
      TokenStart := P;
      P := AnsiStrScan(P, ch2);
      if P = nil then
        FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprNameError, []);
      SetString(FTokenString, TokenStart, P - TokenStart);
      FToken := etName;
      Inc(P);
    end;
  '''':
    begin
      Inc(P);
      L := 0;
      while True do begin
        if P^ = #0 then
          FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprStringError, []);
        if P^ = '''' then begin
          Inc(P);
          if P^ <> '''' then
            Break;
        end;
        if L <= High(StrBuf) then begin
          StrBuf[L] := P^;
          Inc(L);
        end
        else
          FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprStringError, []);
        Inc(P);
      end;
      SetString(FTokenString, StrBuf, L);
      FToken := etLiteral;
      FLiteralType := dtAnsiString;
      FLiteralValue := FTokenString;
    end;
  '-', '+', '0'..'9', '.':
    begin
      if (PrevToken <> etLiteral) and (PrevToken <> etName) and
         ((PrevToken <> etSymbol) or (PrevTokenStr = 'AND')) and
         (PrevToken <> etRParen) then begin
        if P^ = '-' then begin
          sign := -1;
          Inc(P);
        end
        else if P^ = '+' then begin
          sign := 1;
          Inc(P);
        end
        else
          sign := 1;
        ExtractToken(['0'..'9', '.']);
        FToken := etLiteral;
        FLiteralType := dtDouble;
        FLiteralValue := FDStr2Float(FTokenString, '.') * sign;
      end
      else if P^ = '+' then begin
        Inc(P);
        FToken := etADD;
      end
      else if P^ = '-' then begin
        FToken := etSUB;
        Inc(P);
      end
      else
        FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprInvalidChar,
          [String(P)]);
    end;
  '(':
    begin
      Inc(P);
      FToken := etLParen;
    end;
  ')':
    begin
      Inc(P);
      FToken := etRParen;
    end;
  '<':
    begin
      Inc(P);
      case P^ of
      '=':
        begin
          Inc(P);
          FToken := etLE;
        end;
      '>':
        begin
          Inc(P);
          FToken := etNE;
        end;
      else
        FToken := etLT;
      end;
    end;
  '^', '!':
    begin
      Inc(P);
      if P^ = '=' then begin
        Inc(P);
        FToken := etNE;
      end
      else
        FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprInvalidChar,
          [String(P)]);
    end;
  '=':
    begin
      Inc(P);
      FToken := etEQ;
    end;
  '>':
    begin
      Inc(P);
      if P^ = '=' then begin
        Inc(P);
        FToken := etGE;
      end
      else
        FToken := etGT;
    end;
  '|':
    begin
      Inc(P);
      if P^ = '|' then begin
        Inc(P);
        FToken := etCONCAT;
      end
      else
        FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprInvalidChar,
          [String(P)]);
    end;
  '*':
    begin
      Inc(P);
      FToken := etMUL;
    end;
  '/':
    begin
      Inc(P);
      FToken := etDIV;
   end;
  ',':
    begin
      Inc(P);
      FToken := etComma;
    end;
  '{':
    begin
      SaveState(bmk, P);
      FToken := etLiteral;
      Inc(P);
      ExtractWord;
      if FUCTokenString = 'D' then
        FLiteralType := dtDate
      else if FUCTokenString = 'T' then
        FLiteralType := dtTime
      else if FUCTokenString = 'DT' then
        FLiteralType := dtDateTime
      else if FUCTokenString = 'E' then
        FLiteralType := dtDouble
      else if FUCTokenString = 'L' then
        FLiteralType := dtBoolean
      else if FUCTokenString = 'S' then
        FLiteralType := dtAnsiString
      else if FUCTokenString = 'ID' then
        FToken := etName
      else if FUCTokenString = 'FN' then
        FToken := etLCBracket
      else begin
        RestoreState(bmk, P);
        FToken := etLCBracket;
      end;
      if FToken <> etLCBracket then begin
        SkipWS;
        TokenStart := P;
        P := AnsiStrScan(P, '}');
        if P = nil then
          FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprTermination, []);
        SetString(FTokenString, TokenStart, P - TokenStart);
        if FToken = etLiteral then begin
          case FLiteralType of
          dtDateTime:   FLiteralValue := StrToDateTime(FTokenString, rDateTimeFS);
          dtTime:       FLiteralValue := StrToTime(FTokenString, rDateTimeFS);
          dtDate:       FLiteralValue := StrToDate(FTokenString, rDateTimeFS);
          dtDouble:     FLiteralValue := FDStr2Float(FTokenString, '.');
          dtBoolean:    FLiteralValue := (CompareText(FTokenString, 'TRUE') = 0);
          dtAnsiString: FLiteralValue := FTokenString;
          end;
        end;
      end;
      Inc(P);
    end;
  '}':
    begin
      Inc(P);
      FToken := etRCBracket;
    end;
  #0:
    FToken := etEnd;
  else
    FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprInvalidChar,
      [String(P)]);
  end;
  FSourcePtr := P;
end;

{-------------------------------------------------------------------------------}
function TFDExpressionParser.ParseExpr: PFDExpressionNode;
begin
  Result := ParseExpr2;
  while TokenSymbolIs('OR') do begin
    NextToken;
    Result := FExpression.NewNode(enOperator, canOR, Unassigned, Result,
      ParseExpr2, -1);
    GetScopeKind(Result, Result^.FLeft, Result^.FRight);
    Result^.FDataType := dtBoolean;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDExpressionParser.ParseExpr2: PFDExpressionNode;
begin
  Result := ParseExpr3;
  while TokenSymbolIs('AND') do begin
    NextToken;
    Result := FExpression.NewNode(enOperator, canAND, Unassigned, Result,
      ParseExpr3, -1);
    GetScopeKind(Result, Result^.FLeft, Result^.FRight);
    Result^.FDataType := dtBoolean;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDExpressionParser.ParseExpr3: PFDExpressionNode;
begin
  if TokenSymbolIs('NOT') then begin
    NextToken;
    Result := FExpression.NewNode(enOperator, canNOT, Unassigned, ParseExpr4,
      nil, -1);
    Result^.FDataType := dtBoolean;
  end
  else
    Result := ParseExpr4;
  GetScopeKind(Result, Result^.FLeft, Result^.FRight);
end;

{-------------------------------------------------------------------------------}
function TFDExpressionParser.ParseExpr4: PFDExpressionNode;
const
  Operators: array[etEQ .. etLT] of TFDExpressionOperator = (
    canEQ, canNE, canGE, canLE, canGT, canLT);
var
  eOperator: TFDExpressionOperator;
  Left, Right: PFDExpressionNode;
begin
  Result := ParseExpr5(False);
  if (FToken in [etEQ..etLT, etLIKE, etNOTLIKE, etISNULL, etISNOTNULL,
                 etIN, etNOTIN, etBETWEEN, etNOTBETWEEN]) then begin
    case FToken of
    etEQ..etLT:
      eOperator := Operators[FToken];
    etLIKE:
      eOperator := canLIKE;
    etNOTLIKE:
      eOperator := canNOTLIKE;
    etISNULL:
      eOperator := canISBLANK;
    etISNOTNULL:
      eOperator := canNOTBLANK;
    etIN:
      eOperator := canIN;
    etNOTIN:
      eOperator := canNOTIN;
    etBETWEEN:
      eOperator := canBETWEEN;
    etNOTBETWEEN:
      eOperator := canNOTBETWEEN;
    else
      eOperator := canNOTDEFINED;
    end;
    NextToken;
    Left := Result;
    if eOperator in [canIN, canNOTIN] then begin
      if FToken <> etLParen then
        FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprNoLParen,
          [TokenName]);
      NextToken;
      Result := FExpression.NewNode(enOperator, eOperator, Unassigned, Left, nil, -1);
      Result^.FDataType := dtBoolean;
      if FToken <> etRParen then begin
        repeat
          Right := ParseExpr;
          if IsTemporal(Left^.FDataType) then
            Right^.FDataType := Left^.FDataType;
          SetLength(Result^.FArgs, Length(Result^.FArgs) + 1);
          Result^.FArgs[Length(Result^.FArgs) - 1] := Right;
          if (FToken <> etComma) and (FToken <> etRParen) then
            FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprNoRParenOrComma,
              [TokenName]);
          if FToken = etComma then
            NextToken;
        until (FToken = etRParen) or (FToken = etEnd);
        if FToken <> etRParen then
          FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprNoRParen,
            [TokenName]);
        NextToken;
      end
      else
        FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprEmptyInList, []);
    end
    else if eOperator in [canBETWEEN, canNOTBETWEEN] then begin
      Result := FExpression.NewNode(enOperator, eOperator, Unassigned, Left, nil, -1);
      Result^.FDataType := dtBoolean;
      SetLength(Result^.FArgs, 2);
      Result^.FArgs[0] := ParseExpr5(False);
      if TokenSymbolIs('AND') then
        NextToken
      else
        FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprExpected, ['AND']);
      Result^.FArgs[1] := ParseExpr5(False);
    end
    else begin
      if eOperator in [canEQ, canNE, canGE, canLE, canGT, canLT] then begin
        Right := ParseExpr5(True);
        Result := FExpression.NewNode(enOperator, eOperator, Unassigned, Left, Right, -1);
      end
      else if eOperator in [canLIKE, canNOTLIKE] then begin
        Right := ParseExpr5(False);
        Result := FExpression.NewNode(enOperator, eOperator, Unassigned, Left, Right, -1);
        if TokenSymbolIs('ESCAPE') then begin
          NextToken;
          SetLength(Result^.FArgs, 1);
          Result^.FArgs[0] := ParseExpr5(False);
        end;
      end
      else begin
        Right := nil;
        Result := FExpression.NewNode(enOperator, eOperator, Unassigned, Left, Right, -1);
      end;
      if Right <> nil then begin
        if (Left^.FKind = enField) and (Right^.FKind = enConst) then begin
          if IsBoolean(Left^.FDataType) and IsNumeric(Right^.FDataType) then
            Right^.FData := Right^.FData <> 0.0;
          Right^.FDataType := Left^.FDataType;
        end
        else if (Right^.FKind = enField) and (Left^.FKind = enConst) then begin
          if IsBoolean(Right^.FDataType) and IsNumeric(Left^.FDataType) then
            Left^.FData := Left^.FData <> 0.0;
          Left^.FDataType := Right^.FDataType;
        end;
      end;
      if IsBLOB(Left^.FDataType) and (eOperator in [canLIKE, canNOTLIKE]) then begin
        if Right^.FKind = enConst then
          Right^.FDataType := dtAnsiString;
      end
      else if not (eOperator in [canISBLANK, canNOTBLANK]) and
              (IsBLOB(Left^.FDataType) or (Right <> nil) and IsBLOB(Right^.FDataType)) then
        FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprTypeMis, []);
      Result^.FDataType := dtBoolean;
      if Right <> nil then begin
        if IsTemporal(Left^.FDataType) and IsString(Right^.FDataType) then
          Right^.FDataType := Left^.FDataType
        else if IsTemporal(Right^.FDataType) and IsString(Left^.FDataType) then
          Left^.FDataType := Right^.FDataType;
      end;
      GetScopeKind(Result, Left, Right);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDExpressionParser.ParseExpr5(AEnableList: Boolean): PFDExpressionNode;
const
  OperatorsList: array[etANY .. etALL] of TFDExpressionOperator = (
    canANY, canANY, canALL);
  Operators: array[etCONCAT .. etSUB] of TFDExpressionOperator = (
    canCONCAT, canADD, canSUB);
var
  eOperator: TFDExpressionOperator;
  Left, Right: PFDExpressionNode;
begin
  if FToken in [etANY, etSOME, etALL] then begin
    if not AEnableList then
      FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprExpected,
        [TokenName]);
    eOperator := OperatorsList[FToken];
    NextToken;
    if FToken <> etLParen then
      FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprNoLParen,
        [TokenName]);
    NextToken;
    if FToken = etRParen then
      FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprEmptyInList, []);
    Result := FExpression.NewNode(enOperator, eOperator, Unassigned, nil, nil, -1);
    repeat
      SetLength(Result^.FArgs, Length(Result^.FArgs) + 1);
      Result^.FArgs[Length(Result^.FArgs) - 1] := ParseExpr;
      if (FToken <> etComma) and (FToken <> etRParen) then
        FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprNoRParenOrComma,
          [TokenName]);
      if FToken = etComma then
        NextToken;
    until (FToken = etRParen) or (FToken = etEnd);
    if FToken <> etRParen then
      FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprNoRParenOrComma,
        [TokenName]);
    NextToken;
    Result^.FDataType := Result^.FArgs[0]^.FDataType;
                                                          
    // Result.FScopeKind := Result.FArgs[0]^.FScopeKind;
  end
  else begin
    Result := ParseExpr6;
    while FToken in [etCONCAT, etADD, etSUB] do begin
      eOperator := Operators[FToken];
      Left := Result;
      NextToken;
      Right := ParseExpr6;
      Result := FExpression.NewNode(enOperator, eOperator, Unassigned, Left, Right, -1);
      TypeCheckArithOp(Result);
      GetScopeKind(Result, Left, Right);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDExpressionParser.ParseExpr6: PFDExpressionNode;
const
  Operators: array[etMUL .. etDIV] of TFDExpressionOperator = (
    canMUL, canDIV);
var
  eOperator: TFDExpressionOperator;
  Left, Right: PFDExpressionNode;
begin
  Result := ParseExpr7;
  while FToken in [etMUL, etDIV] do begin
    eOperator := Operators[FToken];
    Left := Result;
    NextToken;
    Right := ParseExpr7;
    Result := FExpression.NewNode(enOperator, eOperator, Unassigned, Left, Right, -1);
    TypeCheckArithOp(Result);
    GetScopeKind(Result, Left, Right);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDExpressionParser.ParseExpr7: PFDExpressionNode;

  function NextTokenIsLParen: Boolean;
  var
    P: PChar;
  begin
    P := FSourcePtr;
    while (P^ <> #0) and (P^ <= ' ') do
      Inc(P);
    Result := P^ = '(';
  end;

  function IsField(const AName: String): Boolean;
  begin
    Result := (FDataSource <> nil) and (FDataSource.VarIndex[AName] <> -1);
  end;

var
  FuncName: String;
  FuncInd: Integer;
begin
  Result := nil;
  case FToken of
  etSymbol:
    begin
      FuncInd := TokenSymbolIsFunc(FTokenString);
      if FuncInd <> -1 then begin
        FuncName := FUCTokenString;
        if not NextTokenIsLParen then
          if IsField(FTokenString) then begin
            Result := FExpression.NewNode(enField, canNOTDEFINED, FTokenString, nil, nil, -1);
            FixupFieldNode(Result, FTokenString);
          end
          else
            Result := FExpression.NewNode(enFunc, canNOTDEFINED, FuncName, nil, nil, FuncInd)
        else begin
          NextToken;
          if FToken <> etLParen then
            FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprNoLParen, [TokenName]);
          NextToken;
          if (FuncName = 'COUNT') and (FToken = etMUL) then
            NextToken;
          Result := FExpression.NewNode(enFunc, canNOTDEFINED, FuncName, nil, nil, FuncInd);
          if FToken <> etRParen then begin
            repeat
              SetLength(Result^.FArgs, Length(Result^.FArgs) + 1);
              Result^.FArgs[Length(Result^.FArgs) - 1] := ParseExpr;
              if (FToken <> etComma) and (FToken <> etRParen) then
                FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprNoRParenOrComma, [TokenName]);
              if FToken = etComma then
                NextToken;
            until (FToken = etRParen) or (FToken = etEnd);
            SetLength(Result^.FFuncArgs, Length(Result^.FArgs));
          end;
        end;
        if Result^.FKind = enFunc then
          GetFuncResultInfo(Result);
      end
      else if TokenSymbolIs('NULL') then begin
        Result := FExpression.NewNode(enConst, canNOTDEFINED,
          Null, nil, nil, -1);
        Result^.FScopeKind := ckConst;
      end
      else if TokenSymbolPartialIs('TRUE') and not IsField(FTokenString) then begin
        Result := FExpression.NewNode(enConst, canNOTDEFINED, True, nil, nil, -1);
        Result^.FScopeKind := ckConst;
      end
      else if TokenSymbolPartialIs('FALSE') and not IsField(FTokenString) then begin
        Result := FExpression.NewNode(enConst, canNOTDEFINED, False, nil, nil, -1);
        Result^.FScopeKind := ckConst;
      end
      else begin
        Result := FExpression.NewNode(enField, canNOTDEFINED, FTokenString, nil, nil, -1);
        FixupFieldNode(Result, FTokenString);
      end;
    end;
  etName:
    begin
      Result := FExpression.NewNode(enField, canNOTDEFINED, FTokenString, nil, nil, -1);
      FixupFieldNode(Result, FTokenString);
    end;
  etNULL:
    begin
      Result := FExpression.NewNode(enConst, canNOTDEFINED, Null, nil, nil, -1);
      Result^.FDataType := dtUnknown;
      Result^.FScopeKind := ckConst;
    end;
  etLiteral:
    begin
      Result := FExpression.NewNode(enConst, canNOTDEFINED, FLiteralValue, nil, nil, -1);
      Result^.FDataType := FLiteralType;
      Result^.FScopeKind := ckConst;
    end;
  etLParen:
    begin
      NextToken;
      Result := ParseExpr;
      if FToken <> etRParen then
        FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprNoRParen, [TokenName]);
    end;
  etLCBracket:
    begin
      NextToken;
      Result := ParseExpr;
      if FToken <> etRCBracket then
        FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprNoRParen, [TokenName]);
    end;
  else
    FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprExpected, [TokenName]);
  end;
  NextToken;
end;

{-------------------------------------------------------------------------------}
procedure TFDExpressionParser.GetScopeKind(Root, Left, Right: PFDExpressionNode);
begin
  if (Left = nil) and (Right = nil) then
    Exit;
  if Right = nil then begin
    Root^.FScopeKind := Left^.FScopeKind;
    Exit;
  end;
  if ((Left^.FScopeKind = ckField) and (Right^.FScopeKind = ckAgg))
    or ((Left^.FScopeKind = ckAgg) and (Right^.FScopeKind = ckField)) then
    FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprBadScope, []);
  if (Left^.FScopeKind = ckConst) and (Right^.FScopeKind = ckConst) then
    Root^.FScopeKind := ckConst
  else if (Left^.FScopeKind = ckAgg) or (Right^.FScopeKind = ckAgg) then
    Root^.FScopeKind := ckAgg
  else if (Left^.FScopeKind = ckField) or (Right^.FScopeKind = ckField) then
    Root^.FScopeKind := ckField;
end;

{-------------------------------------------------------------------------------}
procedure TFDExpressionParser.GetFuncResultInfo(Node : PFDExpressionNode);
var
  i, n: Integer;
  pFuncDesc: TFDExpressionFunctionDesc;
begin
  i := TokenSymbolIsFunc(Node^.FData);
  n := Length(Node^.FArgs);
  pFuncDesc := FDExpressionManager().Functions[i];
  if (pFuncDesc.FArgMin > n) or (pFuncDesc.FArgMax < n) then
    FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprTypeMis, []);
  if pFuncDesc.FDataType = dtUnknown then begin
    if pFuncDesc.FDataTypeArg = -1 then
      Node^.FDataType := dtUnknown
    else
      Node^.FDataType := Node^.FArgs[pFuncDesc.FDataTypeArg]^.FDataType;
  end
  else
    Node^.FDataType := pFuncDesc.FDataType;
  if pFuncDesc.FScopeKind = ckUnknown then
    Node^.FScopeKind := Node^.FArgs[pFuncDesc.FScopeKindArg]^.FScopeKind
  else
    Node^.FScopeKind := pFuncDesc.FScopeKind;
end;

{-------------------------------------------------------------------------------}
function TFDExpressionParser.TokenName: String;
begin
  if FSourcePtr = FTokenPtr then
    Result := '<nothing>'
  else begin
    SetString(Result, FTokenPtr, FSourcePtr - FTokenPtr);
    Result := '''' + Result + '''';
  end;
end;

{-------------------------------------------------------------------------------}
function TFDExpressionParser.TokenSymbolIs(const S: String): Boolean;
begin
  Result := (FToken = etSymbol) and (FUCTokenString = S);
end;

{-------------------------------------------------------------------------------}
function TFDExpressionParser.TokenSymbolPartialIs(const S: String): Boolean;
begin
  Result := (FToken = etSymbol) and (Copy(S, 1, Length(FUCTokenString)) = FUCTokenString);
end;

{-------------------------------------------------------------------------------}
function TFDExpressionParser.TokenSymbolIsFunc(const S: String): Integer;
begin
  Result := FDExpressionManager().FindFunction(S);
end;

{-------------------------------------------------------------------------------}
procedure TFDExpressionParser.TypeCheckArithOp(Node: PFDExpressionNode);
begin
  if IsNumeric(Node^.FLeft^.FDataType) and IsNumeric(Node^.FRight^.FDataType) then
    Node^.FDataType := dtDouble
  else if IsString(Node^.FLeft^.FDataType) and IsString(Node^.FRight^.FDataType) and
      ((Node^.FOperator = canADD) or (Node^.FOperator = canCONCAT)) then
    Node^.FDataType := dtAnsiString
  else if IsTemporal(Node^.FLeft^.FDataType) and IsNumeric(Node^.FRight^.FDataType) and
      (Node^.FOperator = canADD) then
    Node^.FDataType := dtDateTime
  else if IsTemporal(Node^.FLeft^.FDataType) and IsNumeric(Node^.FRight^.FDataType) and
      (Node^.FOperator = canSUB) then
    Node^.FDataType := Node^.FLeft^.FDataType
  else if IsTemporal(Node^.FLeft^.FDataType) and IsTemporal(Node^.FRight^.FDataType) and
      (Node^.FOperator = canSUB) then
    Node^.FDataType := dtDouble
  else if IsString(Node^.FLeft^.FDataType) and IsTemporal(Node^.FRight^.FDataType) and
      (Node^.FOperator = canSUB) then begin
    Node^.FLeft^.FDataType := Node^.FRight^.FDataType;
    Node^.FDataType := dtDouble;
  end
  else if IsString(Node^.FLeft^.FDataType) and IsNumeric(Node^.FRight^.FDataType) and
      (Node^.FLeft^.FKind = enConst) then
    Node^.FLeft^.FDataType := dtDateTime
  else
    FDException(Self, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprTypeMis, []);
end;

{-------------------------------------------------------------------------------}
{ TFDExpressionCollation                                                        }
{-------------------------------------------------------------------------------}
function TFDExpressionCollation.GetCall(AEncoding: TFDEncoding): TFDExpressionCompare;
begin
  Result := FCalls[AEncoding];
end;

{-------------------------------------------------------------------------------}
{ TFDExpressionManager                                                          }
{-------------------------------------------------------------------------------}
constructor TFDExpressionManager.Create;
begin
  inherited Create;
  FFunctions := TFDStringList.Create(dupError, True, False);
  FFunctions.Capacity := 100;
  FFunctions.OwnsObjects := True;
  FCollations := TFDStringList.Create(dupAccept, True, False);
  FCollations.OwnsObjects := True;
  // install standard functions
  AddFunction('UPPER',     ckUnknown, 0, dtUnknown,  0, 1, 1, 's', @FunUpper);
  AddFunction('LOWER',     ckUnknown, 0, dtUnknown,  0, 1, 1, 's', @FunLower);
  AddFunction('SUBSTRING', ckUnknown, 0, dtUnknown,  0, 2, 3, 'sii', @FunSubstring);
  AddFunction('TRIM',      ckUnknown, 0, dtUnknown,  0, 1, 2, 'ss', @FunTrim);
  AddFunction('TRIMLEFT',  ckUnknown, 0, dtUnknown,  0, 1, 2, 'ss', @FunTrimLeft);
  AddFunction('TRIMRIGHT', ckUnknown, 0, dtUnknown,  0, 1, 2, 'ss', @FunTrimRight);
  AddFunction('YEAR',      ckUnknown, 0, dtInt16,   -1, 1, 1, 'd', @FunYear);
  AddFunction('MONTH',     ckUnknown, 0, dtInt16,   -1, 1, 1, 'd', @FunMonth);
  AddFunction('DAY',       ckUnknown, 0, dtInt16,   -1, 1, 1, 'd', @FunDay);
  AddFunction('HOUR',      ckUnknown, 0, dtInt16,   -1, 1, 1, 'd', @FunHour);
  AddFunction('MINUTE',    ckUnknown, 0, dtInt16,   -1, 1, 1, 'd', @FunMinute);
  AddFunction('SECOND',    ckUnknown, 0, dtInt16,   -1, 1, 1, 'd', @FunSecond);
  AddFunction('GETDATE',   ckConst,  -1, dtDateTime,-1, 0, 0, '', @FunGetDate);
  AddFunction('DATE',      ckUnknown, 0, dtDateTime,-1, 1, 1, 'd', @FunDate);
  AddFunction('TIME',      ckUnknown, 0, dtDateTime,-1, 1, 1, 'd', @FunTime);
  AddFunction('CMPFILENAME',ckUnknown,0, dtBoolean, -1, 2, 2, 'ss',@FunCmpFileName);
  AddFunction('CMPFILEPATH',ckUnknown,0, dtBoolean, -1, 2, 2, 'ss',@FunCmpFilePath);
  AddFunction('SUM',       ckAgg,    -1, dtDouble,  -1, 1, 1, 'n', @FunAggSum);
  AddFunction('MIN',       ckAgg,    -1, dtUnknown,  0, 1, 1, '*', @FunAggMin);
  AddFunction('MAX',       ckAgg,    -1, dtUnknown,  0, 1, 1, '*', @FunAggMax);
  AddFunction('AVG',       ckAgg,    -1, dtDouble,  -1, 1, 1, 'n', @FunAggAvg);
  AddFunction('COUNT',     ckAgg,    -1, dtInt32,   -1, 0, 1, '*', @FunAggCount);
  AddFunction('TFIRST',    ckAgg,    -1, dtUnknown,  0, 1, 1, '*', @FunAggFirst);
  AddFunction('TLAST',     ckAgg,    -1, dtUnknown,  0, 1, 1, '*', @FunAggLast);
  AddFunction('IIF',       ckUnknown, 1, dtUnknown,  1, 3, 3, 'b**', @FunIIF);
  AddSynonym('IIF', 'IF');
end;

{-------------------------------------------------------------------------------}
destructor TFDExpressionManager.Destroy;
begin
  FDFreeAndNil(FFunctions);
  FDFreeAndNil(FCollations);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDExpressionManager.AddSynonym(const AName, ASynonym: String);
var
  i: Integer;
  oFunc: TFDExpressionFunctionDesc;
  oColl: TFDExpressionCollation;
begin
  if FFunctions.Find(UpperCase(AName), i) then begin
    oFunc := TFDExpressionFunctionDesc(FFunctions.Objects[i]);
    AddFunction(ASynonym, oFunc.FScopeKind, oFunc.FScopeKindArg, oFunc.FDataType,
      oFunc.FDataTypeArg, oFunc.FArgMin, oFunc.FArgMax, oFunc.FArgTypeFamiles,
      oFunc.FCall);
  end;
  if FCollations.Find(UpperCase(AName), i) then begin
    oColl := TFDExpressionCollation(FCollations.Objects[i]);
    AddCollation(ASynonym, ecUTF8, oColl.FCalls[ecUTF8]);
    AddCollation(ASynonym, ecUTF16, oColl.FCalls[ecUTF16]);
    AddCollation(ASynonym, ecANSI, oColl.FCalls[ecANSI]);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDExpressionManager.GetFunctionCount: Integer;
begin
  Result := FFunctions.Count;
end;

{-------------------------------------------------------------------------------}
function TFDExpressionManager.GetFunctions(AIndex: Integer): TFDExpressionFunctionDesc;
begin
  Result := TFDExpressionFunctionDesc(FFunctions.Objects[AIndex]);
end;

{-------------------------------------------------------------------------------}
procedure TFDExpressionManager.AddFunction(const AName: String;
  AScopeKind: TFDExpressionScopeKind; AScopeKindArg: Integer;
  ADataType: TFDDataType; ADataTypeArg, AArgMin, AArgMax: Integer;
  const AArgTypeFamiles: String; ACall: Pointer);
var
  oDesc: TFDExpressionFunctionDesc;
begin
  oDesc := TFDExpressionFunctionDesc.Create;
  oDesc.FName := AName;
  oDesc.FScopeKind := AScopeKind;
  oDesc.FScopeKindArg := AScopeKindArg;
  oDesc.FDataType := ADataType;
  oDesc.FDataTypeArg := ADataTypeArg;
  oDesc.FArgMin := AArgMin;
  oDesc.FArgMax := AArgMax;
  oDesc.FArgTypeFamiles := LowerCase(AArgTypeFamiles);
  oDesc.FCall := ACall;
  FFunctions.AddObject(UpperCase(AName), oDesc);
end;

{-------------------------------------------------------------------------------}
procedure TFDExpressionManager.RemoveFunction(const AName: String);
var
  i: Integer;
begin
  i := FindFunction(AName);
  if i <> -1 then
    FFunctions.Delete(i);
end;

{-------------------------------------------------------------------------------}
function TFDExpressionManager.FindFunction(const AName: String): Integer;
begin
  Result := -1;
  if not FFunctions.Find(UpperCase(AName), Result) then
    Result := -1;
end;

{-------------------------------------------------------------------------------}
function TFDExpressionManager.GetCollationCount: Integer;
begin
  Result := FCollations.Count;
end;

{-------------------------------------------------------------------------------}
function TFDExpressionManager.GetCollations(AIndex: Integer): TFDExpressionCollation;
begin
  Result := TFDExpressionCollation(FCollations.Objects[AIndex]);
end;

{-------------------------------------------------------------------------------}
procedure TFDExpressionManager.AddCollation(const AName: String;
  AEncoding: TFDEncoding; ACall: TFDExpressionCompare);
var
  oColl: TFDExpressionCollation;
  sUCName: String;
  i: Integer;
begin
  sUCName := UpperCase(AName);
  if FCollations.Find(sUCName, i) then
    oColl := TFDExpressionCollation(FCollations.Objects[i])
  else begin
    oColl := TFDExpressionCollation.Create;
    oColl.FName := AName;
    FCollations.AddObject(sUCName, oColl);
  end;
  if AEncoding = ecDefault then
    AEncoding := ecUTF16;
  oColl.FCalls[AEncoding] := ACall;
end;

{-------------------------------------------------------------------------------}
procedure TFDExpressionManager.RemoveCollation(const AName: String; AEncoding: TFDEncoding);
var
  i: Integer;
begin
  i := FindCollation(AName, AEncoding);
  if i <> -1 then
    FCollations.Delete(i);
end;

{-------------------------------------------------------------------------------}
function TFDExpressionManager.FindCollation(const AName: String;
  AEncoding: TFDEncoding): Integer;
begin
  Result := -1;
  if not FCollations.Find(UpperCase(AName), Result) then
    Result := -1
  else begin
    if AEncoding = ecDefault then
      AEncoding := ecUTF16;
    if not Assigned(TFDExpressionCollation(FCollations.Objects[Result]).FCalls[AEncoding]) then
      Result := -1;
  end;
end;

{-------------------------------------------------------------------------------}
var
  FExpressionManager: TFDExpressionManager = nil;

function FDExpressionManager(): TFDExpressionManager;
begin
  if FExpressionManager = nil then
    FExpressionManager := TFDExpressionManager.Create;
  Result := FExpressionManager;
end;

{-------------------------------------------------------------------------------}
var
  oFact: TFDFactory;

initialization
  oFact := TFDMultyInstanceFactory.Create(TFDExpressionParser, IFDStanExpressionParser);
  rDateTimeFS.DateSeparator := '-';
  rDateTimeFS.TimeSeparator := ':';
  rDateTimeFS.ShortDateFormat := 'yyyy/mm/dd';
  rDateTimeFS.ShortTimeFormat := 'hh:nn:ss';

finalization
  FDFreeAndNil(FExpressionManager);
  FDReleaseFactory(oFact);

end.
