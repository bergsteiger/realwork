unit kwSubdescriptorGetColumn;

interface

uses
 l3IntfUses
 , kwSubDescriptorFromStackWord
 , evSubPn
 , tfwScriptingInterfaces
;

type
 TkwSubdescriptorGetColumn = class(TkwSubDescriptorFromStackWord)
  {* �������� � ���� ����� �������.
������:
[code]
aSubDescrObj subdescriptor:GetColumn
[code] }
  procedure DoWithSubDescriptor(aControl: TevSubDescriptor;
   const aCtx: TtfwContext);
 end;//TkwSubdescriptorGetColumn
 
implementation

uses
 l3ImplUses
;

end.
