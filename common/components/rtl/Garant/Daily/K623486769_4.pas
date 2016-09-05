unit K623486769_4;
 {* [Requestlink:623486769] }

// ������: "w:\common\components\rtl\Garant\Daily\K623486769_4.pas"
// ���������: "TestCase"
// ������� ������: "K623486769_4" MUID: (574EAFB50329)
// ��� ����: "TK623486769_4"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoHTMLWithExternalHyperlinks
;

type
 TK623486769_4 = class(TEVDtoHTMLWithExternalHyperlinks)
  {* [Requestlink:623486769] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK623486769_4
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *574EAFB50329impl_uses*
 //#UC END# *574EAFB50329impl_uses*
;

function TK623486769_4.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '8.0';
end;//TK623486769_4.GetFolder

function TK623486769_4.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '574EAFB50329';
end;//TK623486769_4.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK623486769_4.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
