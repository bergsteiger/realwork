unit kwSubdescriptorGetBlockBitmapIndex;

interface

uses
 l3IntfUses
 , kwSubDescriptorFromStackWord
 , evSubPn
 , tfwScriptingInterfaces
;

type
 TkwSubdescriptorGetBlockBitmapIndex = class(TkwSubDescriptorFromStackWord)
  {* �������� � ���� ������ ������ ��� ����������� ����� �����
������:
[code]
aSubDescrObj subdescriptor:GetBlockBitmapIndex
[code] }
  procedure DoWithSubDescriptor(aControl: TevSubDescriptor;
   const aCtx: TtfwContext);
 end;//TkwSubdescriptorGetBlockBitmapIndex
 
implementation

uses
 l3ImplUses
;

end.
