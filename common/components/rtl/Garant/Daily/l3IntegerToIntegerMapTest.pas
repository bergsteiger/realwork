unit l3IntegerToIntegerMapTest;

// ������: "w:\common\components\rtl\Garant\Daily\l3IntegerToIntegerMapTest.pas"
// ���������: "TestCase"
// ������� ������: "Tl3IntegerToIntegerMapTest" MUID: (56090AF902FF)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 Tl3IntegerToIntegerMapTest = class(TBaseTest)
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
  published
   procedure DoIt;
 end;//Tl3IntegerToIntegerMapTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3IntegerToIntegerMap
 , TestFrameWork
 , SysUtils
;

{$If NOT Defined(NotTunedDUnit)}
procedure Tl3IntegerToIntegerMapTest.DoIt;
//#UC START# *56090B0D03D1_56090AF902FF_var*
var
 l_M : Tl3IntegerToIntegerMap;
//#UC END# *56090B0D03D1_56090AF902FF_var*
begin
//#UC START# *56090B0D03D1_56090AF902FF_impl*
 l_M := Tl3IntegerToIntegerMap.Create;
 try
  l_M.Add(1, 100);
  l_M.Add(2, 200);
  l_M.Add(3, 300);
  CheckTrue(l_M.Has(1));
  CheckTrue(l_M.Has(2));
  CheckTrue(l_M.Has(3));
  CheckFalse(l_M.Has(4));

  CheckTrue(l_M.IndexByKey(1) = 0);
  CheckTrue(l_M.IndexByKey(2) = 1);
  CheckTrue(l_M.IndexByKey(3) = 2);
  CheckTrue(l_M.IndexByKey(4) = -1);

  CheckTrue(l_M.ValueByKey(1) = 100);
  CheckTrue(l_M.ValueByKey(2) = 200);
  CheckTrue(l_M.ValueByKey(3) = 300);

  CheckTrue(l_M.ValueSlotByKey(1)^ = 100);
  CheckTrue(l_M.ValueSlotByKey(2)^ = 200);
  CheckTrue(l_M.ValueSlotByKey(3)^ = 300);
 finally
  FreeAndNil(l_M);
 end;//try..finally
//#UC END# *56090B0D03D1_56090AF902FF_impl*
end;//Tl3IntegerToIntegerMapTest.DoIt

function Tl3IntegerToIntegerMapTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//Tl3IntegerToIntegerMapTest.GetFolder

function Tl3IntegerToIntegerMapTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '56090AF902FF';
end;//Tl3IntegerToIntegerMapTest.GetModelElementGUID

initialization
 TestFramework.RegisterTest(Tl3IntegerToIntegerMapTest.Suite);
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
