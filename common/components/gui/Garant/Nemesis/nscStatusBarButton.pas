unit nscStatusBarButton;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Nemesis"
// Модуль: "w:/common/components/gui/Garant/Nemesis/nscStatusBarButton.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi For F1::Nemesis::StatusBar::TnscStatusBarButton
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Nemesis\nscDefine.inc}

interface

{$If defined(Nemesis)}
uses
  Classes
  {$If not defined(NoTB97)}
  ,
  tb97Ctls
  {$IfEnd} //not NoTB97
  ,
  Messages,
  nscNewInterfaces,
  StatusBarUtils,
  Controls {a},
  Types
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
//#UC START# *503DE6F30027ci*
//#UC END# *503DE6F30027ci*
 _nscStatusBarItemNotification_Parent_ = TCustomToolbarButton97;
 {$Include ..\Nemesis\nscStatusBarItemNotification.imp.pas}
//#UC START# *503DE6F30027cit*
//#UC END# *503DE6F30027cit*
 TnscStatusBarButton = class(_nscStatusBarItemNotification_)
 protected
 // overridden protected methods
    {$If not defined(NoTB97)}
   function IsGtbToolbarButtonSizeNeeded: Boolean; override;
    {$IfEnd} //not NoTB97
    {$If not defined(NoTB97)}
   function GetIsAutoCenter: Boolean; override;
    {$IfEnd} //not NoTB97
    {$If not defined(NoTB97)}
   procedure CalcSize(var aSize: TSize); override;
    {$IfEnd} //not NoTB97
    {$If not defined(NoTB97)}
   function NeedAutoDown: Boolean; override;
    {$IfEnd} //not NoTB97
//#UC START# *503DE6F30027publ*
  public
    property AutoSize;
//#UC END# *503DE6F30027publ*
 end;//TnscStatusBarButton
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  SysUtils
  {$If not defined(NoVCL)}
  ,
  ActnList
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3Base
  {$If defined(Nemesis) AND not defined(NoScripts)}
  ,
  StatusBarButtonWords
  {$IfEnd} //Nemesis AND not NoScripts
  
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}

{$Include ..\Nemesis\nscStatusBarItemNotification.imp.pas}

// start class TnscStatusBarButton

{$If not defined(NoTB97)}
function TnscStatusBarButton.IsGtbToolbarButtonSizeNeeded: Boolean;
//#UC START# *503DE82B0311_503DE6F30027_var*
//#UC END# *503DE82B0311_503DE6F30027_var*
begin
//#UC START# *503DE82B0311_503DE6F30027_impl*
 Result := False;
//#UC END# *503DE82B0311_503DE6F30027_impl*
end;//TnscStatusBarButton.IsGtbToolbarButtonSizeNeeded
{$IfEnd} //not NoTB97

{$If not defined(NoTB97)}
function TnscStatusBarButton.GetIsAutoCenter: Boolean;
//#UC START# *503E27CA010E_503DE6F30027_var*
//#UC END# *503E27CA010E_503DE6F30027_var*
begin
//#UC START# *503E27CA010E_503DE6F30027_impl*
 Result := True;
//#UC END# *503E27CA010E_503DE6F30027_impl*
end;//TnscStatusBarButton.GetIsAutoCenter
{$IfEnd} //not NoTB97

{$If not defined(NoTB97)}
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
{$IfEnd} //not NoTB97

{$If not defined(NoTB97)}
function TnscStatusBarButton.NeedAutoDown: Boolean;
//#UC START# *50477A430157_503DE6F30027_var*
//#UC END# *50477A430157_503DE6F30027_var*
begin
//#UC START# *50477A430157_503DE6F30027_impl*
 Result := (Action as TCustomAction).AutoCheck;
//#UC END# *50477A430157_503DE6F30027_impl*
end;//TnscStatusBarButton.NeedAutoDown
{$IfEnd} //not NoTB97

//#UC START# *503DE6F30027impl*
//#UC END# *503DE6F30027impl*

{$IfEnd} //Nemesis

initialization
{$If defined(Nemesis) AND not defined(NoScripts)}
// Регистрация TnscStatusBarButton
 TtfwClassRef.Register(TnscStatusBarButton);
{$IfEnd} //Nemesis AND not NoScripts

end.