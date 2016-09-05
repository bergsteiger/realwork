unit K588037593;
 {* [Requestlink:588037593] }

// ������: "w:\common\components\rtl\Garant\Daily\K588037593.pas"
// ���������: "TestCase"
// ������� ������: "K588037593" MUID: (54D8A00A002C)
// ��� ����: "TK588037593"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK588037593 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:588037593] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK588037593
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *54D8A00A002Cimpl_uses*
 //#UC END# *54D8A00A002Cimpl_uses*
;

function TK588037593.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK588037593.GetFolder

function TK588037593.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '54D8A00A002C';
end;//TK588037593.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK588037593.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
