unit K611827116;
 {* [Requestlink:611827116] }

// ������: "w:\common\components\rtl\Garant\Daily\K611827116.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK611827116 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:611827116] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK611827116
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK611827116.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK611827116.GetFolder

function TK611827116.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '565421DE0353';
end;//TK611827116.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK611827116.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
