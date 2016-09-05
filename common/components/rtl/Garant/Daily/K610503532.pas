unit K610503532;
 {* [Requestlink:610503532] }

// ������: "w:\common\components\rtl\Garant\Daily\K610503532.pas"
// ���������: "TestCase"
// ������� ������: "K610503532" MUID: (5633572B02BE)
// ��� ����: "TK610503532"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK610503532 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:610503532] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK610503532
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5633572B02BEimpl_uses*
 //#UC END# *5633572B02BEimpl_uses*
;

function TK610503532.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK610503532.GetFolder

function TK610503532.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5633572B02BE';
end;//TK610503532.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK610503532.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
