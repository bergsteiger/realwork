unit ProgressIndicatorSupportUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/ProgressIndicatorSupportUnit.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ProgressIndicatorSupport
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

type
 IProgressIndicator = interface(IUnknown)
  {* ��������� ��� �������� ����� ��� ���������� ��������� �� �������.
������ ��������������� ������������� ��������. }
   ['{885E85E3-E74C-4413-8408-2FB7533E7F8A}']
   function GetMaxCount: Integer; stdcall;
   procedure SetCurrent(aCurCount: Integer;
    aArg: Integer
    {* �������������� ��������.}); stdcall;
     {* ��������� ��������� ����������� ��������.
� �������� ��������� cur_count �������� ���� ����� ��� ������������ ���������, ����������� ������� � ���������� ��������, ���� ����� <=100 (��� ��������� � %). }
   property max_count: Integer
     read GetMaxCount;
 end;//IProgressIndicator

 ICancelLongProcess = interface(IUnknown)
  {* ��������� ��� ����������� ���������� ���������� �������� �� �������. ������������ � ���������� IProgressIndicator. }
   ['{CD915CB2-6E7A-4788-A5B0-ED90959D8399}']
   procedure CancelProcess; stdcall;
     {* ���������� ��� ���������� ����������� ��������. }
 end;//ICancelLongProcess

implementation

end.