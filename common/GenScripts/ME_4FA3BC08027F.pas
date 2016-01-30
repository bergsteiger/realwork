unit kwPopEditorRepaintTableLinesAndCheckWithEtalon;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorRepaintTableLinesAndCheckWithEtalon.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
 , l3FrameLinesSpy
 , l3InternalInterfaces
;

type
 _LinesDrawOutput_Parent_ = TkwEditorFromStackWord;
 {$Include LinesDrawOutput.imp.pas}
 TkwPopEditorRepaintTableLinesAndCheckWithEtalon = {final} class(_LinesDrawOutput_)
  private
   f_ScriptCaller: ItfwScriptCaller;
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
   procedure DoCloseLog(const aLogName: AnsiString); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorRepaintTableLinesAndCheckWithEtalon
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , StrUtils
 , SysUtils
;

{$Include LinesDrawOutput.imp.pas}

procedure TkwPopEditorRepaintTableLinesAndCheckWithEtalon.DoWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_4FA3BC08027F_var*
//#UC END# *4F4CB81200CA_4FA3BC08027F_var*
begin
//#UC START# *4F4CB81200CA_4FA3BC08027F_impl*
 f_OutputFileName := ExtractFileName(aCtx.rStreamFactory.Filename);
 f_OutputFileName := Copy(f_OutputFileName, 1, Length(f_OutputFileName) - Length('.lines') - 1);
 RunnerAssert(AnsiStartsStr('TK', f_OutputFileName), 'Имя файла должно начинаться с TK', aCtx);
 Delete(f_OutputFileName, 1, 2);
 f_OutputFileName := aCtx.rCaller.ResolveOutputFilePath(f_OutputFileName);
 f_ScriptCaller := aCtx.rCaller;
 if aCtx.rEngine.IsTopInt then
  f_Precision := aCtx.rEngine.PopInt
 else
  Assert(False, 'Не задана точность округления!');
 try
  SaveDrawing(anEditor, False);
 finally
  f_ScriptCaller := nil;
 end;//try..finally
//#UC END# *4F4CB81200CA_4FA3BC08027F_impl*
end;//TkwPopEditorRepaintTableLinesAndCheckWithEtalon.DoWithEditor

procedure TkwPopEditorRepaintTableLinesAndCheckWithEtalon.DoCloseLog(const aLogName: AnsiString);
//#UC START# *4FA3C6D2025F_4FA3BC08027F_var*
//#UC END# *4FA3C6D2025F_4FA3BC08027F_var*
begin
//#UC START# *4FA3C6D2025F_4FA3BC08027F_impl*
 f_ScriptCaller.CheckWithEtalon(aLogName, #0);
//#UC END# *4FA3C6D2025F_4FA3BC08027F_impl*
end;//TkwPopEditorRepaintTableLinesAndCheckWithEtalon.DoCloseLog

class function TkwPopEditorRepaintTableLinesAndCheckWithEtalon.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:RepaintTableLinesAndCheckWithEtalon';
end;//TkwPopEditorRepaintTableLinesAndCheckWithEtalon.GetWordNameForRegister

initialization
 TkwPopEditorRepaintTableLinesAndCheckWithEtalon.RegisterInEngine;
 {* Регистрация pop_editor_RepaintTableLinesAndCheckWithEtalon }
{$IfEnd} // NOT Defined(NoScripts)

end.
