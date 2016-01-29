{*********************************************************}
{*                   TESTBCD.DPR 1.05                    *}
{*                     Test Program                      *}
{*   Copyright (c) TurboPower Software Co., 1996, 1998   *}
{*                 All rights reserved.                  *}
{*********************************************************}

{***WARNING*** if running this app from within the IDE, turn off the
               Break on Exception flag}

program Testbcd;

uses
  Stbcd;

var
  O : TextFile;

procedure testgenfmtbcd(s : string);
var
  b : tbcd;
begin
  b := valbcd(s);
  writeln(o, 'strgeneralbcd(', s, ') ?= ', strgeneralbcd(b));
end;

procedure testformatbcd(s : string);
const
  maskcount = 10;
  masks : array[1..maskcount] of string[20] = (
  '',
  '0',
  '0.00',
  '#.##',
  '#,##0.00',
  '#,##0.00;(#,##0.00)',
  '#,##0.00;;Zero',
  '#,##0.00;;"Zero"',
  '0.000E+00',
  '#.###E-0'
  );
var
  i : integer;
  b : tbcd;
begin
  b := valbcd(s);
  for i := 1 to MaskCount do
    writeln(o, 'formatbcd(', s, ', ', masks[i], ') ?= ', formatbcd(masks[i], b));
  writeln(o);
end;

procedure testpowbcd(sb, se : string);
var
  b, e : tbcd;
begin
  b := valbcd(sb);
  e := valbcd(se);
  writeln(o, copy(sb, 1, 10), '**', copy(se, 1, 10), ' ?= ',
    strexpbcd(powbcd(b, e), 0));
end;

procedure testlnbcd(s : string);
var
  b : tbcd;
begin
  b := valbcd(s);
  writeln(o, 'ln(', copy(s, 1, 10), ') ?= ', strexpbcd(lnbcd(b), 0));
end;

procedure testexpbcd(s : string);
var
  b : tbcd;
begin
  b := valbcd(s);
  writeln(o, 'exp(', s, ') ?= ', strexpbcd(expbcd(b), 0));
end;

procedure testsqrtbcd(s : string);
var
  b : tbcd;
begin
  b := valbcd(s);
  writeln(o, 'sqrt(', s, ') ?= ', strexpbcd(sqrtbcd(b), 0));
end;

procedure testdivbcd(s1, s2 : string);
var
  b1, b2 : tbcd;
begin
  b1 := valbcd(s1);
  b2 := valbcd(s2);
  write(o, s1, '/', s2, ' ?= ');
  writeln(o, strexpbcd(divbcd(b1, b2), 0));
end;

procedure testextbcd(e : extended);
var
  b : tbcd;
begin
  write(o, 'extbcd(', e:30:18, ') ?= ');
  b := extbcd(e);
  if abs(e) > 1.0e18 then
    writeln(o, strexpbcd(b, 0))
  else
    writeln(o, strbcd(b, 0, mantissadigits));
end;

procedure testbcdext(s : string);
var
  b : tbcd;
  e : extended;
begin
  write(o, 'bcdext(', s, ') ?= ');
  b := valbcd(s);
  e := bcdext(b);
  writeln(o, e:30:18);
end;

procedure testlongbcd(l : longint);
var
  b : tbcd;
begin
  write(o, l, ' ?= ');
  b := longbcd(l);
  writeln(o, strbcd(b, 0, mantissadigits));
end;

procedure testeqplacesbcd(s1, s2 : string; places : cardinal);
var
  b1, b2 : tbcd;
begin
  b1 := valbcd(s1);
  b2 := valbcd(s2);
  write(o, s1, ' ');
  if eqplacesbcd(b1, b2, places) then
    write(o, '=')
  else
    write(o, '<>');
  writeln(o, ' ', s2, ' (to ', places, ' decimal places)');
end;

procedure testcmpbcd(s1, s2 : string);
var
  c : integer;
  b1, b2 : tbcd;
begin
  b1 := valbcd(s1);
  b2 := valbcd(s2);
  write(o, s1, ' ');
  c := cmpbcd(b1, b2);
  if c < 0 then
    write(o, '<')
  else if c > 0 then
    write(o, '>')
  else
    write(o, '=');
  writeln(o, ' ', s2);
end;

procedure testfracbcd(s : string);
var
  b : tbcd;
