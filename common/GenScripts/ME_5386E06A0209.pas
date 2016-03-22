unit K538546220;
 {* [Requestlink:538546220] }

// ������: "w:\common\components\rtl\Garant\Daily\K538546220.pas"
// ���������: "TestCase"
// ������� ������: "K538546220" MUID: (5386E06A0209)
// ��� ����: "TK538546220"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK538546220 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:538546220] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK538546220
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK538546220.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK538546220.GetFolder

function TK538546220.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5386E06A0209';
end;//TK538546220.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK538546220.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
