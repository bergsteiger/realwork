unit k2NullTagImpl;

interface

uses
 l3IntfUses
 , k2NullTagImplPrim
;

type
 Tk2NullTagImpl = class(Tk2NullTagImplPrim)
  {* ���������� ������� ���� }
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
 end;//Tk2NullTagImpl
 
implementation

uses
 l3ImplUses
;

end.
