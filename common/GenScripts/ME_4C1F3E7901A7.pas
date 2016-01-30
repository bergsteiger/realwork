unit K217680744;
 {* [RequestLink:217680744] }

// ������: "w:\common\components\rtl\Garant\Daily\K217680744.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , ScrollTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK217680744 = class(TScrollTest)
  {* [RequestLink:217680744] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK217680744
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK217680744.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK217680744.GetFolder

function TK217680744.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C1F3E7901A7';
end;//TK217680744.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK217680744.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
