unit NOT_FINISHED_vgVisualObject;

// Модуль: "w:\common\components\rtl\external\VGScene\NOT_FINISHED_vgVisualObject.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvgVisualObject" MUID: (4D49562A01B7)

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , vgObject
 , Classes
 , vgObjectList
 , vgTypes
 , vgBounds
 , vgPosition
;

type
 TvgVisualObject = class(TvgObject)
  private
   f_OnClick: TNotifyEvent;
    {* Поле для свойства OnClick }
  protected
   FTabList: TvgObjectList;
  protected
   procedure pm_SetOnClick(aValue: TNotifyEvent); virtual;
   function pm_GetAlign: TvgAlign;
   procedure pm_SetAlign(aValue: TvgAlign);
   function pm_GetDragMode: TvgDragMode;
   procedure pm_SetDragMode(aValue: TvgDragMode);
   function pm_GetMargins: TvgBounds;
   procedure pm_SetMargins(aValue: TvgBounds);
   function pm_GetPosition: TvgPosition;
   procedure pm_SetPosition(aValue: TvgPosition);
   function pm_GetIsVisual: Boolean; override;
  public
   property OnClick: TNotifyEvent
    read f_OnClick
    write pm_SetOnClick;
   property Align: TvgAlign
    read pm_GetAlign
    write pm_SetAlign;
   property DragMode: TvgDragMode
    read pm_GetDragMode
    write pm_SetDragMode;
   property Margins: TvgBounds
    read pm_GetMargins
    write pm_SetMargins;
   property Position: TvgPosition
    read pm_GetPosition
    write pm_SetPosition;
 end;//TvgVisualObject
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , VGSceneWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TvgVisualObject.pm_SetOnClick(aValue: TNotifyEvent);
//#UC START# *4D5E5BB000A5_4D49562A01B7set_var*
//#UC END# *4D5E5BB000A5_4D49562A01B7set_var*
begin
//#UC START# *4D5E5BB000A5_4D49562A01B7set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5E5BB000A5_4D49562A01B7set_impl*
end;//TvgVisualObject.pm_SetOnClick

function TvgVisualObject.pm_GetAlign: TvgAlign;
//#UC START# *4D5EB53101A4_4D49562A01B7get_var*
//#UC END# *4D5EB53101A4_4D49562A01B7get_var*
begin
//#UC START# *4D5EB53101A4_4D49562A01B7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5EB53101A4_4D49562A01B7get_impl*
end;//TvgVisualObject.pm_GetAlign

procedure TvgVisualObject.pm_SetAlign(aValue: TvgAlign);
//#UC START# *4D5EB53101A4_4D49562A01B7set_var*
//#UC END# *4D5EB53101A4_4D49562A01B7set_var*
begin
//#UC START# *4D5EB53101A4_4D49562A01B7set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5EB53101A4_4D49562A01B7set_impl*
end;//TvgVisualObject.pm_SetAlign

function TvgVisualObject.pm_GetDragMode: TvgDragMode;
//#UC START# *4D5EB5860298_4D49562A01B7get_var*
//#UC END# *4D5EB5860298_4D49562A01B7get_var*
begin
//#UC START# *4D5EB5860298_4D49562A01B7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5EB5860298_4D49562A01B7get_impl*
end;//TvgVisualObject.pm_GetDragMode

procedure TvgVisualObject.pm_SetDragMode(aValue: TvgDragMode);
//#UC START# *4D5EB5860298_4D49562A01B7set_var*
//#UC END# *4D5EB5860298_4D49562A01B7set_var*
begin
//#UC START# *4D5EB5860298_4D49562A01B7set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5EB5860298_4D49562A01B7set_impl*
end;//TvgVisualObject.pm_SetDragMode

function TvgVisualObject.pm_GetMargins: TvgBounds;
//#UC START# *4D5EC23E012F_4D49562A01B7get_var*
//#UC END# *4D5EC23E012F_4D49562A01B7get_var*
begin
//#UC START# *4D5EC23E012F_4D49562A01B7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5EC23E012F_4D49562A01B7get_impl*
end;//TvgVisualObject.pm_GetMargins

procedure TvgVisualObject.pm_SetMargins(aValue: TvgBounds);
//#UC START# *4D5EC23E012F_4D49562A01B7set_var*
//#UC END# *4D5EC23E012F_4D49562A01B7set_var*
begin
//#UC START# *4D5EC23E012F_4D49562A01B7set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5EC23E012F_4D49562A01B7set_impl*
end;//TvgVisualObject.pm_SetMargins

function TvgVisualObject.pm_GetPosition: TvgPosition;
//#UC START# *4D5EC27D0219_4D49562A01B7get_var*
//#UC END# *4D5EC27D0219_4D49562A01B7get_var*
begin
//#UC START# *4D5EC27D0219_4D49562A01B7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5EC27D0219_4D49562A01B7get_impl*
end;//TvgVisualObject.pm_GetPosition

procedure TvgVisualObject.pm_SetPosition(aValue: TvgPosition);
//#UC START# *4D5EC27D0219_4D49562A01B7set_var*
//#UC END# *4D5EC27D0219_4D49562A01B7set_var*
begin
//#UC START# *4D5EC27D0219_4D49562A01B7set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5EC27D0219_4D49562A01B7set_impl*
end;//TvgVisualObject.pm_SetPosition

function TvgVisualObject.pm_GetIsVisual: Boolean;
//#UC START# *4D5EAD10009D_4D49562A01B7get_var*
//#UC END# *4D5EAD10009D_4D49562A01B7get_var*
begin
//#UC START# *4D5EAD10009D_4D49562A01B7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5EAD10009D_4D49562A01B7get_impl*
end;//TvgVisualObject.pm_GetIsVisual

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvgVisualObject);
 {* Регистрация TvgVisualObject }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVGScene)

end.
