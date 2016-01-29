unit kwIterateSubDescriptors;

interface

uses
 l3IntfUses
 , kwSubPanelFromStackWord
 , evSubPn
 , tfwScriptingInterfaces
;

type
 TkwIterateSubDescriptors = class(TkwSubPanelFromStackWord)
  {* Перебирает все SubDescriptot на SubPanel, которые могут быть использованы (!). Такой список задается на этапе проектирвоания/изменения компонета. И не зависит от вида отображения.
Формат:
[code]
@ aWord aLayerID aSubPanel ItarateSubDescriptors
[code]
aLayerID - слой, в котором производится итерация
aSubPanel - контрол сабпанели.
aWord - функция для обработки вида:
[code]
PROCEDURE CheckDescription OBJECT IN aSubDescription
 // А здесь обрабатываем полученный aSubDescription
;
[code]
Для извлечения нужной инфорации из aSubDescription есть набор функций: subdescriptor:GetDrawType и т.п. }
  procedure DoWithSubPanel(aControl: TevCustomSubPanel;
   const aCtx: TtfwContext);
 end;//TkwIterateSubDescriptors
 
implementation

uses
 l3ImplUses
;

end.
