unit ncsServerFilesDelivererPool;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsServerFilesDelivererPool.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsServerFilesDelivererPool" MUID: (5810A1310248)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
 , ncsServerFilesDelivererList
 , ncsServerFilesDeliverer
;

type
 TncsServerFilesDelivererPool = class(Tl3ProtoObject)
  private
   f_DelivererList: TncsServerFilesDelivererList;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   procedure RegisterDeliverer(aDeliverer: TncsServerFilesDeliverer);
   procedure UnRegisterDeliverer(aDeliverer: TncsServerFilesDeliverer);
   procedure TerminateAll;
 end;//TncsServerFilesDelivererPool
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *5810A1310248impl_uses*
 //#UC END# *5810A1310248impl_uses*
;

procedure TncsServerFilesDelivererPool.RegisterDeliverer(aDeliverer: TncsServerFilesDeliverer);
//#UC START# *5810A17E0037_5810A1310248_var*
//#UC END# *5810A17E0037_5810A1310248_var*
begin
//#UC START# *5810A17E0037_5810A1310248_impl*
 if f_DelivererList.IndexOf(aDeliverer) = -1 then
   f_DelivererList.Add(aDeliverer);
//#UC END# *5810A17E0037_5810A1310248_impl*
end;//TncsServerFilesDelivererPool.RegisterDeliverer

procedure TncsServerFilesDelivererPool.UnRegisterDeliverer(aDeliverer: TncsServerFilesDeliverer);
//#UC START# *5810A1A500B4_5810A1310248_var*
//#UC END# *5810A1A500B4_5810A1310248_var*
begin
//#UC START# *5810A1A500B4_5810A1310248_impl*
 f_DelivererList.Remove(aDeliverer);
//#UC END# *5810A1A500B4_5810A1310248_impl*
end;//TncsServerFilesDelivererPool.UnRegisterDeliverer

procedure TncsServerFilesDelivererPool.TerminateAll;
//#UC START# *5810A1BA01F9_5810A1310248_var*

 function DoTerminate(aDeliverer: PncsServerFilesDeliverer; Index: Integer): Boolean;
 begin//AddLineDelta
  aDeliverer^.TerminateProcess;
  Result := True;
 end;//AddLineDelta

//#UC END# *5810A1BA01F9_5810A1310248_var*
begin
//#UC START# *5810A1BA01F9_5810A1310248_impl*
 f_DelivererList.IterateAllF(l3L2IA(@DoTerminate));
//#UC END# *5810A1BA01F9_5810A1310248_impl*
end;//TncsServerFilesDelivererPool.TerminateAll

procedure TncsServerFilesDelivererPool.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5810A1310248_var*
//#UC END# *479731C50290_5810A1310248_var*
begin
//#UC START# *479731C50290_5810A1310248_impl*
 FreeAndNil(f_DelivererList);
 inherited;
//#UC END# *479731C50290_5810A1310248_impl*
end;//TncsServerFilesDelivererPool.Cleanup

procedure TncsServerFilesDelivererPool.InitFields;
//#UC START# *47A042E100E2_5810A1310248_var*
//#UC END# *47A042E100E2_5810A1310248_var*
begin
//#UC START# *47A042E100E2_5810A1310248_impl*
 inherited;
 f_DelivererList := TncsServerFilesDelivererList.Make;
//#UC END# *47A042E100E2_5810A1310248_impl*
end;//TncsServerFilesDelivererPool.InitFields
{$IfEnd} // NOT Defined(Nemesis)

end.
