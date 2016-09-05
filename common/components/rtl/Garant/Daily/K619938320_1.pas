unit K619938320_1;
 {* [RequestLink:619938320] }

// ������: "w:\common\components\rtl\Garant\Daily\K619938320_1.pas"
// ���������: "TestCase"
// ������� ������: "K619938320_1" MUID: (56E7EECA00B7)
// ��� ����: "TK619938320_1"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK619938320_1 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:619938320] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK619938320_1
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *56E7EECA00B7impl_uses*
 //#UC END# *56E7EECA00B7impl_uses*
;

function TK619938320_1.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'CrossSegments';
end;//TK619938320_1.GetFolder

function TK619938320_1.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56E7EECA00B7';
end;//TK619938320_1.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK619938320_1.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
