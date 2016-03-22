unit K606118757;
 {* [RequestLink:606118757] }

// ������: "w:\common\components\rtl\Garant\Daily\K606118757.pas"
// ���������: "TestCase"
// ������� ������: "K606118757" MUID: (55DB3FDC005C)
// ��� ����: "TK606118757"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK606118757 = class(TRTFtoEVDWriterTest)
  {* [RequestLink:606118757] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK606118757
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK606118757.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK606118757.GetFolder

function TK606118757.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '55DB3FDC005C';
end;//TK606118757.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK606118757.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
