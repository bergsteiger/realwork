unit kwF1ImportConsultation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Shell Words"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Shell_Words/kwF1ImportConsultation.pas"
// Начат: 06.06.2011 19:53
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Shell Words::F1 Shell Words::TkwF1ImportConsultation
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
 TkwF1ImportConsultation = {scriptword} class(TtfwRegisterableWord)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwF1ImportConsultation
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  DataAdapter,
  nsTypes
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwF1ImportConsultation

procedure TkwF1ImportConsultation.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DECF7F4001F_var*
var
 l_S : String;
//#UC END# *4DAEEDE10285_4DECF7F4001F_var*
begin
//#UC START# *4DAEEDE10285_4DECF7F4001F_impl*
 l_S := aCtx.rEngine.PopDelphiString;
 l_S := aCtx.rCaller.ResolveInputFilePath(l_S);
 DefDataAdapter.ConsultationManager.LoadFromXml(nsAStr(l_S){.S});
//#UC END# *4DAEEDE10285_4DECF7F4001F_impl*
end;//TkwF1ImportConsultation.DoDoIt

class function TkwF1ImportConsultation.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'f1::ImportConsultation';
end;//TkwF1ImportConsultation.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация TkwF1ImportConsultation
 TkwF1ImportConsultation.RegisterInEngine;
{$IfEnd} //not NoScripts

end.