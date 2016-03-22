unit l3StringToStringMapTest;

// ћодуль: "w:\common\components\rtl\Garant\Daily\l3StringToStringMapTest.pas"
// —тереотип: "TestCase"
// Ёлемент модели: "Tl3StringToStringMapTest" MUID: (569F67CE017B)

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
 Tl3StringToStringMapTest = class(TBaseTest)
  protected
   function GetFolder: AnsiString; override;
    {* ѕапка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* »дентификатор элемента модели, который описывает тест }
  published
   procedure DoIt;
 end;//Tl3StringToStringMapTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3StringToStringMap
 , TestFrameWork
 , SysUtils
 , l3Base
 , l3Interfaces
 , l3String
;

{$If NOT Defined(NotTunedDUnit)}
procedure Tl3StringToStringMapTest.DoIt;
//#UC START# *569F68230027_569F67CE017B_var*
var
 l_M: Tl3StringToStringMap;
//#UC END# *569F68230027_569F67CE017B_var*
begin
//#UC START# *569F68230027_569F67CE017B_impl*
 l_M := Tl3StringToStringMap.Create;
 try
  l_M.Add(l3CStr('курочка'), l3CStr('–€ба'));
  l_M.Add(l3CStr('снесла'), l3CStr('€ичко'));
  l_M.Add(l3CStr('дедушке'), l3CStr('начисто снесла'));

  CheckTrue(l_M.Has(l3CStr('курочка')));
  CheckTrue(l_M.Has(l3CStr('снесла')));
  CheckTrue(l_M.Has(l3CStr('дедушке')));
  CheckFalse(l_M.Has(l3CStr('такого тут нет')));

  CheckTrue(l_M.IndexByKey(l3CStr('курочка')) = 1);
  CheckTrue(l_M.IndexByKey(l3CStr('снесла'))  = 2);
  CheckTrue(l_M.IndexByKey(l3CStr('дедушке')) = 0);
  CheckTrue(l_M.IndexByKey(l3CStr('такого тут нет')) = -1);

  CheckTrue(l3Same(l_M.ValueByKey(l3CStr('курочка')), l3CStr('–€ба')));
  CheckTrue(l3Same(l_M.ValueByKey(l3CStr('снесла')), l3CStr('€ичко')));
  CheckTrue(l3Same(l_M.ValueByKey(l3CStr('дедушке')), l3CStr('начисто снесла')));
 finally
  FreeAndNil(l_M);
 end;
//#UC END# *569F68230027_569F67CE017B_impl*
end;//Tl3StringToStringMapTest.DoIt

function Tl3StringToStringMapTest.GetFolder: AnsiString;
 {* ѕапка в которую входит тест }
begin
 Result := '7.11';
end;//Tl3StringToStringMapTest.GetFolder

function Tl3StringToStringMapTest.GetModelElementGUID: AnsiString;
 {* »дентификатор элемента модели, который описывает тест }
begin
 Result := '569F67CE017B';
end;//Tl3StringToStringMapTest.GetModelElementGUID

initialization
 TestFramework.RegisterTest(Tl3StringToStringMapTest.Suite);
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
