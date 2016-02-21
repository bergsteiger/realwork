unit ContextSearchSupportUnit;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ContextSearchSupportUnit.pas"
// ���������: "Interfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
;

type
 THighlightPosition = record
  {* ������� ��� ��������� ��������� ����. }
  start: Cardinal;
   {* ������ ��������� }
  finish: Cardinal;
   {* ����� ��������� }
 end;//THighlightPosition

 IHighlightPositionList = array of THighlightPosition;
  {* ������ ������� ��� ���������. }

 TContextSearchResult = record
  {* ��������� ������ �� ���������. }
  item_index: Cardinal;
   {* ������ ���������� ��������. }
  positions: IHighlightPositionList;
   {* �������, ��������� � ���������� ������ }
 end;//TContextSearchResult

 TSearchStatus = (
  {* ���� ������. }
  SS_GLOBAL
   {* ����� �� ����� �������. }
  , SS_CURENT
   {* ����� �� �������� ��������. }
 );//TSearchStatus

 TSearchDirection = (
  {* ����������� ������. }
  SD_UP
   {* ���� �����. }
  , SD_DOWN
   {* ����� ����. }
 );//TSearchDirection

 TSearchMode = record
  {* ������������ ���, ������������ ������ ������ � �������� ���������� (�������, ������� � �.�.).
��������� ss_Global + sd_Up - ����� � ����� �����.
��������� ss_Global + sd_Down - ����� ������� ����.
��������� c ss_Current - ����� �� �������� �������� ����� ��� ����. }
  status: TSearchStatus;
   {* ��������� ������ }
  direction: TSearchDirection;
   {* ����������� ������ }
 end;//TSearchMode

implementation

uses
 l3ImplUses
;

end.
