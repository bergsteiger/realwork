unit InsertRowTest;
 {* ���� ������� ������ }

// ������: "w:\common\components\gui\Garant\Daily\InsertRowTest.pas"
// ���������: "TestCase"

{$Include sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TInsertRowTest = {abstract} class(TTextViaEditorProcessor)
  {* ���� ������� ������ }
  protected
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* ���������� ������� ��������� ������ }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TInsertRowTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , evOp
 , TestFrameWork
;

procedure TInsertRowTest.Process(aForm: TPrimTextLoadForm);
 {* ���������� ������� ��������� ������ }
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
 {* ����� � ������� ������ ���� }
begin
 Result := 'Everest';
end;//TInsertRowTest.GetFolder

function TInsertRowTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CAAC9D601A2';
end;//TInsertRowTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
