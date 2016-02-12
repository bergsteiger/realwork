unit atDeleteAllOperation;

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atDeleteAllOperation.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , atFoldersHelper
 , atOperationBase
 , FoldersUnit
;

type
 _FoldersNodeMatcher_ = TatAnyMatcher;
 {$Include w:\quality\test\garant6x\AdapterTest\Operations\atProcessFoldersObjectOperation.imp.pas}
 _atDeleteFoldersObjectAddon_Parent_ = _atProcessFoldersObjectOperation_;
 {$Include w:\quality\test\garant6x\AdapterTest\Operations\atDeleteFoldersObjectAddon.imp.pas}
 TatDeleteAllOperation = class(_atDeleteFoldersObjectAddon_)
 end;//TatDeleteAllOperation

implementation

uses
 l3ImplUses
 , atLogger
;

{$Include w:\quality\test\garant6x\AdapterTest\Operations\atProcessFoldersObjectOperation.imp.pas}

{$Include w:\quality\test\garant6x\AdapterTest\Operations\atDeleteFoldersObjectAddon.imp.pas}

end.
