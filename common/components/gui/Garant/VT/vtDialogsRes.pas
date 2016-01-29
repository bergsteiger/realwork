unit vtDialogsRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VT$Core"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/VT/vtDialogsRes.pas"
// �����: 03.03.2010 16:43
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VT$Core::Dialogs::vtDialogsRes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\VT\vtDefine.inc}

interface

uses
  l3StringIDEx
  ;

var
  { ������������ ������ TvtMiscMessages }
 str_vtDefaultOpenDlgFilter : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtDefaultOpenDlgFilter'; rValue : '��� �����|*.*');
  { '��� �����|*.*' }

{$If not defined(Nemesis)}
var
  { ������������ ������ MsgDlg }
 str_vtMsgDlgWarning : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgWarning'; rValue : 'Warning');
  { 'Warning' }
 str_vtMsgDlgError : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgError'; rValue : 'Error');
  { 'Error' }
 str_vtMsgDlgInformation : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgInformation'; rValue : 'Information');
  { 'Information' }
 str_vtMsgDlgConfirm : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgConfirm'; rValue : 'Confirm');
  { 'Confirm' }
{$IfEnd} //not Nemesis

{$If defined(Nemesis)}
var
  { ������������ ������ MsgDlgNemesis }
 str_vtMsgDlgWarning : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgWarning'; rValue : '��������������');
  { '��������������' }
 str_vtMsgDlgError : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgError'; rValue : '������');
  { '������' }
 str_vtMsgDlgInformation : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgInformation'; rValue : '����������');
  { '����������' }
 str_vtMsgDlgConfirm : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgConfirm'; rValue : '�������������');
  { '�������������' }
{$IfEnd} //Nemesis

var
  { ������������ ������ Custom }
 str_vtMsgDlgCustom : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgCustom'; rValue : '');
  { '' }

var
  { ������������ ������ MsgDlgButtons }
 str_vtMsgDlgYes : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgYes'; rValue : '&��');
  { '&��' }
 str_vtMsgDlgNo : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgNo'; rValue : '&���');
  { '&���' }
 str_vtMsgDlgOK : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgOK'; rValue : 'OK');
  { 'OK' }
 str_vtMsgDlgCancel : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgCancel'; rValue : '&������');
  { '&������' }
 str_vtMsgDlgAbort : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgAbort'; rValue : '&��������');
  { '&��������' }
 str_vtMsgDlgRetry : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgRetry'; rValue : '���&������');
  { '���&������' }
 str_vtMsgDlgIgnore : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgIgnore'; rValue : '&������������');
  { '&������������' }
 str_vtMsgDlgAll : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgAll'; rValue : '&���');
  { '&���' }
 str_vtMsgDlgNoToAll : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgNoToAll'; rValue : '&��� ��� ����');
  { '&��� ��� ����' }
 str_vtMsgDlgYesToAll : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgYesToAll'; rValue : '&�� ��� ����');
  { '&�� ��� ����' }
 str_vtMsgDlgHelp : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vtMsgDlgHelp'; rValue : '&�������');
  { '&�������' }

implementation

uses
  l3MessageID
  ;


initialization
// ������������� str_vtDefaultOpenDlgFilter
 str_vtDefaultOpenDlgFilter.Init;
{$If not defined(Nemesis)}
// ������������� str_vtMsgDlgWarning
 str_vtMsgDlgWarning.Init;
{$IfEnd} //not Nemesis
{$If not defined(Nemesis)}
// ������������� str_vtMsgDlgError
 str_vtMsgDlgError.Init;
{$IfEnd} //not Nemesis
{$If not defined(Nemesis)}
// ������������� str_vtMsgDlgInformation
 str_vtMsgDlgInformation.Init;
{$IfEnd} //not Nemesis
{$If not defined(Nemesis)}
// ������������� str_vtMsgDlgConfirm
 str_vtMsgDlgConfirm.Init;
{$IfEnd} //not Nemesis
{$If defined(Nemesis)}
// ������������� str_vtMsgDlgWarning
 str_vtMsgDlgWarning.Init;
{$IfEnd} //Nemesis
{$If defined(Nemesis)}
// ������������� str_vtMsgDlgError
 str_vtMsgDlgError.Init;
{$IfEnd} //Nemesis
{$If defined(Nemesis)}
// ������������� str_vtMsgDlgInformation
 str_vtMsgDlgInformation.Init;
{$IfEnd} //Nemesis
{$If defined(Nemesis)}
// ������������� str_vtMsgDlgConfirm
 str_vtMsgDlgConfirm.Init;
{$IfEnd} //Nemesis
// ������������� str_vtMsgDlgCustom
 str_vtMsgDlgCustom.Init;
// ������������� str_vtMsgDlgYes
 str_vtMsgDlgYes.Init;
// ������������� str_vtMsgDlgNo
 str_vtMsgDlgNo.Init;
// ������������� str_vtMsgDlgOK
 str_vtMsgDlgOK.Init;
// ������������� str_vtMsgDlgCancel
 str_vtMsgDlgCancel.Init;
// ������������� str_vtMsgDlgAbort
 str_vtMsgDlgAbort.Init;
// ������������� str_vtMsgDlgRetry
 str_vtMsgDlgRetry.Init;
// ������������� str_vtMsgDlgIgnore
 str_vtMsgDlgIgnore.Init;
// ������������� str_vtMsgDlgAll
 str_vtMsgDlgAll.Init;
// ������������� str_vtMsgDlgNoToAll
 str_vtMsgDlgNoToAll.Init;
// ������������� str_vtMsgDlgYesToAll
 str_vtMsgDlgYesToAll.Init;
// ������������� str_vtMsgDlgHelp
 str_vtMsgDlgHelp.Init;

end.