unit HCInterfacesUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "HCAdapterLib"
// ������: "w:/garant6x/implementation/Garant/tie/Garant/HCAdapterLib/HCInterfacesUnit.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::HCAdapterLib::HCInterfaces
//
// ���������� ��� �������������� � ������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  IOUnit
  ;

type
 IConsultingData = interface(IUnknown)
  {* ��������� ��� ��������� � ������������� ����� ��������� �������. }
   ['{E92828ED-9B9A-4302-8D42-37E413C6F434}']
   procedure GetData(out aRet {: IStream}); stdcall;
     {* ��������� ������ �������. ������������ ������ (������) � XML ������� (�������� �� � ���������). }
   procedure DataReceived; stdcall;
     {* ������������� ��������� ������ �������� �������. ��� ������ ����� ������ ������ ���������� ��� ���������� �� ��������� (��� ��������� ������, ��� ��������� ������������). }
 end;//IConsultingData

 TResultValue = (
  {* ��������� �������� ������������ �������� ������� }
   RV_SUCCESS // ������� ���������� �������
 , RV_DUPLICATED // ������ � ���� ��� �������, ��� ����������.
 , RV_EMPTY // �� ������ ������ ��� �������� ������� ����
 , RV_ERROR // ������� �� ������� �������� �����, ��� �������� ��� � ����, ��� ��������� ��� �����-�� ���������� ����. � ���� ������ ���������� ��������� ������� ������ ������.
 , RV_BAD_XML // ������ ������ �� ������������� "���������" �������.
 , RV_COMPLECT_REMOVED_ERROR // �������� ��� ����� �� ���-� (http://mdp.garant.ru/pages/viewpage.action?pageId=118982402)
 , RV_INVALID_QUERY_ID // ������� �������������� ��� � ����
 );//TResultValue

 TQueryID = PAnsiChar;

 CantFindXerces = class
  {* �� ������ ��������� ���������� ��� ������ � XML }
 end;//CantFindXerces

 IOnlineData = interface(IConsultingData)
  {* ������������, ���������� ����� ��. ����� ���������� �������������. }
   ['{43387100-5C41-4CCB-83EB-4EE5BB99C443}']
 end;//IOnlineData

const
  { ��������� ��� �������� ������������. }
 STATISTIC_PACKET_SIZE_PARAMETER : PAnsiChar = -StatisticPacketSize;
  { �������� ��������� ������, �������� ������������ ���������� ������������, ������� ����� ���� �������� �� ��� � �� (�� ����������� ����������� �� ���������� ������������, ������������ � ����� GetStatusStatistic) }
 STATISTIC_PACKET_SIZE : size = 500;
  { �������� ��-��������� ��� ������������� ���������� ������������, ������� ����� ���� �������� �� ��� � �� (�� ����������� ����������� �� ���������� ������������, ������������ � ����� GetStatusStatistic) }
 STATISTIC_SLEEP_TIME_PARAMETER : PAnsiChar = -StatisticSleepTime;
  { �������� ��������� ������, �������� ����� �������� ����� �������� �������� �� ���������� ��� ������� ����� ������������. }
 STATISTIC_SLEEP_TIME : unsigned integer = 1;
  { ����� �������� � �������� ����� �������� �������� �� ���������� ��� ������� ����� ������������. }

type
 IBusinessLogicLifeCycle = interface(IUnknown)
  {* ��������� ��� ���������� ��������� ������ ������-�������� �������� }
   ['{AC92D75F-442C-4FFE-897D-23499B1BBC34}']
   procedure Start; stdcall;
     {* ����� ������ ���� ������ ������ ����� �������� dll ���������� }
   procedure Stop; stdcall;
     {* ����� ������ ���� ������ ����� ����������� ������ ���������� }
   procedure GetConsultationManager70; stdcall;
     {* �������� ��������� � ��  ������ 7 }
 end;//IBusinessLogicLifeCycle

const
  { ��������� �������� ������ � xml ��� �������� �������� �� ����. }
 EES_INVALID_STATUS : PAnsiChar = INVALID_STATUS;
  { ������������ � ������� �������� �� ����� ���� ������� (����� � ������� ���������� ������� ������� force="yes") }
 EES_NOT_FOUND : PAnsiChar = NOT_FOUND;
  { ������������ � �������� ��������������� �� ������� (�������� ��������� �� ���� 6-�� � ���� 7-��) }
 EES_UNKNOWN : PAnsiChar = UNKNOWN;
  { ���������� ������ �� }
  { ����� ������ ������ ��� ���������� ������������ }
 QUERY70 : PAnsiChar = QUERY70;
 MARK70 : PAnsiChar = MARK70;

type
 IConsultingRequests = interface(IUnknown)
  {* ��������� ��� ��������� �������� �� ������������� � �� ������. }
   ['{EB5AE11E-74DA-4DFE-950B-CE68586C28F1}']
   function GetQueryById(aQueryId: TQueryID;
    out aData: IConsultingData): TResultValue; stdcall;
     {* �������� ��������� ������ ��� ��������� }
   function GetNextMark(out aData: IConsultingData): TResultValue; stdcall;
     {* ��������� ��������� ������ �� ������.
��� ������ ���� �������� ���������� �������� ������� "������" ��� ��������� ������. �� ��� ��� ���� �� ����� �������� ����� DataRecieved, ��� �������� ����� ���������� ���� ������.
���� ��� �� ������ ������ �������, ����������� ������ ������������, ������������ ������� ������. }
   function SetAnswer(var aAnswer: IStream): TResultValue; stdcall;
     {* ����� �� ������ ��� ��������������� ����������� � ������ ��������� �������.
����� �������� � XML ������� (�������� c�. � ���������).
�������� ������������ ��������:
[0] - ���� ����� ������� ������� � ����.
[1] - ���� ������ � ���� ��� �������, ��� ����������.
[-1] - ���� ������� �� ������� �������� �����, ��� �������� ��� � ����, ��� ��������� ��� �����-�� ���������� ����. � ���� ������ ���������� ��������� ������� ������ ������.
[-2] - ���� ������ ������ �� ������������� "���������" �������. }
   function GetStatusStatistic(var aQuery: IStream;
    out aResult: IStream): TResultValue; stdcall;
     {* ������� ����� ������� ������������ � ���� �� ��������� ����������� �� �� ���������������. }
   function EraseQueriesById(var aQuery: IStream;
    out aResult: IStream): TResultValue; stdcall;
     {* ������� ������� �� ���� �� }
   function SignQuery(var aQuery: IStream;
    out aSignedQuery: IStream): TResultValue; stdcall;
     {* �������� � xml ����������� ����� }
   function GetListOfNewQueries(out aResult: IStream): TResultValue; stdcall;
     {* �������� ������ ��������������� ������������, ������� ����� ������� �� ��������� � ��� }
 end;//IConsultingRequests

implementation

end.