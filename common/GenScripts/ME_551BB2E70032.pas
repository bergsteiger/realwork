unit ncsDefaultProviderHolder;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsDefaultProviderHolder.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
;

type
 TncsDefaultProviderHolder = class(Tl3ProtoObject)
  private
   f_Provider: IdaDataProvider;
  private
   procedure IntCreateProvider;
   procedure IntDoneProvider;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   class procedure CreateProvider;
   class procedure DoneProvider;
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TncsDefaultProviderHolder;
    {* Метод получения экземпляра синглетона TncsDefaultProviderHolder }
 end;//TncsDefaultProviderHolder
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , daDataProviderSuperFactory
 , daDataProviderParams
 , ncsDataAccessServices
 , SysUtils
 , l3Base
;

var g_TncsDefaultProviderHolder: TncsDefaultProviderHolder = nil;
 {* Экземпляр синглетона TncsDefaultProviderHolder }

procedure TncsDefaultProviderHolderFree;
 {* Метод освобождения экземпляра синглетона TncsDefaultProviderHolder }
begin
 l3Free(g_TncsDefaultProviderHolder);
end;//TncsDefaultProviderHolderFree

procedure TncsDefaultProviderHolder.IntCreateProvider;
//#UC START# *551BB38C02D3_551BB2E70032_var*
var
 l_DataParams: TdaDataProviderParams;
//#UC END# *551BB38C02D3_551BB2E70032_var*
begin
//#UC START# *551BB38C02D3_551BB2E70032_impl*
 l_DataParams := TdaDataProviderSuperFactory.Instance.MakeFromConfig;
 try
  TdaDataProviderSuperFactory.Instance.CorrectByClient(l_DataParams);
  TdaDataProviderSuperFactory.Instance.LoadDBVersion(l_DataParams);
  f_Provider := TdaDataProviderSuperFactory.Instance.MakeProvider(l_DataParams);
  f_Provider.Start;
 finally
  FreeAndNil(l_DataParams);
 end;
//#UC END# *551BB38C02D3_551BB2E70032_impl*
end;//TncsDefaultProviderHolder.IntCreateProvider

procedure TncsDefaultProviderHolder.IntDoneProvider;
//#UC START# *551BB3A3005E_551BB2E70032_var*
//#UC END# *551BB3A3005E_551BB2E70032_var*
begin
//#UC START# *551BB3A3005E_551BB2E70032_impl*
 if Assigned(f_Provider) then
  f_Provider.Stop;
 f_Provider := nil;
//#UC END# *551BB3A3005E_551BB2E70032_impl*
end;//TncsDefaultProviderHolder.IntDoneProvider

class procedure TncsDefaultProviderHolder.CreateProvider;
//#UC START# *551BB3090356_551BB2E70032_var*
//#UC END# *551BB3090356_551BB2E70032_var*
begin
//#UC START# *551BB3090356_551BB2E70032_impl*
 Instance.IntCreateProvider;
//#UC END# *551BB3090356_551BB2E70032_impl*
end;//TncsDefaultProviderHolder.CreateProvider

class procedure TncsDefaultProviderHolder.DoneProvider;
//#UC START# *551BB3440181_551BB2E70032_var*
//#UC END# *551BB3440181_551BB2E70032_var*
begin
//#UC START# *551BB3440181_551BB2E70032_impl*
 if Exists then
  Instance.IntDoneProvider;
//#UC END# *551BB3440181_551BB2E70032_impl*
end;//TncsDefaultProviderHolder.DoneProvider

class function TncsDefaultProviderHolder.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TncsDefaultProviderHolder <> nil;
end;//TncsDefaultProviderHolder.Exists

class function TncsDefaultProviderHolder.Instance: TncsDefaultProviderHolder;
 {* Метод получения экземпляра синглетона TncsDefaultProviderHolder }
begin
 if (g_TncsDefaultProviderHolder = nil) then
 begin
  l3System.AddExitProc(TncsDefaultProviderHolderFree);
  g_TncsDefaultProviderHolder := Create;
 end;
 Result := g_TncsDefaultProviderHolder;
end;//TncsDefaultProviderHolder.Instance

procedure TncsDefaultProviderHolder.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_551BB2E70032_var*
//#UC END# *479731C50290_551BB2E70032_var*
begin
//#UC START# *479731C50290_551BB2E70032_impl*
 f_Provider := nil;
 inherited;
//#UC END# *479731C50290_551BB2E70032_impl*
end;//TncsDefaultProviderHolder.Cleanup

procedure TncsDefaultProviderHolder.InitFields;
//#UC START# *47A042E100E2_551BB2E70032_var*
//#UC END# *47A042E100E2_551BB2E70032_var*
begin
//#UC START# *47A042E100E2_551BB2E70032_impl*
 inherited;
 TncsDataAccessServices.Instance.InitClient;
//#UC END# *47A042E100E2_551BB2E70032_impl*
end;//TncsDefaultProviderHolder.InitFields
{$IfEnd} // NOT Defined(Nemesis)

end.
