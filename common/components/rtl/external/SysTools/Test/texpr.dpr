{*********************************************************}
{*                    TEXPR.DPR 2.00                     *}
{*                     Test Program                      *}
{*        Copyright (c) TurboPower Software Co. 1998.    *}
{*                 All rights reserved.                  *}
{*********************************************************}

program TExpr;

{$IFDEF Win32}
  {$APPTYPE CONSOLE}
{$ENDIF}

{$I STDEFINE.INC}

uses
  SysUtils,
  StExpr,
{$IFDEF Win32}
  Math
{$ELSE}
  StMath,
  WinCrt
{$ENDIF}
  ;

  procedure test(const exprst : string; expected : double);
  const
    eps = 1.0e-10;
  var
    i : integer;
    res : double;
  begin
    try
      write(exprst, ' ?= ', FloatToStr(expected), ' ');
      res := AnalyzeExpr(exprst);
      if abs(res-expected) > eps then begin
        writeln('error, expected <> computed ', FloatToStr(res));
        halt;
      end else
        writeln('ok');
    except
      on E: EStExprError do begin
        write('error ', E.ErrorCode, ' trapped: ');
        case E.ErrorCode of
          stscExprEmpty:    writeln('empty expression');
          stscExprBadNum:   writeln('error in floating point number');
          stscExprBadChar:  writeln('unknown character');
          stscExprOpndExp:  writeln('expected function, number, sign, or (');
          stscExprNumeric:  writeln('numeric error');
          stscExprBadExp:   writeln('invalid expression');
          stscExprOpndOvfl: writeln('operand stack overflow');
          stscExprUnkFunc:  writeln('unknown function identifier');
          stscExprLParExp:  writeln('left parenthesis expected');
          stscExprRParExp:  writeln('right parenthesis expected');
          stscExprCommExp:  writeln('comma expected');
        else
          writeln('unknown error');
        end;
        for i := 1 to E.ErrorColumn-1 do
          write(' ');
        writeln('^');
      end;
    else
      raise;
    end;
  end;

begin
  test('2-0.5*3', 0.5);
  test('2^0.5+1.0', power(2, 0.5)+1.0);
  test('2^0.5^2', power(2, power(0.5, 2)));
  test('(2.0^0.5)^2.0', 2.0);
  test('2*3+5.0e-1*6.0', 9);
  test('-2.0*3.0+0.5*6', -3);
  test('-1-2-3', -6);
  test('-1*-2*-3', -6);
  test('2.0*-3.0', -6);
  test('2*(3+0.5)*6', 42);
  test('   1.0  + 2.0   ', 3);
  test('1/2/3', 1/6);
  test('1/(2/3)', 1.5);
  test('1*(2+3*(4+5*(6+7*(8+9*(10+11)))))', 1*(2+3*(4+5*(6+7*(8+9*(10+11))))));
  test('((((1.0+2.0))))', 3);
  test('0.5+5.0e-1+50.00E-002-0.05e+1-0.005E2-.5', 0);
  test('1.+2.-.3', 2.7);
  test('abs(1.0-2)', 1);
  test('exp(ln(2))', 2);
  test('pi*3', 3*pi);
  test('sqrt(2)^2', 2);
  test('round(1.6)', round(1.6));
{$IFDEF Win32}
  test('hypot(1, 2)', hypot(1, 2));
  test('tanh(0.4)', tanh(0.4));
  test('log10(10^0.5)', 0.5);
  test('logn(2, 5.0)', logn(2, 5.0));
{$ENDIF}

  {expected syntax or numeric errors}
  writeln;
  writeln('trap expected errors in the following');
  writeln;
  test('1.0+2...', 0);
  test('1.0e', 0);
  test('1.0e-', 0);
  test('1.0e-sqrt(2)', 0);
  test('1.0-e22-sqrt(2)', 0);
  test('1.0&2.0', 0);
  test('', 0);
  test('*2.0', 0);
  test('     1.0+xxx', 0);
  test('sqrt 2.0', 0);
  test('sqnt(2.0)', 0);
  test('sqrt(2.0,3.0)', 0);
  test('logn(10 5)', 0);
  test('1*(2+3*(4+5*(6+7*(8+9*(10+11))))', 0);
{$IFDEF Win32}
{$IFOPT H+}
  test('1+(2+(3+(4+(5+(6+(7+(8+(9+(10+(11+(12+(13+(14+(15+(16+(17+(18+(19+(20'+
       '+(21+(22+(23+(24+(25+(26+(27+(28+(29+(30+(31+(32+(33+(34+(35+(36+(37'+
       '+(38+(39+(40+(41+(42+(43+(44+(45+(46+(47+(48+(49+(50+(51+(52+(53+(54'+
       '+(55+(56+(57+(58+(59+(60+(61+(62+(63+(64+65)'+
       '))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))', 2145);
{$ENDIF}
{$ENDIF}
  test('1/0', 0);
  test('log10(-1)', 0);
  test('sqrt(-1)+1.0', 0);
end.