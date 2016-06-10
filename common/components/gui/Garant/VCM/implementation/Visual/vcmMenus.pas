unit vcmMenus;
{* ��������� ������� ��� ������ � ����. }

{ ���������� "vcm"        }
{ �����: ����� �.�. �     }
{ ������: vcmMenus -      }
{ �����: 25.02.2003 20:06 }
{ $Id: vcmMenus.pas,v 1.169 2016/04/29 07:13:30 lulin Exp $ }

// $Log: vcmMenus.pas,v $
// Revision 1.169  2016/04/29 07:13:30  lulin
// - �������������.
//
// Revision 1.168  2015/11/17 11:57:31  morozov
// {RequestLink: 611211969}
//
// Revision 1.167  2015/04/20 09:57:17  kostitsin
// {requestlink: 397280205 }
//
// Revision 1.166  2015/01/15 14:08:33  lulin
// {RequestLink:585926571}. ���������� Interlocked.
//
// Revision 1.165  2014/08/12 11:40:15  morozov
// {RequestLink: 560188140}
//
// Revision 1.164  2014/07/22 09:42:41  morozov
// {RequestLink: 556733682}
//
// Revision 1.163  2014/05/23 09:37:10  morozov
// {RequestLink: 518765917}
//
// Revision 1.162  2014/02/18 10:01:29  lulin
// - ��� ������������� ������� ������� ����������� ��������� ���� ����������.
//
// Revision 1.161  2013/07/03 12:35:14  lulin
// - �������� ������.
//
// Revision 1.160  2013/04/05 12:02:41  lulin
// - ���������.
//
// Revision 1.159  2012/11/01 09:42:25  lulin
// - ����� ����� � �������.
//
// Revision 1.158  2012/11/01 07:44:12  lulin
// - ������ ����������� ����������� �������� �������� �������.
//
// Revision 1.157  2012/10/24 18:07:34  lulin
// - ������ ��������� ��� ���������� VGScene.
// - ������� � ������������� ������� � �������� ����.
//
// Revision 1.156  2012/10/24 17:02:30  lulin
// - �������� ����������� � ��������� K380046320.
//
// Revision 1.155  2012/08/07 14:38:06  lulin
// {RequestLink:358352265}
//
// Revision 1.154  2012/05/30 17:12:03  lulin
// - �������� ����� � ��������� ����.
//
// Revision 1.153  2012/05/30 16:54:28  lulin
// - ������ ����.
//
// Revision 1.152  2011/12/08 16:30:10  lulin
// {RequestLink:273590436}
// - ������ ����.
//
// Revision 1.151  2011/12/07 17:48:20  lulin
// {RequestLink:273590436}
//
// Revision 1.150  2011/10/10 16:47:30  lulin
// {RequestLink:288787808}.
//
// Revision 1.149  2011/08/11 09:27:50  vkuprovich
// {RequestLink:276531833}
// ��������� �������� ���
//
// Revision 1.148  2011/08/03 17:09:55  vkuprovich
// {RequestLink:276531833}
// - fix : ��������� �������� ����
//
// Revision 1.147  2011/08/02 15:13:08  lulin
// {RequestLink:272668827}.
//
// Revision 1.146  2011/08/01 16:41:22  vkuprovich
// {RequestLink:272668827}
// ��������� ���� ���� � �������� ����
//
// Revision 1.145  2011/07/21 14:17:04  vkuprovich
// {RequestLink:272668827}
// ���������� �������� �������� �������� ����������� �� �������TvcmPopupMenuPrim
//
// Revision 1.144  2010/12/29 12:58:01  lulin
// {RequestLink:206504442}.
// [$249335215].
//
// Revision 1.143  2010/09/13 09:51:13  lulin
// {RequestLink:197496539}.
// - �2.
//
// Revision 1.142  2010/08/16 06:46:28  lulin
// {RequestLink:232098153}.
// [$232100559].
//
// Revision 1.141  2010/04/30 15:15:48  lulin
// {RequestLink:207389954}.
// - ������ ������������.
//
// Revision 1.140  2009/10/16 17:00:46  lulin
// {RequestLink:159360578}. �52.
//
// Revision 1.139  2009/02/20 13:44:22  lulin
// - <K>: 136941122.
//
// Revision 1.138  2009/02/19 16:53:49  lulin
// - <K>: 136941122. ������ ������ ���� � �����.
//
// Revision 1.137  2009/02/12 17:09:18  lulin
// - <K>: 135604584. ������� ������ � ����������� �����������.
//
// Revision 1.136  2008/03/20 09:48:21  lulin
// - cleanup.
//
// Revision 1.135  2008/03/19 14:23:47  lulin
// - cleanup.
//
// Revision 1.134  2008/03/03 20:05:55  lulin
// - <K>: 85721135.
//
// Revision 1.133  2008/02/20 14:06:37  lulin
// - ������� ���������� �������� ���������.
//
// Revision 1.132  2008/02/14 19:32:33  lulin
// - �������� ����� ������ � ���������.
//
// Revision 1.131  2008/02/14 14:12:17  lulin
// - <K>: 83920106.
//
// Revision 1.130  2008/02/07 08:37:46  lulin
// - ������� �������� ������� �� ������������ ������.
//
// Revision 1.129  2008/01/25 12:06:52  lulin
// - �������������� ����� � �������.
//
// Revision 1.128  2008/01/25 11:32:07  lulin
// - �������������� ����� � �������.
//
// Revision 1.127  2007/11/13 06:57:33  oman
// - fix: ��������� �������� �������������� ��������� (cq27342)
//
// Revision 1.126  2007/09/26 06:18:09  mmorozov
// - change: ������ ������������� TvcmAction ���������� IvcmAction + ������ ������ ��� �������� �� ������������� _SelectedString ������ Caption (� ������ ������ ��� CQ: OIT5-26741 + K<50758978>);
//
// Revision 1.125  2007/09/25 03:55:32  mmorozov
// - new behaviour: ��� ������\��������� �������� ���������� �������� ��� �������� ���� vcm_otDate, vcm_otCombo, vcm_otEditCombo ���������� �������� ���������� _SelectedString, ������ Caption. ��� ����� Caption ��� ���� ����� �������� ���� ���������� (� ������ ������ CQ: OIT5-26741);
//
// Revision 1.124  2007/08/22 09:07:26  oman
// - fix: ������������ ��������� (vcm_otButtonPopup)  ���������
//  ��������� ���������� � ��������� ���������������� �������
//  Checked (cq26444)
//
// Revision 1.123  2007/08/13 17:23:32  lulin
// - cleanup.
//
// Revision 1.122  2007/08/10 12:07:01  oman
// - fix: ��� �������� ���� vcm_otMenuButtonCombo � ����������� ����
//  ������� �� ���������� �������� ��� ������ ������� (cq26335)
//
// Revision 1.121  2007/08/06 14:04:29  oman
// - fix: ������� ����� TvcmBaseMenuManager.BuildAction ��� ���������
//  Action �� ������ TvcmOpSelector (cq25326)
//
// Revision 1.120  2007/06/28 14:56:16  lulin
// - cleanup.
//
// Revision 1.119  2007/06/04 10:08:16  mmorozov
// - new: �������� ������� ��� ����������� ������ �������� ����;
//
// Revision 1.118  2007/05/28 06:33:44  oman
// - �� ���������� ����������
//
// Revision 1.117  2007/05/25 14:52:13  mmorozov
// - change: ��������� ��������� � �������������� �������� ���� ���� (vcm_otDate) � ������ ����� (CQ: OIT5-25342);
//
// Revision 1.116  2007/04/26 11:43:09  oman
// - fix: �������� � ������ ���� ������ �������� �� ����� ��������
//  vcm_otLabel, � ������ vcm_ofDefault (cq24612)
//
// Revision 1.115  2007/04/26 09:27:49  oman
// - fix: ��������� ������ ��� vcm_otLabel ������� �� ActionLink (cq24612, 25145)
//
// Revision 1.114  2007/04/13 10:56:36  oman
// - fix: ��� ��������� Action.Cation ��������� ���������� ����������
//  �������� � ����������  (cq25036)
//
// Revision 1.113  2007/04/12 07:57:11  lulin
// - ���������� ������ � ����������.
//
// Revision 1.112  2007/04/11 12:04:29  lulin
// - ��� ��������� ������ ���������� ������ � ����������.
//
// Revision 1.111  2007/04/10 13:20:11  lulin
// - ���������� ������ � ����������.
//
// Revision 1.110  2007/04/05 11:41:01  lulin
// - ������ ��-��������� � ������ ����� ����� ���������� ��������.
//
// Revision 1.109  2007/04/04 10:24:23  oman
// - new: ����� ��� �������� vcm_otLabel - ����� ������� ������������
//  ������ � ���� � �� �������� �� ������. � ���� ������
//  ������������ ��� Default (������) (cq24612)
//
// Revision 1.108  2007/03/12 13:54:43  lulin
// - cleanup.
//
// Revision 1.107  2007/01/31 09:13:26  lulin
// - ���������������� ���, ������� ������� �������� �� L3.
//
// Revision 1.106  2007/01/24 14:48:25  lulin
// - cleanup.
//
// Revision 1.105  2007/01/24 14:14:46  lulin
// - � �������, ��������� ���� �� ���� ������ �� �������� ������.
//
// Revision 1.104  2007/01/22 15:30:12  lulin
// - ����������� �� ��������������� ���������� ��� ���������� ���������������� ��������.
//
// Revision 1.103  2007/01/18 10:49:35  lulin
// - �������� ������ ��������� ������ �� ���������.
//
// Revision 1.102  2007/01/16 08:51:10  lulin
// - ����������� �� ���������������� ��������� - ������� ����.
//
// Revision 1.101  2007/01/16 06:33:01  oman
// - fix: �� ���������� ����������
//
// Revision 1.100  2007/01/15 17:54:27  lulin
// - ����������� �� ���������������� ���������.
//
// Revision 1.99  2007/01/15 17:25:40  lulin
// - cleanup.
//
// Revision 1.98  2007/01/15 16:37:57  lulin
// - ��� ���������� ���� ���������� �������� �������� �� ������ �����.
//
// Revision 1.97  2007/01/15 16:02:18  lulin
// - ������ "�����" ���������� �� ������������� ��������, ��������� �� ��������.
//
// Revision 1.96  2007/01/15 14:56:51  lulin
// - ��� ���������� ���� ���������� �������� ������ �� ������ �����.
//
// Revision 1.95  2007/01/12 13:14:40  oman
// - fix: ������ vcm_otMenuButtonCombo - ����������� ���� (cq24113)
//
// Revision 1.94  2007/01/11 12:52:18  lulin
// - ������ ������ ��� ������� ������ �� ���������� - ����� ��� ������� ����� ���������.
//
// Revision 1.93  2007/01/11 11:15:08  lulin
// - ������ "������" ����.
//
// Revision 1.92  2007/01/10 17:27:43  lulin
// - ������ ������ ����� ������� ������ �� ���������� - ����� ��� ������� ����� ���������.
//
// Revision 1.91  2007/01/10 15:56:02  lulin
// - cleanup.
//
// Revision 1.90  2007/01/10 14:19:48  lulin
// - �������� �������� ����������������.
//
// Revision 1.89  2007/01/10 11:57:53  lulin
// - cleanup.
//
// Revision 1.88  2007/01/05 18:17:36  lulin
// - ���������� ������� ���� ��� ���������� �������.
//
// Revision 1.87  2007/01/05 14:14:53  lulin
// - ����� ������ ��� �������� - ��� ������ ����� �������� ����� ������������ ��������.
//
// Revision 1.86  2007/01/05 13:53:16  lulin
// - ����� ������ ��� �������� - ��� ������ ����� �������� ����� ������������ ��������.
//
// Revision 1.85  2007/01/05 13:33:00  lulin
// - cleanup.
//
// Revision 1.84  2007/01/05 13:03:25  lulin
// - ���������� ������ ������ ��� ���������� �������� ������ ����.
//
// Revision 1.83  2006/12/29 15:13:43  lulin
// - cleanup.
//
// Revision 1.82  2006/12/29 15:07:46  lulin
// - ���������� ������� ������ ��� ������� ����.
//
// Revision 1.81  2006/12/29 14:53:26  lulin
// - cleanup.
//
// Revision 1.80  2006/12/22 15:06:38  lulin
// - ����� ���� - ������ ��������� � ������ � ������� ���������.
//
// Revision 1.79  2006/11/03 11:00:34  lulin
// - ��������� � ������ 6.4.
//
// Revision 1.78.2.1  2006/10/30 10:09:10  oman
// - fix: ������������ �������� ���������������� vcl.
//  ���������� ���� � ���������� ������ "�������" (cq23319)
//
// Revision 1.78  2006/08/25 12:34:15  oman
// - new: ����� ��� �������� _vcm_otMenuButtonPopup - ����� �� ���
//   _vcm_otButtonPopup, �� ����� ��� ������������ � ����.
//
// Revision 1.77  2006/08/03 05:05:17  mmorozov
// - bugfix: ��� combo ��������, ��� �������� ������ ����, ���������� Caption ��������, �� Action. ��. ����������� _vcmAddEntityOperationItem,  vcm_UseCaptionFromOperation (CQ: OIT500022064);
//
// Revision 1.76  2006/07/26 12:19:18  mmorozov
// - new behaviour: ����� ���������� MenuItem Action �� ��������������� Caption, ��. ����������� � _vcmAddEntityOperationItem (cq: OIT500022024);
//
// Revision 1.75  2006/06/07 15:18:08  mmorozov
// - remove: TvcmPopupMenuItem;
// - new behaviour: ������ ����������� ������ ������������ ���� � TvcmMenuItem.InitiateAction (CQ: OIT500021254);
//
// Revision 1.74  2006/05/03 14:13:16  oman
// - fix: ����� ���������� ������� MenuItem, ��������� � SubNode (_Il3Node)
//  �� �������������� SubNode (��� �������������� ����� �����������
//   ������, �.�. MenuItem � ���������� ���������� �� ������ � Action).
// - fix: MenuItem, ��������� � SubNode �� �������������� ��� ����������
//   ����� subnode � �����.
// - warning fix
//
// Revision 1.73  2006/05/02 09:24:38  oman
// - fix: MenuItem, ��������� � SubNode (_Il3Node) �� ���������� ��
//  �������������� SubNode.
//
// Revision 1.72  2006/02/10 07:14:26  mmorozov
// - new behaviour: �� ���������� �� ��������� �������� � ����������� ���� (CQ: 19527);
//
// Revision 1.71  2006/01/25 14:27:36  lulin
// - ����������� �� �������������������� ����������.
//
// Revision 1.70  2006/01/25 14:07:35  lulin
// - new behavior: �� �������� ������������ ������ ��� �������������� ����.
//
// Revision 1.69  2006/01/20 11:33:11  mmorozov
// 1. ������ ���� �� ������ ������������ �������� �������� �������� �� ������ ��������� � ����������� �������;
// 2. ���� � ������ ������������ ����������� �������� � ����������� ����������, �� �� ������������� ����������� ������� � ���� �������� ��������;
// 3. ��������� ����������� �������, ��� ����������� �������� �������� ������ ������������ � ��������� ������ ����;
// 3.
//
// Revision 1.68  2005/12/01 07:58:39  lulin
// - cleanup.
//
// Revision 1.67  2005/12/01 06:09:23  mmorozov
// - change: ������� ��������� � ImageList-���, �.�. menus.pas:GetImageList ������ �������� ���������;
//
// Revision 1.66  2005/11/29 12:57:48  mmorozov
// - new behaviour: ��������� ������ � ��������� �������� � menus.pas (GetImageList) (cq: 00018297);
//
// Revision 1.65  2005/10/05 12:26:27  lulin
// - bug fix: �� ������� OnTest ��� ��������� ������� �������������� ���� (CQ OIT5-16225).
//
// Revision 1.64  2005/09/13 13:18:25  mmorozov
// - warning fix;
//
// Revision 1.63  2005/08/05 12:46:45  mmorozov
// new: ���, � ������������������ ����, ��� �������� ��������� ���� � ������� ����� �������� ����� � ������� ������� windows (��� ������ ������������������ ������ � ���������);
//
// Revision 1.62  2005/04/12 13:42:23  mmorozov
// change: ��������� vcmMakeModuleMenu;
//
// Revision 1.61  2005/03/21 13:12:49  am
// change: ����� _TvcmPopupMenuPrim � vcmMenus
//
// Revision 1.60  2005/01/14 10:42:32  lulin
// - ������ Get*ParentForm ��������� � ���������� AFW.
//
// Revision 1.59  2004/11/18 16:29:57  lulin
// - ���������� ���������� �� VCM ��� ������������� inc'��.
//
// Revision 1.58  2004/11/05 14:04:54  am
// change: ����� ��� - _vcm_otMenuButtonCombo. ��������� ����� ��, ��� vcm_otButtonCombo, �� ����� ���������� ���� � ����.
//
// Revision 1.57  2004/11/01 15:40:10  am
// change: ������ _lIsChangeSubNodes ����� ��������� ������� �� ��������� � ������ _PlainLevel
// change: vcm_otButtonCombo ����� ������������ � ����������� ����
//
// Revision 1.56  2004/10/18 14:31:37  mmorozov
// bugfix and change: ���� ���� ��������� � ����� ������������ ������� (�� ������ ��������� ����);
//
// Revision 1.55  2004/10/13 15:50:17  mmorozov
// - �� ���������������;
//
// Revision 1.54  2004/10/13 15:22:47  am
// bugfix: ����� ����������� ������� ������ �������
//
// Revision 1.53  2004/10/12 14:18:11  am
// change: ��� �������� ����� ��������� ���� LockPopupMessage/UnlockPopupMessage
// change: ���� ���� �� ������ ���, ������������� ����� ��������� � ������ ������
//
// Revision 1.52  2004/10/12 10:28:37  am
// change: Use\Free � TvcmComboMenuItemChildItemActionLink.Execute
//
// Revision 1.51  2004/10/04 15:16:07  am
// change: ��������� � _TvcmCalendarForm "����������" ��������� � ������������ ����� ������ ������, etc � ��������� ����.
//
// Revision 1.50  2004/09/17 11:23:01  lulin
// - �������� vcm_opStrings ������������ � _vcm_opItems, � ��� ������� ��� � _IvcmHolder �� _IvcmStrings (!).
//
// Revision 1.49  2004/09/15 15:08:14  lulin
// - cleanup.
//
// Revision 1.48  2004/09/15 15:04:01  lulin
// - new unit: vcmMenuItemActionLink.
//
// Revision 1.47  2004/09/08 11:22:46  lulin
// - new define: _l3NoTrace.
// - new define: l3TraceObjects.
//
// Revision 1.46  2004/09/07 10:27:24  mmorozov
// bugfix: ����� ����� �������������� ���������� �����;
//
// Revision 1.45  2004/09/02 17:13:33  mmorozov
// change: MenuImages -> SmallImages;
//
// Revision 1.44  2004/09/01 09:44:03  law
// - bug fix: ����� �� ������ � Toolbar'� ������ �������� ������� ���� (CQ OIT5-8927).
//
// Revision 1.43  2004/08/25 14:25:34  mmorozov
// - �� �������������� ����������;
//
// Revision 1.42  2004/08/25 14:00:48  mmorozov
// new: ���������� ����������� ���������� �� vcmComboMenuItem ������������ � �������������� _SubNodes;
//
// Revision 1.41  2004/08/25 13:15:16  mmorozov
// new: ����������� ���������� �� vcmComboMenuItem ������������ � �������������� _SubNodes;
//
// Revision 1.40  2004/08/24 14:33:14  am
// new: TvcmDateMenuItemActionLink
// new: TvcmDateMenuItem
//
// Revision 1.39  2004/08/24 07:01:51  demon
// - bug fix: ������������� ���������� ComboMenu - � ������ �� �����, � ������ (��� ��������, �� ���� �� ��������� �� ��������� ������ - ��� �������� ���� �������� ���� ��������).
//
// Revision 1.38  2004/08/23 18:00:54  law
// - bug fix: � ������ ����� �������� � ������� _GroupID ����������� ����� �������� � ������� - �� ����������� ����������� ����� ����.
//
// Revision 1.37  2004/07/28 10:20:51  law
// - new prop: TvcmBaseMenuManager.MenuImages.
//
// Revision 1.36  2004/07/16 05:46:27  mmorozov
// new: "����������" ������ ����, ������� �������� ����������� ������ ���� ��������� define-��� "nsDisableMenuItems";
//
// Revision 1.35  2004/06/02 10:20:51  law
// - ������ ����������� Tl3VList.MakeIUnknown - ����������� _Tl3InterfaceList.Make.
//
// Revision 1.34  2004/06/01 15:33:59  law
// - ������� ������������ Tl3VList.MakeLongint, MakeLongintSorted - ����������� _Tl3LongintList.
// - ��������� VCM, �� ������������ ����������� �������.
//
// Revision 1.33  2004/06/01 12:25:09  am
// new: �������� �������� � ������� � ������� ���� �������� "�����������".
//
// Revision 1.32  2004/04/20 15:56:26  mmorozov
// new: �������� TvcmComboMenuItem.CurrentItem - ��������� ����� ����;
// new behaviour: ��� ��������� ���������� ��� vcm_otCombo ���������, ��� ����������� ������� ����������� _Strings, ������� ��������� ������������;
// new: ��� ��������� ���������� ��� vcm_otCombo ������������� ������� ����� ����, ���� ��� ��������� ������������;
//
// Revision 1.31  2004/04/20 11:03:48  law
// - bug fix: ����������� ����� ���������� ������ ���� Caption �� ��������, � �� �� Action �.�. ������, ��� �� ��� ��������� (��. ������ ����).
//
// Revision 1.30  2004/04/19 15:43:37  mmorozov
// new behaviour: ������������� ������ ���� ���� ���������� TvcmAction._Strings;
//
// Revision 1.29  2004/04/09 12:25:23  law
// - new behavior: ��������� �������� �� TvcmMenuItemActionLink.
//
// Revision 1.28  2004/03/29 12:19:58  law
// - new behavior: �� ���������� ShortCut'� � ���������� ���� ������ � � ������������� ����������� �������.
//
// Revision 1.27  2004/02/13 15:21:43  law
// - bug fix: ������ ��������� ������������ Check � �������������� ����.
//
// Revision 1.26  2004/02/13 14:04:18  law
// - new behavior: �������� ���� vcm_otCombo ����� �������� � ����.
//
// Revision 1.25  2004/02/13 08:58:02  law
// - bug fix: AV ��� ������ Popup-����.
// - extract method: _vcmMakeComboMenu.
//
// Revision 1.24  2004/01/21 17:13:25  law
// - new behavior: "cyberz (16.01.2004): ���������, ���� � ������ �������� ����, �� �������� (�������������) ��� ��������� - �� ���������� � ��� �����.
// ������: ������� "������" � "��������" � ��" (CQ OIT5-5913).
//
// Revision 1.23  2004/01/15 13:43:33  law
// - new const: _vcm_otShortCut - ��������, ������� ������ �������� � ���� ������ ��� ShortCut'�.
//
// Revision 1.22  2003/12/26 16:51:20  law
// - new behavior: ���������� ������ ��������� BottonCombo - ������ ���� ���� ����, �� � ������� ���� ����.
// - bug fix: ������ ��� �������������� �� ������� �������� Caption �������� ����.
//
// Revision 1.21  2003/11/18 17:59:45  law
// - new behavior: � ��������� _vcm_eopNode �������� ��������� ���� ������.
//
// Revision 1.20  2003/11/17 15:27:59  law
// - new behavior: ������ ������������� ���� � ������, ��� ������� ���������� _SubNodes (������� ���� �� ��������).
//
// Revision 1.19  2003/11/04 16:10:43  law
// - new behavior: ������ ������������ ����, � �������������� ���������� ���������� �� ���������.
//
// Revision 1.18  2003/10/29 09:11:50  law
// - new behavior: �� ��������� _GroupID ��� ���������� ������������ ����.
//
// Revision 1.17  2003/10/28 12:58:16  law
// - new behavior: ��� ������������ ���� ��������� _GroupID ��������.
//
// Revision 1.16  2003/10/28 09:57:50  law
// - new behavior: ������ ��������� ���� �������� �� ������ MainMenuItems.
//
// Revision 1.15  2003/10/28 08:26:42  law
// - new proc: ������� ��������� vcmAddItem ��� ����������� ������� ������� ���������� ������� ����.
//
// Revision 1.14  2003/10/27 10:09:42  demon
// - bug fix: ����������� ����������� ���� ��� ���������.
//
// Revision 1.13  2003/10/27 09:57:27  law
// - bug fix: �������� ��� ����������� ��������� �������� � ������.
//
// Revision 1.12  2003/10/24 09:22:08  law
// - new prop: TvcmOperationsCollectionItem._Category.
//
// Revision 1.11  2003/09/02 16:12:26  law
// - new const: vcm_otButtonCombo.
//
// Revision 1.10  2003/07/29 13:19:59  law
// - bug fix: ��������� _ExcludeUserTypes � ���������� ����.
//
// Revision 1.9  2003/07/07 18:03:41  demon
// - new behavior: ���� ����������� ������� ���� ����������� �������� AutoLineReduction := maAutomatic, �� ��� ������������ ���� ��� �� �������� �������� � �������������� ��������������� �������.
//
// Revision 1.8  2003/06/03 13:43:57  nikitin75
// - bug fix: �������� �������� ����� ������������ ����� ����.
//
// Revision 1.7  2003/04/22 14:03:01  law
// - new behavior: ������� ��������� ��������, ��������� �� �������� �����.
//
// Revision 1.6  2003/04/09 08:57:35  law
// - ���������������� � ComboBox � Toolbar'�.
//
// Revision 1.5  2003/04/08 12:34:47  law
// - new prop: IvcmOperationDef.Options.
// - new prop: TvcmOperationsCollectionItem.Options.
//
// Revision 1.4  2003/04/08 10:33:10  law
// - bug fix: ������� Interna �������� ����� �� ������ ����.
//
// Revision 1.3  2003/04/03 11:17:57  law
// - bug fix: ������������� ������ ����.
//
// Revision 1.2  2003/04/02 13:50:31  law
// - new const: vcm_otInternal.
//
// Revision 1.1  2003/04/01 12:54:49  law
// - ��������������� MVC � VCM.
//
// Revision 1.17  2003/03/27 14:36:54  law
// - new prop: �������� ������ ����� ��������.
//
// Revision 1.16  2003/03/26 14:58:06  law
// - change: ��������� ActionList �� ��������� ��� ���� ����������.
//
// Revision 1.15  2003/03/26 13:18:42  law
// - new behavior: �������� ������ ��� ��������� Action'�� ��� �������� ������ � ��������.
//
// Revision 1.14  2003/03/20 16:42:58  law
// - change: ���� �������� ����� Name ��������� �������� Caption.
//
// Revision 1.13  2003/03/20 16:03:54  law
// - new behavior: ����� �� TvcmModuleAction ���������������� ������ �� ��������� ������.
//
// Revision 1.12  2003/03/20 12:55:49  law
// - bug fix: ������ ������������ TAction ��� ����������� ����.
//
// Revision 1.11  2003/03/19 17:11:16  law
// - new behavior: �������� ������������ ���� ����������� ������ � �������� ���� ������������ ��������, ��� ������� ���� �������.
//
// Revision 1.10  2003/03/19 16:31:52  law
// - new behavior: ������� ����� ���������������� ������ ������������ ����.
//
// Revision 1.9  2003/03/19 12:46:45  law
// - new behavior: ����� ���������������� ��������� TvcmCustomMemoryManager.
//
// Revision 1.8  2003/03/17 12:24:51  law
// - new behavior: � ������� ����������� ������� �������������� ������ ������������ ����.
//
// Revision 1.7  2003/03/14 12:20:54  law
// - change: ���������� vcm �� l3.
//
// Revision 1.6  2003/03/06 15:15:56  law
// - new behavior: ������� ���������� ���� ��� ���� ���������.
//
// Revision 1.5  2003/02/27 10:55:12  law
// - new unit: vcmEntityAction.
//
// Revision 1.4  2003/02/27 10:06:09  law
// - change: ������ � �������� �������� �������������.
//
// Revision 1.3  2003/02/27 09:51:45  law
// - new behavior: ������� ���������� �������� �������� � ����.
//
// Revision 1.2  2003/02/27 09:00:03  law
// - cleanup.
//
// Revision 1.1  2003/02/25 17:59:46  law
// - new behavior: ����� ������ ������� ��� ���������� �������� ������.
//

