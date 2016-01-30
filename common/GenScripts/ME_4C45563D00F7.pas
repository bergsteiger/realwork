unit ScrollBackByLineTest;
 {* ��������� ��������� ����� ����� }

// ������: "w:\common\components\gui\Garant\Daily\ScrollBackByLineTest.pas"
// ���������: "TestCase"

{$Include sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , PrimScrollTest
 , PrimTextLoad_Form
;

type
 TScrollBackByLineTest = {abstract} class(TPrimScrollTest)
  {* ��������� ��������� ����� ����� }
  protected
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* ���������� ����� }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TScrollBackByLineTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TScrollBackByLineTest.DoVisit(aForm: TPrimTextLoadForm);
 {* ���������� ����� }
//#UC START# *4BE419AF0217_4C45563D00F7_var*
//#UC END# *4BE419AF0217_4C45563D00F7_var*
begin
//#UC START# *4BE419AF0217_4C45563D00F7_impl*
 ScrollByLine(aForm, -1, True, True);
//#UC END# *4BE419AF0217_4C45563D00F7_impl*
end;//TScrollBackByLineTest.DoVisit

function TScrollBackByLineTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Everest';
end;//TScrollBackByLineTest.GetFolder

function TScrollBackByLineTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C45563D00F7';
end;//TScrollBackByLineTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
