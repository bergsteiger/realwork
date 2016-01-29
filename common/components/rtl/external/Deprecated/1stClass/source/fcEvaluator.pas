unit fcEvaluator;

interface

uses Classes, SysUtils, fcCommon;

type
  TOperator = (opMultiply, opDivide, opAdd, opSubtract);
  TOperators = set of TOperator;

  TfcEvaluator = class
  protected
    class function GetOperands(s: string; Operators: TOperators;
      var LOperand, ROperand: string; var FoundOp: TOperator): Boolean;
    class procedure ValidateString(s: String);
    class procedure FixString(var s: String);
  public
    class function Evaluate(s: string): Integer;
  end;

const
  OPERATORSCHAR: array[TOperator] of Char = ('*', '/', '+', '-');

implementation

class function TfcEvaluator.GetOperands(s: string; Operators: TOperators;
  var LOperand, ROperand: string; var FoundOp: TOperator): Boolean;
var OpIndex, CurOpIndex: Integer;
    CurOp: TOperator;
begin
  OpIndex := -1;
  for CurOp := Low(TOperator) to High(TOperator) do
    if (CurOp in Operators) then
    begin
      CurOpIndex := fcFindToken(s, ' ', OPERATORSCHAR[CurOp]);
      if (CurOpIndex <> -1) and ((OpIndex = -1) or (CurOpIndex < OpIndex)) then
      begin
        OpIndex := CurOpIndex;
        FoundOp := CurOp;
      end;
    end;
  if OpIndex = -1 then
  begin
    result := False;
    Exit;
  end;
  LOperand := fcGetToken(s, ' ', OpIndex - 1);
  ROperand := fcGetToken(s, ' ', OpIndex + 1);
  result := True;
end;

class procedure TfcEvaluator.ValidateString(s: String);
var i: Integer;
begin
  for i := 1 to Length(s) do
    if (not (s[i] in ['+', '-', '*', '/', ',', ' '])) and (not (ord(s[i]) in [48..57])) then
      raise EInvalidOperation.Create('Only alpha characters "+", "-", "x", and "/" are allowed.');
end;

class procedure TfcEvaluator.FixString(var s: String);
var CurOp: TOperator;
begin
  for CurOp := Low(TOperator) to High(TOperator) do
    s := fcReplace(s, OPERATORSCHAR[CurOp], ' ' + OPERATORSCHAR[CurOp] + ' ');
  while Pos('  ', s) > 0 do
    s := fcReplace(s, '  ', ' ');
end;

class function TfcEvaluator.Evaluate(s: string): Integer;
var LOperand, ROperand: string;
    IntLOperand, IntROperand: Integer;
    FoundOp: TOperator;
    CurResult: Integer;
begin
  ValidateString(s);
  FixString(s);
  CurResult := -1;
  while GetOperands(s, [opMultiply, opDivide], LOperand, ROperand, FoundOp) or
        GetOperands(s, [opAdd, opSubtract], LOperand, ROperand, FoundOp) do
  begin
    IntLOperand := StrtoInt(LOperand);
    IntROperand := StrtoInt(ROperand);
    case FoundOp of
      opMultiply: CurResult := IntLOperand * IntROperand;
      opDivide: if IntROperand <> 0 then CurResult := IntLOperand div IntROperand
                else raise EInvalidOperation.Create('Divide By Zero Error');
      opAdd: CurResult := IntLOperand + IntROperand;
      opSubtract: CurResult := IntLOperand - IntROperand;
    end;
    s := fcReplace(s, LOperand + ' ' + OPERATORSCHAR[FoundOp] + ' ' + ROperand, InttoStr(CurResult));
  end;
  result := StrToInt(s);
end;

end.


