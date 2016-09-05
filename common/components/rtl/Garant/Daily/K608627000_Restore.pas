unit K608627000_Restore;
 {* [RequestLink:608627000] }

// ������: "w:\common\components\rtl\Garant\Daily\K608627000_Restore.pas"
// ���������: "TestCase"
// ������� ������: "K608627000_Restore" MUID: (561E7F570187)
// ��� ����: "TK608627000_Restore"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , UnicodeFormulasToUnicodeConverterTest
;

type
 TK608627000_Restore = class(TUnicodeFormulasToUnicodeConverterTest)
  {* [RequestLink:608627000] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK608627000_Restore
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *561E7F570187impl_uses*
 //#UC END# *561E7F570187impl_uses*
;

function TK608627000_Restore.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK608627000_Restore.GetFolder

function TK608627000_Restore.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '561E7F570187';
end;//TK608627000_Restore.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK608627000_Restore.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
