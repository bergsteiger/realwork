unit K509706011_2;
 {* [RequestLink:509706011] }

// ������: "w:\common\components\rtl\Garant\Daily\K509706011_2.pas"
// ���������: "TestCase"
// ������� ������: "K509706011_2" MUID: (52BC21C102C5)
// ��� ����: "TK509706011_2"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDWriterTest
;

type
 TK509706011_2 = class(TEVDtoEVDWriterTest)
  {* [RequestLink:509706011] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK509706011_2
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *52BC21C102C5impl_uses*
 //#UC END# *52BC21C102C5impl_uses*
;

function TK509706011_2.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK509706011_2.GetFolder

function TK509706011_2.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '52BC21C102C5';
end;//TK509706011_2.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK509706011_2.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
