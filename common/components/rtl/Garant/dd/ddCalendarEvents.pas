unit ddCalendarEvents;

// ��������� ��� ����������� �� ����������� ��������

{ $Id: ddCalendarEvents.pas,v 1.25 2015/10/14 07:08:12 lukyanets Exp $ }

// $Log: ddCalendarEvents.pas,v $
// Revision 1.25  2015/10/14 07:08:12  lukyanets
// Cleanup
//
// Revision 1.24  2015/10/05 11:45:46  lukyanets
// ����������� ��������
//
// Revision 1.23  2015/09/10 07:04:17  lukyanets
// ������������ ������
//
// Revision 1.22  2015/09/08 09:15:06  lukyanets
// ��������� ������� ����������
//
// Revision 1.21  2015/09/04 13:03:59  lukyanets
// ��������� ������
//
// Revision 1.20  2015/04/01 10:42:31  fireton
// - ������� ����� "����������" �� ������ �������� ��������� � ������
//
// Revision 1.19  2015/02/20 10:37:04  fireton
// - �������� ������� ��������� � ��. ������ � ��������� �������
//
// Revision 1.18  2014/08/25 12:02:32  lukyanets
// ������� ������� ��� ���
//
// Revision 1.17  2014/08/05 06:29:42  lukyanets
// {Requestlink:558466572}. ���������� Define
//
// Revision 1.16  2013/04/16 13:03:52  narry
// ����������
//
// Revision 1.15  2013/04/11 16:46:27  lulin
// - ���������� ��� XE3.
//
// Revision 1.14  2013/04/09 07:22:46  narry
// �������������� ������� �������������� (447390002)
//
// Revision 1.13  2013/04/08 07:06:47  narry
// �������������� ������� �������������� (447390002)
//
// Revision 1.12  2013/03/06 05:46:52  narry
// ����� ��� ������� ��� ���������� ��������� ����
//
// Revision 1.11  2012/08/30 13:55:23  narry
// ������� ��� ����������
//
// Revision 1.10  2011/08/09 11:11:22  narry
// ������� ���������� � ������� ������ ���� (266422146)
//
// Revision 1.9  2010/09/24 09:37:22  narry
// - ������� ������
//
// Revision 1.8  2009/01/23 15:53:12  narry
// - ����������
//
// Revision 1.7  2008/09/29 13:52:14  narry
// - ����� ������� - �������� ������� ������
//
// Revision 1.6  2008/08/18 12:38:28  narry
// - ���������� ��� �������
//
// Revision 1.5  2008/08/18 09:17:57  narry
// - ����� �������� ExecuteByTimer
//
// Revision 1.4  2008/07/28 09:55:16  fireton
// - ��������������� ������������� �������
// - required ���� �������
//
// Revision 1.3  2008/07/21 11:45:03  fireton
// - ������ (������ � ����������)
//
// Revision 1.2  2008/07/16 16:10:28  narry
// - ����� ��� ������ - ����������
//
// Revision 1.1  2008/07/10 12:56:28  fireton
// - refactoring: ���� ����������� ������� ��������� "������"
//

{$I ddDefine.inc}

interface
uses
 Graphics;

type
 TddCalendarTaskType = (ctDeltaTask = 0, ctUpdateTask, ctBirthdayTask, ctHolidayTask,
    ctPreventiveTask, ctAutoExportTask, ctFNSExport_DEPRECATED, ctLoadRegions, ctAutoSubs,
    ctAutoclassify, ctVersion, ctCompilation, ctUploadRegions, ctMakeDivisions,
    ctRelPublish, ctHavansky, ctCloneBase, ctExportAnonced, ctExportAnoncedEx,
    ctAnnoExport, ctMdpSyncDicts, ctMdpSyncDocs, ctContainer);

 TddCalendarEventData = record
  Color : TColor;
  Caption: AnsiString;
  Unique : Boolean;
  Slaves : set of TddCalendarTaskType;
  ExecuteByTimer: Boolean;
  Required: Boolean;
  DefaultRep: Byte;
 end;

 TddCalendarTaskTypes = Set of TddCalendarTaskType;

