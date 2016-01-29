unit kwClickOnCommentHeader;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwClickOnCommentHeader.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwClickOnCommentHeader
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
  arEditorControl,
  evCustomEditorWindow,
  l3Units,
  nevTools,
  nevGUIInterfaces
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
type
 _ClickOnCommentHeader_Parent_ = TarEditorControl;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\ClickOnCommentHeader.imp.pas}
 TkwClickOnCommentHeader = {scriptword} class(_ClickOnCommentHeader_)
 private
 // private fields
   f_Engine : ItfwScriptEngine;
 protected
 // realized methods
   procedure DoWithEditor(const aCtx: TtfwContext;
    const anEditor: TevCustomEditorWindow); override;
   function CheckCollapsed(aText: TevCustomEditorWindow): Boolean; override;
 protected
 // overridden protected methods
   function GetInnerPara(const aView: InevInputView;
    const aDocument: InevPara): InevPara; override;
     {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwClickOnCommentHeader
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  l3Base
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\ClickOnCommentHeader.imp.pas}

// start class TkwClickOnCommentHeader

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
 {-}
begin
 Result := 'редактор:параграф:щелкнуть_на_заголовке';
end;//TkwClickOnCommentHeader.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация TkwClickOnCommentHeader
 TkwClickOnCommentHeader.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.