unit ScrollBackTest;
 {* ���� �������������� ��������� � �������� ������� }

// ������: "w:\common\components\gui\Garant\Daily\ScrollBackTest.pas"
// ���������: "TestCase"

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , PrimScrollTest
 , PrimTextLoad_Form
;

type
 TScrollBackTest = {abstract} class(TPrimScrollTest)
  {* ���� �������������� ��������� � �������� ������� }
  protected
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* ���������� ����� }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TScrollBackTest
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

procedure TScrollBackTest.DoVisit(aForm: TPrimTextLoadForm);
 {* ���������� ����� }
//#UC START# *4BE419AF0217_4BFBDEA300F4_var*
//#UC END# *4BE419AF0217_4BFBDEA300F4_var*
begin
//#UC START# *4BE419AF0217_4BFBDEA300F4_impl*
 ScrollBack(aForm, '');
//#UC END# *4BE419AF0217_4BFBDEA300F4_impl*
end;//TScrollBackTest.DoVisit

function TScrollBackTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Everest';
end;//TScrollBackTest.GetFolder

function TScrollBackTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4BFBDEA300F4';
end;//TScrollBackTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
