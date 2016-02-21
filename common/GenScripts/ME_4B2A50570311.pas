unit TestGlobals;

// Модуль: "w:\common\components\rtl\Garant\Daily\TestGlobals.pas"
// Стереотип: "UtilityPack"

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
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
