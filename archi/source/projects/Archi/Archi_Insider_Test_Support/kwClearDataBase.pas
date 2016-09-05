unit kwClearDataBase;
 {* *Формат:*  'File_Name.zip' 'Path2Base' ClearDataBase
*Описание:* Рапаковывает базу из архива 'File_Name.zip' в заданный каталог 'Path2Base'. Каталог, в который рапаковывается база, предварительно очищается.. 
*Пример:*
[code]
  'testBase.zip' 'C:\Base\TestBase' ClearDataBase
[code] }

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwClearDataBase.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "TkwClearDataBase" MUID: (4E4A181002B0)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwClearDataBase = class(TtfwRegisterableWord)
  {* *Формат:*  'File_Name.zip' 'Path2Base' ClearDataBase
*Описание:* Рапаковывает базу из архива 'File_Name.zip' в заданный каталог 'Path2Base'. Каталог, в который рапаковывается база, предварительно очищается.. 
*Пример:*
[code]
  'testBase.zip' 'C:\Base\TestBase' ClearDataBase
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwClearDataBase
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arDBUtils
 , arArchiTestsAdapter
 {$If NOT Defined(Nemesis)}
 , dt_Jour
 {$IfEnd} // NOT Defined(Nemesis)
 //#UC START# *4E4A181002B0impl_uses*
 //#UC END# *4E4A181002B0impl_uses*
;

class function TkwClearDataBase.GetWordNameForRegister: AnsiString;
begin
 Result := 'ClearDataBase';
end;//TkwClearDataBase.GetWordNameForRegister

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

initialization
 TkwClearDataBase.RegisterInEngine;
 {* Регистрация TkwClearDataBase }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
