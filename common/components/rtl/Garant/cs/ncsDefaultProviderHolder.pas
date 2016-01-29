unit ncsDefaultProviderHolder;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsDefaultProviderHolder.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::ArchiClientServer::TncsDefaultProviderHolder
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3ProtoObject,
  daInterfaces
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TncsDefaultProviderHolder = class(Tl3ProtoObject)
 private
 // private fields
   f_Provider : IdaDataProvider;
 private
 // private methods
   procedure IntCreateProvider;
     {* Сигнатура метода IntCreateProvider }
   procedure IntDoneProvider;
     {* Сигнатура метода IntDoneProvider }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
 public
 // public methods
   class procedure CreateProvider;
   class procedure DoneProvider;
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TncsDefaultProviderHolder;
    {- возвращает экземпляр синглетона. }
 end;//TncsDefaultProviderHolder
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  l3Base {a},
  daDataProviderSuperFactory,
  daDataProviderParams,
  ncsDataAccessServices,
  SysUtils
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}


// start class TncsDefaultProviderHolder

var g_TncsDefaultProviderHolder : TncsDefaultProviderHolder = nil;

procedure TncsDefaultProviderHolderFree;
begin
 l3Free(g_TncsDefaultProviderHolder);
end;

class function TncsDefaultProviderHolder.Instance: TncsDefaultProviderHolder;
begin
 if (g_TncsDefaultProviderHolder = nil) then
 begin
  l3System.AddExitProc(TncsDefaultProviderHolderFree);
  g_TncsDefaultProviderHolder := Create;
 end;
 Result := g_TncsDefaultProviderHolder;
end;


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
 {-}
begin
 Result := g_TncsDefaultProviderHolder <> nil;
end;//TncsDefaultProviderHolder.Exists

procedure TncsDefaultProviderHolder.Cleanup;
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

{$IfEnd} //not Nemesis

end.