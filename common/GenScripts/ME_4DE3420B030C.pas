unit ArchiTestRes;

// Модуль: "w:\archi\source\projects\Archi\ArchiTestRes.pas"
// Стереотип: "SimpleClass"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 , GUIAppTester
;

type
 TArchiTestRes = class(TGUIAppTester)
  public
   class function GetResultsPlaces: TResultsPlaces; override;
 end;//TArchiTestRes
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , GUITestRunner
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , ArchiScriptEngine
 , TestFrameWork
 , toK
 , l3CustomSortIntegerList
 , l3CustomOtherListView
 , l3CustomLongintListView
 , l3LongintListReverseSorter
 , l3EventedRecListView
 , k2TagByHandleView
 {$If NOT Defined(NoScripts)}
 , afwAnswer
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ArchiAutoTestSuite
 {$IfEnd} // NOT Defined(NoScripts)
 , toKT
;

class function TArchiTestRes.GetResultsPlaces: TResultsPlaces;
//#UC START# *52F264840382_4DE3420B030C_var*
//#UC END# *52F264840382_4DE3420B030C_var*
begin
//#UC START# *52F264840382_4DE3420B030C_impl*
 Result := MakeResults([TtoK, TtoKT]);
//#UC END# *52F264840382_4DE3420B030C_impl*
end;//TArchiTestRes.GetResultsPlaces
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
