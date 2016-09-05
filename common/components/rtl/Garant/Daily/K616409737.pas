unit K616409737;
 {* [Requestlink:616409737]. ����������� CSS � ������ ���������. }

// ������: "w:\common\components\rtl\Garant\Daily\K616409737.pas"
// ���������: "TestCase"
// ������� ������: "TK616409737" MUID: (56A8634703BD)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK616409737 = class(THTMLtoEVDTest)
  {* [Requestlink:616409737]. ����������� CSS � ������ ���������. }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK616409737
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *56A8634703BDimpl_uses*
 //#UC END# *56A8634703BDimpl_uses*
;

function TK616409737.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK616409737.GetFolder

function TK616409737.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56A8634703BD';
end;//TK616409737.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK616409737.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
