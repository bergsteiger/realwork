unit StackTest.imp;

interface

uses
 l3IntfUses
 , TestFrameWork
;

type
 TEtalonData = ItemsHolder;
 
 // _StackType_
 
 _StackTest_ = class(TTestCase)
  procedure DoDoIt;
  function GetEtalonData: TEtalonData;
  function ArrayToEtalon(const aData: EtalonData): TEtalonData;
   {* ��������������� ������� ����������� ������, ��� ������������ ������� ����� � �������� ����������� ���������, � ������� - ��� }
  procedure DoIt;
 end;//_StackTest_
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
