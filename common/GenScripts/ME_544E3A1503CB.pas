unit K568147841;
 {* [Requestlink:568147841] }

// ������: "w:\common\components\rtl\Garant\Daily\K568147841.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK568147841 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:568147841] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK568147841
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK568147841.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK568147841.GetFolder

function TK568147841.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '544E3A1503CB';
end;//TK568147841.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK568147841.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
