unit K211878214;
 {* [RequestLink:211878214] }

// ������: "w:\common\components\rtl\Garant\Daily\K211878214.pas"
// ���������: "TestCase"
// ������� ������: "K211878214" MUID: (4BEBB7840223)
// ��� ����: "TK211878214"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCOldWriterTest
;

type
 TK211878214 = class(TEVDtoNSRCOldWriterTest)
  {* [RequestLink:211878214] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK211878214
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4BEBB7840223impl_uses*
 //#UC END# *4BEBB7840223impl_uses*
;

function TK211878214.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK211878214.GetFolder

function TK211878214.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4BEBB7840223';
end;//TK211878214.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK211878214.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