{$Include vcmDefine.inc }

interface

uses
  Classes,
  ImgList,
  ActnList,
  Menus,
  Forms,
  Graphics,
  Types,

  Windows,
  Messages,

  l3Base,
  l3Defaults,

  vcmExternalInterfaces,
  vcmUserControls,
  vcmInterfaces,
  vcmAction,
  vcmMenuItemActionLink,

  //vcmToolbar,

  vcmChromeLikeTypes
  ;

type
  TvcmItemCondition = (vcm_icAll,
                       vcm_icSameAsParent,
                       //vcm_icNotSameAsParent,
                       vcm_icNotFound,
                       vcm_icExternal);
    {-}
  TvcmItemExternalCondition = function(const anEntityDef: IvcmEntityDef): IvcmEntity of object;
    {-}
function vcmAddModuleItem(aParent          : TMenuItem;
                          const aModuleDef : IvcmModuleDef): TMenuItem;
  {* - ��������� ����� ���� ��� ������. }
function vcmAddModuleOperationItem(aParent          : TMenuItem;
                                   const aModuleDef : IvcmModuleDef;
                                   const anOpDef    : IvcmOperationDef;
                                   const anOptions  : TvcmOperationOptions): TMenuItem;
  {* - ��������� ����� ���� ��� �������� ������. }
