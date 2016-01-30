unit K537232046;
 {* [Requestlink:537232046] }

// ������: "w:\common\components\rtl\Garant\Daily\K537232046.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK537232046 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:537232046] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK537232046
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK537232046.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK537232046.GetFolder

function TK537232046.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '53917A1A02AE';
end;//TK537232046.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK537232046.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
