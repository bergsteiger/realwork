unit K228692043;
 {* [RequestLink:228692043] }

// ������: "w:\common\components\rtl\Garant\Daily\K228692043.pas"
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
 TK228692043 = class(TEVDtoEVDWriterTest)
  {* [RequestLink:228692043] }
  protected
   procedure SetFilters(var theGenerator: Ik2TagGenerator); override;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK228692043
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evUnblockEmptyParaFilter
 , TestFrameWork
;

procedure TK228692043.SetFilters(var theGenerator: Ik2TagGenerator);
//#UC START# *4C07BCBE01F2_4C56D8F602AF_var*
//#UC END# *4C07BCBE01F2_4C56D8F602AF_var*
begin
//#UC START# *4C07BCBE01F2_4C56D8F602AF_impl*
 TevUnblockEmptyParaFilter.SetTo(theGenerator);
//#UC END# *4C07BCBE01F2_4C56D8F602AF_impl*
end;//TK228692043.SetFilters

function TK228692043.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK228692043.GetFolder

function TK228692043.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C56D8F602AF';
end;//TK228692043.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK228692043.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
