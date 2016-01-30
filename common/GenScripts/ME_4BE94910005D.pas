unit K210438308;
 {* [RequestLink:210438308] }

// ������: "w:\common\components\rtl\Garant\Daily\K210438308.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCOldWriterTest
;

type
 TK210438308 = class(TEVDtoNSRCOldWriterTest)
  {* [RequestLink:210438308] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK210438308
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK210438308.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK210438308.GetFolder

function TK210438308.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4BE94910005D';
end;//TK210438308.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK210438308.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
