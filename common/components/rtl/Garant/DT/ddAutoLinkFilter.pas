unit ddAutoLinkFilter;

{ $Id: ddAutoLinkFilter.pas,v 1.43 2016/08/24 09:11:13 fireton Exp $ }

// $Log: ddAutoLinkFilter.pas,v $
// Revision 1.43  2016/08/24 09:11:13  fireton
// - ��������������� ������, ����������� � ���������
//
// Revision 1.42  2016/07/27 14:59:33  fireton
// - ��������� �����������
//
// Revision 1.41  2016/07/26 09:26:02  fireton
// - ��������� �����������
//
// Revision 1.40  2016/07/21 12:13:42  fireton
// - ��������� �����������
//
// Revision 1.39  2016/07/18 10:49:49  fireton
// ��������� �����������
//
// Revision 1.38.2.3  2016/07/18 10:48:54  fireton
// ��������� �����������
//
// Revision 1.38.2.2  2016/07/15 13:17:50  fireton
// ��������� �����������
//
// Revision 1.38.2.1  2016/07/15 06:53:07  fireton
// ��������� �����������
//
// Revision 1.38  2016/06/24 12:46:09  fireton
// - ����������� �� RCE
//
// Revision 1.37  2016/06/16 05:40:06  lukyanets
// ������������ UserManager �� ����� ������
//
// Revision 1.36  2015/11/25 14:01:48  lukyanets
// ��������� ��� ������ �������+������� ��������
//
// Revision 1.35  2015/11/23 11:37:15  lukyanets
// ��������� Renum
//
// Revision 1.34  2015/07/02 07:36:07  lukyanets
// ��������� �������
//
// Revision 1.33  2015/04/23 09:49:44  fireton
// - bugfix: ������, ���������� ��� �������� l_FoundNum �� Il3CString
//
// Revision 1.32  2015/04/14 09:35:00  dinishev
// Bug fix: �� �������������� CreateTestBase
//
// Revision 1.31  2015/04/13 17:40:59  lulin
// - ��������������.
//
// Revision 1.30  2015/04/13 16:44:27  lulin
// - ��������������.
//
// Revision 1.29  2015/04/07 11:55:52  fireton
// - AV ��� ������ ������ ����
// - ������ � ��������� ��������� ��� ������ �� �������� ���������
//
// Revision 1.28  2015/04/01 12:29:56  fireton
// - ����� ����������
//
// Revision 1.27  2015/04/01 12:16:49  fireton
// - ����������� ����� ���������
//
// Revision 1.26  2014/06/20 12:50:47  fireton
// - ����� ������������� �� ������� ������
//
// Revision 1.25  2014/06/20 09:19:02  fireton
// - ������� �������� ����������� �����
//
// Revision 1.24  2014/06/03 09:06:41  fireton
// - �� ��������� ������ ([$540178525])
//
// Revision 1.23  2014/04/17 13:04:31  voba
// - ������� ISab �� DT_Sab � dtIntf
//
// Revision 1.22  2014/04/11 15:30:43  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.21  2014/04/08 17:13:23  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.20  2014/04/07 06:53:34  dinishev
// Bug fix: �� ��������������� �������.
//
// Revision 1.19  2014/03/28 06:13:15  dinishev
// Bug fix: �� ���������� ������ ������.
//
// Revision 1.18  2014/03/25 14:31:49  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.17  2014/03/18 10:49:33  fireton
// - ��������� ����������� ������� � ��������� (K 521625290)
//
// Revision 1.16  2014/03/04 14:36:46  lulin
// - ��������� �������������� Sub'�� � ��������� �� ���������� Enum'�.
//
// Revision 1.15  2013/11/19 10:07:17  fireton
// - Index Out Of Range � NeedStartBuffering
//
// Revision 1.14  2013/10/21 15:43:09  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.13  2013/10/21 10:30:56  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.12  2013/10/18 15:38:58  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.11  2013/08/08 10:33:09  fireton
// - ������ �� ������ ���������� � ������ ����������, ���� ��� (K 429694402)
//
// Revision 1.10  2013/08/01 09:16:06  fireton
// - ������������������� ��������� ���������� (K 475476081)
//
// Revision 1.9  2013/07/31 10:32:28  fireton
// - ����� ������ �� ������������ ��������� (K 434754968)
//
// Revision 1.8  2013/04/25 03:56:21  fireton
// - ����������� ����� ��������� ����
//
// Revision 1.7  2012/11/07 10:41:34  fireton
// - �� ������ ������ � ����������� ������������
//
// Revision 1.6  2012/11/02 08:19:52  lulin
// - ������ �� �����.
//
// Revision 1.5  2012/11/01 09:42:41  lulin
// - ����� ����� � �������.
//
// Revision 1.4  2012/11/01 07:44:35  lulin
// - ������ ����������� ����������� �������� �������� �������.
//
// Revision 1.3  2012/10/31 18:38:14  kostitsin
// ������������ ������ Notify �� ���� �����������
//
// Revision 1.2  2012/10/18 06:51:54  narry
// ������ ��� ������������ ������� �������� �����
//
// Revision 1.1  2012/09/21 09:10:43  lulin
// - �� ��������� �������.
//
// Revision 1.70  2012/09/21 07:57:53  fireton
// - ������� ��� ������ � ��������� � ������������
//
// Revision 1.69  2012/09/11 03:54:04  fireton
// - �� ����������� ���� ID ����������� �� �������� (K 392171444)
//
// Revision 1.68  2012/09/10 09:08:51  fireton
// - ����-����� ��� (����) ����� ���������� (K 392168042)
//
// Revision 1.67  2012/08/20 09:17:47  fireton
// - ���������� ����������� ������ (K 385484738)
//
// Revision 1.66  2012/03/19 06:33:20  fireton
// - ����� �������� "�����������"
//
// Revision 1.65  2012/03/16 12:23:58  narry
// ������ ������������ ������ (346758397)
//
// Revision 1.64  2012/03/16 08:37:06  fireton
// - ������ �������� AV ��-�� ���������������� ����������
//
// Revision 1.63  2012/03/14 10:39:31  fireton
// - ��������� � ������ ������ �� �����
//
// Revision 1.62  2012/03/13 13:43:15  fireton
// - ��������� � ������ ������ � ������ ������ ����, � �������� ����������� ��������
//
// Revision 1.61  2011/10/14 13:54:11  fireton
// - ���������� ������� ����� ��������� ����������
//
// Revision 1.60  2011/10/12 13:13:40  fireton
// - ���� ������� ��������� ������
//
// Revision 1.59  2011/10/12 13:06:12  fireton
// - TddAutolinkDocHistory
//
// Revision 1.58  2011/06/30 13:18:05  fireton
// - ������� TddEntryCollector � ��������� ������
//
// Revision 1.57  2011/06/29 16:01:49  fireton
// - ���������
//
// Revision 1.56  2011/06/23 10:49:27  fireton
// - ����������� �� 30 ������ � ������� ��������� �������������, ������ 200
// - ���� �������������� �� ������������
//
// Revision 1.55  2011/06/10 11:52:40  voba
// - DocumentServer ������ �������� function DocumentServer(aFamily : TdaFamilyID), ��� �� �������� Family �� �����������
//
// Revision 1.54  2011/06/03 14:43:43  fireton
// - ��� ������ ������� ����� ���� ��������� �����������
//
// Revision 1.53  2011/05/30 10:08:52  fireton
// - ��������� ������� �� �������� ������ � ������
//
// Revision 1.52  2011/05/26 13:09:04  fireton
// - ������� ���������� "������� ������"
//
// Revision 1.51  2011/05/19 14:10:26  fireton
// - �� �������� ������ � ��������
//
// Revision 1.50  2011/05/13 14:31:53  fireton
// - ������� � ������
//
// Revision 1.49.2.1  2011/05/06 12:26:10  fireton
// - ������� ��� �����������������
//
// Revision 1.49  2011/04/13 10:50:20  fireton
// - ��������� ����������� ������ �� ������� ������ ����������
//
// Revision 1.48  2011/04/11 10:25:01  narry
// �������� ��� ��� (259885290)
//
// Revision 1.47  2011/04/04 06:41:54  fireton
// - ��������� �������� �� �� "�����" CSV
//
// Revision 1.46  2011/03/29 11:41:22  fireton
// - ������������� ������
//
// Revision 1.45  2011/03/15 14:38:12  fireton
// - ����� �������������
//
// Revision 1.44  2011/03/03 08:38:20  fireton
// - ��� �������� ��� ������������� ������
//
// Revision 1.43  2011/03/01 13:23:02  fireton
// - ��� ������ ��� ������������� ������
//
// Revision 1.42  2011/02/11 17:10:25  fireton
// - ���������� ������������ �� �������� ����
//
// Revision 1.41  2011/02/07 13:06:39  fireton
// - ������ ��� ����������� ������� � �������� �������
//
// Revision 1.40  2011/01/21 11:54:42  fireton
// - ������ �������� ������ �������� ��� �������� � ���� ������ ����������
//
// Revision 1.39  2011/01/17 14:46:59  fireton
// - ������ ��� �������� ���������� �� ����� � ��������� ��� �� �������������
//
// Revision 1.38  2010/12/29 11:32:56  fireton
// - �� ��������� ������, ���� ��������� ��������� "�"
//
// Revision 1.37  2010/12/06 13:41:57  fireton
// - ����������� �� �� ���� ����
//
// Revision 1.36  2010/11/23 15:48:25  fireton
// - ����������� ����������� ���������� ��������
//
// Revision 1.35  2010/10/14 10:08:16  fireton
// - �� ��������� ������, ���� ����� ��������� ����� ��� ����
//
// Revision 1.34  2010/10/13 14:32:27  fireton
// - ���� ������ ������ � ������������ �������� ���������
//
// Revision 1.33  2010/10/11 11:26:39  narry
// K235872167
//
// Revision 1.32  2010/10/04 14:08:23  fireton
// - const ����� Tl3WString � Il3CString
//
// Revision 1.31  2010/10/01 12:23:36  fireton
// - ��������� ������ �� �� ��� ������
//
// Revision 1.30  2010/09/30 11:09:04  fireton
// - �������� ����� ���������� ������������� � ���������� �������������
//
// Revision 1.29  2010/09/24 12:10:36  voba
// - k : 235046326
//
// Revision 1.28  2010/09/23 11:30:53  fireton
// - ��� ������ �������� �� ������ �����
// - �� ������ ������ �� ��������� ��� ���������, ���� �� ���� ��� � ������
//
// Revision 1.27  2010/09/21 11:06:50  fireton
// - ��������� ������� � PChar �� Tl3WString
//
// Revision 1.26  2010/09/06 13:58:12  fireton
// - ������ ������ ������ �� ���������� ��������
//
// Revision 1.25  2010/09/06 13:30:59  fireton
// - �� �������� � ������� �������� ����� � ����������
//
// Revision 1.24  2010/09/03 09:15:46  fireton
// - �� ������������� ����������� ������
//
// Revision 1.23  2010/09/03 07:36:25  fireton
// - ����������� ���������
//
// Revision 1.22  2010/08/13 10:28:03  voba
// - k:229214076
//
// Revision 1.21  2010/08/04 08:30:15  voba
// - k: 229672814
//
// Revision 1.20  2010/07/20 13:28:57  fireton
// - ��������� ������� CSV ��� filer
//
// Revision 1.19  2010/03/19 16:12:24  fireton
// - bug fix: �� ��������� ������ �� ����� � ��������
//
// Revision 1.18  2010/03/17 10:04:23  fireton
// - ���� ������������ � ��������� ������� ������� ������ �� ������������� ���������
//
// Revision 1.17  2010/03/10 12:04:39  fireton
// - �� ������ ������ � ������������ �������
//
// Revision 1.16  2010/03/02 13:03:54  fireton
// - ������� ������ �� ��� ����� ����� �����
//
// Revision 1.15  2010/02/12 14:12:26  fireton
// - �������� ��������� ��������� ������
//
// Revision 1.14  2010/02/05 14:18:29  fireton
// - �� ���� �� ��������, ���� �� ����, �� ������
//
// Revision 1.13  2010/01/27 14:35:00  fireton
// - ��������� ������� ����� � ������ ����������
//
// Revision 1.12  2010/01/26 13:39:03  fireton
// - ����� ������ ��������� ������� ����������� ����������
//
// Revision 1.11  2010/01/19 09:44:57  fireton
// - �������: "�������������� ������" = "������"
//
// Revision 1.10  2010/01/18 10:50:01  fireton
// - bugfix: ������ ����� "�"
//
// Revision 1.9  2010/01/18 08:26:57  fireton
// - �������� ����� � ������� ������ ��������� ����
//
// Revision 1.8  2010/01/15 07:52:49  fireton
// - ������� �������� � ���������� "��������" � "�������" ������
//
// Revision 1.7  2010/01/13 16:51:56  fireton
// - bug fix
//
// Revision 1.6  2010/01/13 13:40:23  fireton
// - ����������� �� ������������ ������ �������� � ��
// - ����������� ����������� �� ���������
//
// Revision 1.5  2010/01/13 13:16:14  fireton
// - ����������� �� ������������ ������ �������� � ��
// - ����������� ����������� �� ���������
//
// Revision 1.4  2010/01/12 12:00:27  fireton
// - "�����" � "�����" ������ ��������
// - ������ � ������� �������� "�������"
//
// Revision 1.3  2009/12/24 14:49:34  fireton
// - ��������� ����������� ������
//
// Revision 1.2  2009/12/07 14:36:51  fireton
// - �� ��������� ������ ��������
//
// Revision 1.1  2009/12/04 09:01:10  fireton
// - ����������� ������ � ��������
//
// Revision 1.41  2009/11/16 15:44:41  fireton
// - ������� ������ �������� � �������� finder
//
// Revision 1.40  2009/11/10 10:32:16  dinishev
// Bug fix: �� ��������� ���� � �����
//
// Revision 1.39  2009/10/23 09:36:41  fireton
// - ���������, ��������� ���������� �������
// - ����������� Range Check Error
//
// Revision 1.38  2009/10/22 10:17:07  fireton
// - ��� ��� ����������
//
// Revision 1.37  2009/10/16 12:38:28  narry
// - ����������� ������ � ���
//
// Revision 1.36  2009/10/16 10:09:22  fireton
// - ����� ���������� ��������� �������: ������ ����������� ��� �������� ����� ������� ����������
//
// Revision 1.35  2009/10/15 14:15:50  fireton
// - ������ � ������ � ����������� ������
//
// Revision 1.34  2009/10/14 13:53:59  fireton
// - bug fix: ���� ������ ���������
//
// Revision 1.33  2009/10/13 08:55:35  fireton
// - ����������� ������ � ������� ������ �������
//
// Revision 1.32  2009/09/28 12:49:50  fireton
// - "���������� �������..."
//
// Revision 1.31  2009/09/25 13:23:43  fireton
// - �������� ������� ������ ��� ���������
//
// Revision 1.30  2009/09/23 07:38:41  fireton
// - ����� ���������� ����� �������
//
// Revision 1.29  2009/09/22 12:43:56  fireton
// - �� ������ ������, ���� ������ �� �������
// - �� ������ ������ �� ��������� ������ �������
// - ������ ������
//
// Revision 1.28  2009/09/18 10:36:57  fireton
// - �� �������� ������� ��� �������� ���������
//
// Revision 1.27  2009/09/17 13:41:53  fireton
// - �� ������ ������ �� ������������ �������� (������ ���� "��")
//
// Revision 1.26  2009/09/17 12:39:54  voba
// - opt.  function lRecAccessProc
//
// Revision 1.25  2009/09/17 08:03:00  fireton
// - ����������� � ����������� ������
//
// Revision 1.24  2009/09/15 08:18:40  narry
// - ������ ������ � ���
//
// Revision 1.23  2009/09/11 13:26:07  voba
// - ������� ������������� ISabCursor �� Tl3FieldSortRecList
//
// Revision 1.22  2009/09/11 11:18:17  narry
// - ������������� ����������
//
// Revision 1.21  2009/09/02 14:31:33  lulin
// {RequestLink:161122154}.
//
// Revision 1.20  2009/08/28 15:22:08  fireton
// - ����������� ������ �� ������� ������
//
// Revision 1.19  2009/08/27 16:16:52  fireton
// - ����������� ������ �� ������
//
// Revision 1.18  2009/08/18 11:51:03  fireton
// - �����������
//
// Revision 1.17  2009/08/06 15:59:54  fireton
// - �����������
//
// Revision 1.16  2009/07/29 07:41:07  narry
// - ����� ��������� �� ������� �� ������ � ���
//
// Revision 1.15  2009/06/23 14:32:25  fireton
// - �����������, ���� ����������� ����� � ��������� �����
//
// Revision 1.14  2009/06/23 07:34:15  voba
// - �������������� ������� � ���������
//
// Revision 1.13  2009/06/22 14:48:42  fireton
// - ������� ������ � ���
// - �������� �� �������������� ������
//
// Revision 1.12  2009/06/16 11:52:10  fireton
// - �� ��������� "������ 30.1" �� "������ 30"
//
// Revision 1.11  2009/06/11 11:01:36  fireton
// - bug fix: �������� �� ��������
// - ������ � tabl.csv ������ ���������� ���������
//
// Revision 1.10  2009/06/11 08:58:33  fireton
// - bug fix: ������������� ��������� ������������ (��� ��� �� ����������� ������ ���������, ��������)
// - bug fix: ����� ��������� ����������� ������� ���������
//
// Revision 1.9  2009/06/11 07:41:13  fireton
// - bug fix: ���������� ������ ������ �������������� �������
//
// Revision 1.8  2009/06/10 15:04:58  fireton
// - bug fix: ������ ������ �� ���� ��������
//
// Revision 1.7  2009/06/10 13:38:16  fireton
// - bug fix: ������ ����������� ������ �� �����, ���� �������� �������� ��-��������
//
// Revision 1.6  2009/06/10 07:52:55  narry
// - ������������ ������ �� ����� �������
//
// Revision 1.5  2009/06/09 13:06:14  narry
// - ����� ���� ���� - ������ dnDoc ������������ dnPublish
//
// Revision 1.4  2009/06/09 12:44:42  fireton
// - ������� ����������� ��������� ��������� ������
//
// Revision 1.3  2009/06/04 13:54:20  fireton
// - [$148572782]
//
// Revision 1.2  2009/06/02 13:43:59  narry
// - ������ ��� ��������� ������
//
// Revision 1.1  2009/06/01 11:28:34  fireton
// - [$146377261]
//

