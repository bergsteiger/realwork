unit kwSubdescriptorGetDocumentBitmapIndex;

interface

uses
 l3IntfUses
 , kwSubDescriptorFromStackWord
 , evSubPn
 , tfwScriptingInterfaces
;

type
 TkwSubdescriptorGetDocumentBitmapIndex = class(TkwSubDescriptorFromStackWord)
  {* �������� � ���� ������ ������ ��� ����������� ����� ���������.
������:
[code]
aSubDescrObj subdescriptor:GetDocumentBitmapIndex
[code] }
  procedure DoWithSubDescriptor(aControl: TevSubDescriptor;
   const aCtx: TtfwContext);
 end;//TkwSubdescriptorGetDocumentBitmapIndex
 
implementation

uses
 l3ImplUses
;

end.
