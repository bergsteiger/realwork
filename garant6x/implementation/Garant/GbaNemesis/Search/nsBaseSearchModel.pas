unit nsBaseSearchModel;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\nsBaseSearchModel.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsBaseSearchModel" MUID: (56F12BAB0086)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ProtoObject
 , BaseSearchInterfaces
 , l3Interfaces
 , l3LongintList
 , PrimBaseSearchInterfaces
;

type
 TnsBaseSearchModel = class(Tl3ProtoObject, InsBaseSearchModel)
  private
   f_Context: Il3CString;
   f_FindEnabled: Boolean;
   f_IsLocalSearchArea: Boolean;
   f_Listeners: Tl3LongintList;
  public
   f_ActiveClass: InsBaseSearchClass;
   f_Area: TnsSearchArea;
   f_AvailableAreas: TnsSearchAreas;
   f_FindBackSupported: Boolean;
   f_FindBackEnabled: Boolean;
  private
   procedure Changed;
  protected
   function pm_GetActiveClass: InsBaseSearchClass;
   procedure pm_SetActiveClass(const aValue: InsBaseSearchClass);
   function pm_GetContext: Il3CString;
   procedure pm_SetContext(const aValue: Il3CString);
   function pm_GetArea: TnsSearchArea;
   procedure pm_SetArea(aValue: TnsSearchArea);
   function pm_GetAvailableAreas: TnsSearchAreas;
   function Find(const aProcessor: InsBaseSearchResultProcessor): Boolean;
   function FindBack(const aProcessor: InsBaseSearchResultProcessor): Boolean;
   function pm_GetFindBackSupported: Boolean;
   function pm_GetFindBackEnabled: Boolean;
   procedure AddView(const aVie: InsBaseSearchView);
   procedure RemoveView(const aView: InsBaseSearchView);
   function pm_GetFindEnabled: Boolean;
   procedure SubscribeListener(const aListener: InsBaseSearchModelListener);
   procedure UnsubscribeListener(const aListener: InsBaseSearchModelListener);
   function pm_GetIsLocalSearchArea: Boolean;
   function pm_GetExampleText: Il3CString;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create; reintroduce;
   class function Make: InsBaseSearchModel; reintroduce;
 end;//TnsBaseSearchModel
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

constructor TnsBaseSearchModel.Create;
//#UC START# *56F12C01028A_56F12BAB0086_var*
//#UC END# *56F12C01028A_56F12BAB0086_var*
begin
//#UC START# *56F12C01028A_56F12BAB0086_impl*
 !!! Needs to be implemented !!!
//#UC END# *56F12C01028A_56F12BAB0086_impl*
end;//TnsBaseSearchModel.Create

class function TnsBaseSearchModel.Make: InsBaseSearchModel;
var
 l_Inst : TnsBaseSearchModel;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsBaseSearchModel.Make

procedure TnsBaseSearchModel.Changed;
//#UC START# *56F13824018B_56F12BAB0086_var*
//#UC END# *56F13824018B_56F12BAB0086_var*
begin
//#UC START# *56F13824018B_56F12BAB0086_impl*
 !!! Needs to be implemented !!!
//#UC END# *56F13824018B_56F12BAB0086_impl*
end;//TnsBaseSearchModel.Changed

function TnsBaseSearchModel.pm_GetActiveClass: InsBaseSearchClass;
//#UC START# *56D42F43033E_56F12BAB0086get_var*
//#UC END# *56D42F43033E_56F12BAB0086get_var*
begin
//#UC START# *56D42F43033E_56F12BAB0086get_impl*
 !!! Needs to be implemented !!!
//#UC END# *56D42F43033E_56F12BAB0086get_impl*
end;//TnsBaseSearchModel.pm_GetActiveClass

procedure TnsBaseSearchModel.pm_SetActiveClass(const aValue: InsBaseSearchClass);
//#UC START# *56D42F43033E_56F12BAB0086set_var*
//#UC END# *56D42F43033E_56F12BAB0086set_var*
begin
//#UC START# *56D42F43033E_56F12BAB0086set_impl*
 !!! Needs to be implemented !!!
