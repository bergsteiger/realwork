unit kwPopEditorGetSelectionTextInFormat;
 {* Получает текст параграфа в указанном формате }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetSelectionTextInFormat.pas"
// Стереотип: "ScriptKeyword"

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
 TkwPopEditorGetSelectionTextInFormat = class(TkwEditorFromStackWord)
  {* Получает текст параграфа в указанном формате }
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorGetSelectionTextInFormat
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Utils
 , nevBase
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , evdBlockNameAdder
 , evdDocumentMarksEliminator
 , evdMarkEliminator
 , ddPicturePathListner
 , evTypes
;

procedure TkwPopEditorGetSelectionTextInFormat.DoWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_4EC10AB3000A_var*
var
 l_F   : Integer;
 l_G   : InevTagGenerator;
 l_Flag: Boolean;
//#UC END# *4F4CB81200CA_4EC10AB3000A_var*
begin
//#UC START# *4F4CB81200CA_4EC10AB3000A_impl*
 if aCtx.rEngine.IsTopString then
 begin
  {$If Declared(l3GetClipboardByFormatName)}
  l_F := l3GetClipboardByFormatName(aCtx.rEngine.PopDelphiString);
  {$Else}
  RunnerAssert(false, 'Не определена функция l3GetClipboardByFormatName', aCtx);
  {$IfEnd}
 end
 else
  l_F := aCtx.rEngine.PopInt;
 l_G := nil;
 if l_F = CF_PDF then
 begin
  l_Flag := TddPicturePathListner.Instance.PDF4Etalon;
  TddPicturePathListner.Instance.PDF4Etalon := True;
 end // if l_F = CF_PDF then
 else
  l_Flag := False;
 try
  TevdBlockNameAdder.SetTo(l_G);
  TevdMarkEliminator.SetTo(l_G);
  TevdDocumentMarksEliminator.SetTo(l_G);
  aCtx.rEngine.PushString(EvAsString(anEditor.View.Control.Selection.GetBlock.Data,
                                     l_F,
                                     false,
                                     l_G));
 finally
  if l_F = CF_PDF then
   TddPicturePathListner.Instance.PDF4Etalon := l_Flag;
 end;
//#UC END# *4F4CB81200CA_4EC10AB3000A_impl*
end;//TkwPopEditorGetSelectionTextInFormat.DoWithEditor

class function TkwPopEditorGetSelectionTextInFormat.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:GetSelectionTextInFormat';
end;//TkwPopEditorGetSelectionTextInFormat.GetWordNameForRegister

initialization
 TkwPopEditorGetSelectionTextInFormat.RegisterInEngine;
 {* Регистрация pop_editor_GetSelectionTextInFormat }
{$IfEnd} // NOT Defined(NoScripts)

end.
