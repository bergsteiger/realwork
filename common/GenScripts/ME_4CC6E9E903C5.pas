unit K237503834;
 {* [$237503834] }

// ������: "w:\common\components\rtl\Garant\Daily\K237503834.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , DeleteColumnToolTest
;

type
 TK237503834 = class(TDeleteColumnToolTest)
  {* [$237503834] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK237503834
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK237503834.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK237503834.GetFolder

function TK237503834.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CC6E9E903C5';
end;//TK237503834.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK237503834.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
