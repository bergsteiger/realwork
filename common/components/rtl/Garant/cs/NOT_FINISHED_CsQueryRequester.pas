unit NOT_FINISHED_CsQueryRequester;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_CsQueryRequester.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "CsQueryRequester" MUID: (538DA3BD02A0)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , CsDataPipe
;

type
 TCsQueryProc = procedure(aPipe: TCsDataPipe);

 TCsQueryRequester = class
 end;//TCsQueryRequester
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , CsQueryRequesterTool
 //#UC START# *538DA3BD02A0impl_uses*
 //#UC END# *538DA3BD02A0impl_uses*
;
{$IfEnd} // NOT Defined(Nemesis)

end.
