unit kwSubdescriptorGetBitmapIndex;

interface

uses
 l3IntfUses
 , kwSubDescriptorFromStackWord
 , evSubPn
 , tfwScriptingInterfaces
;

type
 TkwSubdescriptorGetBitmapIndex = class(TkwSubDescriptorFromStackWord)
  {* �������� � ���� ������ ��� ����������� ������� �����
������:
[code]
aSubDescrObj subdescriptor:GetBitmapIndex
[code] }
  procedure DoWithSubDescriptor(aControl: TevSubDescriptor;
   const aCtx: TtfwContext);
 end;//TkwSubdescriptorGetBitmapIndex
 
implementation

uses
 l3ImplUses
;

end.
