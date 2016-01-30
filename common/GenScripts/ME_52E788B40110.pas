unit arCommonTypes;
 {* Общие типы для Арчи и Эвереста. }

// Модуль: "w:\archi\source\projects\Common\Utils\arCommonTypes.pas"
// Стереотип: "Interfaces"

{$Include arCommon.inc}

interface

uses
 l3IntfUses
 , evdTypes
;

type
 TSubType = (
  stSub
  , stBlock
 );//TSubType

 IarCheckLeftOrRightBlock = interface
  ['{994BAAA2-978D-4CB7-B149-87D84CF4423A}']
  function HasAACBlock(aLeft: Boolean): Boolean;
  procedure SetBlockKind(aOldSubID: Integer;
   aNewSubID: Integer;
   aBlockKind: TevBlockViewKind);
 end;//IarCheckLeftOrRightBlock

 IevClearPreviewLink = interface
  ['{2D16504C-B2BF-4480-84CA-C068F041C296}']
  procedure ClearPreview;
 end;//IevClearPreviewLink

implementation

uses
 l3ImplUses
;

end.
