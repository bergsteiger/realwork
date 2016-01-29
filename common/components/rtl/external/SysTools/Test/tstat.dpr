{*********************************************************}
{*                    TSTAT.DPR 2.00                     *}
{*                     Test Program                      *}
{*        Copyright (c) TurboPower Software Co. 1998.    *}
{*                 All rights reserved.                  *}
{*********************************************************}

program TStat;

{$IFNDEF Win32}
  !! error: this program designed for 32-bit operation only
{$ENDIF}

{$APPTYPE CONSOLE}

uses
  StStat;

const
  Data1 : array[1..10] of double = (
    1, 5, 3, 9, 6, 7, 10, 2, 4, 8
  );

  Data2 : array[1..10] of double = (
    10, 9, 8, 7, 6, 5, 4, 3, 2, 1
  );

  Data3 : array[1..18] of double = (
    1,1,6,5,5,5,1,2,1,6,2,7,19,6,6,3,6,2
  );

  Data4 : array[1..17] of double = (
    1,1,6,3.5,5,5.5,1,2,1,6,2,7,19,6,6,3,6
  );

var
  i : integer;
  counts : array[0..3] of longint;
  counts2 : array[0..4] of longint;
  LF : TStLinEst;

begin

  writeln('avedev ', avedev(Data1):0:6, ' ?= 2.5');

  writeln('correlation ', correlation([3,2,4,5,6], [9,7,12,15,17]):0:6, ' ?= 0.997054');
  writeln('correlation ', correlation(Data1, Data2):0:6, ' ?= -0.33333');

  writeln('covariance ', covariance([3,2,4,5,6], [9,7,12,15,17]):0:6, ' ?= 5.2');
  writeln('covariance ', covariance(Data1, Data2):0:6, ' ?= -2.75');

  writeln('devsq ', devsq(Data1):0:6, ' ?= 82.5');
  writeln('devsq ', devsq(Data2):0:6, ' ?= 82.5');
  writeln('devsq ', devsq([4,5,8,7,11,4,3]):0:6, ' ?= 48');

  writeln('geometricmean ', geometricmean(Data1):0:6, ' ?= 4.528729');
  writeln('geometricmean ', geometricmean(Data2):0:6, ' ?= 4.528729');

  writeln('harmonicmean ', harmonicmean(Data1):0:6, ' ?= 3.414172');
  writeln('harmonicmean ', harmonicmean(Data2):0:6, ' ?= 3.414172');

  writeln('median ', median(Data1):0:6, ' ?= 5.5');
  writeln('median ', median(Data3):0:6, ' ?= 5');
  writeln('median ', median(Data4):0:6, ' ?= 5');

  writeln('mode ', mode(Data3):0:0, ' ?= 6');

  writeln('trimmean ', trimmean([79,85,78,85,83,81,95,88,97], 0.1):0:6, ' ?= 85.66667');
  writeln('trimmean ', trimmean([79,85,78,85,83,81,95,88,97], 0.2):0:6, ' ?= 85.66667');
  writeln('trimmean ', trimmean([79,85,78,85,83,81,95,88,97], 0.3):0:6, ' ?= 85.14286');


  write('frequency ');
  frequency([79,85,78,85,83,81,95,88,97], [70,79,89], counts);
  for i := low(counts) to high(counts) do
    write(counts[i], ' ');
  writeln;
  writeln(' ?= 0,2,5,2');

  write('frequency ');
  frequency([99,97,95,93,91,89,87,85,83,81,79,77,75,73,71,69,
             67,65,63,61,59,57,55,53,51], [59,69,79,89], counts2);
  for i := low(counts2) to high(counts2) do
    write(counts2[i], ' ');
  writeln;
  writeln(' ?= 5,5,5,5,5');

  writeln('largest smallest');
  for i := low(Data1) to high(Data1) do
    writeln(Largest(Data1, i):5:0, ' ', Smallest(Data1, i):5:0);

  writeln('percentile ', percentile([1,2,3,4],0.3):0:6, ' ?= 1.9');
  writeln('percentile ', percentile([1,2,3,4,5],0.5):0:6, ' ?= 3.0');

  writeln('percentrank ', percentrank([1,2,3,4,5,6,7,8,9,10], 4):0:6, ' ?= 0.33333');
  writeln('percentrank ', percentrank([1,2,3,4,5,6,7,8,9,10], 3.5):0:6, ' ?= 0.27777');

  writeln('rank ', rank(1.0, Data2, false), ' ?= 1');
  writeln('rank ', rank(1.0, Data2, true), ' ?= 10');
  writeln('rank ', rank(5.0, Data2, false), ' ?= 5');
  writeln('rank ', rank(5.0, [1,2,3,3,3,4,5,5,5,6,7], true), ' ?= 7');
  writeln('rank ', rank(7.0, [1,2,3,3,3,4,5,5,5,6,7], true), ' ?= 11');

  writeln('permutations ', permutations(3,2):0:0, ' ?= 6');
  writeln('permutations ', permutations(1,0):0:0, ' ?= 1');
  writeln('permutations ', permutations(5,4):0:0, ' ?= 120');
  writeln('permutations ', permutations(20,10):0:0, ' ?= 670442670162');

  writeln('combinations ', combinations(3,2):0:0, ' ?= 3');
  writeln('combinations ', combinations(1,0):0:0, ' ?= 1');
  writeln('combinations ', combinations(5,4):0:0, ' ?= 5');
  writeln('combinations ', combinations(20,10):0:0, ' ?= 184756');

  writeln('factorial ', factorial(0):0:0, ' ?= 1');
  writeln('factorial ', factorial(1):0:0, ' ?= 1');
  writeln('factorial ', factorial(2):0:0, ' ?= 2');
  writeln('factorial ', factorial(3):0:0, ' ?= 6');
  writeln('factorial ', factorial(4):0:0, ' ?= 24');
  writeln('factorial ', factorial(5):0:0, ' ?= 120');
  writeln('factorial ', factorial(10):0:0, ' ?= 3628800');
  writeln('factorial ', factorial(20), ' ?= 2.43290202E+0018');
  writeln('factorial ', factorial(30), ' ?= 2.65252890E+0032');
  writeln('factorial ', factorial(40), ' ?= 8.15915976E+0047');
  writeln('factorial ', factorial(50), ' ?= 3.04141233E+0064');

  writeln('linest');
  Linest([1,9,5,7],[0,4,2,3], LF, true);
  with LF do begin
    writeln(B0:0:6, ' ? = 1');
    writeln(B1:0:6, ' ? = 2');
    writeln(seB0:0:6, ' ? = 0');
    writeln(seB1:0:6, ' ? = 0');
    writeln(R2:0:6, ' ? = 1.0');
    writeln(sigma:0:6, ' ? = 0.0');
    writeln(SSr:0:6, ' ? = 35');
    writeln(SSe:0:6, ' ? = 0');
    writeln(F0:0:6, ' ? = num!');
    writeln(df, ' ? = 2');
  end;

  writeln('linest');
  linest([33100, 47300, 69000, 102000, 150000, 220000],
         [11,12,13,14,15,16], LF, true);
  with LF do begin
    writeln(B0:0:6, ' ? = -388450.48');
    writeln(B1:0:6, ' ? = 36445.7');
    writeln(seB0:0:6, ' ? = 68935.9');
    writeln(seB1:0:6, ' ? = 5065.99');
    writeln(R2:0:6, ' ? = 0.928');
    writeln(sigma:0:6, ' ? = 21192.55');
    writeln(SSr:0:6, ' ? = 23245076571');
    writeln(SSe:0:6, ' ? = 1796496762');
    writeln(F0:0:6, ' ? = 51.756');
    writeln(df, ' ? = 4');
  end;

  writeln('logest');
  LogEst([33100, 47300, 69000, 102000, 150000, 220000],
         [11,12,13,14,15,16], LF, true);
  with LF do begin
    writeln(B0:0:6, ' ? = 495.305');
    writeln(B1:0:6, ' ? = 1.46327');
    writeln(seB0:0:6, ' ? = 0.0358');
    writeln(seB1:0:6, ' ? = 0.002633');
    writeln(R2:0:6, ' ? = 0.9998');
    writeln(sigma:0:6, ' ? = 0.011');
    writeln(SSr:0:6, ' ? = 2.536');
    writeln(SSe:0:6, ' ? = 0.000485');
    writeln(F0:0:6, ' ? = 20896.8');
    writeln(df, ' ? = 4');
  end;

  writeln('forecast ', Forecast(30, [6,7,9,15,21], [20,28,31,38,40]):0:6, ' ?= 10.60725');

  writeln('standarderrory ', StandardErrorY([2,3,9,1,8,7,5],[6,5,11,7,5,4,4]):0:6, ' ?= 3.305719');

  writeln('betadist ', betadist(2,8,10,1,3):0:6, ' ?= 0.6854706');

  writeln('betainv ', betainv(0.6854706,8,10,1,3):0:6, ' ?= 2.0');
  writeln('betainv ', betainv(0.00001,8,10,1,3):0:6, ' ?= 1.144');
  writeln('betainv ', betainv(0.99999,8,10,1,3):0:6, ' ?= 2.743');

  writeln('binomdist ', binomdist(6,10,0.5,false):0:6, ' ?= 0.205078');
  writeln('binomdist ', binomdist(6,10,0.5,true):0:6, ' ?= 0.828125');
  writeln('critbinom ', critbinom(6,0.5,0.75), ' ?= 4');
  writeln('critbinom ', critbinom(100,0.5,0.99), ' ?= 62');

  writeln('chidist ', chidist(18.307,10):0:6, ' ?= 0.0500006');
  writeln('chidist ', chidist(4.61,2):0:6, ' ?= 0.09976');
  writeln('chiinv ', chiinv(0.0500006,10):0:6, ' ?= 18.307');
  writeln('chiinv ', chiinv(0.09976,2):0:6, ' ?= 4.61');

  writeln('expondist ', expondist(0.2,10,true):0:6, ' ?= 0.864665');
  writeln('expondist ', expondist(0.2,10,false):0:6, ' ?= 1.353353');

  writeln('fdist ', FDIST(15.20675,6,4):0:6, ' ?= 0.01');
  writeln('fdist ', fdist(3.87,15,4):0:6, ' ?= 0.10');
  writeln('fdist ', fdist(3.52,2,19):0:6, ' ?= 0.05');
  writeln('fdist ', fdist(1.22,120,100000):0:6, ' ?= 0.05');

  writeln('finv ', finv(0.01,6,4):0:6, ' ?= 15.20675');
  writeln('finv ', finv(0.10,15,4):0:6, ' ?= 3.87');
  writeln('finv ', finv(0.05,2,19):0:6, ' ?= 3.52');
  writeln('finv ', finv(0.05,120,100000):0:6, ' ?= 1.22');

  writeln('normsdist ', normsdist(1.333333):0:6, ' ?= 0.908789');
  writeln('normsdist ', normsdist(0.0):0:6, ' ?= 0.5000');
  writeln('normsdist ', normsdist(0.5):0:6, ' ?= 0.6915');
  writeln('normsdist ', normsdist(1.0):0:6, ' ?= 0.8413');
  writeln('normsdist ', normsdist(2.0):0:6, ' ?= 0.9772');
  writeln('normsdist ', normsdist(3.0):0:6, ' ?= 0.9987');

  writeln('normsinv ', normsinv(0.908789):0:6, ' ?= 1.333333');
  writeln('normsinv ', normsinv(0.5):0:6, ' ?= 0.0');
  writeln('normsinv ', normsinv(0.6915):0:6, ' ?= 0.5');
  writeln('normsinv ', normsinv(0.8413):0:6, ' ?= 1.0');
  writeln('normsinv ', normsinv(0.9772):0:6, ' ?= 2.0');
  writeln('normsinv ', normsinv(0.9987):0:6, ' ?= 3.0');

  writeln('normdist ', normdist(4.4333326,1.5,2.2,false):0:6, ' ?= 0.07455');
  writeln('normdist ', normdist(1.5,1.5,2.2,false):0:6, ' ?= 0.18134');
  writeln('normdist ', normdist(2.6,1.5,2.2,false):0:6, ' ?= 0.16003');
  writeln('normdist ', normdist(3.7,1.5,2.2,false):0:6, ' ?= 0.10999');
  writeln('normdist ', normdist(5.9,1.5,2.2,false):0:6, ' ?= 0.02454');
  writeln('normdist ', normdist(8.1,1.5,2.2,false):0:6, ' ?= 0.00201');

  writeln('normdist ', normdist(4.4333326,1.5,2.2,true):0:6, ' ?= 0.908789');
  writeln('normdist ', normdist(1.5,1.5,2.2,true):0:6, ' ?= 0.5000');
  writeln('normdist ', normdist(2.6,1.5,2.2,true):0:6, ' ?= 0.6915');
  writeln('normdist ', normdist(3.7,1.5,2.2,true):0:6, ' ?= 0.8413');
  writeln('normdist ', normdist(5.9,1.5,2.2,true):0:6, ' ?= 0.9772');
  writeln('normdist ', normdist(8.1,1.5,2.2,true):0:6, ' ?= 0.9987');

  writeln('norminv ', norminv(0.908789,1.5,2.2):0:6, ' ?= 4.4333326');
  writeln('norminv ', norminv(0.5000,1.5,2.2):0:6, ' ?= 1.5');
  writeln('norminv ', norminv(0.6915,1.5,2.2):0:6, ' ?= 2.6');
  writeln('norminv ', norminv(0.8413,1.5,2.2):0:6, ' ?= 3.7');
  writeln('norminv ', norminv(0.9772,1.5,2.2):0:6, ' ?= 5.9');
  writeln('norminv ', norminv(0.9987,1.5,2.2):0:6, ' ?= 8.1');
  writeln('norminv ', NORMINV(0.908789,40,1.5):0:6, ' ?= 42');

  writeln('lognormdist ', lognormdist(4,3.5,1.2):0:6, ' ?= 0.039084');
  writeln('loginv ', loginv(0.039084,3.5,1.2):0:6, ' ?= 4');

  writeln('poisson ', poisson(2,5,false):0:6, ' ?= 0.084224');
  writeln('poisson ', poisson(2,5,true):0:6, ' ?= 0.124652');

  writeln('tdist ', tdist(1.333333,60,true):0:6, ' ?= 0.187463');
  writeln('tdist ', tdist(0.0,60,true):0:6, ' ?= 1.0');
  writeln('tdist ', tdist(0.5,60,true):0:6, ' ?= 0.618904');
  writeln('tdist ', tdist(1.0,60,true):0:6, ' ?= 0.321327');
  writeln('tdist ', tdist(2.0,60,true):0:6, ' ?= 0.050033');
  writeln('tdist ', tdist(3.0,60,true):0:6, ' ?= 0.003928');
  writeln('tdist ', tdist(1.96,60,true):0:6, ' ?= 0.054645');

  writeln('tdist ', tdist(1.333333,60,false):0:6, ' ?= 0.093731');
  writeln('tdist ', tdist(0.0,60,false):0:6, ' ?= 0.5');
  writeln('tdist ', tdist(0.5,60,false):0:6, ' ?= 0.309452');
  writeln('tdist ', tdist(1.0,60,false):0:6, ' ?= 0.160663');
  writeln('tdist ', tdist(2.0,60,false):0:6, ' ?= 0.025017');
  writeln('tdist ', tdist(3.0,60,false):0:6, ' ?= 0.001964');
  writeln('tdist ', tdist(1.96,60,false):0:6, ' ?= 0.027322');

  writeln('tinv ', tinv(0.187463,60):0:6, ' ?= 1.333333');
  writeln('tinv ', tinv(1.0,60):0:6, ' ?= 0.0');
  writeln('tinv ', tinv(0.618904,60):0:6, ' ?= 0.5');
  writeln('tinv ', tinv(0.321327,60):0:6, ' ?= 1.0');
  writeln('tinv ', tinv(0.050033,60):0:6, ' ?= 2.0');
  writeln('tinv ', tinv(0.003928,60):0:6, ' ?= 3.0');
  writeln('tinv ', tinv(0.054645,60):0:6, ' ?= 1.96');

  writeln('confidence ', CONFIDENCE(0.05,2.5,50):0:6, ' ?= 0.692951');

  writeln('Press <Enter> to continue');
  readln;
end.