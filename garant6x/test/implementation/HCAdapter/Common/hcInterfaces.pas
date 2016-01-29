unit hcInterfaces;

{------------------------------------------------------------------------------}
{ ������ : hcInterfaces                                                        }
{ �����  : �. �������.                                                         }
{ ���������� : ���������� ��������� ������ ������������;                       }
{------------------------------------------------------------------------------}

// $Id: hcInterfaces.pas,v 1.15 2010/06/09 11:28:28 oman Exp $
// $Log: hcInterfaces.pas,v $
// Revision 1.15  2010/06/09 11:28:28  oman
// - fix: {RequestLink:217680883}
//
// Revision 1.14  2008/06/26 07:54:35  mmorozov
// - new: ������� ������������ (CQ: OIT5-23252);
//
// Revision 1.13  2008/02/27 06:10:06  mmorozov
// - new: � �� ���� �������� ����������� �������� � ������� ������������ (CQ: OIT5-28426);
//
// Revision 1.12  2008/02/26 13:15:46  mmorozov
// - new: ���������� �������� �������� (CQ: OIT5-28426);
//
// Revision 1.11  2007/08/31 09:57:08  mmorozov
// - bugfix: ��� ��������� ������������ ��������� ��������� ���������� � ��� � ������� (CQ: OIT5-26555);
//
// Revision 1.10  2007/08/13 07:06:33  mmorozov
// - new: ��������� �������� "������" ��� ������ � xml-��;
// - change: ������������� ������ �������, ��� ������������ �������������� ������� (CQ: OIT5-25922);
//
// Revision 1.9  2007/06/29 06:05:18  mmorozov
// - bugfix: �������� �� ��� ����� � ������ ������� ��������� ������ � ������ (CQ: OIT5-25586);
//
// �����������:
// - ������ ��������������� �������� ��� ������ � ���������� ���������� XMLDocument;
// - ��������� ��������� ������� ��� ������ ��������, ������/������ ��� ��������;
// - �������������� ����� ������������ ����� ��� ������ � ���������� ������������;
// - ������������� ������������ ���� ���������;
// - ������������ ������������ ������������ ���� ��� �� ������� ����������, � �� ������ ��� ��� ������;
// - �������� �������� ������ "������" � "���������" ���������, � �������� ��������� �������� ���������� 'jrn', 'sts'. ����� �������, � ����� ����, ��� ��������� ������ ����� ������� ����� ��� � � �������;
//
// Revision 1.8  2007/02/06 14:05:56  mmorozov
// - MERGE WITH B_NEMESIS_6_4;
//
// Revision 1.6.4.2  2007/02/06 08:43:08  mmorozov
// - new behaviour: �� ������� �� ������� ��� ��������� ������ �� ������������ ��������������\���������� ������������ + ����������� ��������� ����� �� �������������� ������������ �� ������� (CQ: OIT5-24236);
//
// Revision 1.6.4.1  2007/01/22 13:49:54  mmorozov
// - new: ����� �������� ��������� ������������ (CQ: OIT5-24141);
//
// Revision 1.6  2006/10/04 10:23:38  mmorozov
// - bugfix: �� ������� �������� "�������� � ��������� ���";
//
// Revision 1.5  2006/10/04 08:45:21  mmorozov
// - new: � ������ ������ ���������� ������� � �������� ������������;
// - new: ������������ ����������� � ���������� � �� ������������ ������� ��������  � ������� ��������, �� �������� ����� ������� ���������� ������ �� ��������� �����������, ���������� ������ � ����������� �� ���������� �������; � ������ ��������� ������������� �� ������������ �� ������� �������� ��������������� �����������;
// - new: ����� ������ ������ � �����;
//
// Revision 1.4  2006/08/07 08:50:45  mmorozov
// - new: ������������ ������� ������� (CQ: OIT500022171);
//
// Revision 1.3  2006/06/02 14:40:47  mmorozov
// - new: �������� DLL-�� �� ������;
// - new: ��������� ��������� ������ ������� dll-��;
//

interface

uses
  SysUtils
  ;

