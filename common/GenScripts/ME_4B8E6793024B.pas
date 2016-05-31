unit vtDialogsRes;

// ������: "w:\common\components\gui\Garant\VT\vtDialogsRes.pas"
// ���������: "UtilityPack"
// ������� ������: "vtDialogsRes" MUID: (4B8E6793024B)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ TvtMiscMessages }
 str_vtDefaultOpenDlgFilter: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtDefaultOpenDlgFilter'; rValue : '��� �����|*.*');
  {* '��� �����|*.*' }
{$If NOT Defined(Nemesis)}
 {* ������������ ������ MsgDlg }
 str_vtMsgDlgWarning: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgWarning'; rValue : 'Warning');
  {* 'Warning' }
 str_vtMsgDlgError: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgError'; rValue : 'Error');
  {* 'Error' }
 str_vtMsgDlgInformation: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgInformation'; rValue : 'Information');
  {* 'Information' }
 str_vtMsgDlgConfirm: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgConfirm'; rValue : 'Confirm');
  {* 'Confirm' }
{$IfEnd} // NOT Defined(Nemesis)
{$If Defined(Nemesis)}
const
 {* ������������ ������ MsgDlgNemesis }
 str_vtMsgDlgWarning: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgWarning'; rValue : '��������������');
  {* '��������������' }
 str_vtMsgDlgError: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgError'; rValue : '������');
  {* '������' }
 str_vtMsgDlgInformation: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgInformation'; rValue : '����������');
  {* '����������' }
 str_vtMsgDlgConfirm: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgConfirm'; rValue : '�������������');
  {* '�������������' }
{$IfEnd} // Defined(Nemesis)
const
 {* ������������ ������ Custom }
 str_vtMsgDlgCustom: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgCustom'; rValue : '');
  {* '' }
 {* ������������ ������ MsgDlgButtons }
 str_vtMsgDlgYes: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgYes'; rValue : '&��');
  {* '&��' }
 str_vtMsgDlgNo: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgNo'; rValue : '&���');
  {* '&���' }
 str_vtMsgDlgOK: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgOK'; rValue : 'OK');
  {* 'OK' }
 str_vtMsgDlgCancel: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgCancel'; rValue : '&������');
  {* '&������' }
 str_vtMsgDlgAbort: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgAbort'; rValue : '&��������');
  {* '&��������' }
 str_vtMsgDlgRetry: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgRetry'; rValue : '���&������');
  {* '���&������' }
 str_vtMsgDlgIgnore: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgIgnore'; rValue : '&������������');
  {* '&������������' }
 str_vtMsgDlgAll: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgAll'; rValue : '&���');
  {* '&���' }
 str_vtMsgDlgNoToAll: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgNoToAll'; rValue : '&��� ��� ����');
  {* '&��� ��� ����' }
 str_vtMsgDlgYesToAll: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgYesToAll'; rValue : '&�� ��� ����');
  {* '&�� ��� ����' }
 str_vtMsgDlgHelp: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgHelp'; rValue : '&�������');
  {* '&�������' }

implementation

uses
 l3ImplUses
;

initialization
 str_vtDefaultOpenDlgFilter.Init;
 {* ������������� str_vtDefaultOpenDlgFilter }
 str_vtMsgDlgWarning.Init;
 {* ������������� str_vtMsgDlgWarning }
 str_vtMsgDlgError.Init;
 {* ������������� str_vtMsgDlgError }
 str_vtMsgDlgInformation.Init;
 {* ������������� str_vtMsgDlgInformation }
 str_vtMsgDlgConfirm.Init;
 {* ������������� str_vtMsgDlgConfirm }
 str_vtMsgDlgWarning.Init;
 {* ������������� str_vtMsgDlgWarning }
 str_vtMsgDlgError.Init;
 {* ������������� str_vtMsgDlgError }
 str_vtMsgDlgInformation.Init;
 {* ������������� str_vtMsgDlgInformation }
 str_vtMsgDlgConfirm.Init;
 {* ������������� str_vtMsgDlgConfirm }
 str_vtMsgDlgCustom.Init;
 {* ������������� str_vtMsgDlgCustom }
 str_vtMsgDlgYes.Init;
 {* ������������� str_vtMsgDlgYes }
 str_vtMsgDlgNo.Init;
 {* ������������� str_vtMsgDlgNo }
 str_vtMsgDlgOK.Init;
 {* ������������� str_vtMsgDlgOK }
 str_vtMsgDlgCancel.Init;
 {* ������������� str_vtMsgDlgCancel }
 str_vtMsgDlgAbort.Init;
 {* ������������� str_vtMsgDlgAbort }
 str_vtMsgDlgRetry.Init;
 {* ������������� str_vtMsgDlgRetry }
 str_vtMsgDlgIgnore.Init;
 {* ������������� str_vtMsgDlgIgnore }
 str_vtMsgDlgAll.Init;
 {* ������������� str_vtMsgDlgAll }
 str_vtMsgDlgNoToAll.Init;
 {* ������������� str_vtMsgDlgNoToAll }
 str_vtMsgDlgYesToAll.Init;
 {* ������������� str_vtMsgDlgYesToAll }
 str_vtMsgDlgHelp.Init;
 {* ������������� str_vtMsgDlgHelp }

end.
