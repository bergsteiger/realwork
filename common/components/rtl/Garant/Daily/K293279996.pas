unit K293279996;
 {* [Requestlink:293279996] }

// ������: "w:\common\components\rtl\Garant\Daily\K293279996.pas"
// ���������: "TestCase"
// ������� ������: "K293279996" MUID: (519CBF11000F)
// ��� ����: "TK293279996"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoRTFWriterTest
;

type
 TK293279996 = class(TEVDtoRTFWriterTest)
  {* [Requestlink:293279996] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK293279996
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *519CBF11000Fimpl_uses*
 //#UC END# *519CBF11000Fimpl_uses*
;

function TK293279996.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.8';
end;//TK293279996.GetFolder

function TK293279996.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '519CBF11000F';
end;//TK293279996.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK293279996.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
