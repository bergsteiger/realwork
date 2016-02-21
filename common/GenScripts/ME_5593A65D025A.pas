unit K601686929;
 {* [Requestlink:601686929] }

// ������: "w:\common\components\rtl\Garant\Daily\K601686929.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK601686929 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:601686929] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK601686929
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK601686929.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK601686929.GetFolder

function TK601686929.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5593A65D025A';
end;//TK601686929.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK601686929.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
