unit ComplexScrollByLines;
 {* ���� ���� - ���������� �� ��������� ����� ����, � ����� �� ��������� �����. }

// ������: "w:\common\components\gui\Garant\Daily\ComplexScrollByLines.pas"
// ���������: "TestCase"
// ������� ������: "ComplexScrollByLines" MUID: (4C1B135F02B0)
// ��� ����: "TComplexScrollByLines"

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , TextEditorVisitor
 , PrimTextLoad_Form
;

type
 TComplexScrollByLines = {abstract} class(TTextEditorVisitor)
  {* ���� ���� - ���������� �� ��������� ����� ����, � ����� �� ��������� �����. }
  protected
   function GetScrollLineCount2Down: Integer; virtual; abstract;
    {* ���������� ����� ��� ��������� ���� }
   function GetScrollLineCount2Up: Integer; virtual; abstract;
    {* ���������� ����� ��� ��������� ����� }
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* ���������� ����� }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TComplexScrollByLines
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , TestFrameWork
 , vcmBase
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

procedure TComplexScrollByLines.DoVisit(aForm: TPrimTextLoadForm);
 {* ���������� ����� }
//#UC START# *4BE419AF0217_4C1B135F02B0_var*
//#UC END# *4BE419AF0217_4C1B135F02B0_var*
begin
//#UC START# *4BE419AF0217_4C1B135F02B0_impl*
 ScrollByLine(aForm, GetScrollLineCount2Down, False, False);
 ScrollByLine(aForm, GetScrollLineCount2Up, True, False);
 CheckTopAnchor(aForm.Text.View);
//#UC END# *4BE419AF0217_4C1B135F02B0_impl*
end;//TComplexScrollByLines.DoVisit

function TComplexScrollByLines.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Everest';
end;//TComplexScrollByLines.GetFolder

function TComplexScrollByLines.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C1B135F02B0';
end;//TComplexScrollByLines.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
