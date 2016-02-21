unit K371654285;
 {* [Requestlink:371654285] }

// ������: "w:\common\components\rtl\Garant\Daily\K371654285.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK371654285 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:371654285] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK371654285
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK371654285.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.8';
end;//TK371654285.GetFolder

function TK371654285.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '51ADD32A0065';
end;//TK371654285.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK371654285.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
