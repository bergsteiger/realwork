unit kwIterateSubDecriptorsOnSubPanel;

interface

uses
 l3IntfUses
 , kwSubPanelFromStackWord
 , tfwScriptingInterfaces
 , evSubPn
 , evSubPanelSub
;

type
 TkwIterateSubDecriptorsOnSubPanel = class(TkwSubPanelFromStackWord)
  {* Перебирает все SubDescriptot на SubPanel, которые *могут быть* отрисованы (!). Т.е. проверка на Visible не производится. Если это нужно, то можно реализвать в скриптах. 
Формат:
[code]
@ aWord aLayerID aSubPanel IterateSubDecriptorsOnSubPanel
[code]
aLayerID - слой, в котором производится итерация
aSubPanel - контрол сабпанели.
aWord - функция для обработки вида:
[code]
PROCEDURE CheckDescription OBJECT IN aSubDescription INTEGER IN aHandle
 // А здесь обрабатываем полученный aSubDescription
;
[code]
Для извлечения нужной инфорации из aSubDescription есть набор функций: subdescriptor:GetDrawType и т.п.
aHandle - номер саба, к которому рисуется метка. }
  procedure PushObjData(const aCtx: TtfwContext;
   aSubDescription: TevSubDescriptor;
   aSubPanelSub: TevSubPanelSub);
  procedure DoWithSubPanel(aControl: TevCustomSubPanel;
   const aCtx: TtfwContext);
 end;//TkwIterateSubDecriptorsOnSubPanel
 
implementation

uses
 l3ImplUses
 , evSubPanelSubCollection
 , evSubPanelSubArray
;

end.
