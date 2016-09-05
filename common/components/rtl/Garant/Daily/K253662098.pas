unit K253662098;
 {* [$253662098] }

// ������: "w:\common\components\rtl\Garant\Daily\K253662098.pas"
// ���������: "TestCase"
// ������� ������: "K253662098" MUID: (4D70937501E4)
// ��� ����: "TK253662098"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCPlusWriterTest
;

type
 TK253662098 = class(TEVDtoNSRCPlusWriterTest)
  {* [$253662098] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK253662098
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4D70937501E4impl_uses*
 //#UC END# *4D70937501E4impl_uses*
;

function TK253662098.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'NSRC 7.7';
end;//TK253662098.GetFolder

function TK253662098.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D70937501E4';
end;//TK253662098.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK253662098.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
