unit EVDtoEVDSectionRepairTest;
 {* ���� ��� [IconForPage:175539595] [$175539595] }

// ������: "w:\common\components\rtl\Garant\Daily\EVDtoEVDSectionRepairTest.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDWriterTest
 , l3Variant
;

type
 TEVDtoEVDSectionRepairTest = {abstract} class(TEVDtoEVDWriterTest)
  {* ���� ��� [IconForPage:175539595] [$175539595] }
  protected
   procedure SetFilters(var theGenerator: Ik2TagGenerator); override;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TEVDtoEVDSectionRepairTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , ddSectionRepair
 , ddSectionWithSub2Para
 , TestFrameWork
;

procedure TEVDtoEVDSectionRepairTest.SetFilters(var theGenerator: Ik2TagGenerator);
//#UC START# *4C07BCBE01F2_4C10D6820047_var*
//#UC END# *4C07BCBE01F2_4C10D6820047_var*
begin
//#UC START# *4C07BCBE01F2_4C10D6820047_impl*
 TddSectionRepairFilter.SetTo(theGenerator);
 TddSectionWithSub2ParaFilter.SetTo(theGenerator);
//#UC END# *4C07BCBE01F2_4C10D6820047_impl*
end;//TEVDtoEVDSectionRepairTest.SetFilters

function TEVDtoEVDSectionRepairTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EVD';
end;//TEVDtoEVDSectionRepairTest.GetFolder

function TEVDtoEVDSectionRepairTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C10D6820047';
end;//TEVDtoEVDSectionRepairTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
