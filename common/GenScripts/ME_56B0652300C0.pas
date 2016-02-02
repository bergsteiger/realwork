unit K616411367;
 {* [Requestlink:616411367] }

// ������: "w:\common\components\rtl\Garant\Daily\K616411367.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK616411367 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:616411367] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK616411367
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK616411367.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK616411367.GetFolder

function TK616411367.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56B0652300C0';
end;//TK616411367.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK616411367.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