interface
uses
 l3ProtoObject,
 l3Interfaces,
 l3Variant,
 l3Date,
 l3RegEx,
 l3LongintList,
 l3RecList,
 l3StringList,
 l3FieldSortRecList,
 l3ObjectList,
 l3InterfaceList,
 l3Types,
 l3Tree_TLB,

 k2Types,
 k2Interfaces,
 k2TagGen,

 evdBufferedFilter,

 DT_Types,

 ddCSV,
 ddTypes,
 ddDocStructBase,
 ddDocStruct,
 ddBaseAutoLinkDataSource,
 ddAutoLinkDataSource,


 ddAutolinkTypes,
 ddAutolinkInterfaces,
 ddAutolinkDocEntry,
 ddAutoLinkDocHistory,
 ddAutolinkArbitraryDocList,
 ddAutolinkArbitraryDocEntry,
 ddCustomAutolinkDataLoader,
 ddCustomLinkFinder,
 ddGeneralLawsLinkFinder,
 
 ddEntryCollector
 ;

{$I DtDefine.inc}

type
 PddDocBlocksRec = ^TddDocBlocksRec;
 TddDocBlocksRec = record
  rDocID: TDocID;
  rCache: Tl3FieldSortRecList;
 end;

 TddDocumentLinker = class(Tl3ProtoObject)
 private
  f_FinderList: Tl3ObjectList;
  f_OnError: TddErrorEvent;
  f_Para: Tl3Variant;
  f_SPInQuote: Tl3RegularSearch;
  f_Text: string;
  f_UseInternalLink : Boolean;

  function NoLinkAtPos(aStart, aEnd: Longint): Boolean;
  function NotInQuotation(const aFrom: Longint): Boolean;
  function pm_GetSPInQuote: Tl3RegularSearch;
  procedure pm_SetOnError(const Value: TddErrorEvent);
  procedure SetLinkToBlock(aStart, aEnd: Longint; aDocID: TDocID; aBlockID: Longint);
  procedure SetLinkCallback(aFrom, aTo : Integer;
                            aDocID     : TDocID;
                            aBlockID   : Longint;
                            aLinkMsg   : string);
 protected
  procedure Cleanup; override;
  procedure DoOnError(aMsg: string);
  property SPInQuote: Tl3RegularSearch read pm_GetSPInQuote;
 public
  procedure AddLinkFinder(const aFinder: TddCustomLinkFinder);
  procedure FindAndSetLinks(aPara           : Tl3Variant;
                            aMasterDocID    : TDocID;
                            aMasterDocDate  : TStDate;
                            const aCaseCode : Il3CString);
  procedure Init;
  procedure Done;
  procedure NewDocument;
  property UseInternalLink : Boolean read f_UseInternalLink write f_UseInternalLink;
  property OnError: TddErrorEvent read f_OnError write pm_SetOnError;
 end;

 TddAutoLinkFilter = class(TevdBufferedFilter)
 private
  f_CaseCode: Il3CString;
  f_Category: Integer;
  f_DocDate: TStDate;
  f_DocID: TDocID;
  f_DocLinker: TddDocumentLinker;
  f_ForceSetLinks: Boolean;
  f_OnError: TddErrorEvent;
  f_PresetFlags: Byte; // ����� ��������, ����� ������ ���� ������ "�����" � �� �� ���� ��������
  f_SetLinks: Boolean;
  procedure pm_SetOnError(const Value: TddErrorEvent);
 protected
  procedure Cleanup; override;
        {-}
  procedure DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
  procedure DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean); override;
  function NeedStartBuffering(aID : Integer): Boolean; override;
 public
  constructor Create(anOwner: Tk2TagGeneratorOwner); reintroduce;
  procedure AddLinkFinder(const aFinder: TddCustomLinkFinder);
  procedure CloseStream(NeedUndo: Boolean); override;
  procedure OpenStream; override;
  procedure SetCasecode(const aCasecode: Il3CString);
  procedure SetDocDate(aDate: TStDate);
        {-}
  class function SetTo(var theGenerator: Tk2TagGenerator;
                           aDocID    : TDocID = 0;
                           aDocDate  : TStDate = 0;
                           aCasecode : Il3CString = nil): Pointer; overload;

  procedure SetDocID(aDocID: TDocID);
  procedure UseInternalNumForLink(aValue : boolean);
  procedure StartChild(TypeID: Tl3VariantDef); override;

  property Category: Integer read f_Category write f_Category;
  property ForceSetLinks: Boolean read f_ForceSetLinks write f_ForceSetLinks;
  property OnError: TddErrorEvent read f_OnError write pm_SetOnError;
 end;

