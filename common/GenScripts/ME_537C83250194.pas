unit K535902713;
 {* [Requestlink:535902713] }

// ������: "w:\common\components\rtl\Garant\Daily\K535902713.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK535902713 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:535902713] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK535902713
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK535902713.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK535902713.GetFolder

function TK535902713.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '537C83250194';
end;//TK535902713.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK535902713.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
