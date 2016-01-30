unit K177964498;
 {* [$177964498] }

// ������: "w:\common\components\rtl\Garant\Daily\K177964498.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCPlusWriterTest
;

type
 TK177964498 = class(TEVDtoNSRCPlusWriterTest)
  {* [$177964498] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK177964498
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK177964498.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'NSRCTests';
end;//TK177964498.GetFolder

function TK177964498.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4B7C2B740293';
end;//TK177964498.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK177964498.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
