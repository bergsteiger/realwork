unit K611189558;
 {* [RequestLink:611189558] }

// ������: "w:\common\components\rtl\Garant\Daily\K611189558.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK611189558 = class(TRTFtoEVDWriterTest)
  {* [RequestLink:611189558] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK611189558
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK611189558.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK611189558.GetFolder

function TK611189558.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '565838660385';
end;//TK611189558.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK611189558.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
