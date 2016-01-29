program Client;
{$APPTYPE CONSOLE}
uses
{$IFDEF WIN32}
  Windows,
{$ENDIF}
{$IFDEF LINUX}
  Libc,
{$ENDIF}
  Classes,
  poa,
  poa_int,
  poa_impl,
  SysUtils,
  orb_int,
  orb,
  code_int,
  env_int,
  exceptions,
  CosTransactions_int,
  CosTransactions,
  transact_impl,
  Counter,
  Counter_int,
  orbtypes;

//type

procedure help;
begin
  WriteLn('Enter Command:');
  WriteLn('B' + Chr($09) + 'Begin new Transaction');
  WriteLn('C' + Chr($09) + 'Commit current transaction');
  WriteLn('O' + Chr($09) + 'Mark rollback only current transaction');
  WriteLn('C' + Chr($09) + 'Commit current transaction');
  WriteLn('I' + Chr($09) + 'Increment current counter');
  WriteLn('D' + Chr($09) + 'Decrement current counter');
  WriteLn('P' + Chr($09) + 'Print current counter value');
//    cout << "  S\tShutdown server\n";
  WriteLn('X' + Chr($09) + 'Exit');
end;

procedure mainproc;
var
  dorb : IORB;
  obj: IORBObject;
  counter: ICounter;
  fl : TStream;
  ref: AnsiString;
  prm: TStrings;
  trCurrent: ICurrent;
  currentCtrl: IControl;
  c: Char;
begin
  prm := TStringList.Create;
  try
    TransactionServiceInit;
    dorb := ORB_Init(prm);
  finally
    prm.Free;
  end; { try/finally }

  fl := TFileStream.Create('ots.ior', fmOpenRead);
  fl.Position := 0;
  SetLength(ref, fl.Size);
  fl.ReadBuffer(Pointer(ref)^, fl.Size);
  fl.free;

  obj := dorb.string_to_object(ref);
  dorb.register_initial_reference('TransactionService', obj);

  fl := TFileStream.Create('server.objid', fmOpenRead);
  fl.Position := 0;
  SetLength(ref, fl.Size);
  fl.ReadBuffer(Pointer(ref)^, fl.Size);
  fl.free;

  obj := dorb.string_to_object(ref);
  counter := TCounter._narrow(obj);

  obj := dorb.resolve_initial_reference('TransactionCurrent');
  trCurrent := TCurrent._narrow(obj);

  // Main loop
  help();
  repeat
    c := #0;
    try
      ReadLn(c);
      case c of
        'b', 'B': begin
          currentCtrl := trCurrent.get_control();
          if currentCtrl <> nil then
            WriteLn('Transaction active: ' + currentCtrl.get_coordinator.get_transaction_name)
          else
            trCurrent._begin();
        end;
        'r', 'R': trCurrent.rollback();
        'o', 'O': trCurrent.rollback_only();
        'c', 'C': trCurrent.commit(True);
        'i', 'I': begin
          counter.increment();
         end;
        'd', 'D': counter.decrement();
        'p', 'P': WriteLn('count: ' + IntToStr(counter.count));
        's', 'S': counter.shutdown();
        'x', 'X': Break;
        else
          help();
      end;  
    except
      on E: Exception do
        WriteLn(E.Message);
    end;
  until (c = 'x') or (c = 'X');
  dorb.shutdown(true);
  dorb._destroy();
  dorb := nil;
end;

begin
  mainproc;
end.