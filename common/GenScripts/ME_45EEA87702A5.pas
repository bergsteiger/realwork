unit ProgressIndicatorSupportUnit;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ProgressIndicatorSupportUnit.pas"
// ���������: "Interfaces"
// ������� ������: "ProgressIndicatorSupport" MUID: (45EEA87702A5)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
;

type
 IProgressIndicator = interface
  {* ��������� ��� �������� ����� ��� ���������� ��������� �� �������.
������ ��������������� ������������� ��������. }
  ['{885E85E3-E74C-4413-8408-2FB7533E7F8A}']
  function GetMaxCount: Integer; stdcall;
  procedure SetCurrent(cur_count: Integer;
   arg: Integer
   {* �������������� ��������. }); stdcall;
   {* ��������� ��������� ����������� ��������.
� �������� ��������� cur_count �������� ���� ����� ��� ������������ ���������, ����������� ������� � ���������� ��������, ���� ����� <=100 (��� ��������� � %). }
  property MaxCount: Integer
   read GetMaxCount;
 end;//IProgressIndicator

 ICancelLongProcess = interface
  {* ��������� ��� ����������� ���������� ���������� �������� �� �������. ������������ � ���������� IProgressIndicator. }
  ['{CD915CB2-6E7A-4788-A5B0-ED90959D8399}']
  procedure CancelProcess; stdcall;
   {* ���������� ��� ���������� ����������� ��������. }
 end;//ICancelLongProcess

implementation

uses
 l3ImplUses
;

end.
