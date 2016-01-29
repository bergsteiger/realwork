unit ShowBaseSearchTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Abstract Tests"
// Модуль: "w:/common/components/rtl/Garant/Abstract_Tests/ShowBaseSearchTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Abstract Tests::EditorTests::TShowBaseSearchTest
//
// Тест показа базового поиска
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
  TextEditorVisitor
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 _MouseClickSupport_Parent_ = TTextEditorVisitor;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\MouseClickSupport.imp.pas}
 TShowBaseSearchTest = {abstract} class(_MouseClickSupport_)
  {* Тест показа базового поиска }
 private
 // private fields
   f_InText : Boolean;
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
     {* Обработать текст }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   {$If defined(nsTest) AND not defined(NoVCM)}
   function WithBaseSearch: Boolean; override;
     {* Форма со строкой базового поиска. }
   {$IfEnd} //nsTest AND not NoVCM
   procedure GetDeltaXY(var X: Integer;
    var Y: Integer); override;
     {* Получить кординаты "щелчка" относительно левого верхнего угла контрола. }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 protected
 // protected methods
   procedure ShowBaseSearch(aForm: TPrimTextLoadForm);
 end;//TShowBaseSearchTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  SysUtils
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  F1LikeFormWithBS_Form
  {$IfEnd} //nsTest AND not NoVCM
  ,
  TestFrameWork,
  Types,
  Messages,
  Windows
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\MouseClickSupport.imp.pas}

// start class TShowBaseSearchTest

procedure TShowBaseSearchTest.ShowBaseSearch(aForm: TPrimTextLoadForm);
//#UC START# *4D6CBCE7034B_4D6CBA680035_var*
//#UC END# *4D6CBCE7034B_4D6CBA680035_var*
begin
//#UC START# *4D6CBCE7034B_4D6CBA680035_impl*
 with (aForm as TF1LikeFormWithBSForm) do
 begin
  BaseSearchControl.PersistentSelection := True;
  BaseSearchControl.TextSource.Document.IsValid;
  BaseSearchControl.Visible := True;
  BaseSearchControl.SetFocus;
 end; // with (aForm as TF1LikeFormWithBSForm) do
//#UC END# *4D6CBCE7034B_4D6CBA680035_impl*
end;//TShowBaseSearchTest.ShowBaseSearch

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TShowBaseSearchTest.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4D6CBA680035_var*
var
 l_SBForm : TF1LikeFormWithBSForm;
//#UC END# *4BE419AF0217_4D6CBA680035_var*
begin
//#UC START# *4BE419AF0217_4D6CBA680035_impl*
 l_SBForm := (aForm as TF1LikeFormWithBSForm);
 ShowBaseSearch(aForm);
 f_InText := True;
 MakeClick(aForm.Text);
 Check(aForm.Text.Focused);
 f_InText := False;
 MakeClick(l_SBForm.BaseSearchControl);
 with l_SBForm.BaseSearchControl do
 begin
  Check(Focused);
  Check(Selection.Caret.Visible);
 end; // with l_SBForm.BaseSearchControl do
//#UC END# *4BE419AF0217_4D6CBA680035_impl*
end;//TShowBaseSearchTest.DoVisit
{$IfEnd} //nsTest AND not NoVCM

function TShowBaseSearchTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TShowBaseSearchTest.GetFolder

{$If defined(nsTest) AND not defined(NoVCM)}
function TShowBaseSearchTest.WithBaseSearch: Boolean;
//#UC START# *4D6CB8460086_4D6CBA680035_var*
//#UC END# *4D6CB8460086_4D6CBA680035_var*
begin
//#UC START# *4D6CB8460086_4D6CBA680035_impl*
 Result := True;
//#UC END# *4D6CB8460086_4D6CBA680035_impl*
end;//TShowBaseSearchTest.WithBaseSearch
{$IfEnd} //nsTest AND not NoVCM

procedure TShowBaseSearchTest.GetDeltaXY(var X: Integer;
  var Y: Integer);
//#UC START# *4D6E5F340304_4D6CBA680035_var*
//#UC END# *4D6E5F340304_4D6CBA680035_var*
begin
//#UC START# *4D6E5F340304_4D6CBA680035_impl*
 if f_InText then
 begin
  X := 100;
  Y := 100;
 end // if f_InText then
 else
 begin
  X := 50;
  Y := 10;
 end;
//#UC END# *4D6E5F340304_4D6CBA680035_impl*
end;//TShowBaseSearchTest.GetDeltaXY

function TShowBaseSearchTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D6CBA680035';
end;//TShowBaseSearchTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.