unit atDeleteFoldersOperation;

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atDeleteFoldersOperation.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , atFoldersHelper
 , atOperationBase
 , FoldersUnit
;

type
 _FoldersNodeMatcher_ = TatFolderMatcher;
 {$Include atProcessNamedFoldersObjectOperation.imp.pas}
 _atDeleteFoldersObjectAddon_Parent_ = _atProcessNamedFoldersObjectOperation_;
 {$Include atDeleteFoldersObjectAddon.imp.pas}
 TatDeleteFoldersOperation = class(_atDeleteFoldersObjectAddon_)
 end;//TatDeleteFoldersOperation

implementation

uses
 l3ImplUses
 , atLogger
;

{$Include atProcessNamedFoldersObjectOperation.imp.pas}

{$Include atDeleteFoldersObjectAddon.imp.pas}

end.