function vcmAddEntityOperationItem(aParent           : TMenuItem;
                                   const anEntityDef : IvcmEntityDef;
                                   const anOpDef     : IvcmOperationDef;
                                   const anOptions   : TvcmOperationOptions): TMenuItem;
  overload;
  {* - ��������� ����� ���� ��� �������� ��������. }
function vcmAddEntityOperationItem(aParent           : TMenuItem;
                                   const anEntityDef : IvcmEntityDef;
                                   const anEntity    : IvcmEntity;
                                   const anOpDef     : IvcmOperationDef;
                                   const anOptions   : TvcmOperationOptions): TMenuItem;
  overload;
  {* - ��������� ����� ���� ��� �������� ��������. }
function vcmAddEntityItem(aParent           : TMenuItem;
                          const anEntityDef : IvcmEntityDef): TMenuItem;
  {* - ��������� ����� ���� ��� ��������. }
function vcmGetMainMenu(aForm: TCustomForm): TMenuItem;
  {* - ���� �������� ����, ���� ��� ����, �� ������. }
procedure vcmMakeEntitiesMenus(aParent                     : TMenuItem;
                               const anEntitiesDefIterator : IvcmEntitiesDefIterator;
                               const anOptions             : TvcmOperationOptions;
                               ForContext                  : Boolean = false;
                               anItemCondition             : TvcmItemCondition = vcm_icAll;
                               anOther                     : TMenuItem = nil;
                               anExtenal                   : TvcmItemExternalCondition = nil);
  {* - ������ ���� ��� ���������. }
function vcmMakeModuleMenu(aParent          : TMenuItem;
                           const aModuleDef : IvcmModuleDef;
                           anOptions  : TvcmOperationOptions;
                           aAddModuleItem   : Boolean): TMenuItem;
  {* - ������ ���� ��� ������. }
function  vcmGetActionList: TCustomActionList;
  {-}
function  vcmGetMenuImages: TCustomImageList;
  {-}
