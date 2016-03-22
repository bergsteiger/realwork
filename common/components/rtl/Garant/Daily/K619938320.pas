unit K619938320;
 {* [RequestLink:619938320] }

// ������: "w:\common\components\rtl\Garant\Daily\K619938320.pas"
// ���������: "TestCase"
// ������� ������: "K619938320" MUID: (56E7EEBF0217)
// ��� ����: "TK619938320"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK619938320 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:619938320] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK619938320
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK619938320.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'CrossSegments';
end;//TK619938320.GetFolder

function TK619938320.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56E7EEBF0217';
end;//TK619938320.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK619938320.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
