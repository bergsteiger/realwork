unit K294595323Suite;

// Модуль: "w:\common\components\rtl\Garant\Archi_Tests\K294595323Suite.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TK294595323Suite" MUID: (4EA538D60064)

{$Include w:\common\components\rtl\Garant\Archi_Tests\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , CustomFolderTestSuite
;

type
 TK294595323Suite = class(TCustomFolderTestSuite)
 end;//TK294595323Suite
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 //#UC START# *4EA538D60064impl_uses*
 //#UC END# *4EA538D60064impl_uses*
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
