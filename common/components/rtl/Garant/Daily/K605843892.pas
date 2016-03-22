unit K605843892;
 {* [Requestlink:605843892] }

// ������: "w:\common\components\rtl\Garant\Daily\K605843892.pas"
// ���������: "TestCase"
// ������� ������: "K605843892" MUID: (55D726B80326)
// ��� ����: "TK605843892"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK605843892 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:605843892] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK605843892
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK605843892.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK605843892.GetFolder

function TK605843892.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '55D726B80326';
end;//TK605843892.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK605843892.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
