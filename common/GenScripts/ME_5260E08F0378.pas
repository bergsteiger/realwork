unit K493324121;
 {* [Requestlink:493324121] }

// ������: "w:\common\components\rtl\Garant\Daily\K493324121.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK493324121 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:493324121] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK493324121
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK493324121.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK493324121.GetFolder

function TK493324121.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5260E08F0378';
end;//TK493324121.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK493324121.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
