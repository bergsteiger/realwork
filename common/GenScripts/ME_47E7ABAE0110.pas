unit Menus;

// Модуль: "w:\common\components\rtl\external\NotFinished\Borland\Delphi\Vcl\Menus.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "Menus" MUID: (47E7ABAE0110)

interface

{$If NOT Defined(NoVCL)}
uses
 l3IntfUses
 , Classes
 , Messages
;

const
 MenuKeyCaps: array [0 .. -1] of  = (
 );

type
 TMenuItem = class(TComponent)
  {* TMenuItem describes the properties of an item in a menu. }
 end;//TMenuItem

 TMenu = class(TComponent)
  {* TMenu is the base type for menu components such as TMainMenu and TPopupMenu. }
  public
   function IsShortCut(var Message: TWMKey): Boolean; virtual;
 end;//TMenu

 TPopupMenu = class(TMenu)
  {* TPopupMenu encapsulates the properties, methods, and events of a pop-up menu. }
  public
   procedure Popup(X: Integer;
    Y: Integer); virtual;
 end;//TPopupMenu

 TMenuKeyCap = (
 );//TMenuKeyCap

 TMainMenu = class(TMenu)
 end;//TMainMenu
{$IfEnd} // NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoVCL)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , MenuWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

function TMenu.IsShortCut(var Message: TWMKey): Boolean;
//#UC START# *52A0905E002D_49A3EC9F01DC_var*
//#UC END# *52A0905E002D_49A3EC9F01DC_var*
begin
//#UC START# *52A0905E002D_49A3EC9F01DC_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A0905E002D_49A3EC9F01DC_impl*
end;//TMenu.IsShortCut

procedure TPopupMenu.Popup(X: Integer;
 Y: Integer);
//#UC START# *52A090A90317_49A5750A01E8_var*
//#UC END# *52A090A90317_49A5750A01E8_var*
begin
//#UC START# *52A090A90317_49A5750A01E8_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A090A90317_49A5750A01E8_impl*
end;//TPopupMenu.Popup

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TMenuItem);
 {* Регистрация TMenuItem }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TMenu);
 {* Регистрация TMenu }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPopupMenu);
 {* Регистрация TPopupMenu }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TMainMenu);
 {* Регистрация TMainMenu }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCL)

end.
