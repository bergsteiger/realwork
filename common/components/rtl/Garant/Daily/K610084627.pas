unit K610084627;
 {* [Requestlink:610084627] }

// ������: "w:\common\components\rtl\Garant\Daily\K610084627.pas"
// ���������: "TestCase"
// ������� ������: "K610084627" MUID: (5629C5B002A0)
// ��� ����: "TK610084627"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK610084627 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:610084627] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK610084627
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5629C5B002A0impl_uses*
 //#UC END# *5629C5B002A0impl_uses*
;

function TK610084627.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK610084627.GetFolder

function TK610084627.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5629C5B002A0';
end;//TK610084627.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK610084627.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