implementation
uses
 SysUtils, StrUtils,

 l3Const,
 l3Base,
 l3Chars,
 l3String,
 l3PrimString,
 l3LongintListPrim,
 l3Nodes,
 l3FileUtils,
 l3Filer,

 evdTypes,
 evSegLst,
 evdStyles,

 k2Base,
 k2Tags,
 k2InterfacesEx,
 Document_Const,
 LeafPara_Const,
 NumANDDate_Const,
 HyperLink_Const,
 Address_Const,
 TextSegment_Const,

 m4DictTypes,
 m4DictScanner,
 m4PhraseParser,

 daTypes,
 daInterfaces,
 daSchemeConsts,

 dtIntf,
 DT_Const,
 DT_AttrSchema,
 DT_DictConst,
 DT_Serv,
 DT_Active,
 DT_Doc,
 DT_LinkServ,
 DT_Hyper,
 DT_Dict,
 DT_ReNum,
 DT_Sab,
 DT_Query,
 DT_SrchQueries,

 ddAutolinkConst,
 ddAutolinkUtils,

 l3AutolinkService

 {$If not defined(NoScripts)}
 ,
 kwFiltersAndGeneratorsPack
 {$IfEnd}
 ;

const
 s_Entry   = '������';
 s_Chapter = '�����';

