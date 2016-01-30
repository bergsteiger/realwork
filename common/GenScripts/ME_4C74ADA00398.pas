unit K233019435;
 {* [$233019435] }

// ������: "w:\common\components\rtl\Garant\Daily\K233019435.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , ScrollTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK233019435 = class(TScrollTest)
  {* [$233019435] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK233019435
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK233019435.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK233019435.GetFolder

function TK233019435.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C74ADA00398';
end;//TK233019435.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK233019435.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
