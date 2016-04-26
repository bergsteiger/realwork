unit MainMenuProcessingWordsPack;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\MainMenuProcessingWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "MainMenuProcessingWordsPack" MUID: (571E23FB01C3)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 //#UC START# *571E23FB01C3intf_uses*
 //#UC END# *571E23FB01C3intf_uses*
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
 , SysUtils
 , tfwTypeRegistrator
 , tfwScriptingTypes
 //#UC START# *571E23FB01C3impl_uses*
 , StdRes
 //#UC END# *571E23FB01C3impl_uses*
;

type
 TkwMainMenu = {final} class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwMainMenu

procedure TkwMainMenu.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DAF1471030D_var*
//#UC END# *4DAEEDE10285_4DAF1471030D_var*
begin
//#UC START# *4DAEEDE10285_4DAF1471030D_impl*
 TdmStdRes.OpenMainMenuIfNeeded(nil);
//#UC END# *4DAEEDE10285_4DAF1471030D_impl*
end;//TkwMainMenu.DoDoIt

class function TkwMainMenu.GetWordNameForRegister: AnsiString;
begin
 Result := 'ОсновноеМеню';
end;//TkwMainMenu.GetWordNameForRegister

initialization
 TkwMainMenu.RegisterInEngine;
 {* Регистрация MainMenu }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
