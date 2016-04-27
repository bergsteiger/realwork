unit HCInterfacesUnit;
 {* ���������� ��� �������������� � ������� ������ }

// ������: "w:\garant6x\implementation\Garant\tie\Garant\HCAdapterLib\HCInterfacesUnit.pas"
// ���������: "Interfaces"
// ������� ������: "HCInterfaces" MUID: (442BEF93030D)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
;

const
 {* ��������� ��� �������� ������������. }
 STATISTIC_PACKET_SIZE_PARAMETER: PAnsiChar = -StatisticPacketSize;
  {* �������� ��������� ������, �������� ������������ ���������� ������������, ������� ����� ���� �������� �� ��� � �� (�� ����������� ����������� �� ���������� ������������, ������������ � ����� GetStatusStatistic) }
 STATISTIC_PACKET_SIZE: size = 500;
  {* �������� ��-��������� ��� ������������� ���������� ������������, ������� ����� ���� �������� �� ��� � �� (�� ����������� ����������� �� ���������� ������������, ������������ � ����� GetStatusStatistic) }
 STATISTIC_SLEEP_TIME_PARAMETER: PAnsiChar = -StatisticSleepTime;
  {* �������� ��������� ������, �������� ����� �������� ����� �������� �������� �� ���������� ��� ������� ����� ������������. }
 STATISTIC_SLEEP_TIME: unsigned integer = 1;
  {* ����� �������� � �������� ����� �������� �������� �� ���������� ��� ������� ����� ������������. }
 {* ��������� �������� ������ � xml ��� �������� �������� �� ����. }
 EES_INVALID_STATUS: PAnsiChar = INVALID_STATUS;
  {* ������������ � ������� �������� �� ����� ���� ������� (����� � ������� ���������� ������� ������� force="yes") }
 EES_NOT_FOUND: PAnsiChar = NOT_FOUND;
  {* ������������ � �������� ��������������� �� ������� (�������� ��������� �� ���� 6-�� � ���� 7-��) }
 EES_UNKNOWN: PAnsiChar = UNKNOWN;
  {* ���������� ������ �� }
 {* ����� ������ ������ ��� ���������� ������������ }
 QUERY70: PAnsiChar = QUERY70;
 MARK70: PAnsiChar = MARK70;

type
 IConsultingData = interface
  {* ��������� ��� ��������� � ������������� ����� ��������� �������. }
  ['{E92828ED-9B9A-4302-8D42-37E413C6F434}']
  function GetData: IStream; stdcall;
   {* ��������� ������ �������. ������������ ������ (������) � XML ������� (�������� �� � ���������). }
  procedure DataReceived; stdcall;
   {* ������������� ��������� ������ �������� �������. ��� ������ ����� ������ ������ ���������� ��� ���������� �� ��������� (��� ��������� ������, ��� ��������� ������������). }
 end;//IConsultingData

 TResultValue = (
  {* ��������� �������� ������������ �������� ������� }
  RV_SUCCESS = 0
   {* ������� ���������� ������� }
  , RV_DUPLICATED = 1
   {* ������ � ���� ��� �������, ��� ����������. }
  , RV_EMPTY = 2
   {* �� ������ ������ ��� �������� ������� ���� }
  , RV_ERROR = -1
   {* ������� �� ������� �������� �����, ��� �������� ��� � ����, ��� ��������� ��� �����-�� ���������� ����. � ���� ������ ���������� ��������� ������� ������ ������. }
  , RV_BAD_XML = -2
   {* ������ ������ �� ������������� "���������" �������. }
  , RV_COMPLECT_REMOVED_ERROR = -3
   {* �������� ��� ����� �� ���-� (http://mdp.garant.ru/pages/viewpage.action?pageId=118982402) }
  , RV_INVALID_QUERY_ID = -4
   {* ������� �������������� ��� � ���� }
 );//TResultValue

 TQueryID = PAnsiChar;

 CantFindXerces = class
  {* �� ������ ��������� ���������� ��� ������ � XML }
 end;//CantFindXerces

 IOnlineData = interface(IConsultingData)
  {* ������������, ���������� ����� ��. ����� ���������� �������������. }
  ['{43387100-5C41-4CCB-83EB-4EE5BB99C443}']
  class function Make(var xml_stream: IStream;
   const consultation_id): BadFactoryType; stdcall;
   {* ������� ��� ��������� ���������� }
 end;//IOnlineData

 IBusinessLogicLifeCycle = interface
  {* ��������� ��� ���������� ��������� ������ ������-�������� �������� }
  ['{AC92D75F-442C-4FFE-897D-23499B1BBC34}']
  procedure Start; stdcall;
   {* ����� ������ ���� ������ ������ ����� �������� dll ���������� }
  procedure Stop; stdcall;
   {* ����� ������ ���� ������ ����� ����������� ������ ���������� }
  procedure GetConsultationManager70; stdcall;
   {* �������� ��������� � ��  ������ 7 }
 end;//IBusinessLogicLifeCycle

 IConsultingRequests = interface
  {* ��������� ��� ��������� �������� �� ������������� � �� ������. }
  ['{EB5AE11E-74DA-4DFE-950B-CE68586C28F1}']
  function GetQueryById(query_id: TQueryID;
   out data: IConsultingData): TResultValue; stdcall;
   {* �������� ��������� ������ ��� ��������� }
  function GetNextMark(out data: IConsultingData): TResultValue; stdcall;
   {* ��������� ��������� ������ �� ������.
��� ������ ���� �������� ���������� �������� ������� "������" ��� ��������� ������. �� ��� ��� ���� �� ����� �������� ����� DataRecieved, ��� �������� ����� ���������� ���� ������.
���� ��� �� ������ ������ �������, ����������� ������ ������������, ������������ ������� ������. }
  function SetAnswer(var answer: IStream): TResultValue; stdcall;
   {* ����� �� ������ ��� ��������������� ����������� � ������ ��������� �������.
����� �������� � XML ������� (�������� c�. � ���������).
�������� ������������ ��������:
[0] - ���� ����� ������� ������� � ����.
[1] - ���� ������ � ���� ��� �������, ��� ����������.
[-1] - ���� ������� �� ������� �������� �����, ��� �������� ��� � ����, ��� ��������� ��� �����-�� ���������� ����. � ���� ������ ���������� ��������� ������� ������ ������.
[-2] - ���� ������ ������ �� ������������� "���������" �������. }
  function GetStatusStatistic(var query: IStream;
   out result: IStream): TResultValue; stdcall;
   {* ������� ����� ������� ������������ � ���� �� ��������� ����������� �� �� ���������������. }
  function EraseQueriesById(var query: IStream;
   out result: IStream): TResultValue; stdcall;
   {* ������� ������� �� ���� �� }
  function SignQuery(var query: IStream;
   out signed_query: IStream): TResultValue; stdcall;
   {* �������� � xml ����������� ����� }
  function GetListOfNewQueries(out result: IStream): TResultValue; stdcall;
   {* �������� ������ ��������������� ������������, ������� ����� ������� �� ��������� � ��� }
 end;//IConsultingRequests

implementation

uses
 l3ImplUses
;

type
 IOnlineDataFriend = {abstract} class(IOnlineData)
  {* ���� � ������ IOnlineData }
 end;//IOnlineDataFriend

end.
