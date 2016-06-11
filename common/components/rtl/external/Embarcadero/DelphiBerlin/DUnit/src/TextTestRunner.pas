{ $Id: TextTestRunner.pas 36 2011-04-15 19:26:16Z medington $ }
{: DUnit: An XTreme testing framework for Delphi programs.
   @author  The DUnit Group.
   @version $Revision: 36 $
}
(*
 * The contents of this file are subject to the Mozilla Public
 * License Version 1.1 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of
 * the License at http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS
 * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * rights and limitations under the License.
 *
 * The Original Code is DUnit.
 *
 * The Initial Developers of the Original Code are Kent Beck, Erich Gamma,
 * and Juancarlo Añez.
 * Portions created The Initial Developers are Copyright (C) 1999-2000.
 * Portions created by The DUnit Group are Copyright (C) 2000-2004.
 * All rights reserved.
 *
 * Contributor(s):
 * Kent Beck <kentbeck@csi.com>
 * Erich Gamma <Erich_Gamma@oti.com>
 * Juanco Añez <juanco@users.sourceforge.net>
 * Chris Morris <chrismo@users.sourceforge.net>
 * Jeff Moore <JeffMoore@users.sourceforge.net>
 * Kris Golko <neuromancer@users.sourceforge.net>
 * The DUnit group at SourceForge <http://dunit.sourceforge.net>
 *
 *)

unit TextTestRunner;

interface
uses
{$IFDEF CLR}
  Classes,
{$ELSE !CLR}
  System.Classes,
{$ENDIF CLR}
  TestFramework,
  DUnitConsts;

const
  rcs_id :string = '#(@)$Id: TextTestRunner.pas 36 2011-04-15 19:26:16Z medington $';

type
  TRunnerExitBehavior = (
    rxbContinue,
    rxbPause,
    rxbHaltOnFailures
    );

  TTextTestListener = class(TInterfacedObject, ITestListener, ITestListenerX)
  protected
    FFailureCount,
    FErrorCount: Integer;
    startTime: TDateTime;
    endTime: TDateTime;
    runTime: TDateTime;
    IndentLevel: integer;
  public
    constructor Create;
    // implement the ITestListener interface
    procedure AddSuccess(test: ITest); virtual;
    procedure AddError(error: TTestFailure); virtual;
    procedure AddFailure(failure: TTestFailure); virtual;
    function  ShouldRunTest(test :ITest):boolean; virtual;
    procedure StartSuite(suite: ITest); virtual;
    procedure EndSuite(suite: ITest); virtual;
    procedure StartTest(test: ITest); virtual;
    procedure EndTest(test: ITest); virtual;
    procedure TestingStarts; virtual;
    procedure TestingEnds(testResult: TTestResult); virtual;
    procedure Status(test :ITest; const Msg :string);
    procedure Warning(test :ITest; const Msg :string);
    function  Report(r: TTestResult): string;
    class function RunTest(suite: ITest; exitBehavior: TRunnerExitBehavior = rxbContinue): TTestResult; overload;
    class function RunRegisteredTests(exitBehavior: TRunnerExitBehavior = rxbContinue): TTestResult;

    property FailureCount: Integer read FFailureCount;
    property ErrorCount: Integer read FErrorCount;

  protected
    function  PrefixChars:string;
    function  PrintErrors(r: TTestResult): string; virtual;
    function  PrintFailures(r: TTestResult): string; virtual;
    function  PrintHeader(r: TTestResult): string; virtual;
    function  PrintFailureItems(r :TTestResult): string; virtual;
    function  PrintErrorItems(r :TTestResult): string; virtual;
    function  TruncateString(s: string; len: integer): string; virtual;
  end;

  {: This type defines what the RunTest and RunRegisteredTests methods will do when
     testing has ended.
     @enum rxbContinue Just return the TestResult.
     @enum rxbPause    Pause with a ReadLn before returnng the TestResult.
     @enum rxbHaltOnFailures   Halt the program if errors or failures occurred, setting
                               the program exit code to FailureCount+ErrorCount;
                               behave like rxbContinue if all tests suceeded.
     @seeAlso <See Unit="TextTestRunner" Routine="RunTest">
     @seeAlso <See Unit="TextTestRunner" Routine="RunRegisteredTests">
     }

{: Run the given test suite
}
function RunTest(suite: ITest; exitBehavior: TRunnerExitBehavior = rxbContinue): TTestResult; overload;
function RunRegisteredTests(exitBehavior: TRunnerExitBehavior = rxbContinue): TTestResult; overload;

