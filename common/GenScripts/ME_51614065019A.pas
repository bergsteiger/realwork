unit RefCounted.imp;

interface

uses
 l3IntfUses
;

type
 _RefCounted_ = class(_RefCountedPrim_)
  {* � ���� ������ �������� ������, ������� ��������� ����������� � �������� �������� }
  procedure destroy;
   {* ��� ����� �� ���� �������� ����������� destroy. }
  function NewInstance: TObject;
  procedure FreeInstance;
  procedure AfterConstruction;
  procedure BeforeDestruction;
 end;//_RefCounted_
 
implementation

uses
 l3ImplUses
 , Windows
;

end.
