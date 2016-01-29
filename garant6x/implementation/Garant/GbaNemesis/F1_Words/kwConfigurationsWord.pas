unit kwConfigurationsWord;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Words"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwConfigurationsWord.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Words::Words::ConfigurationsWord
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  SettingsUnit,
  tfwScriptingInterfaces,
  tfwRegisterableWord
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 _kwConfigurationsWordUses_Parent_ = TtfwRegisterableWord;
 {$Include ..\F1_Words\kwConfigurationsWordUses.imp.pas}
 TkwConfigurationsWord = {abstract scriptword} class(_kwConfigurationsWordUses_)
 private
 // private fields
   f_ConfigurationManager : IConfigurationManager;
    {* Поле для свойства ConfigurationManager}
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 protected
 // protected methods
   procedure DoWithConfigurations(const aCtx: TtfwContext); virtual; abstract;
 protected
 // protected properties
   property ConfigurationManager: IConfigurationManager
     read f_ConfigurationManager;
 end;//TkwConfigurationsWord
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  DataAdapter
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

{$Include ..\F1_Words\kwConfigurationsWordUses.imp.pas}

// start class TkwConfigurationsWord

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
 {-}
begin
 {$If not defined(NoScripts)}
 f_ConfigurationManager := nil;
 {$IfEnd} //not NoScripts
 inherited;
end;//TkwConfigurationsWord.ClearFields

{$IfEnd} //not NoScripts

end.