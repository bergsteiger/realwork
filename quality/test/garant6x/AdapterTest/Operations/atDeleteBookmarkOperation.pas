unit atDeleteBookmarkOperation;

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atDeleteBookmarkOperation.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatDeleteBookmarkOperation" MUID: (483FF12203C2)

interface

uses
 l3IntfUses
 , atFoldersHelper
 , atOperationBase
 , FoldersUnit
;

type
 _FoldersNodeMatcher_ = TatBookmarkMatcher;
 {$Include w:\quality\test\garant6x\AdapterTest\Operations\atProcessNamedFoldersObjectOperation.imp.pas}
 _atDeleteFoldersObjectAddon_Parent_ = _atProcessNamedFoldersObjectOperation_;
 {$Include w:\quality\test\garant6x\AdapterTest\Operations\atDeleteFoldersObjectAddon.imp.pas}
 TatDeleteBookmarkOperation = class(_atDeleteFoldersObjectAddon_)
 end;//TatDeleteBookmarkOperation

implementation

uses
 l3ImplUses
 , atLogger
 //#UC START# *483FF12203C2impl_uses*
 //#UC END# *483FF12203C2impl_uses*
;

{$Include w:\quality\test\garant6x\AdapterTest\Operations\atProcessNamedFoldersObjectOperation.imp.pas}

{$Include w:\quality\test\garant6x\AdapterTest\Operations\atDeleteFoldersObjectAddon.imp.pas}

end.
