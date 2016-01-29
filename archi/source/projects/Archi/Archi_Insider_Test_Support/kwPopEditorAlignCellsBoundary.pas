unit kwPopEditorAlignCellsBoundary;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwPopEditorAlignCellsBoundary.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::EditorKeyWords::pop_editor_AlignCellsBoundary
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
  kwEditorFromStackWord,
  evCellWidthCorrecterSpy,
  evCustomEditorWindow
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
type
 TkwPopEditorAlignCellsBoundary = {final scriptword} class(TkwEditorFromStackWord, IevCellsWidthCorrecterLogger)
 private
 // private fields
   f_OutputFileName : AnsiString;
   f_ScriptCaller : ItfwScriptCaller;
 protected
 // realized methods
   procedure DoWithEditor(const aCtx: TtfwContext;
     anEditor: TevCustomEditorWindow); override;
   function OpenLog: AnsiString;
   procedure CloseLog(const aLogName: AnsiString);
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 end;//TkwPopEditorAlignCellsBoundary
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  evCommonUtils,
  SysUtils,
  StrUtils,
  evCustomEditor
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwPopEditorAlignCellsBoundary

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
 {-}
begin
 Result := 'pop:editor:AlignCellsBoundary';
end;//TkwPopEditorAlignCellsBoundary.GetWordNameForRegister

procedure TkwPopEditorAlignCellsBoundary.ClearFields;
 {-}
begin
 {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
 f_ScriptCaller := nil;
 {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
 inherited;
end;//TkwPopEditorAlignCellsBoundary.ClearFields

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация pop_editor_AlignCellsBoundary
 TkwPopEditorAlignCellsBoundary.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.