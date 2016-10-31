unit evdNcsTypes;

// Модуль: "w:\common\components\rtl\Garant\EVD\evdNcsTypes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evdNcsTypes" MUID: (5461F0A303D6)

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
;

type
 TncsMessageKind = (
  ncs_mkMessage
   {* Сообщение на которое ожидается ответ }
  , ncs_mkReply
   {* Ответ на сообщение }
  , ncs_mkSignal
   {* Сообщение на которое НЕ ожидается ответ }
 );//TncsMessageKind

 TncsResultKind = (
  ncs_rkOk
  , ncs_rkFail
  , ncs_rkRetry
  , ncs_rkEmpty
 );//TncsResultKind

 TncsDeliveryCommand = (
  ncs_dcGetTasksList
  , ncs_dcGetFilesList
  , ncs_dcGetFileCRC
  , ncs_dcGetFile
  , ncs_dcSetProgress
  , ncs_dcSetDeliveryResult
  , ncs_dcCorrectTargetFolder
  , ncs_dcCheckAlive
  , ncs_dcDoneProcess
 );//TncsDeliveryCommand

implementation

uses
 l3ImplUses
 //#UC START# *5461F0A303D6impl_uses*
 //#UC END# *5461F0A303D6impl_uses*
;

end.
