unit kwIterateSubDecriptorsOnSubPanelEX;

interface

uses
 l3IntfUses
 , kwIterateSubDecriptorsOnSubPanel
 , tfwScriptingInterfaces
 , evSubPn
 , evSubPanelSub
;

type
 TkwIterateSubDecriptorsOnSubPanelEX = class(TkwIterateSubDecriptorsOnSubPanel)
  {* Перебирает все SubDescriptot на SubPanel, которые *могут быть* отрисованы (!). Т.е. проверка на Visible не производится. Если это нужно, то можно реализвать в скриптах. 
Формат:
[code]
@ aWord aLayerID aSubPanel IterateSubDecriptorsOnSubPanelEX
[code]
aLayerID - слой, в котором производится итерация
aSubPanel - контрол сабпанели.
aWord - функция для обработки вида:
[code]
PROCEDURE CheckDescription OBJECT IN aSubDescription OBJECT IN aSubPanelSub
 // А здесь обрабатываем полученный aSubDescription
;
[code]
Для извлечения нужной инфорации из aSubDescription есть набор функций: subdescriptor:GetDrawType и т.п.
aSubPanelSub - визуальное представление метки. }
 end;//TkwIterateSubDecriptorsOnSubPanelEX
 
implementation

uses
 l3ImplUses
 , evSubPanelSubArray
 , evSubPanelSubCollection
;

end.
