unit K255966779;
 {* [RequestLink:255966779] }

// ������: "w:\common\components\rtl\Garant\Daily\K255966779.pas"
// ���������: "TestCase"
// ������� ������: "K255966779" MUID: (4D909FCA01A2)
// ��� ����: "TK255966779"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDBlockNameAdderTest
;

type
 TK255966779 = class(TEVDtoEVDBlockNameAdderTest)
  {* [RequestLink:255966779] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK255966779
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK255966779.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7 Lulin';
end;//TK255966779.GetFolder

function TK255966779.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D909FCA01A2';
end;//TK255966779.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK255966779.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
