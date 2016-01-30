unit atDeleteBookmarkOperation;

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atDeleteBookmarkOperation.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , atFoldersHelper
 , atOperationBase
 , FoldersUnit
;

type
 _FoldersNodeMatcher_ = TatBookmarkMatcher;
 {$Include atProcessNamedFoldersObjectOperation.imp.pas}
 _atDeleteFoldersObjectAddon_Parent_ = _atProcessNamedFoldersObjectOperation_;
 {$Include atDeleteFoldersObjectAddon.imp.pas}
 TatDeleteBookmarkOperation = class(_atDeleteFoldersObjectAddon_)
 end;//TatDeleteBookmarkOperation

implementation

uses
 l3ImplUses
 , atLogger
;

{$Include atProcessNamedFoldersObjectOperation.imp.pas}

{$Include atDeleteFoldersObjectAddon.imp.pas}

end.
