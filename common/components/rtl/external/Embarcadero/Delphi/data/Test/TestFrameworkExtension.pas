{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

/// <summary> dunit TestFramework extensions.
/// </summary>

unit TestFrameworkExtension;

interface

uses
  TestFramework, System.Classes;

type
  ITestExtension = interface(ITest)
    ['{8FADE3D2-D3E6-4141-A3DE-6C348069EF96}']
    procedure SetProperties( props: TStrings );
    function  GetProperties: TStrings;
    procedure ApplyFilter( FilterString: string );
  end;


  ///<summary>
  /// TTestSuiteExtension allows derived classes to filter which tests are
  ///  run by passing a command line parameter, '-s:[filter]', to the test
  ///  suite.
  ///  <example>
  ///   "TestSuite.exe -s:oRaid"  would run all test methods that
  ///  started with oRaid
  ///  </example>
  ///</summary>
  TTestSuiteExtension = class(TTestSuite)
  public
    function GetRunPattern(CMD: string): string;
    procedure FilterTests; virtual;
    procedure AddTests(testClass: TTestCaseClass); override;
  end;

  ///<summary>
  /// TTestCaseExtension allows derived classes to pass in a properties object
  ///  to the test suite. The properties object will take all name=value pairs
  ///  specified on the command line. This class also implements IApplyFilter,
  ///  so the "-s:" filter can be used.
  ///  <example>
  ///   Executing "TestSuite.exe Name=Value"
  ///   would allow test writers to access this inside of their test case methods
  ///   using,
  ///   Variable := Properties.Values['Name'];
  ///  </example>
  ///</summary>
  TTestCaseExtension = class(TTestCase, ITestExtension)
  protected
    FProperties: TStrings;
    FContext: string;
    FLogFileName: string;
    FTimeoutValue: Integer;
    function GetUserToken: string; virtual;
    function GetHostName: string; virtual;
    procedure Invoke(AMethod: TTestMethod); override;
  public
    constructor Create(MethodName: string); override;
    destructor Destroy; override;
    procedure SetProperties( props: TStrings );
    function  GetProperties: TStrings;
    function  GetMethodName: string; virtual;
    procedure ApplyFilter(FilterString: string);
    property Properties: TStrings read getProperties;
    property TimeOutValue: Integer read FTimeoutValue write FTimeoutValue;
    class function Suite: ITestSuite; override;
  end;

  TTestCaseThread = class(TThread)
  private
    FTestMethod: TTestMethod;
    FExceptionObj: Pointer;
  protected
    procedure Execute; override;
  end;

  TInterval = class(TObject)
  private
    FStart: TDateTime;
    FStop: TDateTime;

    function GetTotalSeconds: Int64;
    function GetTotalMinuets: Int64;
    function GetTotalHours: Int64;
    function GetTimeSpan: TDateTime;
  public
    constructor Create;
    procedure Start;
    procedure Stop;
    procedure Clear;
    property TimeSpan: TDateTime read GetTimeSpan;
    property TotalSeconds: Int64 read GetTotalSeconds;
    property TotalMinuets: Int64 read GetTotalMinuets;
    property TotalHours: Int64 read GetTotalHours;
    function ToString: string; reintroduce; overload;
  end;


const
  SelectSwitch = '-S:';
  DisableTimeoutSwitch = '-DisableTimeout';

function UseTestTimeout: Boolean;
function  GetAppProperties: TStrings;
//for reporting
function  GetPropertyValue(Key: string): string;
procedure SetPropertyValue(Key: string; Value: string);
procedure CopyAppProperties(Destination: TStrings);

implementation

uses
{$IFNDEF POSIX}
  Winapi.Windows,
{$ELSE}
  Posix.Signal, Posix.SysTypes, Posix.UniStd,
{$ENDIF}
{$IF DEFINED(MSWINDOWS) and not DEFINED(NEXTGEN)}
  Winapi.ActiveX,
{$ENDIF}
  System.DateUtils, System.StrUtils, System.SysUtils
{$IFDEF MACOS}
  , Macapi.CoreFoundation
{$ENDIF MACOS}
;

var
//  global properties object that is passed into tests
  AppProperties: TStringList;

function UseTestTimeout: Boolean;
begin
                                                                                                              
{$IF DEFINED(IOS) and DEFINED(CPUARM)}
  Result := False;
{$ELSE}
  Result := AppProperties.Text.ToUpper.IndexOf(DisableTimeoutSwitch.ToUpper) = -1;
{$ENDIF}
end;

function GetAppProperties: TStrings;
begin
  Result := AppProperties;
end;

procedure BuildPropertiesFromCommandLine;
var
  I: Integer;
  S: string;
begin
  if not Assigned(AppProperties) then
    AppProperties := TStringList.Create;

  //loop thorugh cmd params and insert into properties object
  for I := 0 to ParamCount  do
    S := S + ParamStr(I) + ' ';
  // assign sTemp to delim text ( space is considered valid line break )
  AppProperties.DelimitedText := Trim(S);
end;

function  GetPropertyValue(Key: string): string;
begin
  Result := AppProperties.Values[Key];
end;

procedure SetPropertyValue(Key: string; Value: string);
begin
  AppProperties.Values[Trim(Key)] := Trim(Value);
end;

procedure CopyAppProperties(Destination: TStrings);
begin
  if Assigned(Destination) then
    Destination.AddStrings(AppProperties);
end;


{ TBorlandTestCase }

constructor TTestCaseExtension.Create(MethodName: string);
begin
  inherited Create(MethodName);
  TimeoutValue := 30000; //default timeout for each test case is 30 seconds
end;

destructor TTestCaseExtension.Destroy;
begin
  FreeAndNil(FProperties);
end;

function TTestCaseExtension.GetUserToken: string;
var
  UserName: string;
const
  MAXTokenLength = 8;
begin
  UserName := GetEnvironmentVariable('USERNAME');
  UserName := UserName.Replace('-', '_', []);
  if Length(UserName) > MAXTokenLength then
    UserName := UserName.Substring(0, MAXTokenLength)
  else if UserName = '' then
    UserName := 'Tmp' + IntToStr(Random(9)) + IntToStr(Random(9));

  //Changing to return a trimmed down user token per Steve's request 
  Result := UserName;
end;

procedure TTestCaseExtension.Invoke(AMethod: TTestMethod);
var
  TestCaseThread: TTestCaseThread;
begin
  FTestMethodInvoked := True;
  if UseTestTimeout then
  begin
    TestCaseThread := TTestCaseThread.Create(True);
    try
      TestCaseThread.FreeOnTerminate := False;
      TestCaseThread.FTestMethod := AMethod;
      TestCaseThread.FExceptionObj := nil;
      TestCaseThread.Start;
      while not CheckSynchronize do
      begin
        if FTimeoutValue < 1 then
        begin
          {$IFDEF MSWindows}
          TerminateThread(TestCaseThread.Handle, 1);
          {$ELSE}
          //TestCaseThread.Suspend //If SIGINT with pthread_kill does not work, try replacing with this suspend call
          pthread_kill(pthread_t(TestCaseThread.ThreadID), SIGINT);
          {$ENDIF}
          raise Exception.Create('Testcase timed out');
        end;
        Sleep(10);
        Dec(FTimeoutValue, 10);
      end;
      if TestCaseThread.FExceptionObj <> nil then
      begin
        try
          raise Exception(TestCaseThread.FExceptionObj);
        finally
          {$IFDEF MSWINDOWS}
          ReleaseExceptionObject;
          {$ENDIF}
        end;
      end;
    finally
      TestCaseThread.Free;
    end;
  end
  else AMethod;
end;

procedure TTestCaseExtension.ApplyFilter(FilterString: string);
var
  WildCardPos: Integer;
begin
  //implicit wild card, so if -s:Raid is passed then works like Raid*
  // Name=Raid_XXXX is accepted, Name=oRaid_XXXX is not accepted
  // aslo requires that first character and on matches pattern
  Enabled := GetMethodName.ToUpper.IndexOf(FilterString) = 0;

  //wild card was passed, so -s:*Raid or -s:Ra*id
                                                   
  if not Enabled then
  begin
    WildCardPos := FilterString.IndexOf('*') + 1;
    if (WildCardPos > 0) then    
      Writeln('* not supported in -s: param');
  end;
end;

function TTestCaseExtension.GetHostName: string;
{$IFDEF POSIX}
var
  MachName: TArray<Byte>;
{$ENDIF}
const
  ComputerName = 'COMPUTERNAME';
  MaxHostLength = 8;
begin
  Result := 'UNKNOWN';
{$IFDEF POSIX}
  SetLength(MachName, MaxHostLength);
  if Posix.Unistd.GetHostName(MarshaledAString(MachName), MaxHostLength) = 0 then
    Result := TMarshal.ReadStringAsUtf8(TPtrWrapper.Create(MachName)).ToUpper;
{$ELSE}
  if GetEnvironmentVariable(ComputerName)<>'' then
    Result := GetEnvironmentVariable(ComputerName);
{$ENDIF}
  Result := Result.Replace('.' , '');
  Result := Result.Replace(' ' , '');
  Result := Result.Replace('-' , '');
  if (Result.Length > MaxHostLength) then
    Result.Remove(MaxHostLength - 2, Result.Length);
end;

function TTestCaseExtension.GetMethodName: string;
begin
  Result := FTestName;
end;

function TTestCaseExtension.getProperties: TStrings;
begin
  if not Assigned(FProperties) then
    FProperties := TStringList.Create;
  Result := fProperties;
end;

procedure TTestCaseExtension.SetProperties(Props: TStrings);
begin
  if not Assigned(FProperties) then
    FProperties := TStringList.Create;
  if Assigned(Props) then
    FProperties.AddStrings(Props);
end;

class function TTestCaseExtension.Suite: ITestSuite;
begin
  Result := TTestSuiteExtension.Create(Self);
end;

{ TTestSuiteExtension }

procedure TTestSuiteExtension.AddTests(TestClass: TTestCaseClass);
var
  MethodIter     :  Integer;
  NameOfMethod   :  string;
  MethodEnumerator:  TMethodEnumerator;
  TestCase       : ITest;
begin
  { call on the method enumerator to get the names of the test
    cases in the testClass }
  MethodEnumerator := nil;
  try
    MethodEnumerator := TMethodEnumerator.Create(TestClass);
    { make sure we add each test case  to the list of tests }
    for MethodIter := 0 to MethodEnumerator.Methodcount-1 do
    begin
      NameOfMethod := MethodEnumerator.nameOfMethod[MethodIter];
      TestCase := TestClass.Create(NameOfMethod) as ITest;
      if Supports(TestCase,ITestExtension) then
        (TestCase as ITestExtension).setProperties( AppProperties );
      Self.AddTest(TestCase);
    end;
  finally
    MethodEnumerator.Free;
  end;
  FilterTests;
end;

procedure TTestSuiteExtension.FilterTests;
var
  I    : Integer;
  List : IInterfaceList;
  sCMD : string;
  Pattern: string;
  ITemp: IUnknown;
begin
  if ParamCount > 0 then
  begin
    sCMD := AppProperties.Strings[0];
    for I := 1 to AppProperties.Count - 1 do
      sCMD := sCMD + ' ' + AppProperties.Strings[I];
    if sCMD.ToUpper.IndexOf(SelectSwitch) > 0 then
    begin
      List := Tests;
      Pattern := GetRunPattern(sCMD).ToUpper;
      //if the pattern shows up in the method name then it gets run
      //think pattern= RAID and method name is RAID_123423
      for I := 0 to List.Count - 1 do
      begin
        ITemp := (List.Items[I] as ITest);
        if Supports(ITemp,ITestExtension) then
          (ITemp as ITestExtension).ApplyFilter(Pattern);
      end;
    end;
  end
  else
    Exit;
end;

function TTestSuiteExtension.GetRunPattern(CMD: string): string;
var
  S: string;
  I : Integer;
begin
  // extract suite and test case info
  S := CMD.ToUpper;
  S := S.Remove(0, S.IndexOf(SelectSwitch) + SelectSwitch.Length);
  I := S.IndexOf(' ') + 1;
  if I > 1 then // clean up items that might come after -s:asdfsd Name=Value
    S := S.Remove(I - 1, S.Length);
  Result := S;
end;

{ TInterval }

procedure TInterval.Clear;
begin
  FStart := 0;
  FStop := 0;
end;

constructor TInterval.Create;
begin
  inherited;
  Clear;
end;

function TInterval.GetTimeSpan: TDateTime;
begin
  Assert( FStop > FStart );
  Result := FStop - FStart;
end;

function TInterval.GetTotalHours: Int64;
begin
  Result := HoursBetween(FStart,FStop);
end;

function TInterval.GetTotalMinuets: Int64;
begin
  Result := MinutesBetween(FStart,FStop);
end;

function TInterval.GetTotalSeconds: Int64;
begin
  Result := SecondsBetween(FStart,FStop);
end;

procedure TInterval.Start;
begin
  FStart := Now;
end;

procedure TInterval.Stop;
begin
  FStop := Now;
end;

function TInterval.ToString: string;
var
  H,M,S,MS: Word;
const
  TimeFormat = '%d:%d:%d.%d';
begin
  DecodeTime( FStop - FStart,H,M,S,MS );
  Result := Format(TimeFormat,[H,M,S,MS]);
end;

{ TTestCaseThread }

procedure TTestCaseThread.Execute;
begin
  try
    FExceptionObj := nil;
    {$IF DEFINED(MSWINDOWS) and not DEFINED(NEXTGEN)}
    CoInitialize(nil);
    {$ENDIF}
    try
      FTestMethod;
    finally
      {$IF DEFINED(MSWINDOWS) and not DEFINED(NEXTGEN)}
      CoUninitialize;
      {$ENDIF}
    end;
    Synchronize(nil);
  except
    begin
      FExceptionObj := AcquireExceptionObject;
      Assert(FExceptionObj <> nil, 'Unable to acquire exception object');
      Synchronize(nil);
    end;
  end;
end;

initialization
  BuildPropertiesFromCommandLine;
finalization
  if Assigned(AppProperties) then
    AppProperties.Free;

end.
