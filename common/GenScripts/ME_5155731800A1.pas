unit K444993775;
 {* [Requestlink:444993775] }

// ������: "w:\common\components\rtl\Garant\Daily\K444993775.pas"
// ���������: "TestCase"
// ������� ������: "K444993775" MUID: (5155731800A1)
// ��� ����: "TK444993775"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK444993775 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:444993775] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK444993775
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK444993775.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.8';
end;//TK444993775.GetFolder

function TK444993775.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5155731800A1';
end;//TK444993775.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK444993775.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
