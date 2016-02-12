unit kwConfigurationsWord;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwConfigurationsWord.pas"
// Стереотип: "ScriptKeyword"

{$Include nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , SettingsUnit
 , tfwScriptingInterfaces
;

type
 _kwConfigurationsWordUses_Parent_ = TtfwRegisterableWord;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwConfigurationsWordUses.imp.pas}
 TkwConfigurationsWord = {abstract} class(_kwConfigurationsWordUses_)
  private
   f_ConfigurationManager: IConfigurationManager;
    {* Поле для свойства ConfigurationManager }
  protected
   procedure DoWithConfigurations(const aCtx: TtfwContext); virtual; abstract;
   procedure DoDoIt(const aCtx: TtfwContext); override;
   procedure ClearFields; override;
  protected
   property ConfigurationManager: IConfigurationManager
    read f_ConfigurationManager;
 end;//TkwConfigurationsWord
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , DataAdapter
;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwConfigurationsWordUses.imp.pas}

procedure TkwConfigurationsWord.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_53B2E10F03C0_var*
//#UC END# *4DAEEDE10285_53B2E10F03C0_var*
begin
//#UC START# *4DAEEDE10285_53B2E10F03C0_impl*
 f_ConfigurationManager := DefDataAdapter.NativeAdapter.MakeConfigurationManager;
 try
  DoWithConfigurations(aCtx);
 finally
  f_ConfigurationManager := nil;
 end;
//#UC END# *4DAEEDE10285_53B2E10F03C0_impl*
end;//TkwConfigurationsWord.DoDoIt

procedure TkwConfigurationsWord.ClearFields;
begin
 f_ConfigurationManager := nil;
 inherited;
end;//TkwConfigurationsWord.ClearFields
{$IfEnd} // NOT Defined(NoScripts)

end.