begin
  b := valbcd(s);
  writeln(o, 'frac(', s, ') = ', strbcd(fracbcd(b), 0, MantissaDigits));
end;

procedure testintbcd(s : string);
var
  b : tbcd;
begin
  b := valbcd(s);
  writeln(o, 'int(', s, ') = ', strbcd(intbcd(b), 0, MantissaDigits));
end;

procedure testroundbcd(s : string);
var
  b : tbcd;
begin
  b := valbcd(s);
  writeln(o, 'round(', s, ') = ', roundbcd(b));
end;

procedure testtruncbcd(s : string);
var
  b : tbcd;
begin
  b := valbcd(s);
  write(o, 'trunc(', s, ') = ');
  writeln(o, truncbcd(b));
end;

procedure testroundplaces(s : string);
var
  places : cardinal;
  b : tbcd;
begin
  writeln(o, s, ' = (rounded to places)');
  b := valbcd(s);
  for places := 0 to mantissadigits do
    writeln(o, strbcd(roundplacesbcd(b, places), 0, MantissaDigits), ' (', places, ')');
  writeln(o);
end;

procedure testrounddigits(s : string);
var
  digits : cardinal;
  b : tbcd;
begin
  writeln(o, s, ' = (rounded to digits)');
  b := valbcd(s);
  for digits := 0 to mantissadigits do
    writeln(o, strexpbcd(rounddigitsbcd(b, digits), 0), ' (', digits, ')');
  writeln(o);
end;

procedure teststr(s : string);
var
  w : cardinal;
  b : tbcd;
begin
  writeln(o, 'strbcd(', s, ') ?=');
  b := valbcd(s);
  for w := 0 to 10 do
    writeln(o, strbcd(b, 0, w));
  writeln(o);
end;

procedure teststr2(s : string; w, p : cardinal);
var
  b : tbcd;
begin
  writeln(o, 'strbcd(', s, ', ', w, ', ', p, ') ?=');
  b := valbcd(s);
  writeln(o, strbcd(b, w, p));
end;

procedure testval(s : string);
var
  b : tbcd;
begin
  b := valbcd(s);
  writeln(o, 'valbcd(', s, ') ?=', strexpbcd(b, 0));
end;

procedure testadd(s1, s2 : string);
var
  b1, b2 : tbcd;
begin
  b1 := valbcd(s1);
  b2 := valbcd(s2);
  writeln(o, s1, ' + ', s2, ' ?= ', strexpbcd(addbcd(b1, b2), 0));
end;

procedure testmul(s1, s2 : string);
var
  b1, b2 : tbcd;
begin
  b1 := valbcd(s1);
  b2 := valbcd(s2);
  writeln(o, s1, ' * ', s2, ' ?= ', strexpbcd(mulbcd(b1, b2), 0));
end;

procedure writedivider;
begin
  writeln(o, ^M^J'----------------'^M^J);
end;

