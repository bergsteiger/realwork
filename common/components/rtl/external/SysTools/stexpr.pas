{*********************************************************}
{*                   STEXPR.PAS 3.01                     *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}

{$IFNDEF WIN32}
  {$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

unit StExpr;
  {-Expression evaluator component}

interface

uses
  {$IFDEF WIN32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Controls, Messages, StdCtrls, SysUtils,
  {$IFDEF UseMathUnit} Math, {$ENDIF}
  StBase, StConst, StMath;

type
  {TStFloat = Double;}  {TStFloat is defined in StBase}
  {.Z+}
  PStFloat = ^TStFloat;
  {.Z-}

type
  {user-defined functions with up to 3 parameters}
  TStFunction0Param =
    function : TStFloat;
  TStFunction1Param =
    function(Value1 : TStFloat) : TStFloat;
  TStFunction2Param =
    function(Value1, Value2 : TStFloat) : TStFloat;
  TStFunction3Param =
    function(Value1, Value2, Value3 : TStFloat) : TStFloat;

  {user-defined methods with up to 3 parameters}
  TStMethod0Param =
    function : TStFloat
    of object;
  TStMethod1Param =
    function(Value1 : TStFloat) : TStFloat
    of object;
  TStMethod2Param =
    function(Value1, Value2 : TStFloat) : TStFloat
    of object;
  TStMethod3Param =
    function(Value1, Value2, Value3 : TStFloat) : TStFloat
    of object;

  TStGetIdentValueEvent =
    procedure(Sender : TObject; const Identifier : string; var Value : TStFloat)
    of object;

  {.Z+}
  {tokens}
  TStToken = (
    ssStart, ssInIdent, ssInNum, ssInSign, ssInExp, ssEol, ssNum, ssIdent,
    ssLPar, ssRPar, ssComma, ssPlus, ssMinus, ssTimes, ssDiv, ssEqual, ssPower);

const
  StExprOperators : array[ssLPar..ssPower] of Char = '(),+-*/=^';
  {.Z-}

type
  TStExpression = class(TStComponent)
  {.Z+}
  protected {private}
    {property variables}
    FAllowEqual      : Boolean;
    FLastError       : Integer;
    FErrorPos        : Integer;
    FExpression      : string;

    {event variables}
    FOnAddIdentifier : TNotifyEvent;
    FOnGetIdentValue : TStGetIdentValueEvent;

    {internal variables}
    eBusyFlag        : Boolean;
    eCurChar         : Char;
    eExprPos         : Integer;
    eIdentList       : TList;
    eStack           : TList;
    eToken           : TStToken;
    eTokenStr        : string;
    lhs, rhs         : TStFloat;

    {property methods}
    function GetAsInteger : Integer;
    function GetAsString : string;

    {ident list routines}
    function FindIdent(Name : string) : Integer;

    {stack routines}
    procedure StackClear;
    function StackCount : Integer;
    procedure StackPush(const Value : TStFloat);
    function StackPeek : TStFloat;
    function StackPop : TStFloat;
    function StackEmpty : Boolean;

    procedure DoOnAddIdentifier;
    procedure GetBase;
      {-base: unsigned_num | (expression) | sign factor | func_call }
    procedure GetExpression;
      {-expression: term | expression+term | expression-term implemented as loop}
    procedure GetFactor;
      {-factor: base | base^factor}
    procedure GetFunction;
      {-func_call: identifier | identifier(params)}
    procedure GetParams(N : Integer);
      {-params: expression | params,expression}
    procedure GetTerm;
      {-term: factor | term*factor | term/factor implemented as loop}
    procedure GetToken;
      {-return the next token string in eTokenStr and type in eToken}
    function PopOperand : TStFloat;
      {-remove top operand value from stack}
    procedure RaiseExprError(Code : LongInt; Column : Integer);
      {-generate an expression exception}

  public
    constructor Create(AOwner : TComponent);
      override;
    destructor Destroy;
      override;
  {.Z-}

    function AnalyzeExpression : TStFloat;
    procedure AddConstant(const Name : string; Value : TStFloat);
    procedure AddFunction0Param(const Name : string; FunctionAddr : TStFunction0Param);
    procedure AddFunction1Param(const Name : string; FunctionAddr : TStFunction1Param);
    procedure AddFunction2Param(const Name : string; FunctionAddr : TStFunction2Param);
    procedure AddFunction3Param(const Name : string; FunctionAddr : TStFunction3Param);
    procedure AddInternalFunctions;
    procedure AddMethod0Param(const Name : string; MethodAddr : TStMethod0Param);
    procedure AddMethod1Param(const Name : string; MethodAddr : TStMethod1Param);
    procedure AddMethod2Param(const Name : string; MethodAddr : TStMethod2Param);
    procedure AddMethod3Param(const Name : string; MethodAddr : TStMethod3Param);
    procedure AddVariable(const Name : string; VariableAddr : PStFloat);
    procedure ClearIdentifiers;
    procedure GetIdentList(S : TStrings);
    procedure RemoveIdentifier(const Name : string);

    {public properties}
    property AsInteger : Integer
      read GetAsInteger;
    property AsFloat : TStFloat
      read AnalyzeExpression;
    property AsString : string
      read GetAsString;
    property ErrorPosition : Integer
      read FErrorPos;
    property Expression : string
      read FExpression write FExpression;
    property LastError : Integer
      read FLastError;

  published
    property AllowEqual : Boolean
      read FAllowEqual write FAllowEqual default True;

    property OnAddIdentifier : TNotifyEvent
      read FOnAddIdentifier write FOnAddIdentifier;
    property OnGetIdentValue : TStGetIdentValueEvent                   
      read FOnGetIdentValue write FOnGetIdentValue;
  end;


type
  TStExprErrorEvent =
    procedure(Sender : TObject; ErrorNumber : LongInt; const ErrorStr : string)
    of object;

type
  TStExpressionEdit = class(TEdit)
  {.Z+}
  protected {private}
    {property variables}
    FAutoEval : Boolean;
    FExpr     : TStExpression;
    FOnError  : TStExprErrorEvent;

    {property methods}
    function GetOnAddIdentifier : TNotifyEvent;
    function GetOnGetIdentValue : TStGetIdentValueEvent;
    procedure SetOnAddIdentifier(Value : TNotifyEvent);
    procedure SetOnGetIdentValue(Value : TStGetIdentValueEvent);

    {VCL control methods}
    procedure CMExit(var Msg : TMessage);
      message CM_EXIT;
    procedure DoEvaluate;
  {.Z-}

  protected
    procedure KeyPress(var Key: Char);
      override;

  public
    constructor Create(AOwner : TComponent);
      override;
    destructor Destroy;
      override;

    function Evaluate : TStFloat;

    property Expr : TStExpression
      read FExpr;

  published
    property AutoEval : Boolean
      read FAutoEval write FAutoEval;

    property OnAddIdentifier : TNotifyEvent
      read GetOnAddIdentifier write SetOnAddIdentifier;
    property OnError : TStExprErrorEvent
      read FOnError write FOnError;
    property OnGetIdentValue : TStGetIdentValueEvent                   
      read GetOnGetIdentValue write SetOnGetIdentValue;
  end;

function AnalyzeExpr(const Expr : string) : Double;
  {-Compute the arithmetic expression Expr and return the result}


implementation

{$IFDEF TRIALRUN}
uses
  {$IFDEF Win32} Registry, {$ELSE} Ver, {$ENDIF}
  Forms,
  IniFiles,
  ShellAPI,
  StTrial;
{$I TRIAL00.INC} {FIX}
{$I TRIAL01.INC} {CAB}
{$I TRIAL02.INC} {CC}
{$I TRIAL03.INC} {VC}
{$I TRIAL04.INC} {TCC}
{$I TRIAL05.INC} {TVC}
{$I TRIAL06.INC} {TCCVC}
{$ENDIF}

const
  Alpha = ['A'..'Z', 'a'..'z', '_'];
  Numeric = ['0'..'9', '.'];
  AlphaNumeric = Alpha + ['0'..'9'];

type
  PStIdentRec = ^TStIdentRec;
  {a double-variant record - wow - confusing maybe, but it saves space}
  TStIdentRec = record
    Name     : string;
    Kind     : (ikConstant, ikVariable, ikFunction, ikMethod);
    case Byte of
      0 : (Value : TStFloat);
      1 : (VarAddr : PStFloat);
      2 : (PCount : Integer;
           case Byte of
             0 : (Func0Addr : TStFunction0Param);
             1 : (Func1Addr : TStFunction1Param);
             2 : (Func2Addr : TStFunction2Param);
             3 : (Func3Addr : TStFunction3Param);
             4 : (Meth0Addr : TStMethod0Param);
             5 : (Meth1Addr : TStMethod1Param);
             6 : (Meth2Addr : TStMethod2Param);
             7 : (Meth3Addr : TStMethod3Param);
          )
  end;


{routine for backward compatibility}

function AnalyzeExpr(const Expr : string) : Double;
begin
  with TStExpression.Create(nil) do
    try
      Expression := Expr;
      Result := AnalyzeExpression;
    finally
      Free;
    end;
end;


{*** function definitions ***}

function _Abs(Value : TStFloat) : TStFloat; far;
begin
  Result := Abs(Value);
end;

function _ArcTan(Value : TStFloat) : TStFloat; far;
begin
  Result := ArcTan(Value);
end;

function _Cos(Value : TStFloat) : TStFloat; far;
begin
  Result := Cos(Value);
end;

function _Exp(Value : TStFloat) : TStFloat; far;
begin
  Result := Exp(Value);
end;

function _Frac(Value : TStFloat) : TStFloat; far;
begin
  Result := Frac(Value);
end;

function _Int(Value : TStFloat) : TStFloat; far;
begin
  Result := Int(Value);
end;

function _Trunc(Value : TStFloat) : TStFloat; far;
begin
  Result := Trunc(Value);
end;

function _Ln(Value : TStFloat) : TStFloat; far;
begin
  Result := Ln(Value);
end;

function _Pi : TStFloat; far;
begin
  Result := Pi;
end;

function _Round(Value : TStFloat) : TStFloat; far;
begin
  Result := Round(Value);
end;

function _Sin(Value : TStFloat) : TStFloat; far;
begin
  Result := Sin(Value);
end;

function _Sqr(Value : TStFloat) : TStFloat; far;
begin
  Result := Sqr(Value);
end;

function _Sqrt(Value : TStFloat) : TStFloat; far;
begin
  Result := Sqrt(Value);
end;

{$IFDEF UseMathUnit}
function _ArcCos(Value : TStFloat) : TStFloat; far;
begin
  Result := ArcCos(Value);
end;

function _ArcSin(Value : TStFloat) : TStFloat; far;
begin
  Result := ArcSin(Value);
end;

function _ArcTan2(Value1, Value2 : TStFloat) : TStFloat; far;
begin
  Result := ArcTan2(Value1, Value2);
end;

function _Tan(Value : TStFloat) : TStFloat; far;
begin
  Result := Tan(Value);
end;

function _Cotan(Value : TStFloat) : TStFloat; far;
begin
  Result := CoTan(Value);
end;

function _Hypot(Value1, Value2 : TStFloat) : TStFloat; far;
begin
  Result := Hypot(Value1, Value2);
end;

function _Cosh(Value : TStFloat) : TStFloat; far;
begin
  Result := Cosh(Value);
end;

function _Sinh(Value : TStFloat) : TStFloat; far;
begin
  Result := Sinh(Value);
end;

function _Tanh(Value : TStFloat) : TStFloat; far;
begin
  Result := Tanh(Value);
end;

function _ArcCosh(Value : TStFloat) : TStFloat; far;
begin
  Result := ArcCosh(Value);
end;

function _ArcSinh(Value : TStFloat) : TStFloat; far;
begin
  Result := ArcSinh(Value);
end;

function _ArcTanh(Value : TStFloat) : TStFloat; far;
begin
  Result := ArcTanh(Value);
end;

function _Lnxp1(Value : TStFloat) : TStFloat; far;
begin
  Result := Lnxp1(Value);
end;

function _Log10(Value : TStFloat) : TStFloat; far;
begin
  Result := Log10(Value);
end;

function _Log2(Value : TStFloat) : TStFloat; far;
begin
  Result := Log2(Value);
end;

function _LogN(Value1, Value2 : TStFloat) : TStFloat; far;
begin
  Result := LogN(Value1, Value2);
end;

function _Ceil(Value : TStFloat) : TStFloat; far;
begin
  Result := Ceil(Value);
end;

function _Floor(Value : TStFloat) : TStFloat; far;
begin
  Result := Floor(Value);
end;
{$ENDIF}


{*** TStExpression ***}

procedure TStExpression.AddConstant(const Name : string; Value : TStFloat);
var
  IR : PStIdentRec;
begin
  if FindIdent(Name) > -1 then
    RaiseExprError(stscExprDupIdent, 0);

  New(IR);
  IR^.Name := LowerCase(Name);
  IR^.Kind := ikConstant;
  IR^.Value := Value;
  eIdentList.Add(IR);

  DoOnAddIdentifier;
end;

procedure TStExpression.AddFunction0Param(const Name : string;
          FunctionAddr : TStFunction0Param);
var
  IR : PStIdentRec;
begin
  if FindIdent(Name) > -1 then
    RaiseExprError(stscExprDupIdent, 0);

  New(IR);
  IR^.Name := LowerCase(Name);
  IR^.PCount := 0;
  IR^.Kind := ikFunction;
  IR^.Func0Addr := FunctionAddr;
  eIdentList.Add(IR);

  DoOnAddIdentifier;
end;

procedure TStExpression.AddFunction1Param(const Name : string;
          FunctionAddr : TStFunction1Param);
var
  IR : PStIdentRec;
begin
  if FindIdent(Name) > -1 then
    RaiseExprError(stscExprDupIdent, 0);

  New(IR);
  IR^.Name := LowerCase(Name);
  IR^.PCount := 1;
  IR^.Kind := ikFunction;
  IR^.Func1Addr := FunctionAddr;
  eIdentList.Add(IR);

  DoOnAddIdentifier;
end;

procedure TStExpression.AddFunction2Param(const Name : string;
          FunctionAddr : TStFunction2Param);
var
  IR : PStIdentRec;
begin
  if FindIdent(Name) > -1 then
    RaiseExprError(stscExprDupIdent, 0);

  New(IR);
  IR^.Name := LowerCase(Name);
  IR^.PCount := 2;
  IR^.Kind := ikFunction;
  IR^.Func2Addr := FunctionAddr;
  eIdentList.Add(IR);

  DoOnAddIdentifier;
end;

procedure TStExpression.AddFunction3Param(const Name : string;
          FunctionAddr : TStFunction3Param);
var
  IR : PStIdentRec;
begin
  if FindIdent(Name) > -1 then
    RaiseExprError(stscExprDupIdent, 0);

  New(IR);
  IR^.Name := LowerCase(Name);
  IR^.PCount := 3;
  IR^.Kind := ikFunction;
  IR^.Func3Addr := FunctionAddr;
  eIdentList.Add(IR);

  DoOnAddIdentifier;
end;

procedure TStExpression.AddInternalFunctions;
begin
  eBusyFlag := True;
  try
    {add function name and parameter count to list}
    AddFunction1Param('abs',     _Abs);
    AddFunction1Param('arctan',  _ArcTan);
    AddFunction1Param('cos',     _Cos);
    AddFunction1Param('exp',     _Exp);
    AddFunction1Param('frac',    _Frac);
    AddFunction1Param('int',     _Int);
    AddFunction1Param('trunc',   _Trunc);
    AddFunction1Param('ln',      _Ln);
    AddFunction0Param('pi',      _Pi);
    AddFunction1Param('round',   _Round);
    AddFunction1Param('sin',     _Sin);
    AddFunction1Param('sqr',     _Sqr);
    AddFunction1Param('sqrt',    _Sqrt);
    {$IFDEF UseMathUnit}
    AddFunction1Param('arccos',  _ArcCos);
    AddFunction1Param('arcsin',  _ArcSin);
    AddFunction2Param('arctan2', _ArcTan2);
    AddFunction1Param('tan',     _Tan);
    AddFunction1Param('cotan',   _Cotan);
    AddFunction2Param('hypot',   _Hypot);
    AddFunction1Param('cosh',    _Cosh);
    AddFunction1Param('sinh',    _Sinh);
    AddFunction1Param('tanh',    _Tanh);
    AddFunction1Param('arccosh', _ArcCosh);
    AddFunction1Param('arcsinh', _ArcSinh);
    AddFunction1Param('arctanh', _ArcTanh);
    AddFunction1Param('lnxp1',   _Lnxp1);
    AddFunction1Param('log10',   _Log10);
    AddFunction1Param('log2',    _Log2);
    AddFunction2Param('logn',    _LogN);
    AddFunction1Param('ceil',    _Ceil);
    AddFunction1Param('floor',   _Floor);
    {$ENDIF}
  finally
    eBusyFlag := False;
  end;
end;

procedure TStExpression.AddMethod0Param(const Name : string;
          MethodAddr : TStMethod0Param);
var
  IR : PStIdentRec;
begin
  if FindIdent(Name) > -1 then
    RaiseExprError(stscExprDupIdent, 0);

  New(IR);
  IR^.Name := LowerCase(Name);
  IR^.PCount := 0;
  IR^.Kind := ikMethod;
  IR^.Meth0Addr := MethodAddr;
  eIdentList.Add(IR);

  DoOnAddIdentifier;
end;

procedure TStExpression.AddMethod1Param(const Name : string;
          MethodAddr : TStMethod1Param);
var
  IR : PStIdentRec;
begin
  if FindIdent(Name) > -1 then
    RaiseExprError(stscExprDupIdent, 0);

  New(IR);
  IR^.Name := LowerCase(Name);
  IR^.PCount := 1;
  IR^.Kind := ikMethod;
  IR^.Meth1Addr := MethodAddr;
  eIdentList.Add(IR);

  DoOnAddIdentifier;
end;

procedure TStExpression.AddMethod2Param(const Name : string;
          MethodAddr : TStMethod2Param);
var
  IR : PStIdentRec;
begin
  if FindIdent(Name) > -1 then
    RaiseExprError(stscExprDupIdent, 0);

  New(IR);
  IR^.Name := LowerCase(Name);
  IR^.PCount := 2;
  IR^.Kind := ikMethod;
  IR^.Meth2Addr := MethodAddr;
  eIdentList.Add(IR);

  DoOnAddIdentifier;
end;

procedure TStExpression.AddMethod3Param(const Name : string;
          MethodAddr : TStMethod3Param);
var
  IR : PStIdentRec;
begin
  if FindIdent(Name) > -1 then
    RaiseExprError(stscExprDupIdent, 0);

  New(IR);
  IR^.Name := LowerCase(Name);
  IR^.PCount := 3;
  IR^.Kind := ikMethod;
  IR^.Meth3Addr := MethodAddr;
  eIdentList.Add(IR);

  DoOnAddIdentifier;
end;

procedure TStExpression.AddVariable(const Name : string; VariableAddr : PStFloat);
var
  IR : PStIdentRec;
begin
  if FindIdent(Name) > -1 then
    RaiseExprError(stscExprDupIdent, 0);

  New(IR);
  IR^.Name := LowerCase(Name);
  IR^.Kind := ikVariable;
  IR^.VarAddr := VariableAddr;
  eIdentList.Add(IR);

  DoOnAddIdentifier;
end;

function TStExpression.AnalyzeExpression : TStFloat;
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  FLastError := 0;

  {error if nothing to do}
  if (Length(FExpression) = 0) then
    RaiseExprError(stscExprEmpty, 0);

  {clear operand stack}
  StackClear;

  {get the first character from the string}
  eExprPos := 1;
  eCurChar := FExpression[1];

  {get the first Token and start parsing}
  GetToken;
  GetExpression;

  {make sure expression is fully evaluated}
  if (eToken <> ssEol) or (StackCount <> 1) then
    RaiseExprError(stscExprBadExp, FErrorPos);

  Result := StackPop;
end;

procedure TStExpression.ClearIdentifiers;
var
  I : Integer;
begin
  for I := 0 to eIdentList.Count-1 do
    Dispose(PStIdentRec(eIdentList[I]));
  eIdentList.Clear;
end;

constructor TStExpression.Create(AOwner : TComponent);
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  inherited Create(AOwner);

  eStack := TList.Create;
  eIdentList := TList.Create;

  FAllowEqual := True;

  AddInternalFunctions;
end;

destructor TStExpression.Destroy;
begin
  StackClear;
  eStack.Free;
  eStack := nil;

  ClearIdentifiers;
  eIdentList.Free;
  eIdentList := nil;

  inherited Destroy;
end;

procedure TStExpression.DoOnAddIdentifier;
begin
  if eBusyFlag then
    Exit;
  if Assigned(FOnAddIdentifier) then
    FOnAddIdentifier(Self);
end;

function TStExpression.FindIdent(Name : string) : Integer;
var
  I : Integer;
begin
  Result := -1;
  for I := 0 to eIdentList.Count-1 do begin
    if Name = PStIdentRec(eIdentList[I])^.Name then begin
      Result := I;
      Break;
    end;
  end;
end;

function TStExpression.GetAsInteger : Integer;
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  Result := Round(AnalyzeExpression);
end;

function TStExpression.GetAsString : string;
begin
  Result := FloatToStr(AnalyzeExpression);
end;

procedure TStExpression.GetBase;
var
  SaveSign : TStToken;
  Code     : Integer;
  NumVal   : TStFloat;
begin
  case eToken of
    ssNum :
      begin
        {evaluate real number string}
        if (eTokenStr[1] = '.') then
          {allow leading '.'. Delphi 1 may need this help}
          eTokenStr := '0' + eTokenStr;
        Val(eTokenStr, NumVal, Code);
        if Code <> 0 then
          RaiseExprError(stscExprBadNum, FErrorPos);
        {put on operand stack}
        StackPush(NumVal);
        GetToken;
      end;
    ssIdent :
      {function call}
      GetFunction;
    ssLPar :
      begin
        {nested expression}
        GetToken;
        GetExpression;
        if (eToken <> ssRPar) then
          RaiseExprError(stscExprBadExp, FErrorPos);
        GetToken;
      end;
    ssPlus, ssMinus :
      begin
        {unary sign}
        SaveSign := eToken;
        GetToken;
        GetFactor;
        if (SaveSign = ssMinus) then
          {update operand stack}
          StackPush(-PopOperand);
      end;
  else
    RaiseExprError(stscExprOpndExp, FErrorPos);
  end;
end;

procedure TStExpression.GetExpression;
var
  SaveOp : TStToken;
begin
  GetTerm;
  while (True) do begin
    case eToken of
      ssPlus, ssMinus :
        begin
          SaveOp := eToken;
          GetToken;
          GetTerm;
          rhs := PopOperand;
          lhs := PopOperand;
          try
            case SaveOp of
              ssPlus  : StackPush(lhs+rhs);
              ssMinus : StackPush(lhs-rhs);
            end;
          except
            {note operand stack overflow not possible here}
            RaiseExprError(stscExprNumeric, FErrorPos);
          end;
        end;
    else
      Break;
    end;
  end;
end;

procedure TStExpression.GetFactor;
begin
  GetBase;
  if (eToken = ssPower) then begin
    GetToken;
    GetFactor;
    rhs := PopOperand;
    lhs := PopOperand;
    try
      StackPush(Power(lhs, rhs));
    except
      {note operand stack overflow not possible here}
      RaiseExprError(stscExprNumeric, FErrorPos);
    end;
  end;
end;

procedure TStExpression.GetFunction;
var
  I          : Integer;
  P1, P2, P3 : TStFloat;
  Ident      : PStIdentRec;
  St         : string;
begin
  St := eTokenStr;
  GetToken;

  {is this a request to add a constant? (=)}
  if FAllowEqual and (eTokenStr = '=') then begin
    GetToken;
    GetExpression;
    {leave result on the stack to be returned as the expression result}
    AddConstant(St, StackPeek);
    Exit;
  end;

  I := FindIdent(St);
  if I > -1 then begin
    Ident := eIdentList[I];
    case Ident^.Kind of
      ikConstant : StackPush(Ident^.Value);
      ikVariable : StackPush(PStFloat(Ident^.VarAddr)^);
      ikFunction :
        begin
          {place parameters on stack, if any}
          GetParams(Ident^.PCount);
          try
            case Ident^.PCount of
              0 : StackPush(TStFunction0Param(Ident^.Func0Addr));
              1 : begin
                    P1 := PopOperand;
                    StackPush(TStFunction1Param(Ident^.Func1Addr)(P1));
                  end;
              2 : begin
                    P2 := PopOperand;
                    P1 := PopOperand;
                    StackPush(TStFunction2Param(Ident^.Func2Addr)(P1, P2));
                  end;
              3 : begin
                    P3 := PopOperand;
                    P2 := PopOperand;
                    P1 := PopOperand;
                    StackPush(TStFunction3Param(Ident^.Func3Addr)(P1, P2, P3));
                  end;
            else
              RaiseExprError(stscExprNumeric, FErrorPos);
            end;
          except
            {note operand stack overflow or underflow not possible here}
            {translate RTL numeric errors into STEXPR error}
            RaiseExprError(stscExprNumeric, FErrorPos);
          end;
        end;
      ikMethod   :
        begin
          {place parameters on stack, if any}
          GetParams(Ident^.PCount);
          try
            case Ident^.PCount of
              0 : StackPush(TStMethod0Param(Ident^.Meth0Addr));
              1 : begin
                    P1 := PopOperand;
                    StackPush(TStMethod1Param(Ident^.Meth1Addr)(P1));
                  end;
              2 : begin
                    P2 := PopOperand;
                    P1 := PopOperand;
                    StackPush(TStMethod2Param(Ident^.Meth2Addr)(P1, P2));
                  end;
              3 : begin
                    P3 := PopOperand;
                    P2 := PopOperand;
                    P1 := PopOperand;
                    StackPush(TStMethod3Param(Ident^.Meth3Addr)(P1, P2, P3));
                  end;
            else
              RaiseExprError(stscExprNumeric, FErrorPos);
            end;
          except
            {note operand stack overflow or underflow not possible here}
            {translate RTL numeric errors into STEXPR error}
            RaiseExprError(stscExprNumeric, FErrorPos);
          end;
        end;
    end;
  end else begin
    
    if Assigned(FOnGetIdentValue) then begin
      P1 := 0;
      FOnGetIdentValue(Self, St, P1);
      StackPush(P1);
    end else
      RaiseExprError(stscExprUnkFunc, FErrorPos);
  end;
end;

procedure TStExpression.GetIdentList(S : TStrings);
var
  I    : Integer;
begin
  if Assigned(S) then begin
    S.Clear;
    for I := 0 to eIdentList.Count-1 do
      S.Add(PStIdentRec(eIdentList[I])^.Name);
  end;
end;

procedure TStExpression.GetParams(N : Integer);
begin
  if (N > 0) then begin
    if (eToken <> ssLPar) then
      RaiseExprError(stscExprLParExp, FErrorPos);
    while (N > 0) do begin
      GetToken;
      {evaluate parameter value and leave on stack}
      GetExpression;
      Dec(N);
      if (N > 0) then
        if (eToken <> ssComma) then
          RaiseExprError(stscExprCommExp, FErrorPos);
    end;
    if (eToken <> ssRPar) then
      RaiseExprError(stscExprRParExp, FErrorPos);
    GetToken;
  end;
end;

procedure TStExpression.GetTerm;
var
  SaveOp : TStToken;
begin
  GetFactor;
  while (True) do begin
    case eToken of
      ssTimes, ssDiv :
        begin
          SaveOp := eToken;
          GetToken;
          GetFactor;
          rhs := PopOperand;
          lhs := PopOperand;
          try
            case SaveOp of
              ssTimes :
                StackPush(lhs*rhs);
              ssDiv :
                StackPush(lhs/rhs);
            end;
          except
            {note operand stack overflow not possible here}
            RaiseExprError(stscExprNumeric, FErrorPos);
          end;
        end;
    else
      break;
    end;
  end;
end;

procedure TStExpression.GetToken;
var
  Done : Boolean;
  TT   : TStToken;
begin
  eToken := ssStart;
  eTokenStr := '';
  Done := False;

  while (not Done) do begin
    case eToken of
      ssStart :
        begin
          {save potential error column at start of eTokenStr}
          FErrorPos := eExprPos;
          if (eCurChar = ' ') or (eCurChar = ^I) then
            {skip leading whitespace}
          else if (eCurChar = #0) then begin
            {end of string}
            eToken := ssEol;
            Done := true;
          end else if (eCurChar in Alpha) then begin
            {start of identifier}
            eTokenStr := eTokenStr + LowerCase(eCurChar);
            eToken := ssInIdent;
          end else if (eCurChar in Numeric) then begin
            {start of value}
            eTokenStr := eTokenStr + eCurChar;
            eToken := ssInNum;
          end else begin
            {presumably a single character operator}
            eTokenStr := eTokenStr + eCurChar;
            {make sure it matches a known operator}
            for TT := ssLPar to ssPower do
              if (eCurChar = StExprOperators[TT]) then begin
                Done := True;
                eToken := TT;
                Break;
              end;
            if (not Done) then begin
              {error: unknown character}
              RaiseExprError(stscExprBadChar, FErrorPos);
            end;
            {move to next character}
            Inc(eExprPos);
            if (eExprPos > Length(FExpression)) then
              eCurChar := #0
            else
              eCurChar := FExpression[eExprPos];
          end;
        end;
      ssInIdent :
        if (eCurChar in AlphaNumeric) then
          {continuing in identifier}
          eTokenStr := eTokenStr + LowerCase(eCurChar)
        else begin
          {end of identifier}
          eToken := ssIdent;
          Done := True;
        end;
      ssInNum :
        if (eCurChar in Numeric) then
          {continuing in number}
          eTokenStr := eTokenStr + eCurChar
        else if (LowerCase(eCurChar) = 'e') then begin
          {start of exponent}
          eTokenStr := eTokenStr + LowerCase(eCurChar);
          eToken := ssInSign;
        end else begin
          {end of number}
          eToken := ssNum;
          Done := True;
        end;
      ssInSign :
        if (eCurChar in ['-', '+']) or (eCurChar in Numeric) then begin
          {have exponent sign or start of number}
          eTokenStr := eTokenStr + eCurChar;
          eToken := ssInExp;
        end else begin
          {error: started exponent but didn't finish}
          RaiseExprError(stscExprBadNum, FErrorPos);
        end;
      ssInExp :
        if (eCurChar in Numeric) then
          {continuing in number}
          eTokenStr := eTokenStr + eCurChar
        else begin
          {end of number}
          eToken := ssNum;
          Done := True;
        end;
    end;

    {get next character}
    if (not Done) then begin
      Inc(eExprPos);
      if (eExprPos > Length(FExpression)) then
        eCurChar := #0
      else
        eCurChar := FExpression[eExprPos];
    end;

  end;
end;

function TStExpression.PopOperand : TStFloat;
begin
  if StackEmpty then
    RaiseExprError(stscExprBadExp, FErrorPos);
  Result := StackPop;
end;

procedure TStExpression.RaiseExprError(Code : LongInt; Column : Integer);
var
  E : EStExprError;
begin
  {clear operand stack}
  StackClear;
  FLastError := Code;
  E := EStExprError.CreateResTPCol(Code, Column, 0);
  E.ErrorCode := Code;
  raise E;
end;

procedure TStExpression.RemoveIdentifier(const Name : string);
var
  I : Integer;
  S : string;
begin
  S := LowerCase(Name);
  I := FindIdent(S);
  if I > -1 then begin
    Dispose(PStIdentRec(eIdentList[I]));
    eIdentList.Delete(I);
  end;
end;

procedure TStExpression.StackClear;
var
  I : Integer;
begin
  for I := 0 to eStack.Count-1 do
    Dispose(PStFloat(eStack[I]));
  eStack.Clear;
end;

function TStExpression.StackCount : Integer;
begin
  Result := eStack.Count;
end;

function TStExpression.StackEmpty : Boolean;
begin
  Result := eStack.Count = 0;
end;

function TStExpression.StackPeek : TStFloat;
begin
  Result := PStFloat(eStack[eStack.Count-1])^;
end;

function TStExpression.StackPop : TStFloat;
var
  PF : PStFloat;
begin
  PF := PStFloat(eStack[eStack.Count-1]);
  Result := PF^;
  Dispose(PF);
  eStack.Delete(eStack.Count-1);
end;

procedure TStExpression.StackPush(const Value : TStFloat);
var
  PF : PStFloat;
begin
  New(PF);
  PF^ := Value;
  try
    eStack.Add(PF);
  except
    Dispose(PF);
    raise;
  end;
end;


{*** TStExpressionEdit ***}

procedure TStExpressionEdit.CMExit(var Msg : TMessage);
begin
  inherited;

  if FAutoEval then begin
    try
      DoEvaluate;
    except
      SetFocus;
      raise;
    end;
  end;
end;

constructor TStExpressionEdit.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  FExpr := TStExpression.Create(Self);
end;

destructor TStExpressionEdit.Destroy;
begin
  FExpr.Free;

  inherited Destroy;
end;

procedure TStExpressionEdit.DoEvaluate;
var
  V : TStFloat;
begin
  if Text > '' then begin
    V := Evaluate;
    if FExpr.FLastError = 0 then
      Text := FloatToStr(V)
    else
      SelStart := FExpr.FErrorPos;
  end else
    Text := '0';
end;

function TStExpressionEdit.Evaluate : TStFloat;
begin
  Result := 0;
  FExpr.Expression := Text;
  try
    Result := FExpr.AnalyzeExpression;
  except
    on E : EStExprError do begin
      SelStart := FExpr.FErrorPos;
      if Assigned(FOnError) then
        FOnError(Self, E.ErrorCode, E.Message)
      else
        raise;
    end else
      raise;
  end;
end;

function TStExpressionEdit.GetOnAddIdentifier : TNotifyEvent;
begin
  Result := FExpr.OnAddIdentifier;
end;

function TStExpressionEdit.GetOnGetIdentValue : TStGetIdentValueEvent;
begin
  Result := FExpr.OnGetIdentValue;
end;

procedure TStExpressionEdit.KeyPress(var Key : Char);
begin
  if Key = #13 then begin
    DoEvaluate;
    Key := #0;
    SelStart := Length(Text);
  end;

  inherited KeyPress(Key);
end;

procedure TStExpressionEdit.SetOnAddIdentifier(Value : TNotifyEvent);
begin
  FExpr.OnAddIdentifier := Value;
end;

procedure TStExpressionEdit.SetOnGetIdentValue(Value : TStGetIdentValueEvent);
begin
  FExpr.OngetIdentValue := Value;
end;


end.