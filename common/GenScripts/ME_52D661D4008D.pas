unit kwSubdescriptorGetVisible;

interface

uses
 l3IntfUses
 , kwSubDescriptorFromStackWord
 , evSubPn
 , tfwScriptingInterfaces
;

type
 TkwSubdescriptorGetVisible = class(TkwSubDescriptorFromStackWord)
  {* �������� � ���� �������� �����.
������:
[code]
aSubDescrObj subdescriptor:GetVisible
[code] }
  procedure DoWithSubDescriptor(aControl: TevSubDescriptor;
   const aCtx: TtfwContext);
 end;//TkwSubdescriptorGetVisible
 
implementation

uses
 l3ImplUses
;

end.
