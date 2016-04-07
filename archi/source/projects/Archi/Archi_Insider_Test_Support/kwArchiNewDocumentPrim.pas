unit kwArchiNewDocumentPrim;
 {* *Формат:* Создать_из
*Описание:* Создание документа из файла. Имя файла совпадает с названием теста, но используется расширение evd.
*Пример:*
[code]
имя_файла  Создать_из
[code]
*Результат:*
 Создает документ из файла имя_файла. При этом анализируется расширение файла. Путь исправляется на путь к тестовым доукментам.
*Примечания:*
 В скриптах напрямую практически не используется, так как есть более удобные функции в файле:
[code]
  w:\archi\source\projects\Archi\TestSet\Dictionary\MainFormUtils.script"
[code] }

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwArchiNewDocumentPrim.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "TkwArchiNewDocumentPrim" MUID: (4E1D42EC0296)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwCreateNewFile
 , tfwScriptingInterfaces
;

type
 TkwArchiNewDocumentPrim = class(TkwCreateNewFile)
  {* *Формат:* Создать_из
*Описание:* Создание документа из файла. Имя файла совпадает с названием теста, но используется расширение evd.
*Пример:*
[code]
имя_файла  Создать_из
[code]
*Результат:*
 Создает документ из файла имя_файла. При этом анализируется расширение файла. Путь исправляется на путь к тестовым доукментам.
*Примечания:*
 В скриптах напрямую практически не используется, так как есть более удобные функции в файле:
[code]
  w:\archi\source\projects\Archi\TestSet\Dictionary\MainFormUtils.script"
[code] }
  protected
   function DoWithFileName(const aCtx: TtfwContext): AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwArchiNewDocumentPrim
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , arArchiTestsAdapter
 , dt_Types
;

function TkwArchiNewDocumentPrim.DoWithFileName(const aCtx: TtfwContext): AnsiString;
//#UC START# *52BD79600196_4E1D42EC0296_var*
//#UC END# *52BD79600196_4E1D42EC0296_var*
begin
//#UC START# *52BD79600196_4E1D42EC0296_impl*
 if aCtx.rEngine.IsTopString then
  Result := aCtx.rEngine.PopDelphiString
 else
  Assert(False, 'Не задано имя файла!');
 Result := ExtractFileName(Result);
 Result := aCtx.rCaller.ResolveInputFilePath(Result);
//#UC END# *52BD79600196_4E1D42EC0296_impl*
end;//TkwArchiNewDocumentPrim.DoWithFileName

class function TkwArchiNewDocumentPrim.GetWordNameForRegister: AnsiString;
begin
 Result := 'Создать_из';
end;//TkwArchiNewDocumentPrim.GetWordNameForRegister

initialization
 TkwArchiNewDocumentPrim.RegisterInEngine;
 {* Регистрация TkwArchiNewDocumentPrim }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