procedure vcmSetActionList(aValue: TCustomActionList);
  {-}
function  vcmAddCategoryItem(aParent         : TMenuItem;
                             const aCategory : String): TMenuItem;
  {-}

type
  _l3Unknown_Parent_ = TMenuItem;
  {$Define _UnknownIsBaseComponent}
  {$Include l3Unknown.imp.pas}
  TvcmMenuItem = class(_l3Unknown_)
    private
    // internal fields
      f_GroupID : Integer;
    protected
    // internal methods
      function GetActionLinkClass: TMenuActionLinkClass;
        override;
        {-}
      procedure MenuChanged(Rebuild: Boolean);
        override;
        {-}
      procedure Click;
        override;
        {-}
      procedure BeforeClick;
        virtual;
        {-}
    public
    // public methods
      constructor Create(anOwner : TComponent);
        override;
        {-}
      class function Make(anOwner   : TComponent;
                          const anOT : TvcmOperationType): TvcmMenuItem;
        overload;
        {-}
      class function Make(anOwner   : TComponent;
                          const aModuleOrEntity : IvcmUserFriendlyControl;
                          const anOp : IvcmUserFriendlyControl): TvcmMenuItem;
        overload;
        {-}
      procedure InitiateAction;
        override;
        {-}
    public
    // public properties
      property GroupID: Integer
        read f_GroupID;
        {-}
  end;//TvcmMenuItem
  RvcmMenuItem = class of TvcmMenuItem;

  TvcmComboMenuItemActionLink = class(TvcmMenuItemActionLink)
    private
    // fields
      f_CurrentItem: TMenuItem;
       // - ������� ��������� ����� ����;
    private
    // property methods
      procedure pm_SetCurrentItem(const aCaption: String);
        {* - ������������� ������� �������. }
    protected
    // internal methods
      // IvcmActionLink
      procedure ParamsChanged(const anAction: IvcmAction);
        override;
        {-}
      function ExecuteInheritedIfEmpty: Boolean;
        virtual;
        {-}
      procedure Cleanup;
        override;
        {-}
    protected
    // properties
      property CurrentItem: String
        write pm_SetCurrentItem;
        {-}
    public
    // public methods
      function Execute(AComponent: TComponent = nil): Boolean;
        override;
        {-}
  end;//TvcmComboMenuItemActionLink

  TvcmComboMenuItem = class(TvcmMenuItem)
    private
    // internal fields
      f_Inited : Boolean;
    private
    // property methods
      procedure SetCurrentItem(aValue : Integer);
    protected
    // internal methods
      function GetActionLinkClass: TMenuActionLinkClass;
        override;
        {-}
    public
    // public property
      property CurrentItem : Integer
        write SetCurrentItem;
  end;//TvcmComboMenuItem

  TvcmComboMenuButtonItemActionLink = class(TvcmComboMenuItemActionLink)
    protected
    // internal methods
      function ExecuteInheritedIfEmpty: Boolean;
        override;
        {-}
  end;//TvcmComboMenuItemActionLink

  TvcmComboButtonMenuItem = class(TvcmComboMenuItem)
    protected
    // internal methods
      function GetActionLinkClass: TMenuActionLinkClass;
        override;
        {-}
  end;//TvcmComboMenuItem

  TvcmCustomComboMenuItemChildItemActionLink = class(TvcmMenuItemActionLink)
    protected
    // internal methods
      procedure CheckComponentCaptionOnExecute(aComponent: TComponent = nil);
        virtual;
        {-}
    public
    // public methods
      function Execute(AComponent: TComponent = nil): Boolean;
        override;
        {-}
  end;//TvcmCustomComboMenuItemChildItemActionLink

  TvcmComboMenuItemChildItemActionLink = class(TvcmCustomComboMenuItemChildItemActionLink)
    protected
    // internal methods
      procedure CheckComponentCaptionOnExecute(aComponent: TComponent = nil);
        override;
        {-}
  end;//TvcmComboMenuItemChildItemActionLink

  TvcmComboMenuItemChildPopupItemActionLink = class(TvcmCustomComboMenuItemChildItemActionLink)
  end;//TvcmComboMenuItemChildItemActionLink

  TvcmDateMenuItemActionLink = class(TvcmMenuItemActionLink)
    public
    // public methods
      function Execute(AComponent: TComponent = nil): Boolean;
        override;
        {-}
  end;//TvcmDateMenuItemActionLink

  TvcmComboMenuItemChildItem = class(TvcmMenuItem)
    protected
    // internal methods
      function GetActionLinkClass: TMenuActionLinkClass;
        override;
        {-}
  end;//TvcmComboMenuItemChildItem

  TvcmComboMenuItemChildPopupItem = class(TvcmMenuItem)
    protected
    // internal methods
      function GetActionLinkClass: TMenuActionLinkClass;
        override;
        {-}
  end;//TvcmComboMenuItemChildPopupItem

  TvcmDateMenuItem = class(TvcmMenuItem)
    protected
    // protected methods
      function GetActionLinkClass: TMenuActionLinkClass;
        override;
        {-}
    public
    // public methods
      procedure Click;
        override;
        {-}
  end;//TvcmDateMenuItem

  TvcmNodeMenuItemActionLink = class(TvcmMenuItemActionLink)
    protected
    // internal methods
      procedure ParamsChanged(const anAction: IvcmAction);
        override;
        {-}
      procedure SetCaption(const Value: string);
        override;
        {-}
  end;//TvcmNodeMenuItemActionLink

  TvcmNodeMenuItem = class(TvcmMenuItem)
    private
    // internal fields
      f_Node     : IvcmNode;
      f_NodeText : Tl3String;
    protected
    // internal methods
      function GetActionLinkClass: TMenuActionLinkClass;
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      class function Make(anOwner     : TComponent;
                          const aNode : IvcmNode): TvcmNodeMenuItem;
        reintroduce;
        {-}
      function QueryInterface(const IID : TGUID; out Obj): HResult;
        override;
        {-}
  end;//TvcmNodeMenuItem

procedure vcmMakeComboMenu(anAction   : TvcmAction;
                           aParent    : TMenuItem;
                           aNeedRadio : Boolean = false;
                           aItemClass : RvcmMenuItem = nil);
  {-}
function vcmMenuItemClassByOpType(const anOpType: TvcmOperationType): RvcmMenuItem;
  {* - ���������� ���������� �������� ���� �� ���� ��������. }

implementation

uses
  SysUtils,
  StrUtils,

  Controls,

  l3Interfaces,
  l3String,
  l3TreeInterfaces,
  l3Interlocked,

  afwFacade,

  vcmBase,
  vcmOperationAction,
  vcmEntityAction,
  vcmModuleAction,

  vcmBaseMenuManager,
  vcmMenuManager,

  vcmForm,
  vcmEntityForm,

  vcmUtils,
  vcmInternalConst,
  vcmPopupMenuPrim
  ;

{$Include l3Unknown.imp.pas}  

const vcm_MenuComboOperations = [vcm_otCombo, vcm_otMenuButtonCombo, vcm_otButtonPopup];  

// start class TvcmMenuItem

constructor TvcmMenuItem.Create(anOwner: TComponent);
  //override;
  {-}
begin
 inherited Create(anOwner);
 AutoLineReduction := maAutomatic;
 AutoHotkeys := maManual;
end;

class function TvcmMenuItem.Make(anOwner   : TComponent;
                                 const anOT : TvcmOperationType): TvcmMenuItem;
  //overload;
  {-}
begin
 if anOT = vcm_otMenuButtonCombo then
  Result := TvcmComboButtonMenuItem.Create(anOwner)
 else
 if (anOT in vcm_MenuComboOperations) then
  Result := TvcmComboMenuItem.Create(anOwner)
 else
 if (anOT = vcm_otDate) then
  Result := TvcmDateMenuItem.Create(anOwner)
 else
  Result := Create(anOwner);
end;

class function TvcmMenuItem.Make(anOwner   : TComponent;
                                 const aModuleOrEntity : IvcmUserFriendlyControl;
                                 const anOp : IvcmUserFriendlyControl): TvcmMenuItem;
  {-}
var
 l_Op : IvcmOperationDef;
begin
 if Supports(anOp, IvcmOperationDef, l_Op) then
  try
   Result := Make(anOwner, l_Op.OperationType);
   Result.f_GroupID := l_Op.GroupID;
  finally
   l_Op := nil;
  end//try..finally
 else
  Result := Create(anOwner);
 try
  if (anOp <> nil) then
  begin
   if (aModuleOrEntity <> nil) then
    Result.Name := aModuleOrEntity.Name + '_' + anOp.Name
   else
    Result.Name := anOp.Name;
  end//anOp <> nil
  else
  if (aModuleOrEntity <> nil) then
   Result.Name := aModuleOrEntity.Name;
 except
  on EComponentError do
  begin
   FreeAndNil(Result);
  end; 
 end;//try..finally
end;

//procedure vcmUpdateCaptionMenuItemInfo(const aItem  : TMenuItem;
//                                       const aValue : String);
//  {-}
//var
// l_Info : TMenuItemInfo;
//begin
// if (aItem.Visible) and Assigned(aItem.Parent) and (aItem.Handle <> 0) and
//  (aValue <> '') and (aValue <> '-') then
// begin
//  FillChar(l_Info, SizeOf(l_Info), 0);
//  with l_Info do
//  begin
//   cbSize := SizeOf(l_Info);
//   fType := MFT_STRING;
//   fMask := MIIM_TYPE;
//   dwTypeData := PAnsiChar(aValue);
//   cch := Length(aValue) + 1;
//  end;
//  if not SetMenuItemInfo(aItem.Parent.Handle,
//                         aItem.Command,
//                         False,
//                         l_Info) then
//   raise Exception.Create(SysErrorMessage(GetLastError));
// end;
//end;

procedure TvcmMenuItem.MenuChanged(Rebuild: Boolean);
  // override;
  {-}

//  procedure lpIter(const aItem : TMenuItem);
//  var
//   lIndex : Integer;
//  begin
//   vcmUpdateCaptionMenuItemInfo(aItem, aItem.Caption);
//   for lIndex := 0 to Pred(aItem.Count) do
//    lpIter(aItem.Items[lIndex]);
//  end;

begin
 inherited;
// lpIter(Self);
end;

procedure TvcmMenuItem.Click;
  // override;
  {-}
begin
 BeforeClick;
 inherited;
end;

procedure TvcmMenuItem.BeforeClick;
  // override;
  {-}
begin
 g_MenuManager.NotifyMenuItemClick(Self);
end;

function TvcmMenuItem.GetActionLinkClass: TMenuActionLinkClass;
  //override;
  {-}
begin
 Result := TvcmMenuItemActionLink;
end;

