unit eeDocumentContainer;

interface

uses
 l3IntfUses
 , eeDocumentContainerPrim
 , k2TagGen
 , nevTools
 , nevBase
;

type
 TeeDocumentContainer = class(TeeDocumentContainerPrim)
  {* Контейнер документа. }
 end;//TeeDocumentContainer
 
implementation

uses
 l3ImplUses
 , evCommentParaDecorator
 , eeProcessor
 , evLeafParaDecorationsHolderEliminator
 , evBlocksEliminator
 , evdPageParamsFilter
 , evOp
 , evParaTools
 , CommentPara_Const
 , evTypes
 , evGeneratorsInterfaces
 , SysUtils
 , evUserCommentFilter
 , evCommentDecorator
 , evNestedDocumentEliminator
 , afwFacade
 , evCommentParaAdder
 , evPageBreakEliminator
 , evControlParaFilter
 , evTagsListFilter
 , k2Tags
 , LeafPara_Const
 , evBlocksButNotCommentsEliminator
 , evStrictContentsElementEliminator
 , l3Interfaces
;

end.
