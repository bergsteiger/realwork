unit K537249545;
 {* [Requestlink:537249545] }

// ������: "w:\common\components\rtl\Garant\Daily\K537249545.pas"
// ���������: "TestCase"
// ������� ������: "K537249545" MUID: (53847E7A007B)
// ��� ����: "TK537249545"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK537249545 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:537249545] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK537249545
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *53847E7A007Bimpl_uses*
 //#UC END# *53847E7A007Bimpl_uses*
;

function TK537249545.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK537249545.GetFolder

function TK537249545.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '53847E7A007B';
end;//TK537249545.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK537249545.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
