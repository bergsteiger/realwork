unit K613740482;
 {* [Requestlink:613740482] }

// ������: "w:\common\components\rtl\Garant\Daily\K613740482.pas"
// ���������: "TestCase"
// ������� ������: "K613740482" MUID: (5677DA9902D8)
// ��� ����: "TK613740482"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK613740482 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:613740482] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK613740482
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5677DA9902D8impl_uses*
 //#UC END# *5677DA9902D8impl_uses*
;

function TK613740482.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK613740482.GetFolder

function TK613740482.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5677DA9902D8';
end;//TK613740482.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK613740482.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
