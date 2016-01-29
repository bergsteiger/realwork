unit kwArchiOpenDocument;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwArchiOpenDocument.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwArchiOpenDocument
//
// *Формат:*  Номер_документа Внутренний_номер Открыть
// *Описание:* Открывает документ по номеру. Позволяет установить флаг внутренний/внешний при
// задании номера документа.
// *Пример:*
// {code}
// 10003000 true Открыть
// {code}
// *Результат:* Открывает Конституцию РФ
// *Примечания:*
// Константы номеров документов в тестах, залитых в тестовую базу, находятся в файле:
// {code}
// w:\archi\source\projects\Archi\TestSet\Dictionary\DocumentConst.script"
// {code}
// В скриптах напрямую практически не используется, так как есть более удобные функции в файле:
// {code}
// w:\archi\source\projects\Archi\TestSet\Dictionary\MainFormUtils.script"
// {code}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
type
 TkwArchiOpenDocument = {scriptword} class(TtfwRegisterableWord)
  {* *Формат:*  Номер_документа Внутренний_номер Открыть
*Описание:* Открывает документ по номеру. Позволяет установить флаг внутренний/внешний при задании номера документа.
 *Пример:*
 [code]
 10003000 true Открыть
 [code]
 *Результат:* Открывает Конституцию РФ
 *Примечания:*
 Константы номеров документов в тестах, залитых в тестовую базу, находятся в файле:
 [code]
 w:\archi\source\projects\Archi\TestSet\Dictionary\DocumentConst.script"
 [code]
 В скриптах напрямую практически не используется, так как есть более удобные функции в файле:
 [code]
  w:\archi\source\projects\Archi\TestSet\Dictionary\MainFormUtils.script"
 [code] }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwArchiOpenDocument
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestsAdapter
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwArchiOpenDocument

procedure TkwArchiOpenDocument.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DE6299E021A_var*
//#UC END# *4DAEEDE10285_4DE6299E021A_var*
begin
//#UC START# *4DAEEDE10285_4DE6299E021A_impl*
 if aCtx.rEngine.IsTopString then
  aCtx.rCaller.Check(arOpenByNumberAsString(aCtx.rEngine.PopDelphiString, true))
 else
 if aCtx.rEngine.IsTopBool then
 begin
  if aCtx.rEngine.PopBool then
   aCtx.rCaller.Check(arOpenDocumentByNumber(aCtx.rEngine.PopInt, 0, True))
  else
   aCtx.rCaller.Check(arOpenDocumentByNumber(aCtx.rEngine.PopInt, 0, False));
 end//aCtx.rEngine.IsTopBool
 else
  aCtx.rCaller.Check(arOpenDocumentByNumber(aCtx.rEngine.PopInt, 0, False));
//#UC END# *4DAEEDE10285_4DE6299E021A_impl*
end;//TkwArchiOpenDocument.DoDoIt

class function TkwArchiOpenDocument.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Открыть';
end;//TkwArchiOpenDocument.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация TkwArchiOpenDocument
 TkwArchiOpenDocument.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.