unit DrawLineTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "TestFormsTest"
// ������: "w:/common/components/gui/Garant/Daily/DrawLineTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TDrawLineTest
//
// ���� ��������� ����� � ���������
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
 TDrawLineTest = {abstract} class(TTextViaEditorProcessor)
  {* ���� ��������� ����� � ��������� }
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
 end;//TDrawLineTest
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  evOp,
  nevBase,
  evMsgCode,
  TestFrameWork,
  vcmBase,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}

// start class TDrawLineTest

procedure TDrawLineTest.Process(aForm: TPrimTextLoadForm);
//#UC START# *4BE13147032C_4C46F52A0317_var*
var
 i    : Integer;
 l_Op : InevOp;
//#UC END# *4BE13147032C_4C46F52A0317_var*
begin
//#UC START# *4BE13147032C_4C46F52A0317_impl*
 GotoDocumentBottom(aForm);
 for i := 1 to 69 do
  aForm.Text.Selection.ProcessCommand(ev_msgMove, ev_ocLineUp, l_Op, 1);
 aForm.Text.Selection.Cursor.Move(aForm.Text.View, ev_ocLineHome);
 l_Op := aForm.Text.StartOp;
 aForm.Text.Selection.DrawLines := True;
 for i := 1 to 50 do
  aForm.Text.Selection.ProcessCommand(ev_msgMove, ev_ocExtLineUp, l_Op, 1);
//#UC END# *4BE13147032C_4C46F52A0317_impl*
end;//TDrawLineTest.Process

function TDrawLineTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TDrawLineTest.GetFolder

function TDrawLineTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C46F52A0317';
end;//TDrawLineTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.