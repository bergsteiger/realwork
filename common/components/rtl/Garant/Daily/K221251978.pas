unit K221251978;
 {* [RequestLink:221251978] }

// ������: "w:\common\components\rtl\Garant\Daily\K221251978.pas"
// ���������: "TestCase"
// ������� ������: "K221251978" MUID: (4C2C92B700BB)
// ��� ����: "TK221251978"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDSectionRepairTest
;

type
 TK221251978 = class(TEVDtoEVDSectionRepairTest)
  {* [RequestLink:221251978] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK221251978
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK221251978.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK221251978.GetFolder

function TK221251978.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C2C92B700BB';
end;//TK221251978.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK221251978.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
