unit ChangeAllTablesTest;
 {* ������ �� ����� ��������� ���������. }

// ������: "w:\common\components\gui\Garant\Daily\ChangeAllTablesTest.pas"
// ���������: "TestCase"

{$Include sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , TextViaEditorProcessor
 , evCustomEditor
 , PrimTextLoad_Form
;

type
 TChangeAllTablesTest = {abstract} class(TTextViaEditorProcessor)
  {* ������ �� ����� ��������� ���������. }
  protected
   procedure ApplyEditorTool(aEditor: TevCustomEditor); virtual; abstract;
    {* ����� ����������� �� ��������� }
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* ���������� ������� ��������� ������ }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TChangeAllTablesTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , evTypes
 , TestFrameWork
;

procedure TChangeAllTablesTest.Process(aForm: TPrimTextLoadForm);
 {* ���������� ������� ��������� ������ }
//#UC START# *4BE13147032C_4C3FEB280134_var*
//#UC END# *4BE13147032C_4C3FEB280134_var*
begin
//#UC START# *4BE13147032C_4C3FEB280134_impl*
 aForm.Text.Select(ev_stDocument);
 ApplyEditorTool(aForm.Text);
//#UC END# *4BE13147032C_4C3FEB280134_impl*
end;//TChangeAllTablesTest.Process

function TChangeAllTablesTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Everest';
end;//TChangeAllTablesTest.GetFolder

function TChangeAllTablesTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C3FEB280134';
end;//TChangeAllTablesTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
