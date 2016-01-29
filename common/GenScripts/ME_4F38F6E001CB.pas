unit kwPopEditorBlockResize;

interface

uses
 l3IntfUses
 , kwBlockResize
 , tfwScriptingInterfaces
 , nevTools
;

type
 TkwPopEditorBlockResize = class(TkwBlockResize)
  {* *Формат:
aDelta aTop anEditor  pop:editor:BlockResize
* aDelta - смещение блока
* aTop - true чтобы двигать верхнюю границу
* anEditor - редактор, в котором изменяется блок. }
  procedure CorrectBlockPoint(const aCtx: TtfwContext;
   var aMap: InevMap;
   var aCursor: InevBasePoint);
 end;//TkwPopEditorBlockResize
 
implementation

uses
 l3ImplUses
;

end.
