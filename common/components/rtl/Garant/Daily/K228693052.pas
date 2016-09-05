unit K228693052;
 {* [RequestLink:228693052] }

// ������: "w:\common\components\rtl\Garant\Daily\K228693052.pas"
// ���������: "TestCase"
// ������� ������: "K228693052" MUID: (4C518D2B02F1)
// ��� ����: "TK228693052"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDSectionRepairTest
;

type
 TK228693052 = class(TEVDtoEVDSectionRepairTest)
  {* [RequestLink:228693052] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK228693052
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4C518D2B02F1impl_uses*
 //#UC END# *4C518D2B02F1impl_uses*
;

function TK228693052.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK228693052.GetFolder

function TK228693052.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C518D2B02F1';
end;//TK228693052.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK228693052.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
