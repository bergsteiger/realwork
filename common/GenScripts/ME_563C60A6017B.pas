unit K610746048;
 {* [Requestlink:610746048] }

// ������: "w:\common\components\rtl\Garant\Daily\K610746048.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK610746048 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:610746048] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK610746048
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK610746048.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK610746048.GetFolder

function TK610746048.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '563C60A6017B';
end;//TK610746048.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK610746048.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
