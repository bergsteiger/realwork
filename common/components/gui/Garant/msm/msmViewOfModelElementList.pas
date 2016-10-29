unit msmViewOfModelElementList;

// Модуль: "w:\common\components\gui\Garant\msm\msmViewOfModelElementList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmViewOfModelElementList" MUID: (57E3BE8101FE)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmViewOfModelElement
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TmsmViewOfModelElementList = class(TmsmViewOfModelElement)
  private
   f_List: ItfwValueList;
  protected
   function pm_GetList: ItfwValueList;
   procedure pm_SetList(const aValue: ItfwValueList);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  protected
   property List: ItfwValueList
    read pm_GetList
    write pm_SetList;
 end;//TmsmViewOfModelElementList

implementation

uses
 l3ImplUses
 //#UC START# *57E3BE8101FEimpl_uses*
 , l3Base
 //#UC END# *57E3BE8101FEimpl_uses*
;

function TmsmViewOfModelElementList.pm_GetList: ItfwValueList;
//#UC START# *57E3BECB002C_57E3BE8101FEget_var*
var
 l_List : ItfwValueList;
//#UC END# *57E3BECB002C_57E3BE8101FEget_var*
begin
//#UC START# *57E3BECB002C_57E3BE8101FEget_impl*
 if (f_List = nil) then
 begin
  Assert(Self.Element.rElement <> nil);
  l_List := Self.Element.rElement.ListProp[Self.Element.rListName];
  pm_SetList(l_List);
 end//f_List = nil
 else
 begin
  if (Self.Element.rElement <> nil) then
  begin
   l_List := Self.Element.rElement.ListProp[Self.Element.rListName];
   if (f_List <> l_List) then
   // - список почему-то поменялся
   begin
    l3System.Msg2Log('Список поменялся неожиданно: ' + Self.Element.rListName);
    pm_SetList(l_List);
   end;//f_List <> l_List
  end;//(Self.Element.rElement <> nil)
 end;//f_List = nil
 Result := f_List; 
//#UC END# *57E3BECB002C_57E3BE8101FEget_impl*
end;//TmsmViewOfModelElementList.pm_GetList

procedure TmsmViewOfModelElementList.pm_SetList(const aValue: ItfwValueList);
//#UC START# *57E3BECB002C_57E3BE8101FEset_var*
//#UC END# *57E3BECB002C_57E3BE8101FEset_var*
begin
//#UC START# *57E3BECB002C_57E3BE8101FEset_impl*
 if (f_List <> aValue) then
 begin
  f_List := aValue
  // - тут надо организовать подписку
 end;//f_List <> aValue
//#UC END# *57E3BECB002C_57E3BE8101FEset_impl*
end;//TmsmViewOfModelElementList.pm_SetList

procedure TmsmViewOfModelElementList.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57E3BE8101FE_var*
//#UC END# *479731C50290_57E3BE8101FE_var*
begin
//#UC START# *479731C50290_57E3BE8101FE_impl*
 List := nil;
 inherited;
//#UC END# *479731C50290_57E3BE8101FE_impl*
end;//TmsmViewOfModelElementList.Cleanup

procedure TmsmViewOfModelElementList.ClearFields;
begin
 List := nil;
 inherited;
end;//TmsmViewOfModelElementList.ClearFields

end.
