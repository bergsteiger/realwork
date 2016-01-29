unit NOT_FINISHED_vgVisualObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VGScene"
// Модуль: "w:/common/components/rtl/external/VGScene/NOT_FINISHED_vgVisualObject.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VGScene::Impl::TvgVisualObject
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\VGScene\vg_define.inc}

interface

{$If not defined(NoVGScene)}
uses
  Classes,
  vgObject,
  vgTypes,
  vgObjectList,
  vgBounds,
  vgPosition
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}
type
 TvgVisualObject = class(TvgObject)
 private
 // private fields
   f_OnClick : TNotifyEvent;
    {* Поле для свойства OnClick}
 protected
 // property methods
   procedure pm_SetOnClick(aValue: TNotifyEvent); virtual;
   function pm_GetAlign: TvgAlign;
   procedure pm_SetAlign(aValue: TvgAlign);
   function pm_GetDragMode: TvgDragMode;
   procedure pm_SetDragMode(aValue: TvgDragMode);
   function pm_GetMargins: TvgBounds;
   procedure pm_SetMargins(aValue: TvgBounds);
   function pm_GetPosition: TvgPosition;
   procedure pm_SetPosition(aValue: TvgPosition);
 protected
 // overridden property methods
   function pm_GetIsVisual: Boolean; override;
 protected
 // protected fields
   FTabList : TvgObjectList;
 public
 // public properties
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
{$IfEnd} //not NoVGScene

implementation

{$If not defined(NoVGScene)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts) AND not defined(NoVGScene)}
  ,
  VGSceneWordsPack
  {$IfEnd} //not NoScripts AND not NoVGScene
  
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}

// start class TvgVisualObject

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

{$IfEnd} //not NoVGScene

initialization
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// Регистрация TvgVisualObject
 TtfwClassRef.Register(TvgVisualObject);
{$IfEnd} //not NoScripts AND not NoVGScene

end.