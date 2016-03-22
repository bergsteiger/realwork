unit K222757750;
 {* [RequestLink:222757750] }

// ������: "w:\common\components\rtl\Garant\Daily\K222757750.pas"
// ���������: "TestCase"
// ������� ������: "K222757750" MUID: (4C2DEA750305)
// ��� ����: "TK222757750"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCPlusWriterTest
;

type
 TK222757750 = class(TEVDtoNSRCPlusWriterTest)
  {* [RequestLink:222757750] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK222757750
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK222757750.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK222757750.GetFolder

function TK222757750.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C2DEA750305';
end;//TK222757750.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK222757750.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
