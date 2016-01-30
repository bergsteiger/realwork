unit HotSpotSelectionTest;
 {* Тест выделения с помощью хотспота. }

// Модуль: "w:\common\components\rtl\Garant\Abstract_Tests\HotSpotSelectionTest.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , TextViaEditorProcessor
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
 , evCustomEditorWindow
 , nevTools
 , l3Units
 , nevGUIInterfaces
;

type
 _ClipboardOperations_Parent_ = TTextViaEditorProcessor;
 {$Include ClipboardOperations.imp.pas}
 _Para2Point_Parent_ = _ClipboardOperations_;
 {$Include Para2Point.imp.pas}
 _HotSpotTools_Parent_ = _Para2Point_;
 {$Include HotSpotTools.imp.pas}
 THotSpotSelectionTest = {abstract} class(_HotSpotTools_)
  {* Тест выделения с помощью хотспота. }
  protected
   {$If NOT Defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* Собственно процесс обработки текста }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//THotSpotSelectionTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Types
 , TestFrameWork
 , l3Base
 , evOp
 , l3InternalInterfaces
;

{$Include ClipboardOperations.imp.pas}

{$Include Para2Point.imp.pas}

{$Include HotSpotTools.imp.pas}

{$If NOT Defined(NoVCM)}
procedure THotSpotSelectionTest.Process(aForm: TPrimTextLoadForm);
 {* Собственно процесс обработки текста }
//#UC START# *4BE13147032C_4CED106503D0_var*
var
 l_HotSpot : IevHotSpot;
 l_Effect  : TevMouseEffect;
 l_Keys    : TevMouseState;
 l_l3Pt    : Tl3Point;
//#UC END# *4BE13147032C_4CED106503D0_var*
begin
//#UC START# *4BE13147032C_4CED106503D0_impl*
 l_l3Pt := TranslatePara2Point(aForm.Text);
 l_HotSpot := GetHotSpot(aForm.Text, l_l3Pt, False);
 if l_HotSpot <> nil then
 begin
  l3FillChar(l_Keys, SizeOf(l_Keys), 0);
  l_Keys.rKeys := [];
  l_Keys.rInitialPoint := l_l3Pt;
  l_Keys.rPoint := l_l3Pt;
  l_HotSpot.LButtonDown(aForm.Text.View, l_Keys, l_Effect);
  CopyAndPaste2DocumentBottom(aForm.Text);
 end; // if l_HotSpotTester.GetAdvancedHotSpot(aForm.Text.View,
//#UC END# *4BE13147032C_4CED106503D0_impl*
end;//THotSpotSelectionTest.Process
{$IfEnd} // NOT Defined(NoVCM)

function THotSpotSelectionTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//THotSpotSelectionTest.GetFolder

function THotSpotSelectionTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CED106503D0';
end;//THotSpotSelectionTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