const
 etArticle = 1;
 etHead    = 2;

 cMaxEntryNum    = High(Word);
 cMaxEntrySubNum = High(Word);

 affDocID    = $01;
 affDocDate  = $02;
 affCasecode = $04;

constructor TddAutoLinkFilter.Create(anOwner: Tk2TagGeneratorOwner);
begin
 inherited Create(anOwner);
 f_DocLinker := TddDocumentLinker.Create;
end;

procedure TddAutoLinkFilter.Cleanup;
begin
 FreeAndNil(f_DocLinker);
 inherited;
end;

procedure TddAutoLinkFilter.DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean);
begin
 if TypeTable.TypeByHandle[-aTagID].IsKindOf(k2_typLeafPara) and (f_SetLinks or f_ForceSetLinks) then
 begin
  f_DocLinker.FindAndSetLinks(aLeaf, f_DocID, f_DocDate, f_CaseCode);
 end;
 if (aTagId = -k2_idNumANDDate) then
 begin
  if (f_DocDate = 0) and (aLeaf.IntA[k2_tiType] = Ord(dnPublish)) then
   f_DocDate := DemonToStDate(aLeaf.IntA[k2_tiStart]);
  if (f_CaseCode = nil) and (aLeaf.IntA[k2_tiType] = Ord(dnLawCaseNum)) then
   f_CaseCode := l3CStr(aLeaf.PCharLenA[k2_tiNumber]);
 end;
 inherited;
