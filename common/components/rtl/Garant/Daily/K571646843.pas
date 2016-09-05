unit K571646843;
 {* [Requestlink:571646843] }

// ������: "w:\common\components\rtl\Garant\Daily\K571646843.pas"
// ���������: "TestCase"
// ������� ������: "K571646843" MUID: (54609BED0186)
// ��� ����: "TK571646843"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK571646843 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:571646843] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK571646843
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *54609BED0186impl_uses*
 //#UC END# *54609BED0186impl_uses*
;

function TK571646843.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK571646843.GetFolder

function TK571646843.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '54609BED0186';
end;//TK571646843.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK571646843.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
