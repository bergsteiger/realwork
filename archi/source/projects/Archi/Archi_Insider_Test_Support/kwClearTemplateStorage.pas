unit kwClearTemplateStorage;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwClearTemplateStorage.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::CommonArchiWords::ClearTemplateStorage
//
// Очищает данные для 'Текстового шаблона'
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
type
 TkwClearTemplateStorage = {final scriptword} class(TtfwRegisterableWord)
  {* Очищает данные для 'Текстового шаблона' }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwClearTemplateStorage
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestAdapter2
  ;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwClearTemplateStorage

procedure TkwClearTemplateStorage.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_53B647A9029B_var*
//#UC END# *4DAEEDE10285_53B647A9029B_var*
begin
//#UC START# *4DAEEDE10285_53B647A9029B_impl*
 ArClearTemplateStorage;
//#UC END# *4DAEEDE10285_53B647A9029B_impl*
end;//TkwClearTemplateStorage.DoDoIt

class function TkwClearTemplateStorage.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'ClearTemplateStorage';
end;//TkwClearTemplateStorage.GetWordNameForRegister

{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация ClearTemplateStorage
 TkwClearTemplateStorage.RegisterInEngine;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

end.