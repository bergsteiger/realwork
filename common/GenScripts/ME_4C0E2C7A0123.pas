unit K203130960;
 {* [RequestLink:203130960]. }

// ������: "w:\common\components\rtl\Garant\Daily\K203130960.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , ScrollBackTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK203130960 = class(TScrollBackTest)
  {* [RequestLink:203130960]. }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK203130960
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK203130960.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK203130960.GetFolder

function TK203130960.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C0E2C7A0123';
end;//TK203130960.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK203130960.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
