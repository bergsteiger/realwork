unit K259890927;
 {* [RequestLink:259890927] }

// ������: "w:\common\components\rtl\Garant\Daily\K259890927.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDWriterTest
 , l3Variant
;

type
 TK259890927 = class(TEVDtoEVDWriterTest)
  {* [RequestLink:259890927] }
  protected
   procedure SetFilters(var theGenerator: Ik2TagGenerator); override;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK259890927
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evdLeafParaFilter
 , TestFrameWork
;

procedure TK259890927.SetFilters(var theGenerator: Ik2TagGenerator);
//#UC START# *4C07BCBE01F2_4E96F20A02AD_var*
//#UC END# *4C07BCBE01F2_4E96F20A02AD_var*
begin
//#UC START# *4C07BCBE01F2_4E96F20A02AD_impl*
 TevdLeafParaFilter.SetTo(theGenerator);
//#UC END# *4C07BCBE01F2_4E96F20A02AD_impl*
end;//TK259890927.SetFilters

function TK259890927.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7 Lulin';
end;//TK259890927.GetFolder

function TK259890927.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4E96F20A02AD';
end;//TK259890927.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK259890927.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
