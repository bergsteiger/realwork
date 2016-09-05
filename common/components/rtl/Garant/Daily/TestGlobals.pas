unit TestGlobals;

// Модуль: "w:\common\components\rtl\Garant\Daily\TestGlobals.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "TestGlobals" MUID: (4B2A50570311)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;

const
 cNSRCFileIn = 'document.nsr';
 cBadTextUnicode = 'badtext.uni';
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 //#UC START# *4B2A50570311impl_uses*
 //#UC END# *4B2A50570311impl_uses*
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
