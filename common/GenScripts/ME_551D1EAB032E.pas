unit K595967367;
 {* [RequestLink:595967367] }

// ������: "w:\common\components\rtl\Garant\Daily\K595967367.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK595967367 = class(TRTFtoEVDWriterTest)
  {* [RequestLink:595967367] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK595967367
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK595967367.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK595967367.GetFolder

function TK595967367.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '551D1EAB032E';
end;//TK595967367.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK595967367.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
