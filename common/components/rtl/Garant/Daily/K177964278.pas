unit K177964278;
 {* [$177964278] }

// ������: "w:\common\components\rtl\Garant\Daily\K177964278.pas"
// ���������: "TestCase"
// ������� ������: "K177964278" MUID: (4B7C2470024D)
// ��� ����: "TK177964278"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCOldWriterTest
;

type
 TK177964278 = class(TEVDtoNSRCOldWriterTest)
  {* [$177964278] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK177964278
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4B7C2470024Dimpl_uses*
 //#UC END# *4B7C2470024Dimpl_uses*
;

function TK177964278.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'NSRCTests';
end;//TK177964278.GetFolder

function TK177964278.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4B7C2470024D';
end;//TK177964278.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK177964278.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
