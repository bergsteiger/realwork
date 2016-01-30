unit EverestLiteTestSuite;

// Модуль: "w:\archi\source\projects\Everest\Lite\7.0\Express\EverestInsiderTests\EverestLiteTestSuite.pas"
// Стереотип: "SimpleClass"

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , ArchiAutoTestSuite
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TEverestLiteTestSuite = class(TArchiAutoTestSuite)
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
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
