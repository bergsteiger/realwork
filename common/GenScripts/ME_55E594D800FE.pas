unit K588577774;
 {* [Requestlink:588577774] }

// ������: "w:\common\components\rtl\Garant\Daily\K588577774.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK588577774 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:588577774] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK588577774
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK588577774.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK588577774.GetFolder

function TK588577774.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '55E594D800FE';
end;//TK588577774.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK588577774.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
