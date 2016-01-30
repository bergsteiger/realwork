unit K606634250;
 {* [Requestlink:606634250] }

// ������: "w:\common\components\rtl\Garant\Daily\K606634250.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK606634250 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:606634250] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK606634250
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK606634250.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK606634250.GetFolder

function TK606634250.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '55EE94A8022C';
end;//TK606634250.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK606634250.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
