unit nsWebBrowserPrim;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\InternetAgent\nsWebBrowserPrim.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , shdocvw
;

type
 TnsWebBrowserPrim = class(TWebBrowser)
  protected
   procedure InitFields; virtual;
   procedure Cleanup; virtual;
   function CheckStamp(const aGUID: TGUID): Boolean;
   procedure AfterConstruction; override;
    {* AfterConstruction is called automatically after the object’s last constructor has executed. Do not call it explicitly in your applications.

The AfterConstruction method implemented in TObject does nothing. Override this method when creating a class that takes some action after the object is created. For example, TCustomForm overrides AfterConstruction to generate an OnCreate event. }
  public
   destructor Destroy; override;
 end;//TnsWebBrowserPrim
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

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
 {* AfterConstruction is called automatically after the object’s last constructor has executed. Do not call it explicitly in your applications.

The AfterConstruction method implemented in TObject does nothing. Override this method when creating a class that takes some action after the object is created. For example, TCustomForm overrides AfterConstruction to generate an OnCreate event. }
//#UC START# *49F057120234_49F0573B0332_var*
//#UC END# *49F057120234_49F0573B0332_var*
begin
//#UC START# *49F057120234_49F0573B0332_impl*
 inherited;
 InitFields;
//#UC END# *49F057120234_49F0573B0332_impl*
end;//TnsWebBrowserPrim.AfterConstruction

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnsWebBrowserPrim);
 {* Регистрация TnsWebBrowserPrim }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
