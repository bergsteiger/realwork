unit K586185519;
 {* [Requestlink:586185519] }

// ������: "w:\common\components\rtl\Garant\Daily\K586185519.pas"
// ���������: "TestCase"
// ������� ������: "K586185519" MUID: (54C646FE0345)
// ��� ����: "TK586185519"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK586185519 = class(THTMLtoEVDTest)
  {* [Requestlink:586185519] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK586185519
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *54C646FE0345impl_uses*
 //#UC END# *54C646FE0345impl_uses*
;

function TK586185519.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK586185519.GetFolder

function TK586185519.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '54C646FE0345';
end;//TK586185519.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK586185519.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