procedure TvcmMenuItem.InitiateAction;
  //override;
  {-}
var
 l_Index    : Integer;
 l_VisCount : Integer;
 {$IfDef nsDisableMenuItems}
 l_EnCount  : Integer;
 {$EndIf nsDisableMenuItems}
 l_Popup    : Boolean;
begin
 vcmDispatcher.BeginOp;
 try
  l_Popup := (GetParentMenu Is TPopupMenu);
  if (Action = nil) AND (Count > 0) AND Visible then
  begin
   {$IfNDef nsDisableMenuItems}
   if l_Popup then
   {$EndIf  nsDisableMenuItems}
   begin
    l_VisCount := 0;
    {$IfDef nsDisableMenuItems}
    l_EnCount  := 0;
    {$EndIf nsDisableMenuItems}
    l_Index := 0;
    while (l_Index < Count) do
    begin
     with Items[l_Index] do
     begin
      InitiateAction;
      if Visible then
      begin
       Inc(l_VisCount);
       {$IfDef nsDisableMenuItems}
       if Enabled AND (Caption <> '-') then
        Inc(l_EnCount);
       {$EndIf nsDisableMenuItems}
      end;//Visible
     end;//with Items[l_Index]
     Inc(l_Index);
    end;//for l_Index
    if l_Popup then
    begin
     if (l_VisCount = 0) then
      Visible := false
     else
      Visible := True;
    end;//l_Popup
   {$IfDef nsDisableMenuItems}
   if (l_EnCount = 0) then
    Enabled := false
   else
    Enabled := True;
   {$EndIf nsDisableMenuItems}
   end;//l_Popup
  end;//Count > 0
  inherited;
  // �� ���������� � ����������� ���� �� ��������� ��������. �������� �����
  // ����������� ����� inherited (Action.Update) ����� ��������� ������ ����
  // ������ ����������:
  if l_Popup and not Enabled then
   Visible := False;
 finally
  vcmDispatcher.EndOp;
 end;//try..finally
end;

// start class TvcmNodeMenuItemActionLink

procedure TvcmNodeMenuItemActionLink.ParamsChanged(const anAction: IvcmAction);
  //override;
  {-}
begin
 inherited;
 if (FClient Is TvcmNodeMenuItem) then
 begin
  with TvcmNodeMenuItem(FClient) do
  begin
   RadioItem := (Count = 0);
   Checked := (anAction.SubNodes <> nil) AND vcmIEQ(f_Node, anAction.SubNodes.Current);
  end;//with TvcmNodeMenuItem(FClient)
 end;//FClient Is TvcmNodeMenuItem
end;

procedure TvcmNodeMenuItemActionLink.SetCaption(const Value: string);
  //override;
  {-}
begin
 // - �� ������ Caption � ������ ���� - �.�. �� ������ ��������� � ������� ����.
end;

// start class TvcmNodeMenuItem

class function TvcmNodeMenuItem.Make(anOwner     : TComponent;
                                     const aNode : IvcmNode): TvcmNodeMenuItem;
  //reintroduce;
  {-}
begin
 Result := Create(anOwner);
 Result.f_Node := aNode;
 Result.f_NodeText := Tl3String.Make(aNode.Text);
end;

procedure TvcmNodeMenuItem.Cleanup;
  //override;
  {-}
begin
 l3Free(f_NodeText);
 f_Node := nil;
 inherited;
end;

function TvcmNodeMenuItem.GetActionLinkClass: TMenuActionLinkClass;
  //override;
  {-}
begin
 Result := TvcmNodeMenuItemActionLink;
end;

function TvcmNodeMenuItem.QueryInterface(const IID: TGUID; out Obj): HResult;
  //override;
  {-}
begin
 if IsEqualGUID(IID, IvcmNode) then
 begin
  Result := S_Ok;
  IvcmNode(Obj) := f_Node;
 end//IsEqualGUID(IID, IvcmNode)
 else
  Result := inherited QueryInterface(IID, Obj); 
end;  

const
  vcm_ValidMenuOperations = [vcm_otButton,
                             vcm_otShortCut,
                             vcm_otButtonCombo,
                             vcm_otMenuButtonCombo,
                             vcm_otButtonPopup,
                             vcm_otCombo,
                             vcm_otTextButton,
                             vcm_otCheck,
                             vcm_otRadio,
                             vcm_otDate];
    {-}
var
 g_InternalItem : TMenuItem = nil;
    {-}

function vcmGetActionList: TCustomActionList;
  {-}
begin
 Result := vcmAction.vcmGetActionList;
end;

function  vcmGetMenuImages: TCustomImageList;
  {-}
begin
 if (g_MenuManager = nil) OR (g_MenuManager.SmallImages = nil) then
  Result := vcmAction.vcmGetActionList.Images
 else
  Result := g_MenuManager.SmallImages; 
end;

procedure vcmSetActionList(aValue: TCustomActionList);
  {-}
begin
 vcmAction.vcmSetActionList(aValue);
end;

function vcmAddSeparator(aParent : TMenuItem;
                         anIndex : Integer = -1;
                         aChild  : TMenuItem = nil): TMenuItem;
const
 l_Cap = '-';
var
 l_Child : TMenuItem;
begin
 Result := nil;
 if (anIndex = -1) then
  anIndex := aParent.Count;
 if (anIndex = 0) then
  Exit;
 if (anIndex > aParent.Count) then
  Exit;  
 if (anIndex > 0) then
 begin
  l_Child := aParent.Items[Pred(anIndex)];
  if (l_Child.Caption = l_Cap) then
   Exit;
  if (aChild Is TvcmMenuItem) then
  begin
   if (l_Child Is TvcmMenuItem) AND
      (TvcmMenuItem(aChild).GroupID div 100 = TvcmMenuItem(l_Child).GroupID div 100) then
    // - ������ ��������� � ����� ������
    Exit;
  end;//aChild Is TvcmMenuItem
 end//anIndex > 0
 else
  l_Child := nil;
 Result := TvcmMenuItem.Create(aParent);
 if (aChild Is TvcmMenuItem) then
 begin
  if (l_Child Is TvcmMenuItem) AND
   (TvcmMenuItem(l_Child).GroupID > TvcmMenuItem(aChild).GroupID) then
  begin
   // - ��������� ����������� ����� aChild'� (����� l_Child'��).
   TvcmMenuItem(Result).f_GroupID := TvcmMenuItem(l_Child).GroupID div 100 * 100;
   Dec(anIndex);
  end//l_Child Is TvcmMenuItem..
  else
   TvcmMenuItem(Result).f_GroupID := TvcmMenuItem(aChild).GroupID div 100 * 100;
 end;//aChild Is TvcmMenuItem
 Result.Caption := l_Cap;
 aParent.Insert(anIndex, Result);
end;

procedure vcmAddItem(aParent: TMenuItem; aChild: TMenuItem);
var
 l_Index    : Integer;
 l_GroupID  : Integer;
 l_Child    : TMenuItem;
 l_CheckGID : Boolean;
begin
 l_CheckGID := not (aParent.GetParentMenu Is TPopupMenu);
 if l_CheckGID AND (aChild Is TvcmMenuItem) then
 begin
  l_GroupID := TvcmMenuItem(aChild).GroupID;
  l_Index := 0;
  while (l_Index < aParent.Count) do
  begin
   l_Child := aParent.Items[l_Index];
   if (l_Child Is TvcmMenuItem) AND
      {(TvcmMenuItem(l_Child).GroupID >= 100) AND}
      (TvcmMenuItem(l_Child).GroupID > l_GroupID) then
    break;
   Inc(l_Index);
  end;//l_Index < aParent.Count
 end else
  l_Index := aParent.Count;
 if l_CheckGID AND (aChild Is TvcmMenuItem) then
 begin
  if (TvcmMenuItem(aChild).GroupID >= 100) then
  begin
   if (vcmAddSeparator(aParent, l_Index, aChild) <> nil) then
    Inc(l_Index);
  end;//TvcmMenuItem(aChild).GroupID >= 100
 end;//aChild Is TvcmMenuItem
 aParent.Insert(l_Index, aChild);
 if l_CheckGID AND (aChild Is TvcmMenuItem) then
  vcmAddSeparator(aParent, l_Index + 2, aChild);
  // - ��������� ����������� ����� ��� �������, ������� ���������� ����
end;

function vcmAddUFItem(aParent   : TMenuItem;
                      const aUF : IvcmUserFriendlyControl): TMenuItem;
begin
 Result := TvcmMenuItem.Make(aParent, aUF, nil);
 Assert(Result <> nil);
 with aUF do
 begin
  Result.Caption := vcmStr(Caption);
  Result.Hint := vcmStr(vcmCat(vcmCat(Hint, '|'), LongHint));
 end;//with aUF
 vcmAddItem(aParent, Result);
end;

function vcmAddCategoryItem(aParent         : TMenuItem;
                            const aCategory : String): TMenuItem;
begin
 Result := TvcmMenuItem.Create(aParent);
 Result.Caption := aCategory;
 vcmAddItem(aParent, Result);
end;

function vcmAddModuleItem(aParent          : TMenuItem;
                          const aModuleDef : IvcmModuleDef): TMenuItem;
  {-}
begin
 Result := aParent.Find(vcmStr(aModuleDef.Caption));
 if (Result = nil) then
  Result := vcmAddUFItem(aParent, aModuleDef);
end;

function vcmFindCategoryItem(var aParent   : TMenuItem;
                             const anOpDef : IvcmOperationDef): Boolean;
var
 l_Item : TMenuItem;
begin
 if SameText(anOpDef.Category, aParent.Caption) then
  Result := True
 else 
 begin
  if (aParent.Parent = nil) then
   Result := false
  else
  begin
   Result := True;
   l_Item := aParent.Parent.Find(anOpDef.Category);
   if (l_Item = nil) then
    aParent := vcmAddCategoryItem(aParent.Parent, anOpDef.Category)
   else
    aParent := l_Item;
  end;//aParent.Parent = nil
 end;//String(anOpDef.Category) <> ''
end;

function vcmAddModuleOperationItem(aParent          : TMenuItem;
                                   const aModuleDef : IvcmModuleDef;
                                   const anOpDef    : IvcmOperationDef;
                                   const anOptions  : TvcmOperationOptions): TMenuItem;
  {-}
