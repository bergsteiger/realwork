unit K431386712;
 {* [Requestlink:431378358] }

// ������: "w:\common\components\rtl\Garant\Daily\K431386712.pas"
// ���������: "TestCase"
// ������� ������: "K431386712" MUID: (514850D00368)
// ��� ����: "TK431386712"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCPlusWriterTest
;

type
 TK431386712 = class(TEVDtoNSRCPlusWriterTest)
  {* [Requestlink:431378358] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK431386712
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK431386712.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.8';
end;//TK431386712.GetFolder

function TK431386712.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '514850D00368';
end;//TK431386712.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK431386712.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
