unit atDeleteFoldersOperation;

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atDeleteFoldersOperation.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatDeleteFoldersOperation" MUID: (484D0B4A018A)

interface

uses
 l3IntfUses
 , atFoldersHelper
 , atOperationBase
 , FoldersUnit
;

type
 _FoldersNodeMatcher_ = TatFolderMatcher;
 {$Include w:\quality\test\garant6x\AdapterTest\Operations\atProcessNamedFoldersObjectOperation.imp.pas}
 _atDeleteFoldersObjectAddon_Parent_ = _atProcessNamedFoldersObjectOperation_;
 {$Include w:\quality\test\garant6x\AdapterTest\Operations\atDeleteFoldersObjectAddon.imp.pas}
 TatDeleteFoldersOperation = class(_atDeleteFoldersObjectAddon_)
 end;//TatDeleteFoldersOperation

implementation

uses
 l3ImplUses
 , atLogger
;

{$Include w:\quality\test\garant6x\AdapterTest\Operations\atProcessNamedFoldersObjectOperation.imp.pas}

{$Include w:\quality\test\garant6x\AdapterTest\Operations\atDeleteFoldersObjectAddon.imp.pas}

end.
