unit K540414514;
 {* [Requestlink:540414514] }

// ������: "w:\common\components\rtl\Garant\Daily\K540414514.pas"
// ���������: "TestCase"
// ������� ������: "K540414514" MUID: (53903EFB0324)
// ��� ����: "TK540414514"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK540414514 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:540414514] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK540414514
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK540414514.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK540414514.GetFolder

function TK540414514.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '53903EFB0324';
end;//TK540414514.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK540414514.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
