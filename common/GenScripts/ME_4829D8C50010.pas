unit evMultiSelectEditorWindow;
 {* Редактор с возможностью множественного выделения }

// Модуль: "w:\common\components\gui\Garant\Everest\evMultiSelectEditorWindow.pas"
// Стереотип: "GuiControl"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , evCustomEditorWindowModelPart
 , evCustomEditorWindow
;

type
 TevMultiSelectEditorWindow = class(TevCustomEditorWindowModelPart)
  {* Редактор с возможностью множественного выделения }
  private
   f_AllowMultiSelect: Boolean;
    {* Поле для свойства AllowMultiSelect }
  protected
   function pm_GetAllowMultiSelect: Boolean;
   function GetAllowMultiSelect: Boolean; override;
   function SelectionClass: RevSelection; override;
   function HotSpotClass: RevEditorWindowHotSpot; override;
  public
   property AllowMultiSelect: Boolean
    read pm_GetAllowMultiSelect
    write f_AllowMultiSelect
    default False;
 end;//TevMultiSelectEditorWindow

implementation

uses
 l3ImplUses
 , evMultiSelection
 , evMultiSelectEditorWindowHotSpot
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

function TevMultiSelectEditorWindow.pm_GetAllowMultiSelect: Boolean;
//#UC START# *48E4972B039C_4829D8C50010get_var*
//#UC END# *48E4972B039C_4829D8C50010get_var*
begin
//#UC START# *48E4972B039C_4829D8C50010get_impl*
 Result := inherited pm_GetAllowMultiSelect;
//#UC END# *48E4972B039C_4829D8C50010get_impl*
end;//TevMultiSelectEditorWindow.pm_GetAllowMultiSelect

function TevMultiSelectEditorWindow.GetAllowMultiSelect: Boolean;
//#UC START# *48E1F321030C_4829D8C50010_var*
//#UC END# *48E1F321030C_4829D8C50010_var*
begin
//#UC START# *48E1F321030C_4829D8C50010_impl*
 Result := f_AllowMultiSelect;
//#UC END# *48E1F321030C_4829D8C50010_impl*
end;//TevMultiSelectEditorWindow.GetAllowMultiSelect

function TevMultiSelectEditorWindow.SelectionClass: RevSelection;
//#UC START# *48E22866033A_4829D8C50010_var*
//#UC END# *48E22866033A_4829D8C50010_var*
begin
//#UC START# *48E22866033A_4829D8C50010_impl*
 Result := TevMultiSelection;
//#UC END# *48E22866033A_4829D8C50010_impl*
end;//TevMultiSelectEditorWindow.SelectionClass

function TevMultiSelectEditorWindow.HotSpotClass: RevEditorWindowHotSpot;
//#UC START# *48E2297000D3_4829D8C50010_var*
//#UC END# *48E2297000D3_4829D8C50010_var*
begin
//#UC START# *48E2297000D3_4829D8C50010_impl*
 if AllowMultiSelect then
  Result := TevMultiSelectEditorWindowHotSpot
 else
  Result := inherited HotSpotClass;
//#UC END# *48E2297000D3_4829D8C50010_impl*
end;//TevMultiSelectEditorWindow.HotSpotClass

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TevMultiSelectEditorWindow);
 {* Регистрация TevMultiSelectEditorWindow }
{$IfEnd} // NOT Defined(NoScripts)

end.
