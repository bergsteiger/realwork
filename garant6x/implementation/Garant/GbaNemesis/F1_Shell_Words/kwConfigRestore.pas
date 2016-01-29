unit kwConfigRestore;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Shell Words"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Shell_Words/kwConfigRestore.pas"
// Начат: 08.09.2011 17:54
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Shell Words::F1 Shell Words::TkwConfigRestore
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
 TkwConfigRestore = {scriptword} class(TtfwRegisterableWord)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwConfigRestore
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  Classes
  {$If not defined(Admin) AND not defined(Monitorings)}
  ,
  nsConfigurationList
  {$IfEnd} //not Admin AND not Monitorings
  
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwConfigRestore

procedure TkwConfigRestore.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E68C9020275_var*
//#UC END# *4DAEEDE10285_4E68C9020275_var*
begin
//#UC START# *4DAEEDE10285_4E68C9020275_impl*
 ConfigurationList.ActiveConfig.Load(true);
//#UC END# *4DAEEDE10285_4E68C9020275_impl*
end;//TkwConfigRestore.DoDoIt

class function TkwConfigRestore.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Config:Restore';
end;//TkwConfigRestore.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация TkwConfigRestore
 TkwConfigRestore.RegisterInEngine;
{$IfEnd} //not NoScripts

end.