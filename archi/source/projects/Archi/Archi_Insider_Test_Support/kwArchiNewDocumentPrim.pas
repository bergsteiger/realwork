unit kwArchiNewDocumentPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwArchiNewDocumentPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwArchiNewDocumentPrim
//
// *Формат:* Создать_из
// *Описание:* Создание документа из файла. Имя файла совпадает с названием теста, но используется
// расширение evd.
// *Пример:*
// {code}
// имя_файла  Создать_из
// {code}
// *Результат:*
// Создает документ из файла имя_файла. При этом анализируется расширение файла. Путь исправляется
// на путь к тестовым доукментам.
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
  kwCreateNewFile,
  tfwScriptingInterfaces
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
type
 TkwArchiNewDocumentPrim = {scriptword} class(TkwCreateNewFile)
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
 // realized methods
   function DoWithFileName(const aCtx: TtfwContext): AnsiString; override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwArchiNewDocumentPrim
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestsAdapter,
  dt_Types,
  SysUtils
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwArchiNewDocumentPrim

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
 {-}
begin
 Result := 'Создать_из';
end;//TkwArchiNewDocumentPrim.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация TkwArchiNewDocumentPrim
 TkwArchiNewDocumentPrim.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.