end;

function TddAutoLinkFilter.NeedStartBuffering(aID : Integer): Boolean;
begin
 Result := aID = -k2_idNumANDDate;
 if (not Result) and (aID < 0) then
  Result := (TypeTable.TypeByHandle[-aID] <> nil) and TypeTable.TypeByHandle[-aID].IsKindOf(k2_typLeafPara);
end;

function IsNumberOnly(const aStr: string): Boolean;
var
 I : Integer;
 l_Open: Integer;
begin
 l_Open := 0;
 for I := 1 to Length(aStr) do
 begin
  if aStr[I] = '(' then
   Inc(l_Open);
  if l_Open = 0 then
  begin
   Result := aStr[I] in ['0'..'9',' ','.','-'];
   if not Result then
    Exit;
  end;
  if aStr[I] = ')' then
   Dec(l_Open);
 end;
 Result := (l_Open = 0);
end;

procedure TddAutoLinkFilter.AddLinkFinder(const aFinder: TddCustomLinkFinder);
begin
 f_DocLinker.AddLinkFinder(aFinder);
end;

procedure TddAutoLinkFilter.CloseStream(NeedUndo: Boolean);
begin
 inherited;
 f_DocLinker.Done;
end;

procedure TddAutoLinkFilter.DoAddAtomEx(AtomIndex: Long; const Value:
    Tk2Variant);
  //virtual;
  {-}
