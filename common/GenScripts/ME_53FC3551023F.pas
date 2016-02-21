unit kwTestResolveInputFilePath;
 {* *Описание:* добавляет к имени файла путь к директории TestSet, где хранятся исходные файлы.
*Формат*
[code]
aFileName test:ResolveInputFilePath
[code]
где aFileName - имя файля без пути (!).
Результат помещается в стек. }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwTestResolveInputFilePath.pas"
// Стереотип: "ScriptKeyword"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwTestResolveInputFilePath = {final} class(TtfwRegisterableWord)
  {* *Описание:* добавляет к имени файла путь к директории TestSet, где хранятся исходные файлы.
*Формат*
[code]
aFileName test:ResolveInputFilePath
[code]
где aFileName - имя файля без пути (!).
Результат помещается в стек. }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwTestResolveInputFilePath
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

procedure TkwTestResolveInputFilePath.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_53FC3551023F_var*
//#UC END# *4DAEEDE10285_53FC3551023F_var*
begin
//#UC START# *4DAEEDE10285_53FC3551023F_impl*
 RunnerAssert(aCtx.rEngine.IsTopString, 'Не задано имя файла!', aCtx);
 aCtx.rEngine.PushString(aCtx.rCaller.ResolveInputFilePath(aCtx.rEngine.PopDelphiString));
//#UC END# *4DAEEDE10285_53FC3551023F_impl*
end;//TkwTestResolveInputFilePath.DoDoIt

class function TkwTestResolveInputFilePath.GetWordNameForRegister: AnsiString;
begin
 Result := 'test:ResolveInputFilePath';
end;//TkwTestResolveInputFilePath.GetWordNameForRegister

initialization
 TkwTestResolveInputFilePath.RegisterInEngine;
 {* Регистрация test_ResolveInputFilePath }
{$IfEnd} // NOT Defined(NoScripts)

end.
