unit K605147298;
 {* [Requestlink:605147298] }

// ������: "w:\common\components\rtl\Garant\Daily\K605147298.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK605147298 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:605147298] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK605147298
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK605147298.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK605147298.GetFolder

function TK605147298.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '55CC6F620202';
end;//TK605147298.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK605147298.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
