unit EverestLiteTestRes;

// Модуль: "w:\archi\source\projects\Everest\Lite\7.0\Express\EverestLiteTestRes.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TEverestLiteTestRes" MUID: (512AF4F300FC)

{$Include w:\archi\source\projects\Everest\Lite\7.0\Express\EverestLite.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 , GUIAppTester
;

type
 TEverestLiteTestRes = class(TGUIAppTester)
  public
   class function GetResultsPlaces: TResultsPlaces; override;
 end;//TEverestLiteTestRes
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , toK
 , TestFrameWork
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , afwAnswer
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 {$If NOT Defined(NoScripts)}
 , tfwScriptEngineEX
 {$IfEnd} // NOT Defined(NoScripts)
 , EverestLiteTestSuite
 , toKT
 //#UC START# *512AF4F300FCimpl_uses*
 //#UC END# *512AF4F300FCimpl_uses*
;

class function TEverestLiteTestRes.GetResultsPlaces: TResultsPlaces;
//#UC START# *52F264840382_512AF4F300FC_var*
//#UC END# *52F264840382_512AF4F300FC_var*
begin
//#UC START# *52F264840382_512AF4F300FC_impl*
 Result := MakeResults([TtoK, TtoKT]);
//#UC END# *52F264840382_512AF4F300FC_impl*
end;//TEverestLiteTestRes.GetResultsPlaces
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