type
  EhcDuplicateAnswer = class(Exception);
    // - ����� ��� ��� ��������� (RV_DUPLICATED).
  EhcBadXml = class(Exception);
    // - ����������� ����������� XML (RV_BAD_XML);
  EhcError = class(Exception);
    // - ��������� ���������� ������, ������ �� ����� ���� ���������;
  EhcInvalidNumber = class(Exception);
    // - ������������ ����� �������� ��� ��������;
  EhcAccessDenied = class(Exception);
    // - ������ ��� ������� � ���-� ��� ��;

  PhcConsultationId = ^ThcConsultationId;
  ThcConsultationId = record
   rQueryId    : String;
   rVersion    : String;
  end;//ThcConsultationId

  ThcNotification = (
  {* ���� �����������. }
   n_DeleteAnswerFromJournal,
    // - ������� ����� �� �������;
   n_QueryDataChanged
    // - ������ ������� ����������;
  );//ThcNotification

  ThcAnswerType = (
   {* ��� ������. }
    atAnswer,
    atNotification,
    atNone
  );

  ThcWorkMode = (
  {* ���������� ����� ������ �������������. }
    wmAuto,
     // - ��������������
    wmManual,
     // - ������
    wmNone
  );

  ThcQueryStatus = (
  {* ��������� �������. }
    qsNone,
    qsSent,
    qsNotificationSent,
    qsAnswerSent,
    qsApplied,
    qsRefused,
    qsMarkReceived
  );//ThcQueryStatus

  IhcManager = interface(IUnknown)
  ['{857DF2F3-D52D-42F7-9D51-C58C847E42EF}']
  // public methods
    function NextQuery: String;
      {* - �������� ��������� ������. }
    function NextMark: String;
      {* - �������� ������. }
    procedure SetAnswer(const aFileName: String);
      {* - ��������� �����. }
    function MakeQueryManual(const aCardId    : String;
                             const aProductId : String;
                             const aQuery     : String): String;
      {* - ������������ XML ��� ������� ����������� �� ����� ������
           ������������. }
    function PrintQueryStatus(const aFileName: String): String;
      {* - �������� ������� ������������ � ������� XML. }
    function DeleteQuery(const aFileName: String): String;
      {* - �������� ������� ������������ � ������� XML. }
    procedure SignImportConsultation(const aSourceFile : String;
                                     const aDestFile   : String);
      {* - ��������� ������������� ������������. }
  end;//IhcManager

  IhcQuery = interface(IUnknown)
  {* ������� ������� ������. }
  ['{6BDF37BA-6102-47C6-ACD7-6AC4AE1D8EF8}']
    function pm_GetTime: TDateTime;
      {* - ����� ������. }
    function pm_GetId: ThcConsultationId;
    procedure pm_SetId(const aValue: ThcConsultationId);
      {* - ������������� ������������. }
    function pm_GetStatus: ThcQueryStatus;
    procedure pm_SetStatus(const aValue: ThcQueryStatus);
      {* - ������ ������������ }
  // methods
    procedure Delete;
      {* - ������� �������. }
    function Save: String;
      {-}
    procedure Load(const aData: String);
      {-}
  // properties
    property Id: ThcConsultationId
      read pm_GetId
      write pm_SetId;
      {* - ������������� ������������ (complect_id + query_id). }
    property Status: ThcQueryStatus
      read pm_GetStatus
      write pm_SetStatus;
      {* - ��� ������. }
    property Time: TDateTime
      read pm_GetTime;
      {* - ����� ������. }
  end;//IhcQuery

  IhcQueryIdList = interface(IUnknown)
   {* ������ ��������������� ��������. }
    ['{EF62BB59-A3CB-4057-A746-EDB0E9D157A5}']
    // property methods
      function pm_GetItems(aIndex: Integer): PhcConsultationId;
        {-}
      function pm_GetCount: Integer;
        {-}
    // public methods
      procedure AddQuery(const aQuery: IhcQuery);
        overload;
        {* - �������� ������������� ������������. }
      procedure AddQuery(const aId      : String;
                         const aVersion : String);
        overload;
        {* - �������� ������������� ������������. }
    // properties
      property Items[aIndex: Integer]: PhcConsultationId
        read pm_GetItems;
        {-}
      property Count: Integer
        read pm_GetCount;
        {-}
  end;//IhcQueryIdList

  IhcQueryBuilder = interface(IUnknown)
   {* ����������� �������� � ������� ������������. }
    ['{17AB9E20-F9C9-4C12-9563-740A698118F4}']
    // property methods
      function pm_GetAnswerXML: String;
        {* - ����� ������� ������������. }
      function pm_GetQueryXML: String;
        {* - ������ � ������� ������������. }
    // public methods
      procedure Build(const aQueryId: IhcQueryIdList);
        {* - ��������� ������ � ������� ������������. }
    // properties
      property AnswerXML: String
        read pm_GetAnswerXML;
        {* - ����� ������� ������������. }
      property QueryXML: String
        read pm_GetQueryXML;
        {* - ������ � ������� ������������. }
  end;//IhcQueryBuilder

  IhcJournal = interface(IUnknown)
  {* ������ ������. }
  ['{E9617EB8-062D-4443-909D-C8C09C1DFA9D}']
  // property methods
    function pm_GetItem(const anIndex: Integer): IhcQuery;
      {-}
    function pm_GetCount: Integer;
      {-}
  // methods
    function AddQuery(const aTime   : TDateTime;
                      const aId     : ThcConsultationId;
                      const aStatus : ThcQueryStatus): IhcQuery;
      {* - �������� �����. }
    procedure Save(const aFileName: String);
      {-}
    procedure Load(const aFileName: String);
      {-}
    procedure Delete(const aId: ThcConsultationId);
      {-}
    procedure Clear;
      {-}
    procedure UpdateQueryStatus(const aId     : ThcConsultationId;
                                const aStatus : ThcQueryStatus);
      {-}
  // properties
    property Items[const anIndex: Integer]: IhcQuery
      read pm_GetItem;
      {-}
    property Count: Integer
      read pm_GetCount;
      {-}
  end;

  ThcStreamType = (stNone, stNextQuery, stNextMark);
    {* - ��� ������. }

implementation

end.