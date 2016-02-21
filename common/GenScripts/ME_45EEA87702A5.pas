unit ProgressIndicatorSupportUnit;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ProgressIndicatorSupportUnit.pas"
// ���������: "Interfaces"

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
  function Get_max_count: Integer;
  procedure set_current(cur_count: Integer;
   arg: Integer
   {* �������������� ��������. });
   {* ��������� ��������� ����������� ��������.
� �������� ��������� cur_count �������� ���� ����� ��� ������������ ���������, ����������� ������� � ���������� ��������, ���� ����� <=100 (��� ��������� � %). }
  property max_count: Integer
   read Get_max_count;
 end;//IProgressIndicator

 ICancelLongProcess = interface
  {* ��������� ��� ����������� ���������� ���������� �������� �� �������. ������������ � ���������� IProgressIndicator. }
  ['{CD915CB2-6E7A-4788-A5B0-ED90959D8399}']
  procedure cancel_process;
   {* ���������� ��� ���������� ����������� ��������. }
 end;//ICancelLongProcess

implementation

uses
 l3ImplUses
;

end.