//#UC END# *56D42F43033E_56F12BAB0086set_impl*
end;//TnsBaseSearchModel.pm_SetActiveClass

function TnsBaseSearchModel.pm_GetContext: Il3CString;
//#UC START# *56D42F4C032F_56F12BAB0086get_var*
//#UC END# *56D42F4C032F_56F12BAB0086get_var*
begin
//#UC START# *56D42F4C032F_56F12BAB0086get_impl*
 !!! Needs to be implemented !!!
//#UC END# *56D42F4C032F_56F12BAB0086get_impl*
end;//TnsBaseSearchModel.pm_GetContext

procedure TnsBaseSearchModel.pm_SetContext(const aValue: Il3CString);
//#UC START# *56D42F4C032F_56F12BAB0086set_var*
//#UC END# *56D42F4C032F_56F12BAB0086set_var*
begin
//#UC START# *56D42F4C032F_56F12BAB0086set_impl*
 !!! Needs to be implemented !!!
//#UC END# *56D42F4C032F_56F12BAB0086set_impl*
end;//TnsBaseSearchModel.pm_SetContext

function TnsBaseSearchModel.pm_GetArea: TnsSearchArea;
//#UC START# *56D42F5801B5_56F12BAB0086get_var*
//#UC END# *56D42F5801B5_56F12BAB0086get_var*
begin
//#UC START# *56D42F5801B5_56F12BAB0086get_impl*
 !!! Needs to be implemented !!!
//#UC END# *56D42F5801B5_56F12BAB0086get_impl*
end;//TnsBaseSearchModel.pm_GetArea

procedure TnsBaseSearchModel.pm_SetArea(aValue: TnsSearchArea);
//#UC START# *56D42F5801B5_56F12BAB0086set_var*
//#UC END# *56D42F5801B5_56F12BAB0086set_var*
begin
//#UC START# *56D42F5801B5_56F12BAB0086set_impl*
 !!! Needs to be implemented !!!
//#UC END# *56D42F5801B5_56F12BAB0086set_impl*
end;//TnsBaseSearchModel.pm_SetArea

function TnsBaseSearchModel.pm_GetAvailableAreas: TnsSearchAreas;
//#UC START# *56D42FB300D9_56F12BAB0086get_var*
//#UC END# *56D42FB300D9_56F12BAB0086get_var*
begin
//#UC START# *56D42FB300D9_56F12BAB0086get_impl*
 !!! Needs to be implemented !!!
//#UC END# *56D42FB300D9_56F12BAB0086get_impl*
end;//TnsBaseSearchModel.pm_GetAvailableAreas

function TnsBaseSearchModel.Find(const aProcessor: InsBaseSearchResultProcessor): Boolean;
//#UC START# *56D42FE5023F_56F12BAB0086_var*
//#UC END# *56D42FE5023F_56F12BAB0086_var*
begin
//#UC START# *56D42FE5023F_56F12BAB0086_impl*
 !!! Needs to be implemented !!!
//#UC END# *56D42FE5023F_56F12BAB0086_impl*
end;//TnsBaseSearchModel.Find

function TnsBaseSearchModel.FindBack(const aProcessor: InsBaseSearchResultProcessor): Boolean;
//#UC START# *56D42FFF0321_56F12BAB0086_var*
//#UC END# *56D42FFF0321_56F12BAB0086_var*
begin
//#UC START# *56D42FFF0321_56F12BAB0086_impl*
 !!! Needs to be implemented !!!
//#UC END# *56D42FFF0321_56F12BAB0086_impl*
end;//TnsBaseSearchModel.FindBack

function TnsBaseSearchModel.pm_GetFindBackSupported: Boolean;
//#UC START# *56D4300D027E_56F12BAB0086get_var*
//#UC END# *56D4300D027E_56F12BAB0086get_var*
begin
//#UC START# *56D4300D027E_56F12BAB0086get_impl*
 !!! Needs to be implemented !!!
//#UC END# *56D4300D027E_56F12BAB0086get_impl*
end;//TnsBaseSearchModel.pm_GetFindBackSupported

