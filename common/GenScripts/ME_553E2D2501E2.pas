unit K598118986;
 {* [Requestlink:598118986] }

// ������: "w:\common\components\rtl\Garant\Daily\K598118986.pas"
// ���������: "TestCase"
// ������� ������: "K598118986" MUID: (553E2D2501E2)
// ��� ����: "TK598118986"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK598118986 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:598118986] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK598118986
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK598118986.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK598118986.GetFolder

function TK598118986.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '553E2D2501E2';
end;//TK598118986.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK598118986.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
