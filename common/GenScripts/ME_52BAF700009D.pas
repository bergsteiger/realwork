unit K509706011_1;
 {* [RequestLink:509706011] }

// ������: "w:\common\components\rtl\Garant\Daily\K509706011_1.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoRTFWriterTest
;

type
 TK509706011_1 = class(TEVDtoRTFWriterTest)
  {* [RequestLink:509706011] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK509706011_1
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK509706011_1.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.10';
end;//TK509706011_1.GetFolder

function TK509706011_1.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '52BAF700009D';
end;//TK509706011_1.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK509706011_1.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
