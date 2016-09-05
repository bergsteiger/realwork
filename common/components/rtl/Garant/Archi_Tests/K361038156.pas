unit K361038156;
 {* [RequestLink:361038156] }

// ������: "w:\common\components\rtl\Garant\Archi_Tests\K361038156.pas"
// ���������: "TestCase"
// ������� ������: "K361038156" MUID: (4FA138AB0003)
// ��� ����: "TK361038156"

{$Include w:\common\components\rtl\Garant\Archi_Tests\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ArchiStorageTest
;

type
 TK361038156 = class(TArchiStorageTest)
  {* [RequestLink:361038156] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK361038156
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4FA138AB0003impl_uses*
 //#UC END# *4FA138AB0003impl_uses*
;

function TK361038156.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Storage';
end;//TK361038156.GetFolder

function TK361038156.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4FA138AB0003';
end;//TK361038156.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK361038156.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
