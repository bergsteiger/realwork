unit kwEditorTextSaveAs;
 {* Описание: сохраняет файл из редактора (без использования выливки) с именем скрипта и заданным в пареметре расширением.
Формат:
[code]
anExt Editor:Text:SaveAs
[code]
где anExt - расширение из списка поддерживаемых: '.evd', .txt', .rtf', .doc' }

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwEditorTextSaveAs.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Editor_Text_SaveAs" MUID: (537D968501B2)
// Имя типа: "TkwEditorTextSaveAs"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwEditorTextSaveAs = {final} class(TtfwRegisterableWord)
  {* Описание: сохраняет файл из редактора (без использования выливки) с именем скрипта и заданным в пареметре расширением.
Формат:
[code]
anExt Editor:Text:SaveAs
[code]
где anExt - расширение из списка поддерживаемых: '.evd', .txt', .rtf', .doc' }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwEditorTextSaveAs
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestAdapter2
 , SysUtils
;

procedure TkwEditorTextSaveAs.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_537D968501B2_var*
var
 l_FileExt: AnsiString;
 l_FileName: AnsiString;
//#UC END# *4DAEEDE10285_537D968501B2_var*
begin
//#UC START# *4DAEEDE10285_537D968501B2_impl*
 RunnerAssert(aCtx.rEngine.IsTopString, 'Не задано расширение!', aCtx);
 l_FileExt := aCtx.rEngine.PopDelphiString;
 l_FileName := ChangeFileExt(aCtx.rStreamFactory.Filename, l_FileExt);
 l_FileName := ExtractFileName(l_FileName);
 l_FileName := aCtx.rCaller.ResolveInputFilePath(l_FileName);
 AcSaveTextAs(l_FileName);
//#UC END# *4DAEEDE10285_537D968501B2_impl*
end;//TkwEditorTextSaveAs.DoDoIt

class function TkwEditorTextSaveAs.GetWordNameForRegister: AnsiString;
begin
 Result := 'Editor:Text:SaveAs';
end;//TkwEditorTextSaveAs.GetWordNameForRegister

initialization
 TkwEditorTextSaveAs.RegisterInEngine;
 {* Регистрация Editor_Text_SaveAs }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

end.