begin
 if CurrentType.IsKindOf(k2_typDocument) then
  case AtomIndex of
   k2_tiExternalHandle: f_DocID    := Value.AsInteger;
   k2_tiType          : f_SetLinks := Value.AsInteger <> Ord(dtRelText);
  end;
 inherited;
end;

procedure TddAutoLinkFilter.OpenStream;
begin
 inherited;
 f_DocLinker.Init;
end;

procedure TddAutoLinkFilter.pm_SetOnError(const Value: TddErrorEvent);
begin
 f_OnError := Value;
 f_DocLinker.OnError := Value;
end;

procedure TddAutoLinkFilter.SetCasecode(const aCasecode: Il3CString);
begin
 f_CaseCode := NormalizeCasecode(aCasecode);
 f_PresetFlags := f_PresetFlags or affCasecode;
end;

procedure TddAutoLinkFilter.SetDocDate(aDate: TStDate);
begin
 f_DocDate := aDate;
 f_PresetFlags := f_PresetFlags or affDocDate;
end;

class function TddAutoLinkFilter.SetTo(var theGenerator: Tk2TagGenerator;
                                           aDocID    : TDocID = 0;
                                           aDocDate  : TStDate = 0;
                                           aCasecode : Il3CString = nil): Pointer;
  {-}
