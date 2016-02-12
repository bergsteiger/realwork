unit HCInterfacesUnit;
 {* ���������� ��� �������������� � ������� ������ }

// ������: "w:\garant6x\implementation\Garant\tie\Garant\HCAdapterLib\HCInterfacesUnit.pas"
// ���������: "Interfaces"

{$Include nsDefine.inc}

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
  function get_data: IStream;
   {* ��������� ������ �������. ������������ ������ (������) � XML ������� (�������� �� � ���������). }
  procedure data_received;
   {* ������������� ��������� ������ �������� �������. ��� ������ ����� ������ ������ ���������� ��� ���������� �� ��������� (��� ��������� ������, ��� ��������� ������������). }
 end;//IConsultingData

 TResultValue = (
  {* ��������� �������� ������������ �������� ������� }
  RV_SUCCESS
   {* ������� ���������� ������� }
  , RV_DUPLICATED
   {* ������ � ���� ��� �������, ��� ����������. }
  , RV_EMPTY
   {* �� ������ ������ ��� �������� ������� ���� }
  , RV_ERROR
   {* ������� �� ������� �������� �����, ��� �������� ��� � ����, ��� ��������� ��� �����-�� ���������� ����. � ���� ������ ���������� ��������� ������� ������ ������. }
  , RV_BAD_XML
   {* ������ ������ �� ������������� "���������" �������. }
  , RV_COMPLECT_REMOVED_ERROR
   {* �������� ��� ����� �� ���-� (http://mdp.garant.ru/pages/viewpage.action?pageId=118982402) }
  , RV_INVALID_QUERY_ID
   {* ������� �������������� ��� � ���� }
 );//TResultValue

 TQueryID = PAnsiChar;

 CantFindXerces = class
  {* �� ������ ��������� ���������� ��� ������ � XML }
 end;//CantFindXerces

 IOnlineData = interface(IConsultingData)
  {* ������������, ���������� ����� ��. ����� ���������� �������������. }
  ['{43387100-5C41-4CCB-83EB-4EE5BB99C443}']
  class function make(var xml_stream: IStream;
   const consultation_id): BadFactoryType;
   {* ������� ��� ��������� ���������� }
 end;//IOnlineData

 IBusinessLogicLifeCycle = interface
  {* ��������� ��� ���������� ��������� ������ ������-�������� �������� }
  ['{AC92D75F-442C-4FFE-897D-23499B1BBC34}']
  procedure start;
   {* ����� ������ ���� ������ ������ ����� �������� dll ���������� }
  procedure stop;
   {* ����� ������ ���� ������ ����� ����������� ������ ���������� }
  procedure get_consultation_manager70;
   {* �������� ��������� � ��  ������ 7 }
 end;//IBusinessLogicLifeCycle

 IConsultingRequests = interface
  {* ��������� ��� ��������� �������� �� ������������� � �� ������. }
  ['{EB5AE11E-74DA-4DFE-950B-CE68586C28F1}']
  function get_query_by_id(query_id: TQueryID;
   out data: IConsultingData): TResultValue;
   {* �������� ��������� ������ ��� ��������� }
  function get_next_mark(out data: IConsultingData): TResultValue;
   {* ��������� ��������� ������ �� ������.
��� ������ ���� �������� ���������� �������� ������� "������" ��� ��������� ������. �� ��� ��� ���� �� ����� �������� ����� DataRecieved, ��� �������� ����� ���������� ���� ������.
���� ��� �� ������ ������ �������, ����������� ������ ������������, ������������ ������� ������. }
  function set_answer(var answer: IStream): TResultValue;
   {* ����� �� ������ ��� ��������������� ����������� � ������ ��������� �������.
����� �������� � XML ������� (�������� c�. � ���������).
�������� ������������ ��������:
[0] - ���� ����� ������� ������� � ����.
[1] - ���� ������ � ���� ��� �������, ��� ����������.
[-1] - ���� ������� �� ������� �������� �����, ��� �������� ��� � ����, ��� ��������� ��� �����-�� ���������� ����. � ���� ������ ���������� ��������� ������� ������ ������.
[-2] - ���� ������ ������ �� ������������� "���������" �������. }
  function get_status_statistic(var query: IStream;
   out result: IStream): TResultValue;
   {* ������� ����� ������� ������������ � ���� �� ��������� ����������� �� �� ���������������. }
  function erase_queries_by_id(var query: IStream;
   out result: IStream): TResultValue;
   {* ������� ������� �� ���� �� }
  function sign_query(var query: IStream;
   out signed_query: IStream): TResultValue;
   {* �������� � xml ����������� ����� }
  function get_list_of_new_queries(out result: IStream): TResultValue;
   {* �������� ������ ��������������� ������������, ������� ����� ������� �� ��������� � ��� }
 end;//IConsultingRequests

class function make: BadFactoryType;
 {* ������������ ������� ������� }
class function make: BadFactoryType;
 {* �������� ��������� ������  � ��������� ���������������� ������ }

implementation

uses
 l3ImplUses
;

class function make: BadFactoryType;
 {* ������������ ������� ������� }
var
 l_Inst : IBusinessLogicLifeCycle;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
 {* �������� ��������� ������  � ��������� ���������������� ������ }
var
 l_Inst : IConsultingRequests;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
