unit K623486769_1;
 {* [Requestlink:623486769] }

// ������: "w:\common\components\rtl\Garant\Daily\K623486769_1.pas"
// ���������: "TestCase"
// ������� ������: "K623486769_1" MUID: (574EAF6201E3)
// ��� ����: "TK623486769_1"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoHTMLWithExternalHyperlinks
;

type
 TK623486769_1 = class(TEVDtoHTMLWithExternalHyperlinks)
  {* [Requestlink:623486769] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK623486769_1
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK623486769_1.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '8.0';
end;//TK623486769_1.GetFolder

function TK623486769_1.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '574EAF6201E3';
end;//TK623486769_1.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK623486769_1.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