begin
 if (anOpDef = nil) then
  Result := nil
 else
 if (anOptions <> []) AND
    (not (anOpDef.OperationType in vcm_ValidMenuOperations) OR
     (anOpDef.Options * anOptions = [])) then
  Result := g_InternalItem
 else
 begin
  if not vcmFindCategoryItem(aParent, anOpDef) then
  begin
   Result := g_InternalItem;
   Exit;
  end;//not vcmFindCategoryItem
  Result := aParent.Find(vcmStr(anOpDef.Caption));
  if (Result <> nil) AND
   (Result.Action Is TvcmModuleAction) AND
   (TvcmModuleAction(Result.Action).ModuleID = aModuleDef.ID) then
   Exit;
  Result := TvcmMenuItem.Make(aParent, aModuleDef, anOpDef);
  Result.Action := TvcmModuleAction.Make(aModuleDef, anOpDef);
  vcmAddItem(aParent, Result);
 end;//anOpDef = nil
end;

function vcmAddEntityOperationItem(aParent           : TMenuItem;
                                   const anEntityDef : IvcmEntityDef;
                                   const anOpDef     : IvcmOperationDef;
                                   const anOptions   : TvcmOperationOptions): TMenuItem;
  {* - ��������� ����� ���� ��� �������� ��������. }
begin
 if (anOpDef = nil) then
  Result := nil
 else
 if not (anOpDef.OperationType in vcm_ValidMenuOperations) OR
         (anOpDef.Options * anOptions = []) then
  Result := g_InternalItem
 else
 begin
  if not vcmFindCategoryItem(aParent, anOpDef) then
  begin
   Result := g_InternalItem;
   Exit;
  end;//not vcmFindCategoryItem
  Result := aParent.Find(vcmStr(anOpDef.Caption));
  if (Result <> nil) AND
   (Result.Action Is TvcmEntityAction) AND
   (TvcmEntityAction(Result.Action).EntityID = anEntityDef.ID) then
   Exit;
  Result := TvcmMenuItem.Make(aParent, anEntityDef, anOpDef);
  if (Result = nil) then
  // - ���� ��� ��� ����� �����, �������� - "������ ��������"
  begin
   Result := g_InternalItem;
   Exit;
  end;//Result = nil
  Result.Action := TvcmEntityAction.Make(anEntityDef, anOpDef);
  // ������������� �������� MenuItem ������ �������������, ��. ����������� �
  // Revision 1.31, ������ �� ����������� ��� ������������� �������� �� �������.
  // ��� ��������� �������� ������ ��������������� Result.Caption := anOpDef.
  // Caption ������, ������ ��� � ��������� �������� Caption ����� ������,
  // �������� ��� �������� "����������� �� ��������\�����������". �� � �� ��
  // ����� ��� combo �������� ����� ������������ �������� ��������, ��.
  // ����������� � vcm_UseCaptionFromOperation:
  if anOpDef.OperationType in vcm_UseCaptionFromOperation then
   Result.Caption := vcmStr(anOpDef.Caption);
  vcmAddItem(aParent, Result);
 end;//anOpDef = nil
end;

function vcmAddEntityOperationItem(aParent           : TMenuItem;
                                   const anEntityDef : IvcmEntityDef;
                                   const anEntity    : IvcmEntity;
                                   const anOpDef     : IvcmOperationDef;
                                   const anOptions   : TvcmOperationOptions): TMenuItem;
  //overload;
  {* - ��������� ����� ���� ��� �������� ��������. }

  function lp_NeedGroupItem: Boolean;
  begin
   Result := (vcm_enoGroupItemsInContextMenu in anEntityDef.Options) and
    (vcm_ooShowInContextMenu in anOpDef.Options) and
    (aParent.Caption <> vcmStr(anEntityDef.Caption));
  end;//lp_NeedGroupItem

var
 l_Form          : TCustomForm;
 l_NeedGroupItem : Boolean;
begin
 Assert(not l3IsNil(anEntityDef.Caption));
 Result := nil;
 if (anOpDef = nil) then
  Result := nil
 else
 if not (anOpDef.OperationType in vcm_ValidMenuOperations) OR
      (anOpDef.Options * anOptions = []) then
  Result := g_InternalItem
 else
 begin
  if (aParent.GetParentMenu Is TPopupMenu) then
  begin
   l_Form := afw.GetParentForm(TPopupMenu(aParent.GetParentMenu).PopupComponent);
   if (l_Form Is TvcmEntityForm) AND
      (TvcmEntityForm(l_Form).UserType in anOpDef.ExcludeUserTypes) then
   begin
    Result := g_InternalItem;
    Exit;
   end;//l_Form Is TvcmEntityForm
   // �������� �������� ������ ���� �������� � ��������� ������
   l_NeedGroupItem := lp_NeedGroupItem;
  end//aParent.GetParentMenu Is TPopupMenu
  else
   l_NeedGroupItem := false;
  // �� ������ ������������� ��������
  if not l_NeedGroupItem then
   Result := aParent.Find(vcmStr(anOpDef.Caption));
  if l_NeedGroupItem or (Result <> nil) then
  begin
   if (Result <> nil) AND (Result.Action Is TvcmActiveEntityAction) AND
      vcmIEQ(TvcmActiveEntityAction(Result.Action).Entity, anEntity) then
    Exit
   else
   begin
    Result := vcmAddEntityOperationItem(vcmAddEntityItem(aParent, anEntityDef),
                                        anEntityDef, anEntity, anOpDef, anOptions);
    Exit;
   end;//Result.Action Is TvcmActiveEntityAction..
  end;//Result <> nil
  Result := TvcmMenuItem.Make(aParent, anEntityDef, anOpDef);
  Result.Action := TvcmActiveEntityAction.Create(Result, anEntity, anOpDef);
  vcmAddItem(aParent, Result);
 end;//anOpDef = nil
end;

function vcmAddEntityItem(aParent           : TMenuItem;
                          const anEntityDef : IvcmEntityDef): TMenuItem;
  {* - ��������� ����� ���� ��� ��������. }
begin
 if (anEntityDef = nil) then
  Result := nil
 else begin
  with anEntityDef do begin
   if vcmSame(aParent.Caption, Caption, True) then
    Result := aParent
   else
   begin
    Result := aParent.Find(vcmStr(Caption));
    if (Result = nil) then
     Result := vcmAddUFItem(aParent, anEntityDef);
   end;//SameText(aParent.Caption, Caption)
  end;//with anEntityDef
 end;//anEntityDef = nil
end;

function vcmGetMainMenu(aForm: TCustomForm): TMenuItem;
  {* - ���� �������� ����, ���� ��� ����, �� ������. }
var
 l_Menu  : TMainMenu;
 l_Index : Integer;
 l_MenuHolder: IvcmMenuHolder;
begin
 l_Menu := nil;
 with aForm do
 begin
  if (l_Menu = nil) then
   l_Menu := Menu;
  if (l_Menu = nil) then
  begin
   l_Menu := FindComponent('MainMenu') as TMainMenu;
   if (l_Menu = nil) then
   begin
    for l_Index := 0 to Pred(ComponentCount) do
     if (Components[l_Index] is TMainMenu) then
     begin
      l_Menu := TMainMenu(Components[l_Index]);
      Break;
     end;//Components[l_Index] Is TMainMenu
    if (l_Menu = nil) and Supports(aForm, IvcmMenuHolder, l_MenuHolder) then
    try
     Result := l_MenuHolder.MainMenu;
     Exit;
    finally
     l_MenuHolder := nil;
    end
    else
    if (l_Menu = nil) then
    begin
     l_Menu := TMainMenu.Create(aForm);
     l_Menu.AutoHotkeys := maManual;
     {$IfNDef DesignTimeLibrary}
     {$IfDef l3HackedVCL}
     l_Menu.DrawGraphicChecks := True;
     {$EndIf l3HackedVCL}
     {$EndIf  DesignTimeLibrary}
    end;
   end;//l_Menu = nil
  end;//l_Menu = nil
 end;//with aForm
 l_Menu.Images := vcmGetMenuImages;
 Result := l_Menu.Items;
end;

procedure vcmMakeEntitiesMenus(aParent                     : TMenuItem;
                               const anEntitiesDefIterator : IvcmEntitiesDefIterator;
                               const anOptions             : TvcmOperationOptions;
                               ForContext                  : Boolean = false;
                               anItemCondition             : TvcmItemCondition = vcm_icAll;
                               anOther                     : TMenuItem = nil;
                               anExtenal                   : TvcmItemExternalCondition = nil);
  {* - ������ ���� ��� ���������. }
var
 l_EntityDef     : IvcmEntityDef;
 l_EntityItem    : TMenuItem;
 l_OpDefIterator : IvcmOperationsDefIterator;
 l_NeedBreak     : Boolean;
 l_Entity        : IvcmEntity;
begin
 if (anEntitiesDefIterator <> nil) then begin
  l_NeedBreak := false;
  while True do begin
   l_EntityDef := anEntitiesDefIterator.Next;
   if (l_EntityDef = nil) then
    break;
   Case anItemCondition of
    vcm_icSameAsParent:
     if not vcmSame(aParent.Caption, l_EntityDef.Caption, True) then
      continue;
(*    vcm_icNotSameAsParent:
     if vcmSame(aParent.Caption, l_EntityDef.Caption, True) then
      continue;*)
    vcm_icNotFound:
     if (anOther <> nil) AND (anOther.Find(vcmStr(l_EntityDef.Caption)) <> nil) then
      continue;
    vcm_icExternal:
     if not Assigned(anExtenal) then
      l_Entity := nil
     else
     begin
      l_Entity := anExtenal(l_EntityDef);
      if (l_Entity = nil) then
       continue;
     end;//not Assigned(anExtenal)
   end;//Case anItemCondition
   l_OpDefIterator := l_EntityDef.OperationsDefIterator;
   if (l_OpDefIterator <> nil) then
   begin
    if l_NeedBreak then
    begin
     vcmAddSeparator(aParent);
     l_NeedBreak := false;
    end;//l_NeedBreak
    if ForContext then
     l_EntityItem := aParent
    else
     l_EntityItem := vcmAddEntityItem(aParent, l_EntityDef);
    while True do begin
     if (l_Entity <> nil) then begin
      if (vcmAddEntityOperationItem(l_EntityItem, l_EntityDef, l_Entity, l_OpDefIterator.Next, anOptions) = nil) then
       break;
     end else begin
      if (vcmAddEntityOperationItem(l_EntityItem, l_EntityDef, l_OpDefIterator.Next, anOptions) = nil) then
       break;
     end;//l_Entity <> nil
     l_NeedBreak := (l_EntityItem = aParent);
    end;//while True
(*    if (l_EntityItem <> nil) AND (l_EntityItem <> aParent) AND
       (l_EntityItem.Count <= 0) then
     FreeAndNil(l_EntityItem);*)
   end;//l_OpDefIterator <> nil
  end;//while True
 end;//anEntitiesDefIterator <> nil
end;

function vcmMakeModuleMenu(aParent          : TMenuItem;
                           const aModuleDef : IvcmModuleDef;
                           anOptions  : TvcmOperationOptions;
                           aAddModuleItem   : Boolean): TMenuItem;
  {* - ������ ���� ��� ������. }
