unit evExcept;

{ ���������� "�������"  }
{ �����: ����� �.�.     }
{ ������: evExcept - �������� �������������� ��������}
{ �����: 03.06.97 17:37 }
{ $Id: evExcept.pas,v 1.17 2015/06/23 10:23:56 dinishev Exp $ }

// $Log: evExcept.pas,v $
// Revision 1.17  2015/06/23 10:23:56  dinishev
// ����������� ��������� � �������� � ���������� ������.
//
// Revision 1.16  2015/06/22 08:21:28  dinishev
// {Requestlink:602478379}
//
// Revision 1.15  2015/05/21 11:46:03  lulin
// - ����������� �����������.
//
// Revision 1.14  2015/05/21 11:39:36  lulin
// - ����������� �����������.
//
// Revision 1.1  2015/05/21 11:37:08  lulin
// - ����������� �����������.
//
// Revision 1.12  2015/01/23 10:41:26  dinishev
// {Requestlink:570533036}
//
// Revision 1.11  2011/04/04 14:57:09  lulin
// {RequestLink:255980313}.
//
// Revision 1.10  2010/07/23 08:39:04  fireton
// - �������� "�����������" ������� searcher'��
//
// Revision 1.9  2010/06/30 08:46:25  oman
// - fix: {RequestLink:220595917}
//
// Revision 1.8  2007/12/04 12:47:01  lulin
// - ������������� ����� � HEAD.
//
// Revision 1.7.24.4  2007/08/29 15:33:19  lulin
// - cleanup.
//
// Revision 1.7.24.3  2006/12/06 12:24:09  oman
// - fix: ���� �� ������ ����������� �� ��������� ����� ���
//  ��������� ������ - ������� ���������� - ����� ���������� (cq23103)
//
// Revision 1.7.24.2  2006/12/04 13:46:40  oman
// - fix: ���� �� ������ ����������� �� ��������� ����� ���
//  ��������� ������ - ������� ���������� (cq23103)
//
// Revision 1.7.24.1  2006/03/01 10:48:46  lulin
// - cleanup.
//
// Revision 1.7  2004/07/16 12:36:41  law
// - bug fix: ����������� ������������ PgUp/PgDn ����� ������� �� ���� �����.
//
// Revision 1.6  2001/03/12 12:48:22  law
// - bug fix: exception ��� ������������� �������� ���������, � ����� ���������� k2_tiJustification � ���������.
//
// Revision 1.5  2000/12/15 15:10:35  law
// - ��������� ��������� Log.
//

{$Include k2Define.inc }

interface

uses
  SysUtils,
  
  k2Except
  ;

type
  EevException = class(Exception);

  EevWarning = class(EevException);
  EevSearchFailed = class(EevWarning);
  EevReadOnly = Ek2ReadOnly;
  EevLimitReached = Ek2LimitReached;
  EevPrintError = class(EevException);
  EevInvalidPrintMargins = class(EevPrintError);
  EevNothingToPrint = class(EevException);
  EevSearcherRestart = class(Exception);
  EevUnstableProcessWhileInsertUserComment = class(EevException);
  EevTooLargeColumnWidth = class(EevException);
  EevDoubleHandleInNestedBlocks = class(EevException);

const
  ev_errTooLargeColumnWidth = '������������ �������� ������ �������.';
  ev_warSearchFailed = '����� �� ��� �����������';
  ev_warInvalidMargins = '������� ������ ������� �� ������� ��������� �����. '+
    '�������������� ��������� ������� ������ � ������������ � ��������� ������� ������.';
  ev_errDoubleHandleInNestedBlocks = '� ��������� ������� ��������� ����� � ����������� ��������: %d � %d, ����� ������ %s � %s';

implementation

end.

