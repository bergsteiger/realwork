unit evEditorInterfacesTypes;

// Модуль: "w:\common\components\gui\Garant\Everest\evEditorInterfacesTypes.pas"
// Стереотип: "Interfaces"
// Элемент модели: "evEditorInterfacesTypes" MUID: (572305620264)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
;

type
 TedRowType = (
  ed_rtNull
  , ed_rtNumericCels
  , ed_rtSingleCell
  , ed_rtSimpleCells
  , ed_rtPsevdoSingleCells
  , ed_rtSimpleWithoutEmpty
  , ev_rtFormCells
  , ed_rtHasHeadCells
  , ed_rtEmptyWithContnueCells
  , ed_rtHasMergedCell
  , ed_rtSimpleEmptyCells
  , ed_rtChessTableRow
 );//TedRowType

 TedCellType = (
  {* Классификация содержимого ячейки. }
  ed_ctNone
  , ed_ctInteger
  , ed_ctNumber
  , ed_ctEmpty
  , ed_ctText
  , ed_ctFloat
  , ed_ctHasFormLine
  , ed_ctNeedDelete
  , ed_ctNeedMakeContinue
  , ed_ctSmallText
  , ed_ctEmptyAndNotFramed
 );//TedCellType

implementation

uses
 l3ImplUses
;

end.
