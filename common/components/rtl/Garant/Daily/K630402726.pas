unit K630402726;
 {* [Requestlink:630402726] }

// ������: "w:\common\components\rtl\Garant\Daily\K630402726.pas"
// ���������: "TestCase"
// ������� ������: "K630402726" MUID: (57DBC78600D1)
// ��� ����: "TK630402726"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoHTMLWithExternalHyperlinks
;

type
 TK630402726 = class(TEVDtoHTMLWithExternalHyperlinks)
  {* [Requestlink:630402726] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK630402726
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *57DBC78600D1impl_uses*
 //#UC END# *57DBC78600D1impl_uses*
;

function TK630402726.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '8.0';
end;//TK630402726.GetFolder

function TK630402726.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '57DBC78600D1';
end;//TK630402726.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK630402726.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
