unit PasteColumnTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "TestFormsTest"
// ������: "w:/common/components/gui/Garant/Daily/PasteColumnTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TPasteColumnTest
//
// ���� ����������� � ������� �� ������ ������� � ������������ �������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  TextViaEditorProcessor,
  PrimTextLoad_Form
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 TPasteColumnTest = {abstract} class(TTextViaEditorProcessor)
  {* ���� ����������� � ������� �� ������ ������� � ������������ �������. }
 protected
 // realized methods
   procedure Process(aForm: TPrimTextLoadForm); override;
     {* ���������� ������� ��������� ������ }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TPasteColumnTest
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  Classes
  {$If defined(k2ForEditor)}
  ,
  evCursorTools
  {$IfEnd} //k2ForEditor
  ,
  nevTools,
  l3Base,
  TestFrameWork,
  vcmBase,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}

// start class TPasteColumnTest

procedure TPasteColumnTest.Process(aForm: TPrimTextLoadForm);
//#UC START# *4BE13147032C_4C88AA1A00AB_var*
var
 l_Selection : InevSelection;
//#UC END# *4BE13147032C_4C88AA1A00AB_var*
begin
//#UC START# *4BE13147032C_4C88AA1A00AB_impl*
 l_Selection := aForm.Text.Selection;
 if (l_Selection <> nil) then
 begin
  evSelectTableColumn(l_Selection, aForm.Text.Document.Para[0].AsList, 0);
  aForm.Text.Copy;
  evSelectTableColumn(l_Selection, aForm.Text.Document.Para[2].AsList, 0);
  aForm.Text.Paste;
  l3System.ClearClipboard;
 end; // if (l_Selection <> nil) then
//#UC END# *4BE13147032C_4C88AA1A00AB_impl*
end;//TPasteColumnTest.Process

function TPasteColumnTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TPasteColumnTest.GetFolder

function TPasteColumnTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C88AA1A00AB';
end;//TPasteColumnTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.