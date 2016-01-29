unit InsertRowTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "TestFormsTest"
// ������: "w:/common/components/gui/Garant/Daily/InsertRowTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TInsertRowTest
//
// ���� ������� ������
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
 TInsertRowTest = {abstract} class(TTextViaEditorProcessor)
  {* ���� ������� ������ }
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
 end;//TInsertRowTest
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  evOp,
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

// start class TInsertRowTest

procedure TInsertRowTest.Process(aForm: TPrimTextLoadForm);
//#UC START# *4BE13147032C_4CAAC9D601A2_var*
var
 i: Integer;
//#UC END# *4BE13147032C_4CAAC9D601A2_var*
begin
//#UC START# *4BE13147032C_4CAAC9D601A2_impl*
 for i := 0 to 2 do
  aForm.Text.Selection.Cursor.Move(aForm.Text.View, ev_ocLineDown);
 aForm.Text.InsertRow;
//#UC END# *4BE13147032C_4CAAC9D601A2_impl*
end;//TInsertRowTest.Process

function TInsertRowTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TInsertRowTest.GetFolder

function TInsertRowTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CAAC9D601A2';
end;//TInsertRowTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.