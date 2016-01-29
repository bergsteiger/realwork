unit HotSpotSelectionTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Abstract Tests"
// Модуль: "w:/common/components/rtl/Garant/Abstract_Tests/HotSpotSelectionTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Abstract Tests::EditorTests::THotSpotSelectionTest
//
// Тест выделения с помощью хотспота.
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
 _ClipboardOperations_Parent_ = TTextViaEditorProcessor;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\ClipboardOperations.imp.pas}
 _Para2Point_Parent_ = _ClipboardOperations_;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\Para2Point.imp.pas}
 _HotSpotTools_Parent_ = _Para2Point_;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\HotSpotTools.imp.pas}
 THotSpotSelectionTest = {abstract} class(_HotSpotTools_)
  {* Тест выделения с помощью хотспота. }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
     {* Собственно процесс обработки текста }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//THotSpotSelectionTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  Types,
  TestFrameWork,
  l3Base,
  evOp,
  l3InternalInterfaces
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

{$Include w:\common\components\rtl\Garant\ScriptEngine\ClipboardOperations.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\Para2Point.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\HotSpotTools.imp.pas}

// start class THotSpotSelectionTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure THotSpotSelectionTest.Process(aForm: TPrimTextLoadForm);
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
{$IfEnd} //nsTest AND not NoVCM

function THotSpotSelectionTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//THotSpotSelectionTest.GetFolder

function THotSpotSelectionTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CED106503D0';
end;//THotSpotSelectionTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.