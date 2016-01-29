unit ctTypes;

// $Id: ctTypes.pas,v 1.3 2008/07/04 15:43:50 lulin Exp $

// $Log: ctTypes.pas,v $
// Revision 1.3  2008/07/04 15:43:50  lulin
// - <K>: 99647706.
//
// Revision 1.2  2008/05/15 20:15:29  lulin
// - ��������� ������.
//
// Revision 1.1  2007/12/07 16:59:52  lulin
// - �������.
//
// Revision 1.1  2007/12/07 16:22:40  lulin
// - ��������������� ����, ����� �� ������ � ������ �����������.
//
// Revision 1.37  2007/09/07 12:27:31  lulin
// - cleanup.
//
// Revision 1.36  2007/04/23 10:42:29  oman
// - new: �������� ������ ��� � ������ ������� - ����� Garant5Editor (cq25125)
// - ���������� ����������� ������...
//
// Revision 1.35  2007/04/23 10:39:29  oman
// - fix: *��������� IQuery �� ������ ����� ��� - ����� Garant5Editor (cq25139)
//
// Revision 1.34  2007/03/22 09:09:30  lulin
// - cleanup.
//
// Revision 1.33  2007/03/20 15:01:42  lulin
// - ����������� ������������ ������, � ����� ������������ ���������� ������.
//
// Revision 1.32  2007/03/14 18:27:33  lulin
// - cleanup.
//
// Revision 1.31  2007/01/30 15:24:09  lulin
// - ����� ���� - ������ ����� �������� ����.
//
// Revision 1.30  2007/01/19 07:45:11  oman
// - new: ����������� ��������� - ct (cq24078)
//
// Revision 1.29  2006/12/22 15:06:27  lulin
// - ����� ���� - ������ ��������� � ������ � ������� ���������.
//
// Revision 1.28  2006/06/23 10:32:01  oman
// - fix: ReadOnly �� ������������ DropDownList. ������� ReadOnly...
//
// Revision 1.27  2005/05/27 14:42:18  lulin
// - ������� ������� �������� � ���������� L3.
//
// Revision 1.26  2004/12/30 14:34:58  am
// change: ����������� ������ ����������
//
// Revision 1.25  2004/12/28 16:25:50  lulin
// - ��������� ��������� CVS.
//

interface

const
  COMBO_MIN_SIZE_X = 40;
  COMBO_MIN_SIZE_Y = 70;
  COMBO_MAX_SIZE_Y = 120;

type
  TAutoWidthMode = ( awNone, awCurrent, awMax );
  TComboStyle = (ct_cbDropDown, ct_cbDropDownList, ct_cbEdit);
  TCurrentMode = set of ( cmButtonClick, cmSetText, cmNoFiltering, cmFocusing,
                          cmAppNotActive, cmTimer, cmAllVisible, cmEscapePressed,
                          cmKeyProhibited, cmWMSetText, cmClear, cmVcmExecute, cmSetCurrent);

  // cmButtonClick - ��� ��������� ������, �� ������� ������� �������� ������
  // cmSetText - ������ TFakeCombo.SetText
  // cmAllVisible - ��� ����� ������ (��� ����� ������ setAllFlags/SetRoot �
  // ����������� _Changed � �������������� ���������)
  // cmWMSetText - caption ��� ���������� ����� WMSetText (� �������������, ������ ����������,
  // ���� �� vcm ����� Current ����
  // cmVcmExecute - ��������� vcmCurrent, etc..

const
 ReadOnlyComboStyles = [ct_cbDropDownList];

implementation

end.
