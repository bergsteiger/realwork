unit K327821495;
 {* [RequestLink:327821495] }

// ������: "w:\common\components\rtl\Garant\Archi_Tests\K327821495.pas"
// ���������: "TestCase"
// ������� ������: "K327821495" MUID: (4F1934B0037D)
// ��� ����: "TK327821495"

{$Include w:\common\components\rtl\Garant\Archi_Tests\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , StgIndexTest
;

type
 TK327821495 = class(TStgIndexTest)
  {* [RequestLink:327821495] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK327821495
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4F1934B0037Dimpl_uses*
 //#UC END# *4F1934B0037Dimpl_uses*
;

function TK327821495.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'DBTests';
end;//TK327821495.GetFolder

function TK327821495.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4F1934B0037D';
end;//TK327821495.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK327821495.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
