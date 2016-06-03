unit K623486769;
 {* [Requestlink:623486769] }

// ������: "w:\common\components\rtl\Garant\Daily\K623486769.pas"
// ���������: "TestCase"
// ������� ������: "K623486769" MUID: (574EAF4002F2)
// ��� ����: "TK623486769"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoHTMLWithExternalHyperlinks
;

type
 TK623486769 = class(TEVDtoHTMLWithExternalHyperlinks)
  {* [Requestlink:623486769] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK623486769
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK623486769.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '8.0';
end;//TK623486769.GetFolder

function TK623486769.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '574EAF4002F2';
end;//TK623486769.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK623486769.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
