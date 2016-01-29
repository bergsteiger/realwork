unit kwCreateNewFile;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwCreateNewFile.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwCreateNewFile
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
  tfwScriptingInterfaces,
  tfwRegisterableWord
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
type
 TkwCreateNewFile = {abstract} class(TtfwRegisterableWord)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // protected methods
   function DoWithFileName(const aCtx: TtfwContext): AnsiString; virtual; abstract;
 end;//TkwCreateNewFile
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

// start class TkwCreateNewFile

procedure TkwCreateNewFile.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_52BD79050326_var*
var
 l_FileName: TFileName;
//#UC END# *4DAEEDE10285_52BD79050326_var*
begin
//#UC START# *4DAEEDE10285_52BD79050326_impl*
 l_FileName := DoWithFileName(aCtx);
 Assert((l_FileName = '') or FileExists(l_FileName), Format('Файл не существует: %s', [l_FileName]));
 ArCreateNewDocumentByFileName(l_FileName, dtText);
//#UC END# *4DAEEDE10285_52BD79050326_impl*
end;//TkwCreateNewFile.DoDoIt

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация TkwCreateNewFile
 TkwCreateNewFile.RegisterClass;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.