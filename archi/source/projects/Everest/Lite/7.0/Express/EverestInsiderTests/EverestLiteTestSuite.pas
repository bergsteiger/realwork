unit EverestLiteTestSuite;

// Модуль: "w:\archi\source\projects\Everest\Lite\7.0\Express\EverestInsiderTests\EverestLiteTestSuite.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TEverestLiteTestSuite" MUID: (512DB031030F)

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , ArchiAutoTestSuite
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TEverestLiteTestSuite = class({$If NOT Defined(NoScripts)}
 TArchiAutoTestSuite
 {$IfEnd} // NOT Defined(NoScripts)
 )
 end;//TEverestLiteTestSuite
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , EverestLiteKeyWords
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwEditorKeyWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwArchiEverestWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *512DB031030Fimpl_uses*
 //#UC END# *512DB031030Fimpl_uses*
;

{$If NOT Defined(NoScripts)}
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
