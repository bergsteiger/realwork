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
  {* Помещает в стек индекс иконки для отображения метки блока
Формат:
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
