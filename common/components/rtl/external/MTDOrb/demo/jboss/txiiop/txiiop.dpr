program txiiop;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Classes,
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
  java_utils,
  StatefulSessionHome_org_jboss_test_txiiop_interfaces_int,
  StatefulSessionHome_org_jboss_test_txiiop_interfaces,
  StatefulSession_org_jboss_test_txiiop_interfaces_int,
  StatefulSession_org_jboss_test_txiiop_interfaces,
  jboss_transact_impl in 'jboss_transact_impl.pas';

var
  prm: TStrings;
  myorb: IORB;
  nsobj: INamingContext;
  name: TName;
  obj: IORBObject;
  home: Iorg_jboss_test_txiiop_interfaces_StatefulSessionHome;
  bean: Iorg_jboss_test_txiiop_interfaces_StatefulSession;
  Current: ICurrent;

procedure TestTxMandotory;
begin
  bean := home._create(StringToWStringValue('testTxMandatory'));
  WriteLn('Call txMandatoryMethod without a UserTransaction');
  try
    bean.txMandatoryMethod(StringToWStringValue('without a UserTransaction'));
    WriteLn('TransactionRequiredException should have been thrown');
  except
    on E: TRANSACTION_REQUIRED do
      WriteLn('Expected exception: ' + e.Message);
  end;
  WriteLn('Begin UserTransaction');
  Current._begin();
  bean.txMandatoryMethod(StringToWStringValue('within a UserTransaction'));
  WriteLn('Commit UserTransaction');
  Current.commit(False);
  bean.remove();
end;

procedure TestUserTx;
begin
  bean := home._create(StringToWStringValue('testUserTx'));
  bean.Counter := 100;
  WriteLn('Try to instantiate a UserTransaction');
  Current._begin();
  bean.incCounter();
  bean.incCounter();
  Current.commit(False);
  Assert(bean.Counter = 102, 'counter == 102');

  bean.Counter := 100;
  Current._begin();
  bean.incCounter();
  bean.incCounter();
  Current.rollback();
  Assert(bean.Counter = 100, 'counter == 100');

  bean.remove();
end;

begin
  try
    TRIORBInitializerImpl.Init();
    TTransactionCurrentInitializer.Init();

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

    finally
      prm.Free;
    end; { try/finally }

    nsobj := TNamingContext._narrow(myorb.resolve_initial_reference('NameService'));
    Current := TCurrent._narrow(myorb.resolve_initial_reference('TransactionCurrent'));

    SetLength(name, 2);
    name[0].id := 'txiiop';
    name[0].kind := '';
    name[1].id := 'StatefulSessionBean';
    name[1].kind := '';
    try
      obj := nsobj.resolve(name);
      home := Torg_jboss_test_txiiop_interfaces_StatefulSessionHome._narrow(obj);
    except
      on E: TNamingContext_NotFound do begin
        WriteLn('NotFound exception.');
        Exit;
      end;
      on E: TNamingContext_CannotProceed do begin
        WriteLn('CannotProceed exception.');
        Exit;
      end;
      on E: TNamingContext_InvalidName do begin
        WriteLn('InvalidName exception.');
        Exit;
      end;
    end; { try/except }

    TestTxMandotory();
    TestUserTx();

    WriteLn('Press Enter');
    ReadLn;
    myorb.shutdown(True);
    myorb._destroy();
  except
    on E: Exception do begin
      WriteLn(E.Message);
      ReadLn;
      myorb.shutdown(True);
      myorb._destroy();
    end;
  end; { try/except }
end.
