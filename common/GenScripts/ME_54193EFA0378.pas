unit K392696007;
 {* [Requestlink:392696007] }

// ������: "w:\common\components\rtl\Garant\Archi_Tests\K392696007.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Archi_Tests\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , MultyOperationTest
;

type
 TK392696007 = class(TMultyOperationTest)
  {* [Requestlink:392696007] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK392696007
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK392696007.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'DBTests';
end;//TK392696007.GetFolder

function TK392696007.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '54193EFA0378';
end;//TK392696007.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK392696007.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
