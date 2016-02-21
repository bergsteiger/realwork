unit EVDtoEVDBlockNameAdderTest;

// ������: "w:\common\components\rtl\Garant\Daily\EVDtoEVDBlockNameAdderTest.pas"
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
 TEVDtoEVDBlockNameAdderTest = {abstract} class(TEVDtoEVDWriterTest)
  protected
   procedure SetFilters(var theGenerator: Ik2TagGenerator); override;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TEVDtoEVDBlockNameAdderTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evdBlockNameAdder
 , TestFrameWork
;

procedure TEVDtoEVDBlockNameAdderTest.SetFilters(var theGenerator: Ik2TagGenerator);
//#UC START# *4C07BCBE01F2_4D909F2701A6_var*
//#UC END# *4C07BCBE01F2_4D909F2701A6_var*
begin
//#UC START# *4C07BCBE01F2_4D909F2701A6_impl*
 TevdBlockNameAdder.SetTo(theGenerator);
//#UC END# *4C07BCBE01F2_4D909F2701A6_impl*
end;//TEVDtoEVDBlockNameAdderTest.SetFilters

function TEVDtoEVDBlockNameAdderTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EVD';
end;//TEVDtoEVDBlockNameAdderTest.GetFolder

function TEVDtoEVDBlockNameAdderTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D909F2701A6';
end;//TEVDtoEVDBlockNameAdderTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
