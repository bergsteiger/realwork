unit l3Castable.imp;

interface

uses
 l3IntfUses
 , l3Interfaces
;

type
 _l3Castable_ = class
  {* �����-������� � ������� QueryInterface }
  function QueryInterface(const IID: TGUID;
   out Obj): HResult; stdcall;
   {* �������� ������� ��������� � ��������������, ���� ��� ��������. }
 end;//_l3Castable_
 
implementation

uses
 l3ImplUses
;

end.