const
 repeatOnce       = 0;
 repeatEveryday   = 1;
 repeatEveryweek  = 2;
 repeatEveryMonth = 3;
 repeatEveryYear  = 4;

 ddCalendarEventArray : array[TddCalendarTaskType] of TddCalendarEventData = (
  (Color: clOlive;
   Caption: '������ ������ ����������';
   Unique: False;
   Slaves: [];
   ExecuteByTimer: True;
   Required: False;
   DefaultRep: repeatEveryWeek), // ctDeltaTask

  (Color: clTeal;
   Caption: '���������� ����������';
   Unique: False;
   Slaves: [];
   ExecuteByTimer: True;
   Required: True;
   DefaultRep: repeatEveryday), // ctUpdateTask

  (Color: clFuchsia;
   Caption: '���� �������� ������������';
   Unique: False;
   Slaves: [];
   ExecuteByTimer: True;
   Required: False;
   DefaultRep: repeatEveryYear), // ctBirthdayTask

  (Color: clRed;
   Caption: '��������';
   Unique: False;
   Slaves: [];
   ExecuteByTimer: True;
   Required: False;
   DefaultRep: repeatEveryYear), // ctHolidayTask

  (Color: clGreen;
   Caption: '������������';
   Unique: False;
   Slaves: [];
   ExecuteByTimer: True;
   Required: False;
   DefaultRep: repeatEveryday), // ctPreventiveTask

  (Color: clNavy;
   Caption: '�������������� �������';
   Unique: False;
   Slaves: [];
   ExecuteByTimer: True;
   Required: False;
   DefaultRep: repeatEveryday), // ctAutoExportTask

  (Color: clYellow;
   Caption: '��������! ������� ���������� ��� ��� ��';
   Unique: False;
   Slaves: [];
   ExecuteByTimer: True;
   Required: False;
   DefaultRep: repeatEveryWeek), // ctFNSExport_DEPRECATED

  (Color: clAqua;
   Caption: '������ ������� ����������';
   Unique: False;
   Slaves: [];
   ExecuteByTimer: True;
   Required: False;
   DefaultRep: repeatEveryWeek), //  ctLoadRegions

  (Color: clSilver;
   Caption: '����������� ����� � �����';
   Unique: False;
   Slaves: [];
   ExecuteByTimer: True;
   Required: False;
   DefaultRep: repeatEveryWeek), // ctAutoSubs

  (Color: clMaroon;
   Caption: '����������������� ����������';
   Unique: False;
   Slaves: [];
   ExecuteByTimer: True;
   Required: False;
   DefaultRep: repeatEveryday), // ctAutoClassify

  (Color: clMoneyGreen;
   Caption: '������';
   Unique: True;
   Slaves: [];
   ExecuteByTimer: False;
   Required: True;
   DefaultRep: repeatEveryWeek), // ctVersion

  (Color: clGray;
   Caption: '����������';
   Unique: True;
   Slaves: [ctVersion];
   ExecuteByTimer: True;
   Required: True;
   DefaultRep: repeatEveryWeek),  // ctCompilation

  (Color: clLime;
   Caption: '������� ������� ����������';
   Unique: False;
   Slaves: [];
   ExecuteByTimer: True;
   Required: False;
   DefaultRep: repeatEveryWeek), //  ctUploadRegions

  (Color: clYellow;
   Caption: '����������� �������� � ����������';
   Unique: False;
   Slaves: [];
   ExecuteByTimer: True;
   Required: False;
   DefaultRep: repeatEveryDay), //  ctDivisions

  (Color: clCream;
   Caption: '���������� ���������� � ���������� � �������';
   Unique: False;
   Slaves: [];
   ExecuteByTimer: True;
   Required: False;
   DefaultRep: repeatEveryWeek), //  ctRelPublish

  (Color: clCream;
   Caption: '������� ���������� ��� ��� �����';
   Unique: False;
   Slaves: [];
   ExecuteByTimer: True;
   Required: False;
   DefaultRep: repeatEveryMonth), //  ctHavansky

  (Color: clCream;
   Caption: '������������ ����';
   Unique: False;
   Slaves: [];
   ExecuteByTimer: True;
   Required: False;
   DefaultRep: repeatEveryday), //  ctCloneBase

  (Color: clCream;
   Caption: '������� ��������������';
   Unique: False;
   Slaves: [];
   ExecuteByTimer: True;
   Required: False;
   DefaultRep: repeatEveryday),//  ctExportAnonced

  (Color: clCream;
   Caption: '������� �������������� � ���� ����������';
   Unique: False;
   Slaves: [];
   ExecuteByTimer: True;
   Required: False;
   DefaultRep: repeatEveryWeek), //  ctExportAnoncedEx

  (Color: clBlue;
   Caption: '������� ��������� ��� ������';
   Unique: False;
   Slaves: [];
   ExecuteByTimer: True;
   Required: False;
   DefaultRep: repeatEveryday), //  ctAnnoExport

  (Color: clCream;
   Caption: '������������� �������� � ������';
   Unique: False;
   Slaves: [];
   ExecuteByTimer: True;
   Required: False;
   DefaultRep: repeatEveryday), // ctMdpSyncDicts

  (Color: clCream;
   Caption: '������ ���������� �� �������';
   Unique: False;
   Slaves: [];
   ExecuteByTimer: True;
   Required: False;
   DefaultRep: repeatEveryday), // ctMdpSyncDocs

  (Color: clBlack;
   Caption: '������ ������������ ������';
   Unique: False;
   Slaves: [];
   ExecuteByTimer: True;
   Required: False;
   DefaultRep: repeatEveryday) // ctContainer
 );

var
 ddEnabledTasks: TddCalendarTaskTypes = [ctDeltaTask, ctUpdateTask, ctBirthdayTask, ctHolidayTask, ctPreventiveTask,
                     ctAutoExportTask, ctLoadRegions, ctAutoSubs, ctAutoclassify,
                     ctVersion, ctCompilation, ctUploadRegions, ctRelPublish, ctHavansky, ctCloneBase,
                     ctExportAnonced, ctExportAnoncedEx, ctAnnoExport, ctContainer]; 

implementation

end.