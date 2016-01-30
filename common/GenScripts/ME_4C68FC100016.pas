unit K232099823;
 {* [RequestLink:232099823] }

// ������: "w:\common\components\rtl\Garant\Daily\K232099823.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCPlusWriterTest
;

type
 TK232099823 = class(TEVDtoNSRCPlusWriterTest)
  {* [RequestLink:232099823] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK232099823
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK232099823.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK232099823.GetFolder

function TK232099823.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C68FC100016';
end;//TK232099823.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK232099823.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
