unit K623486769_7;
 {* [Requestlink:623486769] }

// ������: "w:\common\components\rtl\Garant\Daily\K623486769_7.pas"
// ���������: "TestCase"
// ������� ������: "K623486769_7" MUID: (574EB0010211)
// ��� ����: "TK623486769_7"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoHTMLWithExternalHyperlinks
;

type
 TK623486769_7 = class(TEVDtoHTMLWithExternalHyperlinks)
  {* [Requestlink:623486769] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK623486769_7
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK623486769_7.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '8.0';
end;//TK623486769_7.GetFolder

function TK623486769_7.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '574EB0010211';
end;//TK623486769_7.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK623486769_7.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
