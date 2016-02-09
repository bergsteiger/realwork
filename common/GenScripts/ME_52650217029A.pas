unit kwInsertFromStreamCommon;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwInsertFromStreamCommon.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwInsertFromStreamCommon = {abstract} class(TkwEditorFromStackWord)
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
  public
   function GetFormat(const aCtx: TtfwContext): Integer; virtual; abstract;
 end;//TkwInsertFromStreamCommon
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evTypes
 , ActiveX
 , l3Base
 , l3Filer
 , nevInternalInterfaces
 , l3Types
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

procedure TkwInsertFromStreamCommon.DoWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_52650217029A_var*
var
 l_Filer    : Tl3CustomDOSFiler;
 l_Format   : Integer;
 l_Reader   : Tk2CustomReader;
 l_FileName : AnsiString;
//#UC END# *4F4CB81200CA_52650217029A_var*
begin
//#UC START# *4F4CB81200CA_52650217029A_impl*
 l_Format := GetFormat(aCtx);
 RunnerAssert(aCtx.rEngine.IsTopString, 'Не задано имя файла!', aCtx);
 l_FileName := aCtx.rEngine.PopDelphiString;
 l_FileName := aCtx.rCaller.ResolveInputFilePath(l_FileName);
 l_Filer := Tl3CustomDOSFiler.Make(l_FileName, l3_fmRead, False);
 try
  InevDocumentContainerInternal(anEditor.TextSource.DocumentContainer.Internal).GetReader(l_Format,
                                                                                          l_Filer As IStream,
                                                                                          l_Reader,
                                                                                          False,
                                                                                          l_Filer.CodePage);
  try
   if l_Reader = nil then Exit;
   with anEditor do
    TextSource.DocumentContainer.TagWriter.WriteTagEx(View, l_Reader, Selection.Cursor);
  finally
   l3Free(l_Reader);
  end;//try..finally
 finally
  l3Free(l_Filer);
 end;
//#UC END# *4F4CB81200CA_52650217029A_impl*
end;//TkwInsertFromStreamCommon.DoWithEditor

initialization
 TkwInsertFromStreamCommon.RegisterClass;
 {* Регистрация TkwInsertFromStreamCommon }
{$IfEnd} // NOT Defined(NoScripts)

end.
