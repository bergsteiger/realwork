unit K208700993;
 {* [RequestLink:208700993] }

// ������: "w:\common\components\rtl\Garant\Daily\K208700993.pas"
// ���������: "TestCase"
// ������� ������: "K208700993" MUID: (4BDFE7D90383)
// ��� ����: "TK208700993"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCOldWriterTest
;

type
 TK208700993 = class(TEVDtoNSRCOldWriterTest)
  {* [RequestLink:208700993] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK208700993
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK208700993.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK208700993.GetFolder

function TK208700993.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4BDFE7D90383';
end;//TK208700993.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK208700993.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
