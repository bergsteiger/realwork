unit K622840683;
 {* [Requestlink:622840683] }

// ������: "w:\common\components\rtl\Garant\Daily\K622840683.pas"
// ���������: "TestCase"
// ������� ������: "K622840683" MUID: (57342D1B03C8)
// ��� ����: "TK622840683"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK622840683 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:622840683] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK622840683
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *57342D1B03C8impl_uses*
 //#UC END# *57342D1B03C8impl_uses*
;

function TK622840683.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '8.0';
end;//TK622840683.GetFolder

function TK622840683.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '57342D1B03C8';
end;//TK622840683.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK622840683.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
