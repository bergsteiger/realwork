unit K211878862;
 {* [$211878862] }

// ������: "w:\common\components\rtl\Garant\Daily\K211878862.pas"
// ���������: "TestCase"
// ������� ������: "K211878862" MUID: (4BEBDEBA0161)
// ��� ����: "TK211878862"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCOldWriterTest
;

type
 TK211878862 = class(TEVDtoNSRCOldWriterTest)
  {* [$211878862] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK211878862
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4BEBDEBA0161impl_uses*
 //#UC END# *4BEBDEBA0161impl_uses*
;

function TK211878862.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'NSRCTests';
end;//TK211878862.GetFolder

function TK211878862.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4BEBDEBA0161';
end;//TK211878862.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK211878862.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
