unit NOT_FINISHED_csNonEditableDictsRequest;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csNonEditableDictsRequest.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "csNonEditableDictsRequest" MUID: (531707B602E1)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csRequestTask
;

{$If Defined(RemoteDict)}
type
 TddNonEditableDictsRequest = class(TddRequestTask)
 end;//TddNonEditableDictsRequest
{$IfEnd} // Defined(RemoteDict)

{$IfEnd} // NOT Defined(Nemesis)
implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;

{$If Defined(RemoteDict)}
{$IfEnd} // Defined(RemoteDict)
{$IfEnd} // NOT Defined(Nemesis)
end.
