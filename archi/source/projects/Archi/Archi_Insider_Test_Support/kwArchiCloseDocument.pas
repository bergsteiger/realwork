unit kwArchiCloseDocument;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwArchiCloseDocument.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwArchiCloseDocument
//
// *Формат:* Закрыть
// *Описание:* Закрывает текущее дочернее окно в Арчи. В качестве окна может выступать окно
// документа, окно почтового сообщения, окно словарей и т.п.
// *Пример:*
// {code}
// '76.bmp' Создать_Объектный_топик_из
// TRY
// carPictureViewer TryFocus ASSERT
// acCut arMainActionList carMainForm Action:Execute
// ProcessMessages
// acPaste arMainActionList carMainForm Action:Execute
// ProcessMessages
// FINALLY
// wait:No
// Закрыть
// waited:? ASSERT
// END
// {code}
// *Результат:*
// Создает объектный топик из графического файла, выполняет с ними набор тестовых операций (в
// данном случае, копирование/вставка картинкуи в/из буфера обмена) и закрывает документ без
// вопроса о необходимости сохранения.
// *Примечания:*
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
 TkwArchiCloseDocument = {scriptword} class(TtfwRegisterableWord)
  {* *Формат:* Закрыть
*Описание:* Закрывает текущее дочернее окно в Арчи. В качестве окна может выступать окно документа, окно почтового сообщения, окно словарей и т.п.
 *Пример:*
[code]
 '76.bmp' Создать_Объектный_топик_из
 TRY
   carPictureViewer TryFocus ASSERT
   acCut arMainActionList carMainForm Action:Execute
   ProcessMessages
   acPaste arMainActionList carMainForm Action:Execute
   ProcessMessages
 FINALLY
  wait:No
  Закрыть
  waited:? ASSERT
 END
[code]
 *Результат:*
 Создает объектный топик из графического файла, выполняет с ними набор тестовых операций (в данном случае, копирование/вставка картинкуи в/из буфера обмена) и закрывает документ без вопроса о необходимости сохранения.
*Примечания:*
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
 end;//TkwArchiCloseDocument
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestsAdapter
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwArchiCloseDocument

procedure TkwArchiCloseDocument.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DE632EF020B_var*
//#UC END# *4DAEEDE10285_4DE632EF020B_var*
begin
//#UC START# *4DAEEDE10285_4DE632EF020B_impl*
 aCtx.rCaller.Check(arCloseActiveDocument);
//#UC END# *4DAEEDE10285_4DE632EF020B_impl*
end;//TkwArchiCloseDocument.DoDoIt

class function TkwArchiCloseDocument.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Закрыть';
end;//TkwArchiCloseDocument.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация TkwArchiCloseDocument
 TkwArchiCloseDocument.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.