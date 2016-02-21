unit K226005005;
 {* [$226005005] }

// ������: "w:\common\components\rtl\Garant\Daily\K226005005.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDOEMTableFlagTest
;

type
 TK226005005 = class(TEVDtoEVDOEMTableFlagTest)
  {* [$226005005] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK226005005
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK226005005.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK226005005.GetFolder

function TK226005005.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C3FEEC100C1';
end;//TK226005005.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK226005005.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
