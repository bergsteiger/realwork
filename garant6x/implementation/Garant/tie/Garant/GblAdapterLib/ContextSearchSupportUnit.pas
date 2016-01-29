unit ContextSearchSupportUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/ContextSearchSupportUnit.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ContextSearchSupport
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

type
 THighlightPosition = record
  {* Позиции для подсветки найденных слов. }
   start : Cardinal; // начало выделения
   finish : Cardinal; // конец выделения
 end;//THighlightPosition

 IHighlightPositionList = array of THighlightPosition;
  {* Список позиций для подсветки. }

 TContextSearchResult = record
  {* Результат поиска по контексту. }
   item_index : Cardinal; // Индекс найденного элемента.
   positions : IHighlightPositionList; // позиции, найденные в результате поиска
 end;//TContextSearchResult

 TSearchStatus = (
  {* Зона поиска. }
   SS_GLOBAL // Поиск по всему объекту.
 , SS_CURENT // Поиск от текущего элемента.
 );//TSearchStatus

 TSearchDirection = (
  {* Направление поиска. }
   SD_UP // Поис вверх.
 , SD_DOWN // Поиск вниз.
 );//TSearchDirection

 TSearchMode = record
  {* Перечислимый тип, определяющий способ поиска в линейных структурах (списках, текстах и т.п.).
Сочетание ss_Global + sd_Up - поиск с конца вверх.
Сочетание ss_Global + sd_Down - поиск сначала вниз.
Сочетание c ss_Current - поиск от текущего элемента вверх или вниз. }
   status : TSearchStatus; // результат поиска
   direction : TSearchDirection; // направление поиска
 end;//TSearchMode

implementation

end.