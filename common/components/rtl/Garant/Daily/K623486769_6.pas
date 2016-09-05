unit K623486769_6;
 {* [Requestlink:623486769] }

// ������: "w:\common\components\rtl\Garant\Daily\K623486769_6.pas"
// ���������: "TestCase"
// ������� ������: "K623486769_6" MUID: (574EAFF003CC)
// ��� ����: "TK623486769_6"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoHTMLWithExternalHyperlinks
;

type
 TK623486769_6 = class(TEVDtoHTMLWithExternalHyperlinks)
  {* [Requestlink:623486769] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK623486769_6
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *574EAFF003CCimpl_uses*
 //#UC END# *574EAFF003CCimpl_uses*
;

function TK623486769_6.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '8.0';
end;//TK623486769_6.GetFolder

function TK623486769_6.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '574EAFF003CC';
end;//TK623486769_6.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK623486769_6.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
