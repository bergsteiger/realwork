unit K619338871;
 {* [Requestlink:619338871] }

// ������: "w:\common\components\rtl\Garant\Daily\K619338871.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK619338871 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:619338871] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK619338871
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK619338871.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK619338871.GetFolder

function TK619338871.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56E010DE0110';
end;//TK619338871.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK619338871.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
