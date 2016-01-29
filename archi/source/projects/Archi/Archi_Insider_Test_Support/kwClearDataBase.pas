unit kwClearDataBase;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwClearDataBase.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwClearDataBase
//
// *Формат:*  'File_Name.zip' 'Path2Base' ClearDataBase
// *Описание:* Рапаковывает базу из архива 'File_Name.zip' в заданный каталог 'Path2Base'. Каталог,
// в который рапаковывается база, предварительно очищается..
// *Пример:*
// {code}
// 'testBase.zip' 'C:\Base\TestBase' ClearDataBase
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
 TkwClearDataBase = {scriptword} class(TtfwRegisterableWord)
  {* *Формат:*  'File_Name.zip' 'Path2Base' ClearDataBase
*Описание:* Рапаковывает базу из архива 'File_Name.zip' в заданный каталог 'Path2Base'. Каталог, в который рапаковывается база, предварительно очищается.. 
*Пример:*
[code]
  'testBase.zip' 'C:\Base\TestBase' ClearDataBase
[code] }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwClearDataBase
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arDBUtils,
  arArchiTestsAdapter
  {$If not defined(Nemesis)}
  ,
  dt_Jour
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwClearDataBase

procedure TkwClearDataBase.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E4A181002B0_var*
var
 l_Msg      : AnsiString;
 l_DirName  : AnsiString;
 l_FileName : AnsiString;
//#UC END# *4DAEEDE10285_4E4A181002B0_var*
begin
//#UC START# *4DAEEDE10285_4E4A181002B0_impl*
 inherited;
 RunnerAssert(aCtx.rEngine.IsTopString, 'Не задано директория для базы!', aCtx);
 l_DirName := aCtx.rEngine.PopDelphiString;
 RunnerAssert(aCtx.rEngine.IsTopString, 'Не задано имя архива с базой!', aCtx);
 l_FileName := aCtx.rCaller.ResolveInputFilePath(aCtx.rEngine.PopDelphiString);
 try
  acDeInitDB;
 except
  on EdtBrokenFileLock do;
 end;
 if not ArUnackBaseFromArchive(l_FileName, l_DirName, l_Msg) then
  Assert(False, l_Msg);
 acInitDB; 
//#UC END# *4DAEEDE10285_4E4A181002B0_impl*
end;//TkwClearDataBase.DoDoIt

class function TkwClearDataBase.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'ClearDataBase';
end;//TkwClearDataBase.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация TkwClearDataBase
 TkwClearDataBase.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.