var
 l_Filter : TddAutoLinkFilter;
begin
 l_Filter := Create(nil);
 try
  if aDocID <> 0 then
   l_Filter.SetDocID(aDocID);
  if aDocDate <> 0 then
   l_Filter.SetDocDate(aDocDate);
  if aCasecode <> nil then
   l_Filter.SetCasecode(aCasecode); 
  l_Filter.Generator := theGenerator;
  l3Set(theGenerator, l_Filter);
 finally
  FreeAndNil(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

procedure TddAutoLinkFilter.SetDocID(aDocID: TDocID);
begin
 f_DocID := aDocID;
 f_PresetFlags := f_PresetFlags or affDocID;
end;

procedure TddAutoLinkFilter.UseInternalNumForLink(aValue : boolean);
begin
 f_DocLinker.UseInternalLink := aValue;
end;

procedure TddAutoLinkFilter.StartChild(TypeID: Tl3VariantDef);
var
 I: Integer;
begin
 if TypeID = k2_typDocument then
 begin
  f_DocLinker.NewDocument;
  if f_PresetFlags and affDocID = 0 then
   f_DocID := 0;
  if f_PresetFlags and affDocDate = 0 then
   f_DocDate  := 0;
  if f_PresetFlags and affCasecode = 0 then
   f_CaseCode := nil;
  f_SetLinks := True;
  f_PresetFlags := 0; // ��������� ����� ������������� ������ ��� ������� ���������
 end;
 inherited;
end;

procedure TddDocumentLinker.AddLinkFinder(const aFinder: TddCustomLinkFinder);
var
 l_Finder: TddCustomLinkFinder;
begin
 if f_FinderList = nil then
  f_FinderList := Tl3ObjectList.Make;
 l_Finder := aFinder.Use;
 l_Finder.OnError := f_OnError;
 f_FinderList.Add(l_Finder);
end;

procedure TddDocumentLinker.Cleanup;
var
 I: Integer;
begin
 if f_FinderList <> nil then
 begin
  for I := 0 to Pred(f_FinderList.Count) do
   f_FinderList.Items[I].Free;
  FreeAndNil(f_FinderList);
 end;
 FreeAndNil(f_SPInQuote);
 FreeAndNil(f_Para);
 inherited;
end;

procedure TddDocumentLinker.DoOnError(aMsg: string);
begin
 if Assigned(f_OnError) then
  f_OnError(aMsg, 1);
end;

procedure TddDocumentLinker.FindAndSetLinks(aPara           : Tl3Variant;
                                            aMasterDocID    : TDocID;
                                            aMasterDocDate  : TStDate;
                                            const aCaseCode : Il3CString);
var
 I: Integer;
 l_Finder: TddCustomLinkFinder;
begin
 Assert((f_FinderList <> nil) and (f_FinderList.Count > 0), 'TddDocumentLinker: no link finders has been added!');
 if aPara.IsValid and (not l3IsNil(aPara.PCharLenA[k2_tiText])) and
    (aPara.IntA[k2_tiStyle] <> ev_saTxtHeader1) and (aPara.IntA[k2_tiStyle] <> ev_saTxtComment) and
    (aPara.IntA[k2_tiStyle] <> ev_saTechComment) then
 begin
  f_Text := aPara.StrA[k2_tiText];
  if Trim(f_Text) = '' then
   Exit;
  aPara.SetRef(f_Para);
  for I := 0 to Pred(f_FinderList.Count) do
  begin
   l_Finder := TddCustomLinkFinder(f_FinderList.Items[I]);
   l_Finder.FindLinks(f_Text, aMasterDocID, aMasterDocDate, aCaseCode, SetLinkCallback);
  end;
 end;
end;

procedure TddDocumentLinker.Init;
var
 I: Integer;
begin
 if f_FinderList <> nil then
  for I := 0 to Pred(f_FinderList.Count) do
   TddCustomLinkFinder(f_FinderList.Items[I]).Init;
end;

procedure TddDocumentLinker.Done;
var
 I: Integer;
begin
 if f_FinderList <> nil then
  for I := 0 to Pred(f_FinderList.Count) do
   TddCustomLinkFinder(f_FinderList.Items[I]).Done;
end;

procedure TddDocumentLinker.NewDocument;
var
 I: Integer;
begin
 if Assigned(f_FinderList) then
  for I := 0 to Pred(f_FinderList.Count) do
   TddCustomLinkFinder(f_FinderList.Items[I]).DoOnNewDocument;
end;

function TddDocumentLinker.NoLinkAtPos(aStart, aEnd: Longint): Boolean;
var
 l_Layer: Tl3Variant;
begin
 l_Layer := f_Para.cAtomEx([k2_tiSegments, k2_tiChildren, k2_tiHandle, Ord(ev_slHyperlinks)], nil);
 Result := evIsSegmentsLayerEmpty(f_Para, l_Layer, aStart, aEnd);
end;

function TddDocumentLinker.NotInQuotation(const aFrom: Longint): Boolean;
var
 l_RP: Tl3MatchPosition;
begin
 Result := (aFrom = 0) or (not SPInQuote.SearchInString(PAnsiChar(f_Text), 0, aFrom+1, l_RP));
end;

function TddDocumentLinker.pm_GetSPInQuote: Tl3RegularSearch;
begin
 if f_SPInQuote = nil then
 begin
  f_SPInQuote := Tl3RegularSearch.Create;
  f_SPInQuote.IgnoreCase := True;
  f_SPInQuote.SearchPattern := '�[^�]*$';
 end;
 Result := f_SPInQuote;
end;

procedure TddDocumentLinker.pm_SetOnError(const Value: TddErrorEvent);
var
 I: Integer;
begin
 f_OnError := Value;
 if f_FinderList <> nil then
  for I := 0 to Pred(f_FinderList.Count) do
   TddCustomLinkFinder(f_FinderList.Items[I]).OnError := Value;
end;

procedure TddDocumentLinker.SetLinkToBlock(aStart, aEnd: Longint; aDocID: TDocID; aBlockID: Longint);
var
 l_Seg: Tl3Variant;
 l_Addr: Tl3Variant;
begin
 if not f_UseInternalLink then
  aDocID := LinkServer(CurrentFamily).Renum.GetExtDocID(aDocID);

 if aDocID <> cUndefDocID then
 begin
  with f_Para.cAtomEx([k2_tiSegments, k2_tiChildren, k2_tiHandle, Ord(ev_slHyperlinks)], nil) do
  begin
   l_Seg := k2_typHyperLink.MakeTag.AsObject;
   l_Seg.IntA[k2_tiStart]  := aStart + 1;
   l_Seg.IntA[k2_tiFinish] := aEnd;

   l_Addr := k2_typAddress.MakeTag.AsObject;
   l_Addr.IntA[k2_tiDocID] := aDocID;
   l_Addr.IntA[k2_tiSubID] := aBlockID;
   l_Seg.AddChild(l_Addr);

   AddChild(l_Seg);
  end;
 end;
end;

procedure TddDocumentLinker.SetLinkCallback(aFrom, aTo : Integer;
                                            aDocID     : TDocID;
                                            aBlockID   : Longint;
                                            aLinkMsg   : string);
begin
 if NoLinkAtPos(aFrom, aTo) and NotInQuotation(aFrom) then
 begin
  SetLinkToBlock(aFrom, aTo, aDocID, aBlockID);
  if aLinkMsg <> '' then
   DoOnError(aLinkMsg);
 end;
end;

end.


