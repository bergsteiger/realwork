unit evdNcsTypes;

// ������: "w:\common\components\rtl\Garant\EVD\evdNcsTypes.pas"
// ���������: "UtilityPack"

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

implementation

uses
 l3ImplUses
;

end.
