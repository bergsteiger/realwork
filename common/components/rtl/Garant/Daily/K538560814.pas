unit K538560814;
 {* [Requestlink:538560814] }

// ������: "w:\common\components\rtl\Garant\Daily\K538560814.pas"
// ���������: "TestCase"
// ������� ������: "K538560814" MUID: (53881E4003E3)
// ��� ����: "TK538560814"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK538560814 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:538560814] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK538560814
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *53881E4003E3impl_uses*
 //#UC END# *53881E4003E3impl_uses*
;

function TK538560814.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK538560814.GetFolder

function TK538560814.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '53881E4003E3';
end;//TK538560814.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK538560814.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
