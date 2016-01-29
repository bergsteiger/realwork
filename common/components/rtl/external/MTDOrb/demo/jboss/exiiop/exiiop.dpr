program exiiop;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Classes,
  Windows,
  orbtypes,
  orb_int,
  orb,
  exceptions,
  cosnaming_int,
  cosnaming,
  value_int,
  value,
  pi,
  pi_int,
  pi_impl,
  EJB,
  EJB_int,
  CosTransactions_int,
  CosTransactions,
  TestFramework,
  TextTestRunner,
  ExceptionThrowerHome_org_jboss_test_excepiiop_interfaces_int,
  ExceptionThrowerHome_org_jboss_test_excepiiop_interfaces,
  ExceptionThrower_org_jboss_test_excepiiop_interfaces_int,
  ExceptionThrower_org_jboss_test_excepiiop_interfaces,
  IdlException_org_jboss_test_excepiiop_interfaces,
  JavaEx_org_jboss_test_excepiiop_interfaces,
  JavaException_org_jboss_test_excepiiop_interfaces,
  java_utils;

var
  nsobj: INamingContext;

type
  TJavaExceptionFactory = class(TValueFactoryBase, IValueFactory)
  protected
    function create_for_umarshal(): IValueBase; override;
  end;

  TJBossTestCase = class(TTestCase)
  private
    home: Iorg_jboss_test_excepiiop_interfaces_ExceptionThrowerHome;
    bean: Iorg_jboss_test_excepiiop_interfaces_ExceptionThrower;
  public
    procedure Setup; override;
    procedure TearDown; override;
  end;

  TExceptionTimingStressTestCase = class(TJBossTestCase)
  published
    procedure TestNoException;
    procedure TestIdlException();
    procedure TestJavaException();
    procedure TestSpeedNoException();
    procedure TestSpeedJavaException();
    procedure TestSpeedIdlException();
  end;

function GetIterationCount(): Integer;
begin
  Result := 100;
end;

{ TJavaExceptionFactory }

function TJavaExceptionFactory.create_for_umarshal: IValueBase;
begin
  Result := Torg_jboss_test_excepiiop_interfaces_JavaException.Create();
end;

{ TExceptionTimingStressTestCase }

procedure TExceptionTimingStressTestCase.TestNoException;
begin
  bean := home._create();
  bean.throwException(0);
  bean.remove();
end;

procedure TExceptionTimingStressTestCase.TestIdlException;
begin
  bean := home._create();
  try
    bean.throwException(-1);
  except
    on E: Torg_jboss_test_excepiiop_interfaces_IdlException do
      WriteLn('IdlException: ' + E.Message);
  end;
  bean.remove();
end;

procedure TExceptionTimingStressTestCase.TestJavaException;
begin
  bean := home._create();
  try
    bean.throwException(1);
  except
    on E: Torg_jboss_test_excepiiop_interfaces_JavaEx do
      WriteLn('JavaException: ' + E.Message);
  end;
  bean.remove();
end;

procedure TExceptionTimingStressTestCase.TestSpeedNoException();
var
  i: Integer;
  start, _end: Cardinal;
begin
  bean := home._create();
  start := GetTickCount();
  for i := 1 to GetIterationCount do
    bean.throwException(0);
  _end := GetTickCount();
  WriteLn('Avg. time/call(ms):' + FloatToStr((_end-start)/getIterationCount()));
  bean.remove();
end;

procedure TExceptionTimingStressTestCase.TestSpeedJavaException();
var
  i: Integer;
  start, _end: Cardinal;
begin
  bean := home._create();
  start := GetTickCount();
  for i := 1 to GetIterationCount do
    try
      bean.throwException(1);
    except
      on E: Torg_jboss_test_excepiiop_interfaces_JavaEx do
        //WriteLn('JavaException: ' + E.Message);
    end;
  _end := GetTickCount();
  WriteLn('Avg. time/call(ms):' + FloatToStr((_end-start)/getIterationCount()));
  bean.remove();
end;

procedure TExceptionTimingStressTestCase.TestSpeedIdlException();
var
  i: Integer;
  start, _end: Cardinal;
begin
  bean := home._create();
  start := GetTickCount();
  for i := 1 to GetIterationCount do
    try
      bean.throwException(-1);
    except
      on E: Torg_jboss_test_excepiiop_interfaces_IdlException do
        //WriteLn('IdlException: ' + E.Message);
    end;
  _end := GetTickCount();
  WriteLn('Avg. time/call(ms):' + FloatToStr((_end-start)/getIterationCount()));
  bean.remove();
end;

{ TJBossTestCase }

procedure TJBossTestCase.Setup;
var
  obj: IORBObject;
  ObjName: TName;
begin
  SetLength(ObjName, 2);
  ObjName[0].id := 'excepiiop';
  ObjName[0].kind := '';
  ObjName[1].id := 'ExceptionThrower';
  ObjName[1].kind := '';
  
  try
    obj := nsobj.resolve(ObjName);
    home := Torg_jboss_test_excepiiop_interfaces_ExceptionThrowerHome._narrow(obj);
  except
    on E: TNamingContext_NotFound do begin
      Fail('NotFound exception.');
    end;
    on E: TNamingContext_CannotProceed do begin
      Fail('CannotProceed exception.');
    end;
    on E: TNamingContext_InvalidName do begin
      Fail('InvalidName exception.');
    end;
  end; { try/except }
end;

procedure TJBossTestCase.TearDown;
begin
end;

var
  prm: TStringList;
  myorb: IORB;
  Current: ICurrent;
begin
  prm := TStringList.Create;
  try
    prm.Add('-ORBInfoLogger');
    prm.Add('mtorb_info_log');
    prm.Add('-ORBDebugLevel');
    prm.Add('Info');
    prm.Add('-ORBGIOPVersion');
    prm.Add('1.2');
    prm.Add('-ORBIIOPVersion');
    prm.Add('1.2');
    prm.Add('-ORBInitRef');
    prm.Add('NameService=corbaloc::1.2@localhost:3528/JBoss/Naming/root');
    myorb := ORB_Init(prm);

    myorb.register_value_factory('RMI:org.jboss.test.excepiiop.interfaces.JavaException:CAFB404AE0EE2EBF:5725FDB2D0D57E0F', TJavaExceptionFactory.Create());
    RegisterValueFactory(myorb);
  finally
    prm.Free;
  end; { try/finally }

  nsobj := TNamingContext._narrow(myorb.resolve_initial_reference('NameService'));
  Current := TCurrent._narrow(myorb.resolve_initial_reference('TransactionCurrent'));

  RegisterTest('', TExceptionTimingStressTestCase.Suite);

  TextTestRunner.RunRegisteredTests(rxbPause);

  if myorb <> nil then begin
    myorb.shutdown(True);
    myorb._destroy();
  end;
end.
