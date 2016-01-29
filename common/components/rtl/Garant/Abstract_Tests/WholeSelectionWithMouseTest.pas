unit WholeSelectionWithMouseTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Abstract Tests"
// Модуль: "w:/common/components/rtl/Garant/Abstract_Tests/WholeSelectionWithMouseTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Abstract Tests::EditorTests::TWholeSelectionWithMouseTest
//
// Выделение с помощью мыши всего документа (с прокруткой).
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
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TWholeSelectionWithMouseTest = {abstract} class(TTextEditorVisitor)
  {* Выделение с помощью мыши всего документа (с прокруткой). }
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
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TWholeSelectionWithMouseTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  nevGUIInterfaces,
  nevBase,
  l3Units,
  l3Base,
  Windows,
  TestFrameWork
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

// start class TWholeSelectionWithMouseTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TWholeSelectionWithMouseTest.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4DA7CCC00062_var*
const
 cnSelectionStep = 500;
var
 l_Now           : Cardinal;
 l_X             : Integer;
 l_Y             : Integer;
 l_FinishY       : Integer;
 l_FinishX       : Integer;
 l_Effect        : TnevMouseEffect;
 l_Keys          : TnevMouseState;
 l_l3Pt          : Tl3Point;
 l_EditorHotSpot : IevHotSpot;
//#UC END# *4BE419AF0217_4DA7CCC00062_var*
begin
//#UC START# *4BE419AF0217_4DA7CCC00062_impl*
 aForm.Text.Repaint;
 l_X := aForm.Left + 10;
 l_Y := aForm.Top + 10;
 l_l3Pt := l3Point(l_X, l_Y);
 l_EditorHotSpot := aForm.Text.HotSpotClass.Make(aForm.Text, nil);
 try
  // Щелкаем левой кнопкой...
  l3FillChar(l_Effect, SizeOf(l_Effect), 0);
  l_Effect.rNeedAsyncLoop := True;
  l3FillChar(l_Keys, SizeOf(l_Keys), 0);
  l_Keys.rKeys := [];
  l_Keys.rInitialPoint := l_l3Pt;
  l_Keys.rPoint := l_l3Pt;
  if l_EditorHotSpot.LButtonDown(aForm.Text.View, l_Keys, l_Effect) then
  begin
   // Сдвигаем мышь...
   l_FinishX := aForm.BoundsRect.Right - 20;
   l_FinishY := aForm.BoundsRect.Bottom - 10;
   l_l3Pt := aForm.Text.Canvas.DP2LP(l3SPoint(l_FinishX, l_FinishY));
   l_FinishX := l_l3Pt.X;
   l_FinishY := l_l3Pt.Y;
   l_Keys.rInMove := true;
   l_Now := GetTickCount;
   while not aForm.Text.Selection.Finish.AtEnd(aForm.Text.View) do
   begin
    l_Keys.rPoint := l3Point(l_X, l_l3Pt.Y);
    if not l_EditorHotSpot.MouseMove(aForm.Text.View, l_Keys) then Break;
    if l_X < l_FinishX then
     Inc(l_X, cnSelectionStep);
    if l_Y < l_FinishY then
     Inc(l_Y, cnSelectionStep);
    CheckTimeout(l_Now, 30 * 60 * 1000);
   end; // while l_X < l_FinishX do
   l_EditorHotSpot.LButtonUp(aForm.Text.View, l_Keys);
  end; // if l_EditorHotSpot.LButtonDown(aForm.Text.View, l_Keys, l_Effect) then
 finally
  l_EditorHotSpot := nil;
 end;
//#UC END# *4BE419AF0217_4DA7CCC00062_impl*
end;//TWholeSelectionWithMouseTest.DoVisit
{$IfEnd} //nsTest AND not NoVCM

function TWholeSelectionWithMouseTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TWholeSelectionWithMouseTest.GetFolder

function TWholeSelectionWithMouseTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4DA7CCC00062';
end;//TWholeSelectionWithMouseTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.