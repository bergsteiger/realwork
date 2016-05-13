unit kwArchiCloseDocument;
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

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwArchiCloseDocument.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "TkwArchiCloseDocument" MUID: (4DE632EF020B)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwArchiCloseDocument = class(TtfwRegisterableWord)
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
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwArchiCloseDocument
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestsAdapter
;

class function TkwArchiCloseDocument.GetWordNameForRegister: AnsiString;
begin
 Result := 'Закрыть';
end;//TkwArchiCloseDocument.GetWordNameForRegister

procedure TkwArchiCloseDocument.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DE632EF020B_var*
//#UC END# *4DAEEDE10285_4DE632EF020B_var*
begin
//#UC START# *4DAEEDE10285_4DE632EF020B_impl*
 aCtx.rCaller.Check(arCloseActiveDocument);
//#UC END# *4DAEEDE10285_4DE632EF020B_impl*
end;//TkwArchiCloseDocument.DoDoIt

initialization
 TkwArchiCloseDocument.RegisterInEngine;
 {* Регистрация TkwArchiCloseDocument }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
