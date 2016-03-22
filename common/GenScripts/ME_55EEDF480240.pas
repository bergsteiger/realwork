unit K606129412;
 {* [Requestlink:606129412] }

// ������: "w:\common\components\rtl\Garant\Daily\K606129412.pas"
// ���������: "TestCase"
// ������� ������: "K606129412" MUID: (55EEDF480240)
// ��� ����: "TK606129412"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK606129412 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:606129412] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK606129412
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK606129412.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK606129412.GetFolder

function TK606129412.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '55EEDF480240';
end;//TK606129412.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK606129412.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