var
 l_OpDefIterator : IvcmOperationsDefIterator;
begin
 if aAddModuleItem then
  Result := vcmAddModuleItem(aParent, aModuleDef)
 else
  Result := aParent;      
 l_OpDefIterator := aModuleDef.OperationsDefIterator;
 if (l_OpDefIterator <> nil) then
  while True do
   if (vcmAddModuleOperationItem(Result, aModuleDef, l_OpDefIterator.Next, anOptions) = nil) then
    break;
end;

function vcmMenuItemClassByOpType(const anOpType: TvcmOperationType): RvcmMenuItem;
  {* - ���������� ���������� �������� ���� �� ���� ��������. }
begin
 if (anOpType = vcm_otButtonPopup) then
  Result := TvcmComboMenuItemChildPopupItem
 else
  Result := TvcmComboMenuItemChildItem;
end;//vcmMenuItemClassByOpType

procedure vcmMakeComboMenu(anAction   : TvcmAction;
                           aParent    : TMenuItem;
                           aNeedRadio : Boolean = false;
                           aItemClass : RvcmMenuItem = nil);
  {-}
var
 l_Tag        : Integer;
 l_PlainLevel : Integer;

 function AddSubItems(anItem      : TMenuItem;
                      const aNode : IvcmNode;
                      anAddThis   : Boolean;
                      anInsertAfter : Boolean): TMenuItem;

  function l_AddItems(anItem      : TMenuItem;
                       const aNode : IvcmNode;
                       anAddThis   : Boolean;
                       aLevel      : Integer;
                       anInsertAfter : Boolean): TMenuItem;
  var
   l_Item    : TMenuItem;
   l_Child   : IvcmNode;
  begin//l_AddItems
   if anAddThis then
   begin
    if anInsertAfter then
     l_Item := TvcmNodeMenuItem.Make(anItem.Parent, aNode)
    else
     l_Item := TvcmNodeMenuItem.Make(anItem, aNode);
    l_Item.Tag := l_Tag;
    if anInsertAfter then
     anItem.Parent.Insert(anItem.Parent.IndexOf(anItem) + 1, l_Item)
    else
     anItem.Add(l_Item);
   end//anAddThis
   else
    l_Item := anItem;
   Result := l_Item; 
   if aNode.HasChild then
   begin
    l_Child := aNode.Child;
    while (l_Child <> nil) do
    begin
     if (aLevel >= l_PlainLevel) then
      l_AddItems(anItem, l_Child, True, Succ(aLevel), false)
     else
      l_AddItems(l_Item, l_Child, True, Succ(aLevel), false);
     if l_Child.IsLast then
      l_Child := nil
     else
      l_Child := l_Child.Next;
    end;//while True
   end;//aNode.HasChild
   if anAddThis then
   begin
    if (l_Item.Count = 0) then
    begin
     l_Item.Action := anAction;
     l_Item.RadioItem := aNeedRadio;
    end;//l_Item.Count = 0
    if (aLevel > l_PlainLevel) then
     l_Item.Caption := ev_psFixLen('', (aLevel - l_PlainLevel) * 2, ' ') + l3PCharLen2String(aNode.Text)
    else
     l_Item.Caption := l3PCharLen2String(aNode.Text);
    if (l_Item.Action <> nil) then
    begin
     l_Item.ShortCut := 0;
     // - ������� ShortCut - ����� �� ����������� � ���������� ����
     l_Item.ImageIndex := -1;
    end;//l_Item.Action <> nil
   end;//anAddThis
  end;//l_AddItems

 begin//AddSubItems
  if (aNode = nil) then
   Result := nil
  else 
   Result := l_AddItems(anItem, aNode, anAddThis, 0, anInsertAfter);
 end;//AddSubItems

var
 l_SubNodes  : IvcmNodes;
 l_WasAction : Boolean;

 procedure MakeItem(const aCaption : IvcmCString;
                    const anOp     : TvcmOpSelector;
                    anIndex        : Integer);
 var
  l_Item : TvcmMenuItem;
  l_Node : IvcmNode;
 begin//MakeItem
  if (anOp.rKind = vcm_okNone) then
   l_Tag := Succ(anIndex)
  else
  begin
   l_WasAction := true;
   l_Tag := 0;
  end;//anOp.rKind = vcm_okNone
  if (aItemClass = nil) then
   l_Item := TvcmMenuItem.Make(aParent, nil, g_MenuManager.OpDefBySelector(anOp))
  else
   l_Item := aItemClass.Create(aParent);
  l_Item.Tag := l_Tag;
  aParent.Add(l_Item);
  if (l_SubNodes <> nil) AND (anIndex < l_SubNodes.Count) then
   l_Node := l_SubNodes[anIndex]
  else
   l_Node := nil;
  try
   if (AddSubItems(l_Item, l_Node, false, false) = nil) then
   begin
    // - ����������� Action ������ ���� �� ���� �������� ���������
    l_Item.Action := g_MenuManager.BuildAction(anOp, anAction);
    l_Item.RadioItem := aNeedRadio;
   end;//AddSubItems = nil
  finally
   l_Node := nil;
  end;//try..finally
  if not vcmIsNil(aCaption) then
   l_Item.Caption := vcmStr(aCaption);
  if (l_Item.Action = anAction) then
  begin
   l_Item.ShortCut := 0;
   // - ������� ShortCut - ����� �� ����������� � ���������� ����
   l_Item.ImageIndex := -1;
  end;//l_Item.Action = anAction
  //Assert(l_Item.Action <> nil);
  // - �� ����� ���� ������ ������ ���� �� �����
  // - �٨ ��� �����:
  // http://mdp.garant.ru/pages/viewpage.action?pageId=288787808&focusedCommentId=288787833#comment-288787833
(*  {$IfDef Nemesis}
  if (l_Item <> nil) AND
     ((l_Item.Action = nil) {OR (l_Item.Action = anAction)}) then
   // �������� ��� http://mdp.garant.ru/pages/viewpage.action?pageId=272668827
   // ��� �� ���, �� ������� ����������� �� � ���� �� ����.
   // (+) http://mdp.garant.ru/pages/viewpage.action?pageId=272668827&focusedCommentId=276546490#comment-276546490
   l_Item.SubMenuImages := vcmGetMenuImages;
  // ��� - ������ ��� � Borland �� ����� ���� - ����� ������ ������
  // SubMenuImages ��� �����, � ��� ���� - �����.
  // ������ ���� TAction ��������� ������. ��� ���������, �� ����.
  // ��� ��� �����������.
  {$EndIf Nemesis}*)
 end;//MakeItem

 procedure MakeItemE;
 var
  l_Node : IvcmNode;
  l_Index : Integer;
  l_AddThis : Boolean;
  l_Parent : TMenuItem;
 begin//MakeItemE
  if (l_SubNodes <> nil) AND (l_SubNodes.Count >= 1) then
  begin
   l_AddThis := (l_SubNodes.Count > 1);
   // http://mdp.garant.ru/pages/viewpage.action?pageId=273590436
   if l_AddThis then
   begin
    l_Parent := aParent;
    for l_Index := 0 to Pred(l_SubNodes.Count) do
    begin
     l_Node := l_SubNodes[l_Index];
     l_Tag := 0;
     l_Parent := AddSubItems(l_Parent, l_Node, l_AddThis, l_AddThis);
    end;//l_Index := 0
   end//l_AddThis
   else
    for l_Index := 0 to Pred(l_SubNodes.Count) do
    begin
     l_Node := l_SubNodes[l_Index];
     l_Tag := 0;
     AddSubItems(aParent, l_Node, l_AddThis, l_AddThis);
    end;//l_Index := 0
  end;//l_SubNodes <> nil
 end;//MakeItemE

var
 l_Index   : Integer;
 l_Strings : IvcmItems;
 l_Action  : IvcmAction;
begin
 g_Dispatcher.LockActionUpdate;
 try
  if Supports(anAction, IvcmAction, l_Action) then
  try
   l_Strings := l_Action.SubItems;
   l_SubNodes := l_Action.SubNodes;
   if (l_SubNodes = nil) then
    l_PlainLevel := High(l_PlainLevel)
   else
    l_PlainLevel := l_SubNodes.PlainLevel;
   if (l_Strings = nil) OR (l_Strings.Count = 0) then
    MakeItemE
   else
   begin
    l_WasAction := false;
    for l_Index := 0 to Pred(l_Strings.Count) do
     MakeItem(l_Strings[l_Index], l_Strings.Op[l_Index], l_Index);
    {$IfDef Nemesis}
     if not l_WasAction then
     // �������� ��� http://mdp.garant.ru/pages/viewpage.action?pageId=272668827
     // ��� �� ���, �� ������� ����������� �� � ���� �� ����.
     // (+) http://mdp.garant.ru/pages/viewpage.action?pageId=272668827&focusedCommentId=276546490#comment-276546490
      if (aParent <> nil)
         {and (l_Strings.Items[0] <> '') }
         // - ��� �������� �� �������� ���� �������
       then
       aParent.SubMenuImages := vcmGetMenuImages;
       // ��� � Borland �� ����� ���� - ����� ������ ������
       // SubMenuImages ��� �����, � ��� ���� - �����.
       // ������ ���� TAction �������� ������. ��� ���������, �� ����.
       // ��� ��� �����������.
    {$EndIf Nemesis}
   end;
  finally
   l_Action := nil;
  end;//try..finally
 finally
  g_Dispatcher.UnlockActionUpdate;
 end;//try..finally
end;//vcmMakeComboMenu

// start class TvcmComboMenuItem