implementation
uses
{$IFDEF CLR}
  SysUtils;
{$ELSE !CLR}
  System.SysUtils;
{$ENDIF CLR}

const
  CRLF = #13#10;

{ TTExtTestListener }

procedure TTextTestListener.AddSuccess(test: ITest);
begin
// No display for successes
  if test is TTestSuite then
  begin
    // Do not write anything
  end
  else
    write('.');
end;

constructor TTextTestListener.Create;
begin
  inherited Create;
  IndentLevel := 0;
end;

procedure TTextTestListener.AddError(error: TTestFailure);
begin
  Inc(FErrorCount);
{$IFDEF ADDITIONAL_INFO}
  Writeln('Error: ',TObject(error).UnitName,'.',TObject(error).ClassName,'.',error.FailedTest.Name);
{$ELSEIF defined(BASIC_INFO)}
  Write('<'+error.FailedTest.Name+'> Error');
{$ELSE !BASIC_INFO}
  Write('E');
{$ENDIF ADDITIONAL_INFO}
end;

procedure TTextTestListener.AddFailure(failure: TTestFailure);
begin
  Inc(FFailureCount);
{$IFDEF ADDITIONAL_INFO}
  Writeln('Failure: ',TObject(failure).UnitName,'.',TObject(failure).ClassName,'.',failure.FailedTest.Name);
{$ELSEIF defined(BASIC_INFO)}
  Write('<'+failure.FailedTest.Name+'> Fails');
{$ELSE !BASIC_INFO}
  Write('F');
{$ENDIF ADDITIONAL_INFO}
end;

{:
   Prints failures to the standard output
 }
function TTextTestListener.Report(r: TTestResult): string;
begin
  result := PrintHeader(r) +
            PrintErrors(r) +
            PrintFailures(r);
end;

{:
   Prints the errors to the standard output
 }
function TTextTestListener.PrintErrors(r: TTestResult): string;
begin
  result := '';
  if (r.errorCount <> 0) then begin
    if (r.errorCount = 1) then
      result := result + format(sPrintError, [r.errorCount]) + CRLF
    else
      result := result + format(sPrintErrors, [r.errorCount]) + CRLF;

    result := result + PrintErrorItems(r);
    result := result + CRLF
  end
end;

function TTextTestListener.PrintFailureItems(r :TTestResult): string;
var
  i: Integer;
  failure: TTestFailure;
begin
  result := '';
  for i := 0 to r.FailureCount-1 do begin
    failure := r.Failures[i];
    result := result + format(sFailedTestDetails,
                               [
                               i+1,
{$IFDEF CLR}
                               '',
{$ELSE}
                               TObject(failure.failedTest).UnitName,
{$ENDIF !CLR}
                               TObject(failure.failedTest).ClassName,
                               failure.failedTest.name,
                               failure.thrownExceptionName,
                               failure.LocationInfo,
                               failure.thrownExceptionMessage
                               ]) + CRLF;
  end;
end;

function TTextTestListener.PrefixChars: string;
var
  i:integer;
begin
  result := '';
  for i := 1 to IndentLevel do
    result := result + ' ';
end;

function TTextTestListener.PrintErrorItems(r :TTestResult): string;
var
  i: Integer;
  failure: TTestFailure;
begin
  result := '';
  for i := 0 to r.ErrorCount-1 do begin
    failure := r.Errors[i];
    result := result + format(sFailedTestDetails,
                               [
                               i+1,
{$IFDEF CLR}
                               '',
{$ELSE}
                               TObject(failure.failedTest).UnitName,
{$ENDIF !CLR}
                               TObject(failure.failedTest).ClassName,
                               failure.failedTest.name,
                               failure.thrownExceptionName,
                               failure.LocationInfo,
                               failure.thrownExceptionMessage
                               ]) + CRLF;
  end;
end;

{:
   Prints failures to the standard output
 }
function TTextTestListener.PrintFailures(r: TTestResult): string;
begin
  result := '';
  if (r.failureCount <> 0) then begin
    if (r.failureCount = 1) then
      result := result + format(sPrintFailure, [r.failureCount]) + CRLF
    else
      result := result + format(sPrintFailures, [r.failureCount]) + CRLF;

    result := result + PrintFailureItems(r);
    result := result + CRLF
  end
end;

{:
   Prints the header of the Report
 }
function TTextTestListener.PrintHeader(r: TTestResult): string;
begin
  result := '';
  if r.wasSuccessful then
  begin
    result := result + CRLF;
    result := result + format(sTestResultsOk + CRLF, [r.runCount]);
  end
  else
  begin
    result := result + CRLF;
    result := result + sTestResultsFailures +CRLF;
    result := result + sTestResults +CRLF;
    result := result + format(sRunCount +CRLF+ sFailureCount +CRLF+ sErrorsCount +CRLF,
                      [r.runCount, r.failureCount, r.errorCount]
                      );
  end
