unit K294595323;
 {* [RequestLink:294595323] }

// ������: "w:\common\components\rtl\Garant\Archi_Tests\K294595323.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , AACFiltersTest
 , TestFrameWork
;

type
 TK294595323 = class(TAACFiltersTest)
  {* [RequestLink:294595323] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
  public
   class function Suite: ITestSuite; override;
 end;//TK294595323
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , K294595323Suite
;

function TK294595323.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Filters';
end;//TK294595323.GetFolder

function TK294595323.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4EA5382F006A';
end;//TK294595323.GetModelElementGUID

class function TK294595323.Suite: ITestSuite;
//#UC START# *4EA553E901DB_4EA5382F006A_var*
//#UC END# *4EA553E901DB_4EA5382F006A_var*
begin
//#UC START# *4EA553E901DB_4EA5382F006A_impl*
 Result := TK294595323Suite.Create(Self);
//#UC END# *4EA553E901DB_4EA5382F006A_impl*
end;//TK294595323.Suite

initialization
 TestFramework.RegisterTest(TK294595323.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
