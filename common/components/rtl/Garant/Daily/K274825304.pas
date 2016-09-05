unit K274825304;
 {* [RequestLink:274825304] }

// ������: "w:\common\components\rtl\Garant\Daily\K274825304.pas"
// ���������: "TestCase"
// ������� ������: "K274825304" MUID: (4E84927503A3)
// ��� ����: "TK274825304"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoRTFWriterTest
;

type
 TK274825304 = class(TEVDtoRTFWriterTest)
  {* [RequestLink:274825304] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK274825304
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4E84927503A3impl_uses*
 //#UC END# *4E84927503A3impl_uses*
;

function TK274825304.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7 Lulin';
end;//TK274825304.GetFolder

function TK274825304.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4E84927503A3';
end;//TK274825304.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK274825304.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
