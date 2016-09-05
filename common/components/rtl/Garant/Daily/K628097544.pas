unit K628097544;
 {* [Requestlink:628097544] }

// ������: "w:\common\components\rtl\Garant\Daily\K628097544.pas"
// ���������: "TestCase"
// ������� ������: "K628097544" MUID: (57B1A26602CB)
// ��� ����: "TK628097544"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDFull
;

type
 TK628097544 = class(THTMLtoEVDFull)
  {* [Requestlink:628097544] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK628097544
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *57B1A26602CBimpl_uses*
 //#UC END# *57B1A26602CBimpl_uses*
;

function TK628097544.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '8.0';
end;//TK628097544.GetFolder

function TK628097544.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '57B1A26602CB';
end;//TK628097544.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK628097544.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
