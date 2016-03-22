unit K214074330;
 {* [RequestLink:214074330] }

// ������: "w:\common\components\rtl\Garant\Daily\K214074330.pas"
// ���������: "TestCase"
// ������� ������: "K214074330" MUID: (4C10D71D00E5)
// ��� ����: "TK214074330"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDSectionRepairTest
;

type
 TK214074330 = class(TEVDtoEVDSectionRepairTest)
  {* [RequestLink:214074330] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK214074330
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK214074330.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK214074330.GetFolder

function TK214074330.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C10D71D00E5';
end;//TK214074330.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK214074330.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
