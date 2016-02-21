unit K180060897;
 {* [$180060897] }

// ������: "w:\common\components\rtl\Garant\Daily\K180060897.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCOldWriterTest
;

type
 TK180060897 = class(TEVDtoNSRCOldWriterTest)
  {* [$180060897] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK180060897
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK180060897.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'NSRCTests';
end;//TK180060897.GetFolder

function TK180060897.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4B7D0B5D02BA';
end;//TK180060897.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK180060897.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
