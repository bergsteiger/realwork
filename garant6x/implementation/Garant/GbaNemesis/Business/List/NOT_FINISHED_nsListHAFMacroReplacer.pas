unit NOT_FINISHED_nsListHAFMacroReplacer;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\List\NOT_FINISHED_nsListHAFMacroReplacer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsListHAFMacroReplacer" MUID: (4954CA1102DB)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
;

type
 TnsListHAFMacroReplacer = class
 end;//TnsListHAFMacroReplacer
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 //#UC START# *4954CA1102DBimpl_uses*
 //#UC END# *4954CA1102DBimpl_uses*
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
