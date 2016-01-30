unit kwClickOnCommentHeader;

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwClickOnCommentHeader.pas"
// Стереотип: "ScriptKeyword"

{$Include arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , arEditorControl
 , tfwScriptingInterfaces
 , evCustomEditorWindow
 , nevTools
 , l3Units
 , nevGUIInterfaces
;

type
 _ClickOnCommentHeader_Parent_ = TarEditorControl;
 {$Include ClickOnCommentHeader.imp.pas}
 TkwClickOnCommentHeader = class(_ClickOnCommentHeader_)
  private
   f_Engine: ItfwScriptEngine;
  private
   function CheckCollapsed(aText: TevCustomEditorWindow): Boolean; override;
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    const anEditor: TevCustomEditorWindow); override;
   function GetInnerPara(const aView: InevInputView;
    const aDocument: InevPara): InevPara; override;
    {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwClickOnCommentHeader
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Base
;

{$Include ClickOnCommentHeader.imp.pas}

procedure TkwClickOnCommentHeader.DoWithEditor(const aCtx: TtfwContext;
 const anEditor: TevCustomEditorWindow);
//#UC START# *4DE7421F03DF_4DE740FA0192_var*
//#UC END# *4DE7421F03DF_4DE740FA0192_var*
begin
//#UC START# *4DE7421F03DF_4DE740FA0192_impl*
 RunnerAssert(aCtx.rEngine.IsTopInt, 'Нет номера параграфа в стеке!', aCtx);
 f_Engine := aCtx.rEngine;
 try
  ClickOnPoint(anEditor, True);
  aCtx.rCaller.Check(CheckCollapsed(anEditor));
 finally
  f_Engine := nil;
 end;
//#UC END# *4DE7421F03DF_4DE740FA0192_impl*
end;//TkwClickOnCommentHeader.DoWithEditor

function TkwClickOnCommentHeader.CheckCollapsed(aText: TevCustomEditorWindow): Boolean;
//#UC START# *4DE7456800BE_4DE740FA0192_var*
//#UC END# *4DE7456800BE_4DE740FA0192_var*
begin
//#UC START# *4DE7456800BE_4DE740FA0192_impl*
 {$IfDef evNeedCollapsedVersionComments}
 Result := not aText.View.IsObjectCollapsed[GetInnerPara(aText.View, aText.Document)];
 {$Else  evNeedCollapsedVersionComments}
 Result := true;
 {$EndIf evNeedCollapsedVersionComments}
//#UC END# *4DE7456800BE_4DE740FA0192_impl*
end;//TkwClickOnCommentHeader.CheckCollapsed

function TkwClickOnCommentHeader.GetInnerPara(const aView: InevInputView;
 const aDocument: InevPara): InevPara;
 {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
//#UC START# *4BF4E6A00093_4DE740FA0192_var*
//#UC END# *4BF4E6A00093_4DE740FA0192_var*
begin
//#UC START# *4BF4E6A00093_4DE740FA0192_impl*
 if f_Engine.IsTopInt then
  Result := aDocument.AsList.Para[f_Engine.PopInt]
 else
  Assert(False, 'Нет номера параграфа в стеке!');
//#UC END# *4BF4E6A00093_4DE740FA0192_impl*
end;//TkwClickOnCommentHeader.GetInnerPara

class function TkwClickOnCommentHeader.GetWordNameForRegister: AnsiString;
begin
 Result := 'редактор:параграф:щелкнуть_на_заголовке';
end;//TkwClickOnCommentHeader.GetWordNameForRegister

initialization
 TkwClickOnCommentHeader.RegisterInEngine;
 {* Регистрация TkwClickOnCommentHeader }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
