unit K569230238;
 {* [RequestLink:569230238] }

// ������: "w:\common\components\rtl\Garant\Daily\K569230238.pas"
// ���������: "TestCase"
// ������� ������: "K569230238" MUID: (5491B956037A)
// ��� ����: "TK569230238"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK569230238 = class(TRTFtoEVDWriterTest)
  {* [RequestLink:569230238] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK569230238
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5491B956037Aimpl_uses*
 //#UC END# *5491B956037Aimpl_uses*
;

function TK569230238.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK569230238.GetFolder

function TK569230238.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5491B956037A';
end;//TK569230238.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK569230238.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