procedure TvcmComboMenuItemActionLink.ParamsChanged(const anAction: IvcmAction);
  //override;
  {-}

  function IsItemsChange(aMenu          : TMenuItem;
                         const aStrings : IvcmItems) : Boolean;

   var
    l_PlainLevel : Integer;

   function lIsChangeSubNodes(aMenu          : TMenuItem;
                              const aNode    : Il3SimpleNode;
                              var aStartWith : Integer;
                              aLevel         : Integer) : Boolean;
   var
    l_SubIndex : Integer;
    l_Node     : Il3SimpleNode;
   begin//lIsChangeSubNodes
    Result := false;
    l_Node := aNode.Child;
    while (l_Node <> nil) and (aStartWith < aMenu.Count) do
    begin
     if not l_Node.IsSame(TvcmNodeMenuItem(aMenu[aStartWith]).f_Node) or
      (not l3Same(TvcmNodeMenuItem(aMenu[aStartWith]).f_NodeText.AsWStr, TvcmNodeMenuItem(aMenu[aStartWith]).f_Node.Text)) then
     begin
      Result := True;
      break;
     end;//not l_Node.IsSame(TvcmNodeMenuItem(aMenu[aStartWith]).f_Node)
     if (aLevel >= l_PlainLevel - 1) then
     begin
      inc(aStartWith);
      Result := lIsChangeSubNodes(aMenu, l_Node, aStartWith, aLevel + 1);
      if Result then
       break;
     end//aLevel >= l_PlainLevel - 1
     else
     begin
      l_SubIndex := 0;
      Result := lIsChangeSubNodes(aMenu[aStartWith], l_Node, l_SubIndex, aLevel + 1);
      inc(aStartWith);
      if Result then
       break;
     end;//aLevel >= l_PlainLevel - 1
     if l_Node.IsLast then
      break;
     if (aStartWith < aMenu.Count) then
      l_Node := l_Node.Next;
    end;//while (l_Node <> nil)
     // ��������
     // ����� ���������:
     //  1) �� �������� ������ SubNode (l_Node.IsLast)
     //  2) SubNode �� ��������� ������ ������� (����� ����� ������
     //     ��� aLevel <= l_PlainLevel (������ ������ �����!)
     if not Result and ((Assigned(l_Node) and not l_Node.IsLast) or
      ((aLevel <= l_PlainLevel) and (aStartWith <> aMenu.Count))) then
        Result := True;
   end;//lIsChangeSubNodes

  var
   lIndex : Integer;
   lStr   : String;
  begin//IsItemsChange
   if (aStrings = nil) OR (aStrings.Count = 0) then
   // - ���� ������� �� SubNodes - � ���� � ���� ����������
   begin
    if (anAction.SubNodes <> nil) AND (anAction.SubNodes.Count > 1) then
    // http://mdp.garant.ru/pages/viewpage.action?pageId=273590436
     Result := false
    else
     Result := ((aMenu.Count > 0) and ((anAction.SubNodes = nil) or (anAction.SubNodes.Count = 0))) or
              ((aMenu.Count = 0) and ((anAction.SubNodes <> nil) and (anAction.SubNodes.Count > 0)));
    if not Result and
       (anAction.SubNodes <> nil) and (anAction.SubNodes.Count > 0) then
    begin
     lIndex := 0;
     l_PlainLevel := anAction.SubNodes.PlainLevel;
     if (anAction.SubNodes.Count > 1) then
     // http://mdp.garant.ru/pages/viewpage.action?pageId=273590436
      Result := false
     else
      Result := lIsChangeSubNodes(aMenu, anAction.SubNodes[0], lIndex, 0);
    end;//not Result
   end//aStrings = nil
   else
   begin
   // - ���� ������� �� ����� - � ���� � ���� ����������
    Result := not (aMenu.Count = aStrings.Count);
    if not Result then
     for lIndex := 0 to Pred(aMenu.Count) do
     begin
      if (aStrings.Op[lIndex].rKind = vcm_okNone) then
      begin
       lStr := AnsiReplaceStr(aMenu.Items[lIndex].Caption, '&', '');
       // - ������� ������ ��� �����������
       if not vcmSame(lStr, aStrings[lIndex]) then
       begin
        Result := True;
        Break;
       end;//AnsiCompareStr
      end;//aStrings.Op[lIndex].rKind = vcm_okNone
     end;//for lIndex
   end;//aStrings.Count = 0
  end;//IsItemsChange

  function lp_OperationType: TvcmOperationType;
  begin
   Result := TvcmOperationAction(Action).OpDef.OperationType;
  end;//lp_OperationType

begin
 inherited;
 //if not vcmDispatcher.InOp then
 begin
  if (FClient Is TvcmComboMenuItem) AND
    (Action Is TvcmOperationAction) AND
    (lp_OperationType in vcm_MenuComboOperations) then
  begin
   // Items
   if not TvcmComboMenuItem(FClient).f_Inited or anAction.IsStringsChanged or
      IsItemsChange(FClient, anAction.SubItems) then
   begin
    // �������� �������� ����� �������� �����
    anAction.SaveStrings;
    // �������� ����� ������ ����
    TvcmComboMenuItem(FClient).Clear;
    if anAction.HasInfoForCombo then
    begin
     TvcmComboMenuItem(FClient).f_Inited := True;
     vcmMakeComboMenu(TvcmAction(Action),
                      TvcmComboMenuItem(FClient),
                      lp_OperationType <> vcm_otButtonPopup,
                      vcmMenuItemClassByOpType(lp_OperationType));
    end;//anAction.HasInfoForCombo
   end;//not TvcmComboMenuItem(FClient).f_Inited
   // ������� ��� ��������� �������� ��������
   CurrentItem := vcmStr(anAction.SelectedString);
  end;//FClient Is TvcmComboMenuItem
 end;//not vcmDispatcher.InOp
end;

function TvcmComboMenuItemActionLink.Execute(AComponent: TComponent = nil): Boolean;
  //override;
  {-}
begin
 if (FClient.Count = 0) and ExecuteInheritedIfEmpty then
  Result := inherited Execute(aComponent)
 else
  Result := false;
end;

procedure TvcmComboMenuItemActionLink.pm_SetCurrentItem(const aCaption: String);
  {* - ������������� ������� �������. }
begin
 if (FClient Is TvcmComboMenuItem) AND
  (Action Is TvcmOperationAction) AND
  (TvcmOperationAction(Action).OpDef.OperationType = vcm_otCombo) AND
  ((f_CurrentItem = nil) or (f_CurrentItem.Caption <> aCaption)) then
 begin
  f_CurrentItem := TvcmComboMenuItem(FClient).Find(aCaption);
  if (f_CurrentItem <> nil) then
  begin
   if f_CurrentItem.RadioItem then
    f_CurrentItem.Checked := True;
  end;//l_Item <> nil
 end//FClient Is TvcmComboMenuItem
end;//SetCurrentItem

// start class TvcmComboMenuItem

procedure TvcmComboMenuItem.SetCurrentItem(aValue : Integer);
begin
 if (Count > 0) and ((aValue >= 0) and (aValue <= Pred(Count))) and
   Items[aValue].RadioItem then
  Items[aValue].Checked := True;
end;

function TvcmComboMenuItem.GetActionLinkClass: TMenuActionLinkClass;
  //override;
  {-}
begin
 Result := TvcmComboMenuItemActionLink;
end;

// start class TvcmComboMenuItemChildItemActionLink

procedure TvcmComboMenuItemChildItemActionLink.CheckComponentCaptionOnExecute(aComponent: TComponent = nil);
var
 l_Action: IvcmAction;
begin
 if Assigned(aComponent) and (aComponent is TMenuItem) and
  Supports(Action, IvcmAction, l_Action) then
 try
  l_Action.SelectedString := vcmCStr(TMenuItem(aComponent).Caption);
 finally
  l_Action := nil;
 end;//try..finally
end;//CheckComponentCaptionOnExecute

// start class TvcmComboMenuItemChildItem

function TvcmComboMenuItemChildItem.GetActionLinkClass: TMenuActionLinkClass;
  //override;
  {-}
begin
 Result := TvcmComboMenuItemChildItemActionLink;
end;

{ TvcmDateMenuItem }

procedure TvcmDateMenuItem.Click;
var
 l_DateStr : IvcmCString;
 l_Action  : IvcmAction;
begin
 if Supports(Action, IvcmAction, l_Action) then
 try
  l_DateStr := vcmSelectDate(vcmCStr(Caption), l_Action.SelectedString);
  try
   // ������������ ������ ��������, �������� ��������:
   if not vcmIsNil(l_DateStr) then
   begin
    l_Action.SelectedString := l_DateStr;
    inherited;
   end;//if not l3IsNil(l_DateStr) then
  finally
   l_DateStr := nil;
  end;//try..finally
 finally
  l_Action := nil;
 end//try..finally
 else
  inherited;
end;//Click

function TvcmDateMenuItem.GetActionLinkClass: TMenuActionLinkClass;
begin
 Result := TvcmDateMenuItemActionLink;
end;

{ TvcmDateMenuItemActionLink }

function TvcmDateMenuItemActionLink.Execute(AComponent: TComponent): Boolean;
var
 l_Action: IvcmAction;
begin
{ if (Action Is TCustomAction) then
  TCustomAction(Action).Caption := (aComponent As TMenuItem).Caption; }
 if Supports(Action, IvcmAction, l_Action) then
 try
  l_Action.LockUpdate;
  try
   Result := inherited Execute(aComponent);
  finally
   l_Action.UnlockUpdate;
  end;//try..finally
 finally
  l_Action := nil;
 end//Action Is TvcmAction
 else
  Result := inherited Execute(aComponent);
end;

{ TvcmComboMenuItemChildPopupItem }

function TvcmComboMenuItemChildPopupItem.GetActionLinkClass: TMenuActionLinkClass;
begin
 Result := TvcmComboMenuItemChildPopupItemActionLink;
end;

{ TvcmComboMenuItemActionLink }

procedure TvcmComboMenuItemActionLink.Cleanup;
  // override;
  {-}
begin
 f_CurrentItem := nil;
 inherited;
end;//Cleanup

function TvcmComboMenuItemActionLink.ExecuteInheritedIfEmpty: Boolean;
begin
 Result := False;
end;

{ TvcmComboMenuButtonItemActionLink }

function TvcmComboMenuButtonItemActionLink.ExecuteInheritedIfEmpty: Boolean;
begin
 Result := True;
end;

{ TvcmComboButtonMenuItem }

function TvcmComboButtonMenuItem.GetActionLinkClass: TMenuActionLinkClass;
begin
 Result := TvcmComboMenuButtonItemActionLink;
end;

{ TvcmCustomComboMenuItemChildItemActionLink }

procedure TvcmCustomComboMenuItemChildItemActionLink.CheckComponentCaptionOnExecute(
  aComponent: TComponent);
begin

end;

function TvcmCustomComboMenuItemChildItemActionLink.Execute(
  AComponent: TComponent): Boolean;
var
 l_Action: IvcmAction;
begin
 Use;
 try
  CheckComponentCaptionOnExecute(AComponent);
  if Supports(Action, IvcmAction, l_Action) then
  try
   l_Action.LockUpdate;
   try
    Result := inherited Execute(aComponent);
   finally
    l_Action.UnlockUpdate;
   end;//try..finally
  finally
   l_Action := nil;
  end//try..finally
  else
   Result := inherited Execute(aComponent);
 finally
  Free;
 end;//try..finally
end;//Execute

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\VCM\implementation\Visual\vcmMenus.pas initialization enter'); {$EndIf}
 g_InternalItem := TvcmMenuItem.Create(nil);

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\VCM\implementation\Visual\vcmMenus.pas initialization leave'); {$EndIf}
finalization
 FreeAndNil(g_InternalItem);

end.

