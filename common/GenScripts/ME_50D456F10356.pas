{$IfNDef kwCheckWithEtalonCommon_imp}

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwCheckWithEtalonCommon.imp.pas"
// Стереотип: "Impurity"

{$Define kwCheckWithEtalonCommon_imp}

{$If NOT Defined(NoScripts)}
 _DrawOutputSupport_Parent_ = _kwCheckWithEtalonCommon_Parent_;
 {$Include DrawOutputSupport.imp.pas}
 _kwCheckWithEtalonCommon_ = class(_DrawOutputSupport_)
  private
   f_ScriptCaller: ItfwScriptCaller;
   f_OutputFileName: AnsiString;
  protected
   procedure ExecuteWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow);
   function DoOpenLog(const aView: InevView): AnsiString; override;
   procedure DoCloseLog(const aLogName: AnsiString); override;
 end;//_kwCheckWithEtalonCommon_

{$Else NOT Defined(NoScripts)}

_DrawOutputSupport_Parent_ = _kwCheckWithEtalonCommon_Parent_;
{$Include DrawOutputSupport.imp.pas}
_kwCheckWithEtalonCommon_ = _DrawOutputSupport_;

{$IfEnd} // NOT Defined(NoScripts)
{$Else kwCheckWithEtalonCommon_imp}

{$IfNDef kwCheckWithEtalonCommon_imp_impl}

{$Define kwCheckWithEtalonCommon_imp_impl}

{$If NOT Defined(NoScripts)}
{$Include DrawOutputSupport.imp.pas}

procedure _kwCheckWithEtalonCommon_.ExecuteWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *50F3D8DF034F_50D456F10356_var*
//#UC END# *50F3D8DF034F_50D456F10356_var*
begin
//#UC START# *50F3D8DF034F_50D456F10356_impl*
 f_OutputFileName := ChangeFileExt(ExtractFileName(aCtx.rStreamFactory.Filename), '.shapes');
 RunnerAssert(AnsiStartsStr('TK', f_OutputFileName), 'Имя файла должно начинаться с TK', aCtx);
 Delete(f_OutputFileName, 1, 2);
 f_OutputFileName := aCtx.rCaller.ResolveOutputFilePath(f_OutputFileName);
 f_ScriptCaller := aCtx.rCaller;
 try
  SaveDrawing(anEditor);
 finally
  f_ScriptCaller := nil;
 end;//try..finally
//#UC END# *50F3D8DF034F_50D456F10356_impl*
end;//_kwCheckWithEtalonCommon_.ExecuteWithEditor

function _kwCheckWithEtalonCommon_.DoOpenLog(const aView: InevView): AnsiString;
//#UC START# *4E1C0C6C026C_50D456F10356_var*
//#UC END# *4E1C0C6C026C_50D456F10356_var*
begin
//#UC START# *4E1C0C6C026C_50D456F10356_impl*
 Result := f_OutputFileName;
//#UC END# *4E1C0C6C026C_50D456F10356_impl*
end;//_kwCheckWithEtalonCommon_.DoOpenLog

procedure _kwCheckWithEtalonCommon_.DoCloseLog(const aLogName: AnsiString);
//#UC START# *4E1C0C8C0007_50D456F10356_var*
//#UC END# *4E1C0C8C0007_50D456F10356_var*
begin
//#UC START# *4E1C0C8C0007_50D456F10356_impl*
 f_ScriptCaller.CheckWithEtalon(aLogName, #0);
//#UC END# *4E1C0C8C0007_50D456F10356_impl*
end;//_kwCheckWithEtalonCommon_.DoCloseLog
{$IfEnd} // NOT Defined(NoScripts)

{$EndIf kwCheckWithEtalonCommon_imp_impl}

{$EndIf kwCheckWithEtalonCommon_imp}

