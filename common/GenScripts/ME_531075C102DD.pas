unit k2NonOptimizeContext;

interface

uses
 l3IntfUses
 , k2Context
;

type
 Tk2NonOptimizeContext = class(Tk2Context)
  procedure Create;
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
 end;//Tk2NonOptimizeContext
 
implementation

uses
 l3ImplUses
;

end.
