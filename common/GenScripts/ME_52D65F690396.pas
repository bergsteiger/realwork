unit kwSubdescriptorGetDrawType;

interface

uses
 l3IntfUses
 , kwSubDescriptorFromStackWord
 , evSubPn
 , tfwScriptingInterfaces
;

type
 TkwSubdescriptorGetDrawType = class(TkwSubDescriptorFromStackWord)
  {* �������� � ���� ��� ����������� ����� � ���� ������ �����.
������:
[code]
aSubDescrObj subdescriptor:GetDrawType
[code] }
  procedure DoWithSubDescriptor(aControl: TevSubDescriptor;
   const aCtx: TtfwContext);
 end;//TkwSubdescriptorGetDrawType
 
implementation

uses
 l3ImplUses
;

end.
