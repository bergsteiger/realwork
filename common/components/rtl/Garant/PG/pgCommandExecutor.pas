unit pgCommandExecutor;

// Модуль: "w:\common\components\rtl\Garant\PG\pgCommandExecutor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TpgCommandExecutor" MUID: (5694BA3500C4)

{$Include w:\common\components\rtl\Garant\PG\pgDefine.inc}

interface

{$If Defined(UsePostgres)}
uses
 l3IntfUses
 , l3ProtoObject
 , pgConnection
;

type
 TpgCommandExecutor = class(Tl3ProtoObject)
  private
   f_Connection: TpgConnection;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aConnection: TpgConnection); reintroduce;
   procedure Execute(const aCommand: AnsiString);
 end;//TpgCommandExecutor
{$IfEnd} // Defined(UsePostgres)

implementation

{$If Defined(UsePostgres)}
uses
 l3ImplUses
 , SysUtils
 , LibPQ
 , pgUtils
 //#UC START# *5694BA3500C4impl_uses*
 //#UC END# *5694BA3500C4impl_uses*
;

constructor TpgCommandExecutor.Create(aConnection: TpgConnection);
//#UC START# *5694BA880236_5694BA3500C4_var*
//#UC END# *5694BA880236_5694BA3500C4_var*
begin
//#UC START# *5694BA880236_5694BA3500C4_impl*
 inherited Create;
 aConnection.SetRefTo(f_Connection);
//#UC END# *5694BA880236_5694BA3500C4_impl*
end;//TpgCommandExecutor.Create

procedure TpgCommandExecutor.Execute(const aCommand: AnsiString);
//#UC START# *5694BA4A0323_5694BA3500C4_var*
var
 l_Result: PPGResult;
//#UC END# *5694BA4A0323_5694BA3500C4_var*
begin
//#UC START# *5694BA4A0323_5694BA3500C4_impl*
 l_Result := PQexec(f_Connection.Handle, PAnsiChar(aCommand));
 try
  pgCheckStatus(l_Result);
 finally
  PQclear(l_Result);
 end;
//#UC END# *5694BA4A0323_5694BA3500C4_impl*
end;//TpgCommandExecutor.Execute

procedure TpgCommandExecutor.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5694BA3500C4_var*
//#UC END# *479731C50290_5694BA3500C4_var*
begin
//#UC START# *479731C50290_5694BA3500C4_impl*
 FreeAndNil(f_Connection);
 inherited;
//#UC END# *479731C50290_5694BA3500C4_impl*
end;//TpgCommandExecutor.Cleanup
{$IfEnd} // Defined(UsePostgres)

end.