begin
  assign(O, 'TBCD.OUT');
  rewrite(O);

  testdivbcd('1.0', '1.0');
  testdivbcd('1.0', '2.0');
  testdivbcd('2.0', '1.0');
  testdivbcd('1.0', '3.0');
  testdivbcd('2.0', '3.0');
  testdivbcd('1.65', '0.55');
  testdivbcd('1.011E6', '5.4962E2');
  testdivbcd('-1.0', '1.0');
  testdivbcd('1.0', '-2.0');
  testdivbcd('2.0', '-1.0');
  testdivbcd('-1.0', '3.0');
  testdivbcd('-1.65', '0.55');
  testdivbcd('1.011E6', '-5.4962E2');
  testdivbcd('1.0e-33', '2.0e+33');
  testdivbcd('1.0e-32', '2.0e+32');
  testdivbcd('1.0e-31', '2.0e+31');
  testdivbcd('2.0e-33', '1.0e+33');
  testdivbcd('2.0e-32', '1.0e+32');
  testdivbcd('2.0e-31', '1.0e+31');
  testdivbcd('1.0', '9.0');
  testdivbcd('0.999999999999999999', '0.111111111111111110');
  try
    testdivbcd('2.0e+33', '1.0e-33');
  except
    writeln(o, 'caught expected overflow error');
  end;
  try
    testdivbcd('2.0e+32', '1.0e-32');
  except
    writeln(o, 'caught expected overflow error');
  end;
  testdivbcd('2.0e+31', '1.0e-31');
  testdivbcd('1.0e+34', '1.01e-30');
  try
    testdivbcd('1.0e+34', '0.99e-30');
  except
    writeln(o, 'caught expected overflow error');
  end;
  try
    testdivbcd('1.0', '0.0');
  except
    writeln(o, 'caught expected divide by zero error');
  end;
  writedivider;

  testformatbcd('1234');
  testformatbcd('-1234');
  testformatbcd('0.5');
  testformatbcd('0');

  writedivider;

  testgenfmtbcd('1234');
  testgenfmtbcd('1234.1');
  testgenfmtbcd('0');
  testgenfmtbcd('12345678901234567890123');
  testgenfmtbcd('0.000001');
  testgenfmtbcd('1.2345E+40');
  testgenfmtbcd('-1234');
  testgenfmtbcd('0.5');

  writedivider;

  testexpbcd('0.0');
  testexpbcd('1.0');
  testexpbcd('-1.0');
  testexpbcd('2.0');
  testexpbcd('10.0');
  testexpbcd('11.0');
  testexpbcd('-10.0');
  testexpbcd('-11.0');

  writedivider;

  testpowbcd('1.0', '1.0');
  testpowbcd('2.0', '0.5');
  testpowbcd('2.0', '0.333333333333333333333333333333333333333333333333333');
  testpowbcd('2.0', '-1.0');

  writedivider;

  testlnbcd('10.0');
  testlnbcd('2.0');
  testlnbcd('3.0');
  testlnbcd('2.7182818284590452353602874713526624977572');
  testlnbcd('1.0e6');
  testlnbcd('0.001');

  writedivider;

  testsqrtbcd('1.0');
  testsqrtbcd('2.0');
  testsqrtbcd('0.1');
  testsqrtbcd('3.0');
  testsqrtbcd('100.0');
  testsqrtbcd('0.01');

  writedivider;

  testlongbcd(0);
  testlongbcd(1);
  testlongbcd(-1);
  testlongbcd(1000);
  testlongbcd(-999);
  testlongbcd(maxlongint);
  testlongbcd(-maxlongint-1);

  writedivider;

  testextbcd(0.99);
  testextbcd(1.0);
  testextbcd(-0.99);
  testextbcd(-1.0);
  testextbcd(0.0);
  testextbcd(1.0E63);
  testextbcd(-1.0E63);

  writedivider;

  testeqplacesbcd('1', '1', 1);
  testeqplacesbcd('0.99', '0.98', 1);
  testeqplacesbcd('0.99', '0.98', 2);
  testeqplacesbcd('-0.99', '-0.98', 1);
  testeqplacesbcd('-0.99', '-0.98', 2);
  testeqplacesbcd('1.0', '0.99', 1);
  testeqplacesbcd('1.0', '0.99', 2);
  testeqplacesbcd('-1.0', '-0.99', 1);
  testeqplacesbcd('-1.0', '-0.99', 2);
  testeqplacesbcd('10000.001', '10000.0011', 2);
  testeqplacesbcd('10000.001', '10000.002', 2);
  testeqplacesbcd('10000.001', '10000.005', 2);
  testeqplacesbcd('10000.001', '10000.009', 2);
  testeqplacesbcd('10000.001', '10000.01', 2);

  writedivider;

  testcmpbcd('-1', '1');
  testcmpbcd('1', '-1');
  testcmpbcd('0', '0');
  testcmpbcd('0', '1');
  testcmpbcd('-1', '0');
  testcmpbcd('-1', '-1');
  testcmpbcd('0.99', '0.98');
  testcmpbcd('-0.99', '-0.98');
  testcmpbcd('0.1', '1.0');
  testcmpbcd('-0.1', '-1.0');

  writedivider;

  testfracbcd('1.0');
  testfracbcd('1.1');
  testfracbcd('0');
  testfracbcd('-1.0');
  testfracbcd('-1.1');
  testfracbcd('1000.9');
  testfracbcd('0.1');
  testfracbcd('-1000.9');
  testfracbcd('-0.1');
  testfracbcd('0.0001');
  testfracbcd('9999.999');
  testfracbcd('2147483647');
  testfracbcd('-2147483647');

  writedivider;

  testintbcd('1.0');
  testintbcd('1.1');
  testintbcd('0');
  testintbcd('-1.0');
  testintbcd('-1.1');
  testintbcd('1000.9');
  testintbcd('0.1');
  testintbcd('-1000.9');
  testintbcd('-0.1');
  testintbcd('0.0001');
  testintbcd('9999.999');
  testintbcd('2147483647');
  testintbcd('-2147483647');

  writedivider;

  testroundbcd('1.0');
  testroundbcd('1.1');
  testroundbcd('0');
  testroundbcd('-1.0');
  testroundbcd('-1.1');
  testroundbcd('1000.9');
  testroundbcd('0.5');
  testroundbcd('-1000.9');
  testroundbcd('-0.5');
  testroundbcd('9999.999');
  testroundbcd('2147483647.0');
  testroundbcd('-2147483647.0');
  try
    testroundbcd('2147483647.5');
  except
    writeln(o, 'caught expected overflow error');
  end;
  testroundbcd('-2147483647.5');

  writedivider;

  testtruncbcd('1.0');
  testtruncbcd('1.1');
  testtruncbcd('0');
  testtruncbcd('-1.0');
  testtruncbcd('-1.1');
  testtruncbcd('1000.9');
  testtruncbcd('0.1');
  testtruncbcd('-1000.9');
  testtruncbcd('-0.1');
  testtruncbcd('0.0001');
  testtruncbcd('9999.999');
  testtruncbcd('2147483647');
  testtruncbcd('-2147483647');
  testtruncbcd('-2147483648');
  try
    testtruncbcd('2147483648');
  except
    writeln(o, 'caught expected overflow error');
  end;

  writedivider;

  testroundplaces('123456789.01234');
  testroundplaces('0.0123456789');
  testroundplaces('9.87654321');

  writedivider;

  testrounddigits('-0.0123456789');
  testrounddigits('-9.87654321');
  testrounddigits('0.0123456789');
  testrounddigits('9.87654321');

  writedivider;

  teststr('1.2345678901234567890123E+1');
  teststr('1');
  teststr('0.0005');
  teststr('1');
  teststr('-5E-1');
  teststr('0.500');
  teststr('0');
  teststr('1000.0001');
  teststr('-12345.678');

  writedivider;

  teststr2('57.29577951', 7, 5);
  teststr2('57.29577951', 8, 5);
  teststr2('57.29577951', 9, 5);

  writedivider;

  testadd('0.5', '0.5');
  testadd('0.5', '-0.5');
  testadd('0.5', '1.0');
  testadd('0.5', '-1.0');
  testadd('0.5000000001', '0.4999999999');
  testadd('1.0000000000', '-0.9999999999');
  testadd('1.0', '-0.9');
  testadd('1.0', '-0.9999999999');
  testadd('-0.9999999999', '1.0');
  testadd('1.0E10', '1.0E-10');
  testadd('1.0E10', '1.0E-8');
  testadd('1.0E10', '1.0E-7');
  testadd('1.0E10', '-1.0E-10');
  testadd('1.0E10', '-1.0E-8');
  testadd('1.0E10', '-1.0E-7');
  testadd('9.99999999999999990E9', '1.0E-7');

  writedivider;

  testmul('1.0', '0.0');
  testmul('1.0', '1.0');
  testmul('1.0', '-1.0');
  testmul('-1.0', '-1.0');
  testmul('123', '456');
  testmul('999', '999');
  testmul('456', '789');
  testmul('1.001', '1.002');
  testmul('1.00001', '1.00002');

  writedivider;

  testval('0.9999999999999999999999999999999999999999');
  testval('0.0005');
  testval('1');
  testval('1.2345678901234567890123E+1');
  testval('-5E-1');
  testval('0.500');
  testval('.500');
  testval('5.000E-01');
  testval('0');

  writedivider;

  testbcdext('1.234');
  testbcdext('1.111e-63');
  testbcdext('9.8e+63');
  testbcdext('-0.000001');

  writedivider;

  if cmpbcd(valbcd('0.0'), zerobcd) <> 0 then
    writeln(o, 'zerobcd is wrong');
  if cmpbcd(valbcd('3.1415926535897932384626433832795028841971'), pibcd) <> 0 then
    writeln(o, 'pibcd is wrong');
  if cmpbcd(valbcd('2.3025850929940456840179914546843642076011'), ln10bcd) <> 0 then
    writeln(o, 'ln10bcd is wrong');

  close(O);
end.
