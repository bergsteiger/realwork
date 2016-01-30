unit atDeleteListOperation;

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atDeleteListOperation.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , atFoldersHelper
 , atOperationBase
 , FoldersUnit
;

type
 _FoldersNodeMatcher_ = TatListMatcher;
 {$Include atProcessNamedFoldersObjectOperation.imp.pas}
 _atDeleteFoldersObjectAddon_Parent_ = _atProcessNamedFoldersObjectOperation_;
 {$Include atDeleteFoldersObjectAddon.imp.pas}
 TatDeleteListOperation = class(_atDeleteFoldersObjectAddon_)
 end;//TatDeleteListOperation

implementation

uses
 l3ImplUses
 , atLogger
;

{$Include atProcessNamedFoldersObjectOperation.imp.pas}

{$Include atDeleteFoldersObjectAddon.imp.pas}

end.
