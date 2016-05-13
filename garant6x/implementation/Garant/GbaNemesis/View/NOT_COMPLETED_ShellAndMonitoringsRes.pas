unit NOT_COMPLETED_ShellAndMonitoringsRes;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\NOT_COMPLETED_ShellAndMonitoringsRes.pas"
// Стереотип: "VCMApplication"
// Элемент модели: "ShellAndMonitorings" MUID: (4AAA42BF0267)
// Имя типа: "TShellAndMonitoringsRes"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimF1Res
;

type
 TShellAndMonitoringsRes = {abstract} class(TPrimF1Res)
  protected
   procedure Loaded; override;
 end;//TShellAndMonitoringsRes
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , moCommonSearch
 , tasSaveLoadRealization
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , ShellAndMonitoringsMain_Form
 , evExtFormat
;

procedure TShellAndMonitoringsRes.Loaded;
begin
 inherited;
end;//TShellAndMonitoringsRes.Loaded

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TShellAndMonitoringsRes);
 {* Регистрация ShellAndMonitorings }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
