unit K91850237;
 {* [$91850237] }

// ������: "w:\common\components\rtl\Garant\Daily\K91850237.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , VerticalCursorMovingTest
;

type
 TK91850237 = class(TVerticalCursorMovingTest)
  {* [$91850237] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK91850237
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK91850237.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK91850237.GetFolder

function TK91850237.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D79E21C03A5';
end;//TK91850237.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK91850237.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
