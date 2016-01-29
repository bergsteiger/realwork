unit ArchiTestRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/archi/source/projects/Archi/ArchiTestRes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$Test::Archi$Test::TArchiTestRes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Archi\arDefine.inc}

interface

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  GUIAppTester
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}
type
 TArchiTestRes = class(TGUIAppTester)
 public
 // realized methods
   class function GetResultsPlaces: TResultsPlaces; override;
 end;//TArchiTestRes
{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  GUITestRunner
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  KTestRunner
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  ArchiScriptEngine,
  TestFrameWork,
  toK,
  l3CustomSortIntegerList,
  l3CustomOtherListView,
  l3CustomLongintListView,
  l3LongintListReverseSorter,
  l3EventedRecListView,
  k2TagByHandleView
  {$If not defined(NoScripts)}
  ,
  afwAnswer
  {$IfEnd} //not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  ArchiAutoTestSuite
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  ,
  toKT
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}

// start class TArchiTestRes

class function TArchiTestRes.GetResultsPlaces: TResultsPlaces;
//#UC START# *52F264840382_4DE3420B030C_var*
//#UC END# *52F264840382_4DE3420B030C_var*
begin
//#UC START# *52F264840382_4DE3420B030C_impl*
 Result := MakeResults([TtoK, TtoKT]);
//#UC END# *52F264840382_4DE3420B030C_impl*
end;//TArchiTestRes.GetResultsPlaces

{$IfEnd} //InsiderTest AND nsTest

end.