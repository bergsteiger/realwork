unit NOT_FINISHED_csExportResultRequest;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csExportResultRequest.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "csExportResultRequest" MUID: (53170931038A)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csRequestTask
;

type
 TcsExportResultRequest = class(TddRequestTask)
 end;//TcsExportResultRequest
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.
