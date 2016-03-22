unit K537974930;
 {* [Requestlink:537974930] }

// ������: "w:\common\components\rtl\Garant\Daily\K537974930.pas"
// ���������: "TestCase"
// ������� ������: "K537974930" MUID: (538582D300CA)
// ��� ����: "TK537974930"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK537974930 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:537974930] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK537974930
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK537974930.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK537974930.GetFolder

function TK537974930.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '538582D300CA';
end;//TK537974930.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK537974930.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
