unit vtOutlinerWithDragDropRes;
 {* Ресурсы для TvtOutlinerWithDragDrop }

// Модуль: "w:\common\components\gui\Garant\VT\vtOutlinerWithDragDropRes.pas"
// Стереотип: "UtilityPack"

{$Include vtDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки TreeViewMessages }
 str_nsc_MultiSelectDraggingText: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_MultiSelectDraggingText'; rValue : 'Всего: %d');
  {* 'Всего: %d' }

implementation

uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_nsc_MultiSelectDraggingText.Init;
 {* Инициализация str_nsc_MultiSelectDraggingText }

end.
