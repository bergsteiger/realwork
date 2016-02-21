unit kwStyleTableRestore;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Shell_Words\kwStyleTableRestore.pas"
// Стереотип: "ScriptKeyword"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwStyleTableRestore = class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwStyleTableRestore
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 , nsConfigurationList
 {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
 {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 , nsStyleEditor
 {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
 {$If NOT Defined(DesignTimeLibrary)}
 , evStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
;

procedure TkwStyleTableRestore.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E68D33202D5_var*
//#UC END# *4DAEEDE10285_4E68D33202D5_var*
begin
//#UC START# *4DAEEDE10285_4E68D33202D5_impl*
 TnsStyleTableSettingsInfo.Make(ConfigurationList.ActiveConfig.Configuration).Load(true);
//#UC END# *4DAEEDE10285_4E68D33202D5_impl*
end;//TkwStyleTableRestore.DoDoIt

class function TkwStyleTableRestore.GetWordNameForRegister: AnsiString;
begin
 Result := 'StyleTable:Restore';
end;//TkwStyleTableRestore.GetWordNameForRegister

initialization
 TkwStyleTableRestore.RegisterInEngine;
 {* Регистрация TkwStyleTableRestore }
{$IfEnd} // NOT Defined(NoScripts)

end.
