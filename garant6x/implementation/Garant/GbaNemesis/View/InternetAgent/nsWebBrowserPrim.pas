unit nsWebBrowserPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/InternetAgent/nsWebBrowserPrim.pas"
// Начат: 23.04.2009 15:56
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::InternetAgent::View::InternetAgent::TnsWebBrowserPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  shdocvw
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsWebBrowserPrim = class(TWebBrowser)
 protected
 // overridden protected methods
   procedure AfterConstruction; override;
     {* AfterConstruction is called automatically after the object’s last constructor has executed. Do not call it explicitly in your applications.

The AfterConstruction method implemented in TObject does nothing. Override this method when creating a class that takes some action after the object is created. For example, TCustomForm overrides AfterConstruction to generate an OnCreate event. }
 public
 // overridden public methods
   destructor Destroy; override;
 protected
 // protected methods
   procedure InitFields; virtual;
   procedure Cleanup; virtual;
   function CheckStamp(const aGUID: TGUID): Boolean;
 end;//TnsWebBrowserPrim
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsWebBrowserPrim

procedure TnsWebBrowserPrim.InitFields;
//#UC START# *49F0577C02ED_49F0573B0332_var*
//#UC END# *49F0577C02ED_49F0573B0332_var*
begin
//#UC START# *49F0577C02ED_49F0573B0332_impl*
 // - ничего не делаем
//#UC END# *49F0577C02ED_49F0573B0332_impl*
end;//TnsWebBrowserPrim.InitFields

procedure TnsWebBrowserPrim.Cleanup;
//#UC START# *49F058E50188_49F0573B0332_var*
//#UC END# *49F058E50188_49F0573B0332_var*
begin
//#UC START# *49F058E50188_49F0573B0332_impl*
 // - ничего не делаем
//#UC END# *49F058E50188_49F0573B0332_impl*
end;//TnsWebBrowserPrim.Cleanup

function TnsWebBrowserPrim.CheckStamp(const aGUID: TGUID): Boolean;
//#UC START# *49F05B0D02C7_49F0573B0332_var*
//#UC END# *49F05B0D02C7_49F0573B0332_var*
begin
//#UC START# *49F05B0D02C7_49F0573B0332_impl*
 Result := false;
//#UC END# *49F05B0D02C7_49F0573B0332_impl*
end;//TnsWebBrowserPrim.CheckStamp

destructor TnsWebBrowserPrim.Destroy;
//#UC START# *48077504027E_49F0573B0332_var*
//#UC END# *48077504027E_49F0573B0332_var*
begin
//#UC START# *48077504027E_49F0573B0332_impl*
 Cleanup;
 inherited;
//#UC END# *48077504027E_49F0573B0332_impl*
end;//TnsWebBrowserPrim.Destroy

procedure TnsWebBrowserPrim.AfterConstruction;
//#UC START# *49F057120234_49F0573B0332_var*
//#UC END# *49F057120234_49F0573B0332_var*
begin
//#UC START# *49F057120234_49F0573B0332_impl*
 inherited;
 InitFields;
//#UC END# *49F057120234_49F0573B0332_impl*
end;//TnsWebBrowserPrim.AfterConstruction

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация TnsWebBrowserPrim
 TtfwClassRef.Register(TnsWebBrowserPrim);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.