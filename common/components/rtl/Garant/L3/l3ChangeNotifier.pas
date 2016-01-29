unit l3ChangeNotifier;

{ $Id: l3ChangeNotifier.pas,v 1.14 2014/02/13 10:12:59 lulin Exp $ }

// $Log: l3ChangeNotifier.pas,v $
// Revision 1.14  2014/02/13 10:12:59  lulin
// - ���������� �������� ������.
//
// Revision 1.13  2012/01/25 16:43:07  lulin
// {RequestLink:326773370}
//
// Revision 1.12  2009/12/11 15:56:11  lulin
// {RequestLink:172984520}.
//
// Revision 1.11  2009/12/11 14:14:53  lulin
// {RequestLink:172984520}.
//
// Revision 1.10  2008/03/20 09:48:40  lulin
// - cleanup.
//
// Revision 1.9  2008/02/07 14:44:45  lulin
// - ����� _Tl3LongintList �������� � ����������� ������.
//
// Revision 1.8  2005/11/24 17:14:46  demon
// - fix: ����� �������� ���������������� �� l3Control ��������
// ���������� ����������� ������ Changing/Changed �� DoChanged ����������
//
// Revision 1.7  2005/09/08 12:47:34  lulin
// - �������� ������ _LockedNotifier_.
//
// Revision 1.6  2005/07/28 15:09:50  voba
// - improve : l3ItemStorages_TLB ����������  � l3Interfaces
// - improve : AddNotifiedObj/DelNotifiedObj ������������ � Subscribe/Unsubscribe ��� ��������� ���������� Il3ChangeNotifier
// - improve : Il3ItemNotifyRecipient.Notify �������� �������� aNotifier : Il3ChangeNotifier
//
// Revision 1.5  2005/07/25 13:07:28  lulin
// - bug fix: �� �������������� ����������.
//
// Revision 1.4  2005/02/08 09:51:06  step
// ������� ��� f_Subscribers (_TInterfaceList --> _Tl3LongintList)
//
// Revision 1.3  2005/01/12 17:50:29  step
// ����� ������� ������
//
// Revision 1.2  2005/01/11 10:58:06  step
// ��������� ��������� Log.
//

interface

uses
  Classes,

  l3Types,
  l3Interfaces,
  l3Base,
  l3InternalInterfaces,
  l3NotifyPtrList,
  l3ProtoObject
  ;

type
  // ���������� "��������-���������"
  _l3Changing_Parent_ = Tl3ProtoObject;
  {$Include ..\L3\l3Changing.imp.pas}
  _l3ChangingChangedNotifier_Parent_ = _l3Changing_;
  {$Include l3ChangingChangedNotifier.imp.pas}
  Tl3ChangeNotifier = class(_l3ChangingChangedNotifier_)
  end;//Tl3ChangeNotifier

implementation

uses
  SysUtils
  ;

{$Include ..\L3\l3Changing.imp.pas}

{$Include l3ChangingChangedNotifier.imp.pas}

end.

