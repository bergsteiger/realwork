unit ScrollTest;
 {* ���� �������������� ��������� }

// ������: "w:\common\components\gui\Garant\Daily\ScrollTest.pas"
// ���������: "TestCase"
// ������� ������: "TScrollTest" MUID: (4BEBF13B0076)

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , PrimScrollTest
 , PrimTextLoad_Form
;

type
 TScrollTest = {abstract} class(TPrimScrollTest)
  {* ���� �������������� ��������� }
  protected
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* ���������� ����� }
   function GetNormalFontSize: Integer; override;
    {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TScrollTest
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

procedure TScrollTest.DoVisit(aForm: TPrimTextLoadForm);
 {* ���������� ����� }
//#UC START# *4BE419AF0217_4BEBF13B0076_var*
//#UC END# *4BE419AF0217_4BEBF13B0076_var*
begin
//#UC START# *4BE419AF0217_4BEBF13B0076_impl*
 Scroll(aForm, '');
//#UC END# *4BE419AF0217_4BEBF13B0076_impl*
end;//TScrollTest.DoVisit

function TScrollTest.GetNormalFontSize: Integer;
 {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
//#UC START# *4C07AC6F036D_4BEBF13B0076_var*
//#UC END# *4C07AC6F036D_4BEBF13B0076_var*
begin
//#UC START# *4C07AC6F036D_4BEBF13B0076_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4BEBF13B0076_impl*
end;//TScrollTest.GetNormalFontSize

function TScrollTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Everest';
end;//TScrollTest.GetFolder

function TScrollTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4BEBF13B0076';
end;//TScrollTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
