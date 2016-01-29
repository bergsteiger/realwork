unit ClickOnCommentTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Abstract Tests"
// Модуль: "w:/common/components/rtl/Garant/Abstract_Tests/ClickOnCommentTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Abstract Tests::EditorTests::TClickOnCommentTest
//
// Тестирование кликанья мышью на заголовке комментария.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Abstract_Tests\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  TextViaEditorProcessor
  {$IfEnd} //nsTest AND not NoVCM
  ,
  evCustomEditorWindow,
  l3Units,
  nevTools,
  nevGUIInterfaces
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 _ClickOnCommentHeader_Parent_ = TTextViaEditorProcessor;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\ClickOnCommentHeader.imp.pas}
 TClickOnCommentTest = {abstract} class(_ClickOnCommentHeader_)
  {* Тестирование кликанья мышью на заголовке комментария. }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
     {* Собственно процесс обработки текста }
   {$IfEnd} //nsTest AND not NoVCM
   function CheckCollapsed(aText: TevCustomEditorWindow): Boolean; override;
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TClickOnCommentTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  l3Base
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\ClickOnCommentHeader.imp.pas}

// start class TClickOnCommentTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TClickOnCommentTest.Process(aForm: TPrimTextLoadForm);
//#UC START# *4BE13147032C_4DDF6677000D_var*
//#UC END# *4BE13147032C_4DDF6677000D_var*
begin
//#UC START# *4BE13147032C_4DDF6677000D_impl*
 ClickOnPoint(aForm.Text, True);
 {$IfDef evNeedCollapsedVersionComments}
 Check(CheckCollapsed(aForm.Text));
 {$Else  evNeedCollapsedVersionComments}
 Check(not CheckCollapsed(aForm.Text));
 {$EndIf evNeedCollapsedVersionComments}
//#UC END# *4BE13147032C_4DDF6677000D_impl*
end;//TClickOnCommentTest.Process
{$IfEnd} //nsTest AND not NoVCM

function TClickOnCommentTest.CheckCollapsed(aText: TevCustomEditorWindow): Boolean;
//#UC START# *4DE7456800BE_4DDF6677000D_var*
//#UC END# *4DE7456800BE_4DDF6677000D_var*
begin
//#UC START# *4DE7456800BE_4DDF6677000D_impl*
 {$IfDef evNeedCollapsedVersionComments}
 Result := aText.View.IsObjectCollapsed[GetInnerPara(aText.View, aText.Document)];
 {$Else  evNeedCollapsedVersionComments}
 Result := false;
 {$EndIf evNeedCollapsedVersionComments}
//#UC END# *4DE7456800BE_4DDF6677000D_impl*
end;//TClickOnCommentTest.CheckCollapsed

function TClickOnCommentTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TClickOnCommentTest.GetFolder

function TClickOnCommentTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4DDF6677000D';
end;//TClickOnCommentTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.