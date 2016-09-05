unit K590757091;
 {* [Requestlink:590757091] }

// ������: "w:\common\components\rtl\Garant\Daily\K590757091.pas"
// ���������: "TestCase"
// ������� ������: "K590757091" MUID: (5510067D003A)
// ��� ����: "TK590757091"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK590757091 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:590757091] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK590757091
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5510067D003Aimpl_uses*
 //#UC END# *5510067D003Aimpl_uses*
;

function TK590757091.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK590757091.GetFolder

function TK590757091.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '5510067D003A';
end;//TK590757091.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK590757091.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
