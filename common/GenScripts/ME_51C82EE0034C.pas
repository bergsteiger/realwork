unit K462555833;
 {* [RequestLink:462555833] }

// ������: "w:\common\components\rtl\Garant\Daily\K462555833.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDEmptyRowAndEmptyTableTest
;

type
 TK462555833 = class(TEVDtoEVDEmptyRowAndEmptyTableTest)
  {* [RequestLink:462555833] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK462555833
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK462555833.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.9';
end;//TK462555833.GetFolder

function TK462555833.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '51C82EE0034C';
end;//TK462555833.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK462555833.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
