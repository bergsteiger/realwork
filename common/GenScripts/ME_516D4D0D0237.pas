unit UnknownImpl.imp;

interface

uses
 l3IntfUses
;

type
 _UnknownImpl_ = class(_RefCounted_)
  function __AddRef: Integer; stdcall;
   {* ����������� ������� ������. }
  function __Release: Integer; stdcall;
   {* ��������� ������� ������. }
  function QueryInterface(const IID: TGUID;
   out Obj): HResult; stdcall;
   {* �������� ������� ��������� � ��������������, ���� ��� ��������. }
 end;//_UnknownImpl_
 
implementation

uses
 l3ImplUses
 , Windows
;

end.
