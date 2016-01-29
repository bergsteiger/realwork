unit kwF1BaseDate;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Words"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwF1BaseDate.pas"
// Начат: 14.11.2011 19:32
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Words::Words::f1_BaseDate
//
// Кладёт на стек дату базы в строковом формате
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
 TkwF1BaseDate = {scriptword} class(TtfwRegisterableWord)
  {* Кладёт на стек дату базы в строковом формате }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwF1BaseDate
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  bsUtils
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwF1BaseDate

procedure TkwF1BaseDate.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4EC134690154_var*
//#UC END# *4DAEEDE10285_4EC134690154_var*
begin
//#UC START# *4DAEEDE10285_4EC134690154_impl*
 aCtx.rEngine.PushString(bsBaseDateStr);
//#UC END# *4DAEEDE10285_4EC134690154_impl*
end;//TkwF1BaseDate.DoDoIt

class function TkwF1BaseDate.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'f1:BaseDate';
end;//TkwF1BaseDate.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация f1_BaseDate
 TkwF1BaseDate.RegisterInEngine;
{$IfEnd} //not NoScripts

end.