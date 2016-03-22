unit NOT_FINISHED_csTaskRequest;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csTaskRequest.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "csTaskRequest" MUID: (5317087100E3)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ddGetTaskRequestPrim
 , ddTaskResultRequestPrim
;

type
 TddGetTaskRequest = class(TddGetTaskRequestPrim)
 end;//TddGetTaskRequest

 TddTaskResultRequest = class(TddTaskResultRequestPrim)
 end;//TddTaskResultRequest
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.