function TnsBaseSearchModel.pm_GetFindBackEnabled: Boolean;
//#UC START# *56D4301A00C4_56F12BAB0086get_var*
//#UC END# *56D4301A00C4_56F12BAB0086get_var*
begin
//#UC START# *56D4301A00C4_56F12BAB0086get_impl*
 !!! Needs to be implemented !!!
//#UC END# *56D4301A00C4_56F12BAB0086get_impl*
end;//TnsBaseSearchModel.pm_GetFindBackEnabled

procedure TnsBaseSearchModel.AddView(const aVie: InsBaseSearchView);
//#UC START# *56D4309E031C_56F12BAB0086_var*
//#UC END# *56D4309E031C_56F12BAB0086_var*
begin
//#UC START# *56D4309E031C_56F12BAB0086_impl*
 !!! Needs to be implemented !!!
//#UC END# *56D4309E031C_56F12BAB0086_impl*
end;//TnsBaseSearchModel.AddView

procedure TnsBaseSearchModel.RemoveView(const aView: InsBaseSearchView);
//#UC START# *56D430AD02C7_56F12BAB0086_var*
//#UC END# *56D430AD02C7_56F12BAB0086_var*
begin
//#UC START# *56D430AD02C7_56F12BAB0086_impl*
 !!! Needs to be implemented !!!
//#UC END# *56D430AD02C7_56F12BAB0086_impl*
end;//TnsBaseSearchModel.RemoveView

function TnsBaseSearchModel.pm_GetFindEnabled: Boolean;
//#UC START# *56EF9DE2023E_56F12BAB0086get_var*
//#UC END# *56EF9DE2023E_56F12BAB0086get_var*
begin
//#UC START# *56EF9DE2023E_56F12BAB0086get_impl*
 !!! Needs to be implemented !!!
//#UC END# *56EF9DE2023E_56F12BAB0086get_impl*
end;//TnsBaseSearchModel.pm_GetFindEnabled

procedure TnsBaseSearchModel.SubscribeListener(const aListener: InsBaseSearchModelListener);
//#UC START# *56EFAA430205_56F12BAB0086_var*
//#UC END# *56EFAA430205_56F12BAB0086_var*
begin
//#UC START# *56EFAA430205_56F12BAB0086_impl*
 !!! Needs to be implemented !!!
//#UC END# *56EFAA430205_56F12BAB0086_impl*
end;//TnsBaseSearchModel.SubscribeListener

procedure TnsBaseSearchModel.UnsubscribeListener(const aListener: InsBaseSearchModelListener);
//#UC START# *56EFAA520307_56F12BAB0086_var*
//#UC END# *56EFAA520307_56F12BAB0086_var*
begin
//#UC START# *56EFAA520307_56F12BAB0086_impl*
 !!! Needs to be implemented !!!
//#UC END# *56EFAA520307_56F12BAB0086_impl*
end;//TnsBaseSearchModel.UnsubscribeListener

function TnsBaseSearchModel.pm_GetIsLocalSearchArea: Boolean;
//#UC START# *56F122950394_56F12BAB0086get_var*
//#UC END# *56F122950394_56F12BAB0086get_var*
begin
//#UC START# *56F122950394_56F12BAB0086get_impl*
 !!! Needs to be implemented !!!
//#UC END# *56F122950394_56F12BAB0086get_impl*
end;//TnsBaseSearchModel.pm_GetIsLocalSearchArea

function TnsBaseSearchModel.pm_GetExampleText: Il3CString;
//#UC START# *56F2592D029E_56F12BAB0086get_var*
//#UC END# *56F2592D029E_56F12BAB0086get_var*
begin
//#UC START# *56F2592D029E_56F12BAB0086get_impl*
 !!! Needs to be implemented !!!
//#UC END# *56F2592D029E_56F12BAB0086get_impl*
end;//TnsBaseSearchModel.pm_GetExampleText

procedure TnsBaseSearchModel.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_56F12BAB0086_var*
//#UC END# *479731C50290_56F12BAB0086_var*
begin
//#UC START# *479731C50290_56F12BAB0086_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_56F12BAB0086_impl*
end;//TnsBaseSearchModel.Cleanup
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
