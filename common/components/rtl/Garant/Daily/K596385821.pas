unit K596385821;
 {* [Requestlink:596385821] }

// ������: "w:\common\components\rtl\Garant\Daily\K596385821.pas"
// ���������: "TestCase"
// ������� ������: "K596385821" MUID: (552D157001DD)
// ��� ����: "TK596385821"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK596385821 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:596385821] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK596385821
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *552D157001DDimpl_uses*
 //#UC END# *552D157001DDimpl_uses*
;

function TK596385821.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//TK596385821.GetFolder

function TK596385821.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '552D157001DD';
end;//TK596385821.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK596385821.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
