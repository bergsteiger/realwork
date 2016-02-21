unit K442368006;
 {* [Requestlink:442368006] }

// ������: "w:\common\components\rtl\Garant\Daily\K442368006.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDSectionRepairTest
;

type
 TK442368006 = class(TEVDtoEVDSectionRepairTest)
  {* [Requestlink:442368006] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK442368006
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK442368006.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.8';
end;//TK442368006.GetFolder

function TK442368006.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5150432D0169';
end;//TK442368006.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK442368006.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
