unit K608626880;
 {* [Requestlink:608626880] }

// ������: "w:\common\components\rtl\Garant\Daily\K608626880.pas"
// ���������: "TestCase"
// ������� ������: "K608626880" MUID: (561CDC9B03CA)
// ��� ����: "TK608626880"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK608626880 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:608626880] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK608626880
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *561CDC9B03CAimpl_uses*
 //#UC END# *561CDC9B03CAimpl_uses*
;

function TK608626880.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.12';
end;//TK608626880.GetFolder

function TK608626880.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '561CDC9B03CA';
end;//TK608626880.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK608626880.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
