unit K424386600;
 {* [Requestlink:424386600] }

// ������: "w:\common\components\rtl\Garant\Daily\K424386600.pas"
// ���������: "TestCase"
// ������� ������: "K424386600" MUID: (50F7F16800DD)
// ��� ����: "TK424386600"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoRTFWriterTest
;

type
 TK424386600 = class(TEVDtoRTFWriterTest)
  {* [Requestlink:424386600] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK424386600
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *50F7F16800DDimpl_uses*
 //#UC END# *50F7F16800DDimpl_uses*
;

function TK424386600.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.8';
end;//TK424386600.GetFolder

function TK424386600.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '50F7F16800DD';
end;//TK424386600.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK424386600.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
