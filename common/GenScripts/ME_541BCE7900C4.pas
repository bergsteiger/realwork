unit K565269737;
 {* [Requestlink:565269737] }

// ������: "w:\common\components\rtl\Garant\Daily\K565269737.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK565269737 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:565269737] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK565269737
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK565269737.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK565269737.GetFolder

function TK565269737.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '541BCE7900C4';
end;//TK565269737.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK565269737.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
