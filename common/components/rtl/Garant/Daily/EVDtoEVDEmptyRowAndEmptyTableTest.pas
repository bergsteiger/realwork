unit EVDtoEVDEmptyRowAndEmptyTableTest;

// ������: "w:\common\components\rtl\Garant\Daily\EVDtoEVDEmptyRowAndEmptyTableTest.pas"
// ���������: "TestCase"
// ������� ������: "EVDtoEVDEmptyRowAndEmptyTableTest" MUID: (51C8347903A2)
// ��� ����: "TEVDtoEVDEmptyRowAndEmptyTableTest"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDEmptyRowTest
 , l3Variant
;

type
 TEVDtoEVDEmptyRowAndEmptyTableTest = {abstract} class(TEVDtoEVDEmptyRowTest)
  protected
   procedure SetFilters(var theGenerator: Ik2TagGenerator); override;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TEVDtoEVDEmptyRowAndEmptyTableTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evEmptyTableEliminator
 , TestFrameWork
 //#UC START# *51C8347903A2impl_uses*
 //#UC END# *51C8347903A2impl_uses*
;

procedure TEVDtoEVDEmptyRowAndEmptyTableTest.SetFilters(var theGenerator: Ik2TagGenerator);
//#UC START# *4C07BCBE01F2_51C8347903A2_var*
//#UC END# *4C07BCBE01F2_51C8347903A2_var*
begin
//#UC START# *4C07BCBE01F2_51C8347903A2_impl*
 inherited;
 TevEmptyTableEliminator.SetTo(theGenerator);
//#UC END# *4C07BCBE01F2_51C8347903A2_impl*
end;//TEVDtoEVDEmptyRowAndEmptyTableTest.SetFilters

function TEVDtoEVDEmptyRowAndEmptyTableTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EVD';
end;//TEVDtoEVDEmptyRowAndEmptyTableTest.GetFolder

function TEVDtoEVDEmptyRowAndEmptyTableTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '51C8347903A2';
end;//TEVDtoEVDEmptyRowAndEmptyTableTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
