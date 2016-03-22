unit K540615571;
 {* [Requestlink:540414514] }

// ������: "w:\common\components\rtl\Garant\Daily\K540615571.pas"
// ���������: "TestCase"
// ������� ������: "K540615571" MUID: (539181DB00B8)
// ��� ����: "TK540615571"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK540615571 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:540414514] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK540615571
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK540615571.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK540615571.GetFolder

function TK540615571.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '539181DB00B8';
end;//TK540615571.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK540615571.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
