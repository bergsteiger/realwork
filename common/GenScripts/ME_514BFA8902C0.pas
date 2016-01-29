unit kwPopEditorBlockResizeEX;

interface

uses
 l3IntfUses
 , kwBlockResize
 , tfwScriptingInterfaces
 , nevTools
;

type
 TkwPopEditorBlockResizeEX = class(TkwBlockResize)
  {* *Формат:
aDelta aTop aLevel anEditor  pop:editor:BlockResizeEX
* aDelta - смещение блока
* aTop - true чтобы двигать верхнюю границу
* aLevel - уровень изменяемого блока.
* anEditor - редактор, в котором изменяется блок. }
  procedure CorrectBlockPoint(const aCtx: TtfwContext;
   var aMap: InevMap;
   var aCursor: InevBasePoint);
 end;//TkwPopEditorBlockResizeEX
 
implementation

uses
 l3ImplUses
;

end.
