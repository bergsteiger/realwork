unit NOT_FINISHED_vgObject;

// Модуль: "w:\common\components\rtl\external\VGScene\NOT_FINISHED_vgObject.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvgObject" MUID: (4D4956480326)

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , vgCustomObject
 , vgAnyObjectList
 , vgSortableObjectList
 , vgCustomObjectList
;

type
 TvgObject = class(TvgCustomObject)
  private
   FNotifyList: TvgAnyObjectList;
  protected
   FChildren: TvgSortableObjectList;
  protected
   function pm_GetIsVisual: Boolean; override;
  public
   procedure AddObjectsToList(aList: TvgCustomObjectList);
   procedure AddControlsToList(aList: TvgCustomObjectList);
 end;//TvgObject
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4D4956480326impl_uses*
 //#UC END# *4D4956480326impl_uses*
;

procedure TvgObject.AddObjectsToList(aList: TvgCustomObjectList);
//#UC START# *4D5EA9B9016E_4D4956480326_var*
//#UC END# *4D5EA9B9016E_4D4956480326_var*
begin
//#UC START# *4D5EA9B9016E_4D4956480326_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5EA9B9016E_4D4956480326_impl*
end;//TvgObject.AddObjectsToList

procedure TvgObject.AddControlsToList(aList: TvgCustomObjectList);
//#UC START# *4D5EA9E700D0_4D4956480326_var*
//#UC END# *4D5EA9E700D0_4D4956480326_var*
begin
//#UC START# *4D5EA9E700D0_4D4956480326_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5EA9E700D0_4D4956480326_impl*
end;//TvgObject.AddControlsToList

function TvgObject.pm_GetIsVisual: Boolean;
//#UC START# *4D5EAD10009D_4D4956480326get_var*
//#UC END# *4D5EAD10009D_4D4956480326get_var*
begin
//#UC START# *4D5EAD10009D_4D4956480326get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5EAD10009D_4D4956480326get_impl*
end;//TvgObject.pm_GetIsVisual

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvgObject);
 {* Регистрация TvgObject }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVGScene)

end.
