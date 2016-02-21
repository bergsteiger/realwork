unit K235053014;
 {* [RequestLink:235053014]. }

// ������: "w:\common\components\rtl\Garant\Daily\K235053014.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK235053014 = class(TRTFtoEVDWriterTest)
  {* [RequestLink:235053014]. }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK235053014
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK235053014.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK235053014.GetFolder

function TK235053014.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C972F6D0219';
end;//TK235053014.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235053014.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
