unit K611646760;
 {* [Requestlink:611646760] }

// ������: "w:\common\components\rtl\Garant\Daily\K611646760.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK611646760 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:611646760] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK611646760
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK611646760.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK611646760.GetFolder

function TK611646760.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '566148A803A9';
end;//TK611646760.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK611646760.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
