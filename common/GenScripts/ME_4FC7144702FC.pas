unit kwPopEditorAlignCellsBoundary;

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwPopEditorAlignCellsBoundary.pas"
// Стереотип: "ScriptKeyword"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackWord
 , evCellWidthCorrecterSpy
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorAlignCellsBoundary = {final} class(TkwEditorFromStackWord, IevCellsWidthCorrecterLogger)
  private
   f_OutputFileName: AnsiString;
   f_ScriptCaller: ItfwScriptCaller;
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
   function OpenLog: AnsiString;
   procedure CloseLog(const aLogName: AnsiString);
   class function GetWordNameForRegister: AnsiString; override;
   procedure ClearFields; override;
 end;//TkwPopEditorAlignCellsBoundary
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evCommonUtils
 , SysUtils
 , StrUtils
 , evCustomEditor
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

procedure TkwPopEditorAlignCellsBoundary.DoWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_4FC7144702FC_var*
//#UC END# *4F4CB81200CA_4FC7144702FC_var*
begin
//#UC START# *4F4CB81200CA_4FC7144702FC_impl*
 f_OutputFileName := ChangeFileExt(ExtractFileName(aCtx.rStreamFactory.Filename), '.cwal');
 RunnerAssert(AnsiStartsStr('TK', f_OutputFileName), 'Имя файла должно начинаться с TK', aCtx);
 Delete(f_OutputFileName, 1, 2);
 f_OutputFileName := aCtx.rCaller.ResolveOutputFilePath(f_OutputFileName);
 f_ScriptCaller := aCtx.rCaller;
 try
  with TevCellWidthCorrecterSpy.Instance do
  begin
   SetLogger(Self);
   try
    StartSaveData;
    try
     EvAlignCellsBoundary(anEditor as TevCustomEditor);
    finally
     EndSaveData;
    end;
   finally
    RemoveLogger(Self);
   end;
  end; // with TevCellWidthCorrecterSpy.Instance do
 finally
  f_ScriptCaller := nil;
 end;//try..finally
//#UC END# *4F4CB81200CA_4FC7144702FC_impl*
end;//TkwPopEditorAlignCellsBoundary.DoWithEditor

function TkwPopEditorAlignCellsBoundary.OpenLog: AnsiString;
//#UC START# *4FC707D40199_4FC7144702FC_var*
//#UC END# *4FC707D40199_4FC7144702FC_var*
begin
//#UC START# *4FC707D40199_4FC7144702FC_impl*
 Result := f_OutputFileName;
//#UC END# *4FC707D40199_4FC7144702FC_impl*
end;//TkwPopEditorAlignCellsBoundary.OpenLog

procedure TkwPopEditorAlignCellsBoundary.CloseLog(const aLogName: AnsiString);
//#UC START# *4FC707E401BA_4FC7144702FC_var*
//#UC END# *4FC707E401BA_4FC7144702FC_var*
begin
//#UC START# *4FC707E401BA_4FC7144702FC_impl*
 f_ScriptCaller.CheckWithEtalon(aLogName, ';');
//#UC END# *4FC707E401BA_4FC7144702FC_impl*
end;//TkwPopEditorAlignCellsBoundary.CloseLog

class function TkwPopEditorAlignCellsBoundary.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:AlignCellsBoundary';
end;//TkwPopEditorAlignCellsBoundary.GetWordNameForRegister

procedure TkwPopEditorAlignCellsBoundary.ClearFields;
begin
 f_ScriptCaller := nil;
 inherited;
end;//TkwPopEditorAlignCellsBoundary.ClearFields

initialization
 TkwPopEditorAlignCellsBoundary.RegisterInEngine;
 {* Регистрация pop_editor_AlignCellsBoundary }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
