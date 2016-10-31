unit evdNcsTypes;

// ������: "w:\common\components\rtl\Garant\EVD\evdNcsTypes.pas"
// ���������: "UtilityPack"
// ������� ������: "evdNcsTypes" MUID: (5461F0A303D6)

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
;

type
 TncsMessageKind = (
  ncs_mkMessage
   {* ��������� �� ������� ��������� ����� }
  , ncs_mkReply
   {* ����� �� ��������� }
  , ncs_mkSignal
   {* ��������� �� ������� �� ��������� ����� }
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
