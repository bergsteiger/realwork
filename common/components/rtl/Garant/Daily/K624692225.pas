unit K624692225;
 {* [Requestlink:624692225] }

// ������: "w:\common\components\rtl\Garant\Daily\K624692225.pas"
// ���������: "TestCase"
// ������� ������: "K624692225" MUID: (5762732D0290)
// ��� ����: "TK624692225"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDFull
;

type
 TK624692225 = class(THTMLtoEVDFull)
  {* [Requestlink:624692225] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK624692225
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5762732D0290impl_uses*
 //#UC END# *5762732D0290impl_uses*
;

function TK624692225.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '8.0';
end;//TK624692225.GetFolder

function TK624692225.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5762732D0290';
end;//TK624692225.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK624692225.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
