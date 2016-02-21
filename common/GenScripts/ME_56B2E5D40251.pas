unit K617064868;
 {* [RequestLink:617064868] }

// ������: "w:\common\components\rtl\Garant\Daily\K617064868.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK617064868 = class(TRTFtoEVDWriterTest)
  {* [RequestLink:617064868] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK617064868
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK617064868.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK617064868.GetFolder

function TK617064868.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56B2E5D40251';
end;//TK617064868.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK617064868.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
