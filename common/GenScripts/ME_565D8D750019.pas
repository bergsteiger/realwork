unit K612741573;
 {* [Requestlink:612741573] }

// ������: "w:\common\components\rtl\Garant\Daily\K612741573.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK612741573 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:612741573] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK612741573
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK612741573.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK612741573.GetFolder

function TK612741573.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '565D8D750019';
end;//TK612741573.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK612741573.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
