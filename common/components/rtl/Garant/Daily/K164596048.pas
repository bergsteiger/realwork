unit K164596048;
 {* [$164596048] }

// ������: "w:\common\components\rtl\Garant\Daily\K164596048.pas"
// ���������: "TestCase"
// ������� ������: "K164596048" MUID: (4B7C1B6B02F2)
// ��� ����: "TK164596048"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCPlusWriterTest
;

type
 TK164596048 = class(TEVDtoNSRCPlusWriterTest)
  {* [$164596048] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK164596048
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4B7C1B6B02F2impl_uses*
 //#UC END# *4B7C1B6B02F2impl_uses*
;

function TK164596048.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'NSRCTests';
end;//TK164596048.GetFolder

function TK164596048.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4B7C1B6B02F2';
end;//TK164596048.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK164596048.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
