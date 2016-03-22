unit nscStatusBarButton;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscStatusBarButton.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TnscStatusBarButton" MUID: (503DE6F30027)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 {$If NOT Defined(NoTB97)}
 , tb97Ctls
 {$IfEnd} // NOT Defined(NoTB97)
 , Types
 , StatusBarUtils
 , nscNewInterfaces
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Messages
;

type
 //#UC START# *503DE6F30027ci*
 //#UC END# *503DE6F30027ci*
 _nscStatusBarItemNotification_Parent_ = TCustomToolbarButton97;
 {$Include w:\common\components\gui\Garant\Nemesis\nscStatusBarItemNotification.imp.pas}
 //#UC START# *503DE6F30027cit*
 //#UC END# *503DE6F30027cit*
 TnscStatusBarButton = class(_nscStatusBarItemNotification_)
  protected
   {$If NOT Defined(NoTB97)}
   function IsGtbToolbarButtonSizeNeeded: Boolean; override;
   {$IfEnd} // NOT Defined(NoTB97)
   {$If NOT Defined(NoTB97)}
   function GetIsAutoCenter: Boolean; override;
   {$IfEnd} // NOT Defined(NoTB97)
   {$If NOT Defined(NoTB97)}
   procedure CalcSize(var aSize: TSize); override;
   {$IfEnd} // NOT Defined(NoTB97)
   {$If NOT Defined(NoTB97)}
   function NeedAutoDown: Boolean; override;
   {$IfEnd} // NOT Defined(NoTB97)
 //#UC START# *503DE6F30027publ*
  public
    property AutoSize;
 //#UC END# *503DE6F30027publ*
 end;//TnscStatusBarButton
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , ActnList
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , StatusBarButtonWords
 {$IfEnd} // NOT Defined(NoScripts)
 , l3Base
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoTB97)}
{$Include w:\common\components\gui\Garant\Nemesis\nscStatusBarItemNotification.imp.pas}

function TnscStatusBarButton.IsGtbToolbarButtonSizeNeeded: Boolean;
//#UC START# *503DE82B0311_503DE6F30027_var*
//#UC END# *503DE82B0311_503DE6F30027_var*
begin
//#UC START# *503DE82B0311_503DE6F30027_impl*
 Result := False;
//#UC END# *503DE82B0311_503DE6F30027_impl*
end;//TnscStatusBarButton.IsGtbToolbarButtonSizeNeeded

function TnscStatusBarButton.GetIsAutoCenter: Boolean;
//#UC START# *503E27CA010E_503DE6F30027_var*
//#UC END# *503E27CA010E_503DE6F30027_var*
begin
//#UC START# *503E27CA010E_503DE6F30027_impl*
 Result := True;
//#UC END# *503E27CA010E_503DE6F30027_impl*
end;//TnscStatusBarButton.GetIsAutoCenter

procedure TnscStatusBarButton.CalcSize(var aSize: TSize);
//#UC START# *504779E00385_503DE6F30027_var*
//#UC END# *504779E00385_503DE6F30027_var*
begin
//#UC START# *504779E00385_503DE6F30027_impl*
 inherited CalcSize(aSize);
 aSize.cy := cStatusbarItemSize;
 if DisplayMode = dmGlyphOnly then
  aSize.cx := cStatusbarItemSize;
//#UC END# *504779E00385_503DE6F30027_impl*
end;//TnscStatusBarButton.CalcSize

function TnscStatusBarButton.NeedAutoDown: Boolean;
//#UC START# *50477A430157_503DE6F30027_var*
//#UC END# *50477A430157_503DE6F30027_var*
begin
//#UC START# *50477A430157_503DE6F30027_impl*
 Result := (Action as TCustomAction).AutoCheck;
//#UC END# *50477A430157_503DE6F30027_impl*
end;//TnscStatusBarButton.NeedAutoDown

//#UC START# *503DE6F30027impl*
//#UC END# *503DE6F30027impl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscStatusBarButton);
 {* Регистрация TnscStatusBarButton }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoTB97)

{$IfEnd} // Defined(Nemesis)
end.
