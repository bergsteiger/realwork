unit vcmExportConst;

{ ���������� "vcm"        }
{ �����: ����� �.�. �     }
{ ������: vcmExportConst - }
{ �����: 09.03.2006 20:33 }
{ $Id: vcmExportConst.pas,v 1.23 2013/11/11 15:21:12 lulin Exp $ }

// $Log: vcmExportConst.pas,v $
// Revision 1.23  2013/11/11 15:21:12  lulin
// - �������� ���������� ���.
//
// Revision 1.22  2012/05/23 18:32:59  lulin
// {RequestLink:294608726}
//
// Revision 1.21  2011/06/23 17:01:31  lulin
// {RequestLink:254944102}.
//
// Revision 1.20  2011/03/16 13:26:08  lulin
// - �������� �������.
//
// Revision 1.19  2009/05/26 10:30:01  oman
// - new: ������ ���� ��� ���������� - [$148018532]
//
// Revision 1.18  2008/12/03 08:25:56  oman
// - new: ����� ���������� ����� ���������� (�-104431648)
//
// Revision 1.17  2008/12/02 14:55:47  oman
// - new: ����� ���������� ����� ���������� (�-104431648)
//
// Revision 1.16  2008/12/02 13:09:12  oman
// - new: �������� ������� �������� �������� (�-104431648)
//
// Revision 1.14  2008/07/11 12:04:00  lulin
// -<K>: 101417264.
//
// Revision 1.13  2007/07/27 11:57:28  oman
// - new: � �������� ����������� �������� ������� ������ (cq25775)
//
// Revision 1.12  2007/07/27 10:11:11  oman
// - new: ���������� �������� "EmptyHint" (cq25825)
//
// Revision 1.11  2007/07/26 12:24:28  oman
// - fix: ������� ��� ����������� vtHeader - ����� �����������
// _OnGetLocalizationInfo (cq24480)
//
// Revision 1.10  2007/02/26 12:59:48  oman
// - fix: �� �������� Message._CustomButtonCaption (cq24518)
//
// Revision 1.9  2006/11/25 15:22:33  lulin
// - ������ ������ ������.
//
// Revision 1.8  2006/11/03 11:00:29  lulin
// - ��������� � ������ 6.4.
//
// Revision 1.7.6.4  2006/10/23 07:50:39  lulin
// - bug fix: ���� ������ � ����������.
//
// Revision 1.7.6.3  2006/10/23 07:28:57  lulin
// - �������� ��� ��������� �������� Text � ItemsText.
//
// Revision 1.7.6.2  2006/10/18 08:00:29  lulin
// - ��������� ��� �������� �������� ����� ��������.
//
// Revision 1.7.6.1  2006/10/17 12:47:38  lulin
// - bug fix: �� ���������� ������� ����� ���������������� �����.
//
// Revision 1.7  2006/03/23 14:39:49  lulin
// - new behavior: �������� ��������� ���������.
//
// Revision 1.6  2006/03/20 13:03:50  lulin
// - new behavior: �������� ��������� ��������� ��������.
//
// Revision 1.5  2006/03/13 14:23:54  lulin
// - new behavior: ���������� UserType'�.
//
// Revision 1.4  2006/03/10 18:22:01  lulin
// - ������ ��� ��������/�������� ��������� ��������.
//
// Revision 1.3  2006/03/09 20:07:35  lulin
// - bug fix: ������ � ��������� ����������.
// - new behavior: �������� ��������� �������.
//
// Revision 1.2  2006/03/09 18:43:24  lulin
// - �������� ���������.
// - ���������� ��� ��������.
//
// Revision 1.1  2006/03/09 17:58:03  lulin
// - ��� ��� ������� ���������.
//

{$Include vcmDefine.inc }

interface

const
  c_vcmModule = 'module';
  c_vcmForm = 'form';
  c_vcmEntity = 'entity';
  c_vcmControl = 'control';
  c_vcmOperation = 'operation';
  c_vcmState = 'state';
  c_vcmTitle = 'title';
  c_vcmCaption = 'caption';
  c_vcmLongCaption = 'settingscaption';
  c_vcmHint = 'hint';
  c_vcmEmptyHint = 'emptyhint';
  c_vcmLongHint = 'longhint';
  c_vcmID = 'id';
  c_vcmMessage = 'message';
  //c_vcmChoices = 'choices';
  c_vcmString = 'string';
  c_vcmMenuItem = 'menuitem';
  c_vcmCategory = 'category';
  c_vcmUserType = 'usertype';
  c_vcmText = 'text';
  c_vcmItems = 'items';
  c_vcmStrings = 'strings';
  c_vcmCustomButtonCaption = 'custombuttoncaption';
//  c_vcmAdditionalInfo = 'additionalinfo';
  c_vcmFormSetFactory = 'fsfactory';
  c_vcmContainerForm = 'container';
  c_vcmMainForm = 'main';
  c_vcmUserTypeIcon = 'icon';
  c_vcmEditableUserType = 'editable';
  c_vcmParentUserType = 'parent';
  c_vcmExcludeUserTypes = 'excludeusertypes';
  c_vcmEntities = 'entities';
  c_vcmFooterCaption = 'footercaption';

  cTit = c_vcmTitle + '="%s"';
  cTitID = cTit + ' ' + c_vcmID + '="%s"';
  cID = c_vcmID + '="%s"';

implementation

end.

