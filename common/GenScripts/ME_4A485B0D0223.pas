unit evStyleTableListenerPrim.imp;

interface

uses
 l3IntfUses
 , afwInterfaces
;

type
 _evStyleTableListenerPrim_ = class(IafwStyleTableSpy, Ml3Unknown)
  procedure DoStyleTableChanged;
  function NeedListen: Boolean;
   {* ����� �� ������������� � ������� ������ (����� �� ��� �����������) }
  function AtEnd: Boolean;
   {* ������������� � ����� ������ ����������� }
  procedure StyleTableChanged;
   {* ������� ������ ����������. }
 end;//_evStyleTableListenerPrim_
 
implementation

uses
 l3ImplUses
 , evStyleTableSpy
;

end.
