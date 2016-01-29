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
  {* Помещает в стек иконки для отображения обычной метки
Формат:
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
