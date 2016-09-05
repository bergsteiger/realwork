unit K219122895;
 {* [RequestLink:219122895] }

// ������: "w:\common\components\rtl\Garant\Daily\K219122895.pas"
// ���������: "TestCase"
// ������� ������: "K219122895" MUID: (4C28D831004B)
// ��� ����: "TK219122895"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDWriterTest
 , l3Variant
;

type
 TK219122895 = class(TEVDtoEVDWriterTest)
  {* [RequestLink:219122895] }
  protected
   procedure SetFilters(var theGenerator: Ik2TagGenerator); override;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK219122895
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , ddMisspellCorrect
 , SysUtils
 , l3String
 , TestFrameWork
 //#UC START# *4C28D831004Bimpl_uses*
 //#UC END# *4C28D831004Bimpl_uses*
;

procedure TK219122895.SetFilters(var theGenerator: Ik2TagGenerator);
//#UC START# *4C07BCBE01F2_4C28D831004B_var*
var
 l_F : TddMisspellCorrectFilter;
//#UC END# *4C07BCBE01F2_4C28D831004B_var*
begin
//#UC START# *4C07BCBE01F2_4C28D831004B_impl*
 l_F := TddMisspellCorrectFilter.Create;
 try
  ddAddOnePair(l3PCharLen('����=�����'), l_F);
  ddAddOnePair(l3PCharLen('�������=��������'), l_F);
  ddAddOnePair(l3PCharLen('����������=����������'), l_F);
  ddAddOnePair(l3PCharLen('��������������=�� ������������'), l_F);
  ddAddOnePair(l3PCharLen('#{\d\d\d\d}{�\.}={1} {2}'), l_F);
  l_F.Generator := theGenerator;
  theGenerator := l_F;
 finally
  FreeAndNil(l_F);
 end;//try..finally
//#UC END# *4C07BCBE01F2_4C28D831004B_impl*
end;//TK219122895.SetFilters

function TK219122895.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK219122895.GetFolder

function TK219122895.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C28D831004B';
end;//TK219122895.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK219122895.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
