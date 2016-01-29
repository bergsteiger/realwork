unit kwStyleTableRestore;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Shell Words"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Shell_Words/kwStyleTableRestore.pas"
// Начат: 08.09.2011 18:38
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Shell Words::F1 Shell Words::TkwStyleTableRestore
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
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwStyleTableRestore = {scriptword} class(TtfwRegisterableWord)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwStyleTableRestore
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  Classes
  {$If not defined(Admin) AND not defined(Monitorings)}
  ,
  nsConfigurationList
  {$IfEnd} //not Admin AND not Monitorings
  
  {$If not defined(Admin) AND not defined(Monitorings)}
  ,
  nsStyleEditor
  {$IfEnd} //not Admin AND not Monitorings
  
  {$If not defined(DesignTimeLibrary)}
  ,
  evStyleTableSpy
  {$IfEnd} //not DesignTimeLibrary
  
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwStyleTableRestore

procedure TkwStyleTableRestore.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E68D33202D5_var*
//#UC END# *4DAEEDE10285_4E68D33202D5_var*
begin
//#UC START# *4DAEEDE10285_4E68D33202D5_impl*
 TnsStyleTableSettingsInfo.Make(ConfigurationList.ActiveConfig.Configuration).Load(true);
//#UC END# *4DAEEDE10285_4E68D33202D5_impl*
end;//TkwStyleTableRestore.DoDoIt

class function TkwStyleTableRestore.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'StyleTable:Restore';
end;//TkwStyleTableRestore.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация TkwStyleTableRestore
 TkwStyleTableRestore.RegisterInEngine;
{$IfEnd} //not NoScripts

end.