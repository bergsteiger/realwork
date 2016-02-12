unit ShowBaseSearchTest;
 {* Тест показа базового поиска }

// Модуль: "w:\common\components\rtl\Garant\Abstract_Tests\ShowBaseSearchTest.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , TextEditorVisitor
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 _MouseClickSupport_Parent_ = TTextEditorVisitor;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\MouseClickSupport.imp.pas}
 TShowBaseSearchTest = {abstract} class(_MouseClickSupport_)
  {* Тест показа базового поиска }
  private
   f_InText: Boolean;
  protected
   procedure ShowBaseSearch(aForm: TPrimTextLoadForm);
   {$If NOT Defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* Обработать текст }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   {$If NOT Defined(NoVCM)}
   function WithBaseSearch: Boolean; override;
    {* Форма со строкой базового поиска. }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure GetDeltaXY(var X: Integer;
    var Y: Integer); override;
    {* Получить кординаты "щелчка" относительно левого верхнего угла контрола. }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TShowBaseSearchTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , F1LikeFormWithBS_Form
 {$IfEnd} // NOT Defined(NoVCM)
 , TestFrameWork
 , Types
 , Messages
 , Windows
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\MouseClickSupport.imp.pas}

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

{$If NOT Defined(NoVCM)}
procedure TShowBaseSearchTest.DoVisit(aForm: TPrimTextLoadForm);
 {* Обработать текст }
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
{$IfEnd} // NOT Defined(NoVCM)

function TShowBaseSearchTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TShowBaseSearchTest.GetFolder

{$If NOT Defined(NoVCM)}
function TShowBaseSearchTest.WithBaseSearch: Boolean;
 {* Форма со строкой базового поиска. }
//#UC START# *4D6CB8460086_4D6CBA680035_var*
//#UC END# *4D6CB8460086_4D6CBA680035_var*
begin
//#UC START# *4D6CB8460086_4D6CBA680035_impl*
 Result := True;
//#UC END# *4D6CB8460086_4D6CBA680035_impl*
end;//TShowBaseSearchTest.WithBaseSearch
{$IfEnd} // NOT Defined(NoVCM)

procedure TShowBaseSearchTest.GetDeltaXY(var X: Integer;
 var Y: Integer);
 {* Получить кординаты "щелчка" относительно левого верхнего угла контрола. }
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
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D6CBA680035';
end;//TShowBaseSearchTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
