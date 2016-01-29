unit kwArchiNewEmptyDocument;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwArchiNewEmptyDocument.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwArchiNewEmptyDocument
//
// *Формат:* Создать_пустой
// *Описание:* Создание пустого документа.
// *Пример:*
// {code}
// Создать_пустой
// {code}
// *Результат:*
// Создает пустой документ
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
 TkwArchiNewEmptyDocument = {scriptword} class(TkwCreateNewFile)
  {* *Формат:* Создать_пустой
*Описание:* Создание пустого документа. 
*Пример:*
[code]
 Создать_пустой
[code]
*Результат:*
 Создает пустой документ
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
 end;//TkwArchiNewEmptyDocument
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

// start class TkwArchiNewEmptyDocument

function TkwArchiNewEmptyDocument.DoWithFileName(const aCtx: TtfwContext): AnsiString;
//#UC START# *52BD79600196_4E8EE51103C2_var*
//#UC END# *52BD79600196_4E8EE51103C2_var*
begin
//#UC START# *52BD79600196_4E8EE51103C2_impl*
 Result := '';
//#UC END# *52BD79600196_4E8EE51103C2_impl*
end;//TkwArchiNewEmptyDocument.DoWithFileName

class function TkwArchiNewEmptyDocument.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Создать_пустой';
end;//TkwArchiNewEmptyDocument.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация TkwArchiNewEmptyDocument
 TkwArchiNewEmptyDocument.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.