end;

procedure TTextTestListener.StartTest(test: ITest);
begin
{$IFDEF ADDITIONAL_INFO}
  Writeln;
  Write(PrefixChars, TObject(test).UnitName,'.',TObject(test).ClassName,'.',test.Name+' ');
{$ENDIF ADDITIONAL_INFO}
end;

procedure TTextTestListener.EndTest(test: ITest);
begin

end;

function TTextTestListener.TruncateString(s: string; len: integer): string;
begin
  if s.Length > len then
    result := s.Substring( 0, len) + '...'
  else
    result := s
end;

procedure TTextTestListener.TestingStarts;
begin
  FFailureCount := 0;
  FErrorCount := 0;
{$IFNDEF CLR}
  Writeln;
  Writeln('Executing: "'+Paramstr(0)+'"');
  Writeln('DataFiles: "'+TestDataDir+'"');
  Writeln('OSVersion: "'+TOSVersion.ToString+'"');
{$ENDIF CLR}
  Writeln;
  Writeln(sDUnitTesting);
  startTime := now;
end;

procedure TTextTestListener.TestingEnds(testResult: TTestResult);
var
  h, m, s, l :Word;
begin
  endTime := now;
  runTime := endTime-startTime;
  writeln;
  DecodeTime(runTime, h,  m, s, l);
  writeln(Format(sDecodeTime, [h, m, s, l]));
  writeln(Report(testResult));
  writeln;
end;

class function TTextTestListener.RunTest(suite: ITest; exitBehavior: TRunnerExitBehavior = rxbContinue): TTestResult;
begin
  Result := TestFramework.RunTest(suite, [TTextTestListener.Create]);
  case exitBehavior of
    rxbPause:
      try
        writeln(sPressReturn);
        readln
      except
      end;
    rxbHaltOnFailures:
{$IFNDEF CLR}
      with Result do
      begin
        if not WasSuccessful then
          System.Halt(ErrorCount+FailureCount);
      end
{$ENDIF}
    // else fall through
  end;
end;

class function TTextTestListener.RunRegisteredTests(exitBehavior: TRunnerExitBehavior = rxbContinue): TTestResult;
begin
  Result := RunTest(registeredTests, exitBehavior);
end;

function RunTest(suite: ITest; exitBehavior: TRunnerExitBehavior = rxbContinue): TTestResult;
begin
  Result := TestFramework.RunTest(suite, [TTextTestListener.Create]);
  case exitBehavior of
    rxbPause:
      try
        writeln(sPressReturn);
        readln
      except
      end;
    rxbHaltOnFailures:
{$IFNDEF CLR}
      with Result do
      begin
        if not WasSuccessful then
          System.Halt(ErrorCount+FailureCount);
      end
{$ENDIF}
    // else fall through
  end;
end;

function RunRegisteredTests(exitBehavior: TRunnerExitBehavior = rxbContinue): TTestResult;
begin
   Result := RunTest(registeredTests, exitBehavior);
end;


procedure TTextTestListener.Status(test: ITest; const Msg: string);
begin
  writeln(Format('%s: %s', [test.Name, Msg]));
end;

procedure TTextTestListener.Warning(test: ITest; const Msg: string);
begin
  writeln(Format('%s: %s', [test.Name, Msg]));
end;

function TTextTestListener.ShouldRunTest(test: ITest): boolean;
begin
  Result := test.Enabled;
end;

procedure TTextTestListener.EndSuite(suite: ITest);
begin
  Dec(IndentLevel);
{$IF defined(ADDITIONAL_INFO)}
  Writeln;
  Write(PrefixChars, '> EndSuite('+suite.Name+')');
{$ELSEIF defined(BASIC_INFO)}
  Write('> ');
{$ENDIF ADDITIONAL_INFO}
end;

procedure TTextTestListener.StartSuite(suite: ITest);
begin
{$IF defined(ADDITIONAL_INFO) or defined (BASIC_INFO)}
  Writeln;
  if suite is TTestSuite then
    Write(PrefixChars,'StartSuite('+suite.Name+')('+ IntToStr(suite.CountTestCases) +') <')
  else
    Write(PrefixChars, '('+suite.Name+')');
  Inc(IndentLevel);
{$ENDIF defined(ADDITIONAL_INFO) or defined (BASIC_INFO)}
end;

end.
