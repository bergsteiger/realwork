unit RefCountedPrim.imp;

interface

uses
 l3IntfUses
;

type
 _RefCountedPrim_ = class(MObject)
  procedure Cleanup;
   {* ������� ������� ����� �������. }
  function Use: Pointer;
   {* ��������� ������� ������ �� 1 � ������� ��������� �� ����. }
  function SetRefTo(var F): Boolean;
  procedure BeforeRelease;
  procedure Release;
 end;//_RefCountedPrim_
 
implementation

uses
 l3ImplUses
 , Windows
;

end.
