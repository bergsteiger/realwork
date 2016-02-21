unit kwConfigRestore;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Shell_Words\kwConfigRestore.pas"
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
 TkwConfigRestore = class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwConfigRestore
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 , nsConfigurationList
 {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
;

procedure TkwConfigRestore.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E68C9020275_var*
//#UC END# *4DAEEDE10285_4E68C9020275_var*
begin
//#UC START# *4DAEEDE10285_4E68C9020275_impl*
 ConfigurationList.ActiveConfig.Load(true);
//#UC END# *4DAEEDE10285_4E68C9020275_impl*
end;//TkwConfigRestore.DoDoIt

class function TkwConfigRestore.GetWordNameForRegister: AnsiString;
begin
 Result := 'Config:Restore';
end;//TkwConfigRestore.GetWordNameForRegister

initialization
 TkwConfigRestore.RegisterInEngine;
 {* Регистрация TkwConfigRestore }
{$IfEnd} // NOT Defined(NoScripts)

end.
