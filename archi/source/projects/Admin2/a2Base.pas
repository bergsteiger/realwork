unit a2Base;

{ $Id: a2Base.pas,v 1.8 2015/04/30 11:14:36 lukyanets Exp $}

// $Log: a2Base.pas,v $
// Revision 1.8  2015/04/30 11:14:36  lukyanets
// ��������� �������� �����
//
// Revision 1.7  2015/03/31 14:08:40  lukyanets
// �������� ����������� GlobalHTServer
//
// Revision 1.6  2014/09/09 05:54:01  lukyanets
// �� ����������. ������������� CurUserID � UserID
//
// Revision 1.5  2008/10/03 11:57:53  fireton
// - ������������� �������������� �������� �����
//
// Revision 1.4  2006/12/06 13:45:15  fireton
// - �������� l3Control �� uses
// - ��������� "��������" � �������
// - ������ � ������� ������������� ������ ����������
//
// Revision 1.3  2005/08/04 16:30:54  fireton
// - ���������� ������-��������
//
// Revision 1.2  2005/08/02 15:14:20  fireton
// - ���������� ������-��������
//
// Revision 1.1  2005/07/29 16:53:07  fireton
// - ������ ������
//

interface

uses
 SysUtils,

 daDataProvider,
 
 DT_Serv;

type
 Ea2UserDataSaveError = class(Exception)
 end;

 Ea2GroupDataLoadError = class(Exception)
 end;

var
 gSilentClose: Boolean = False;

procedure CheckBBUserID;

implementation

procedure CheckBBUserID;
begin
 if GlobalDataProvider.Journal.UserID <> GlobalDataProvider.UserID then
  GlobalDataProvider.Journal.UserID := GlobalDataProvider.UserID;
end;


end.
