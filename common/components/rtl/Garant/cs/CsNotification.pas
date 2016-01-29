unit CsNotification;

{ $Id: CsNotification.pas,v 1.20 2014/09/24 07:16:40 lukyanets Exp $ }

// $Log: CsNotification.pas,v $
// Revision 1.20  2014/09/24 07:16:40  lukyanets
// {RequestLink:565271071}
//
// Revision 1.19  2014/07/10 11:37:28  lukyanets
// {Requestlink:553422280}. KeepAlive + ��������� �������
//
// Revision 1.18  2014/07/01 05:48:31  lulin
// - �������� ��� ��������������� ������������� ����� � �����.
//
// Revision 1.17  2014/06/05 13:45:07  lulin
// - ������ ���.
//
// Revision 1.16  2014/05/21 13:57:35  lulin
// - ������ ���.
//
// Revision 1.15  2013/04/19 13:09:32  lulin
// - ���������.
//
// Revision 1.14  2013/04/03 09:51:26  fireton
// - ������ ����������� VANONCED
//
// Revision 1.13  2009/07/22 08:20:23  narry
// - ����� ��������� _KeepAlive
// - cleanup
//
// Revision 1.12  2008/07/10 12:56:26  fireton
// - refactoring: ���� ����������� ������� ��������� "������"
//
// Revision 1.11  2007/08/14 14:44:18  lulin
// - ������������ ����������� ������ ������.
//
// Revision 1.10  2007/08/14 14:30:03  lulin
// - ������������ ����������� ������ ������.
//
// Revision 1.9  2007/07/24 12:32:27  narry
// - ����������� ������� ���������
//
// Revision 1.8  2006/08/02 12:18:46  narry
// - ������� ��� ��������� � �������
//
// Revision 1.7  2006/06/26 12:12:32  narry
// - ����������
//
// Revision 1.6  2006/06/05 14:52:37  narry
// - ����������: ���������� ������ �����
//
// Revision 1.5  2006/03/31 12:46:18  narry
// - ����������
//
// Revision 1.4  2006/03/16 15:50:16  narry
// - ��� ���� ����� � ������� ������-�������
//
// Revision 1.3  2006/03/09 11:47:12  narry
// - ���������: ����� ���������� �������� �������
//
// Revision 1.2  2006/02/08 17:24:29  step
// ���������� �������� ���������� �� �������-�������� � ��������� ��������
//

{$I CsDefine.inc}

interface

uses
 Classes, SysUtils,
 IdGlobal,
 CsCommon, CsObject

 ,
 l3Base,

 evdTaskTypes
 ;

const
 c_MaxTextNotificationLength = 255;

type
 TCsNotificationType = evdTaskTypes.TCsNotificationType;

const
 ntEmpty = evdTaskTypes.ntEmpty;
 ntServerStarted = evdTaskTypes.ntServerStarted;
 ntServerStopped = evdTaskTypes.ntServerStopped;
 ntTaskChanged = evdTaskTypes.ntTaskChanged;
 ntTaskProgress = evdTaskTypes.ntTaskProgress;
 ntRepeatLogin = evdTaskTypes.ntRepeatLogin;
 ntAutoLogoff = evdTaskTypes.ntAutoLogoff;
 ntInformation = evdTaskTypes.ntInformation;
 ntUserLogin = evdTaskTypes.ntUserLogin;
 ntUserLogout = evdTaskTypes.ntUserLogout;
 ntMailArrived = evdTaskTypes.ntMailArrived;
 ntTaskAdded = evdTaskTypes.ntTaskAdded;
 ntDictEdit = evdTaskTypes.ntDictEdit;
 ntHaveNewMessages = evdTaskTypes.ntHaveNewMessages;
 ntExportDone = evdTaskTypes.ntExportDone;
 ntImportDone = evdTaskTypes.ntImportDone;
 ntDelDoc = evdTaskTypes.ntDelDoc;
 ntCalendar = evdTaskTypes.ntCalendar;
 ntAnouncedDateChanged = evdTaskTypes.ntAnouncedDateChanged;
 ntAbortAsyncRun = evdTaskTypes.ntAbortAsyncRun;
 ntResultsReadyForDelivery = evdTaskTypes.ntResultsReadyForDelivery;

type
 TNotificationHeader = packed record
  Version: Integer;
  NotificationType: TCsNotificationType;
 end;

 TcsBytes = {$IfDef XE} Tl3Bytes {$Else} TIdBytes {$EndIf};

 TCsNotification = class(TCsObject)
 private
  f_Header: TNotificationHeader;
  f_Number: Integer;
  f_Text: string[c_MaxTextNotificationLength];
  function GetType: TCsNotificationType;
  function GetVersion: Integer;
  function GetText: string;
 protected
  function GetBytes: TcsBytes;
  procedure SetBytes(const aBytes: TcsBytes);
 public
  constructor Create(aType: TCsNotificationType;
                     aNumber: Integer;
                     const aText: string);
  class function Restore(const aBytes: TcsBytes): TCsNotification; // ��� �����������
  function IsValid: Boolean;
  property Version: Integer read GetVersion;
  property NotificationType: TCsNotificationType read GetType;
  property Number: Integer read f_Number;
  property Text: string read GetText;

  property AsBytes: TcsBytes read GetBytes write SetBytes;
 end;//TCsNotification

implementation

uses
 CsConst
 ;

const
 c_WrongVersion = 0;

{ TCsNotification }

constructor TCsNotification.Create(aType: TCsNotificationType;
                                   aNumber: Integer;
                                   const aText: string);
begin
 inherited Create;
 f_Header.Version := c_CsVersion;
 f_Header.NotificationType := aType;
 f_Number := aNumber;
 if Length(aText) > 0 then
  f_Text := Copy(aText, 1, c_MaxTextNotificationLength);
end;

class function TCsNotification.Restore(const aBytes: TcsBytes): TCsNotification;
begin
 Result := inherited Create;
 Result.AsBytes := aBytes;
end;

function TCsNotification.GetBytes: TcsBytes;
begin
 SetLength(Result, SizeOf(f_Header) + SizeOf(f_Number) + SizeOf(f_Text));
 l3Move(f_Header, Result[0],                                   SizeOf(f_Header));
 l3Move(f_Number, Result[SizeOf(f_Header)],                    SizeOf(f_Number));
 l3Move(f_Text,   Result[SizeOf(f_Header) + SizeOf(f_Number)], SizeOf(f_Text));
end;

function TCsNotification.GetType: TCsNotificationType;
begin
 Result := f_Header.NotificationType;
end;

function TCsNotification.GetVersion: Integer;
begin
 Result := f_Header.Version;
end;

function TCsNotification.IsValid: Boolean;
begin
 Result := Version = c_CsVersion;
end;

procedure TCsNotification.SetBytes(const aBytes: TcsBytes);
begin
 if Length(aBytes) < SizeOf(f_Header) + SizeOf(f_Number) + SizeOf(f_Text) then
 begin
  f_Header.Version := c_WrongVersion;
  f_Header.NotificationType := ntEmpty;
 end
 else
 begin
  l3Move(aBytes[0],                                   f_Header, SizeOf(f_Header));
  l3Move(aBytes[SizeOf(f_Header)],                    f_Number, SizeOf(f_Number));
  l3Move(aBytes[SizeOf(f_Header) + SizeOf(f_Number)], f_Text,   SizeOf(f_Text));
 end;
end;

function TCsNotification.GetText: string;
begin
 Result := f_Text;
end;

end.

