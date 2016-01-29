unit atDeleteAllOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/Operations/atDeleteAllOperation.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatDeleteAllOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  atFoldersHelper,
  atOperationBase,
  FoldersUnit
  ;

type
 _FoldersNodeMatcher_ = TatAnyMatcher;
 {$Include ..\Operations\atProcessFoldersObjectOperation.imp.pas}
 _atDeleteFoldersObjectAddon_Parent_ = _atProcessFoldersObjectOperation_;
 {$Include ..\Operations\atDeleteFoldersObjectAddon.imp.pas}
 TatDeleteAllOperation = class(_atDeleteFoldersObjectAddon_)
 end;//TatDeleteAllOperation

implementation

uses
  atLogger
  ;

{$Include ..\Operations\atProcessFoldersObjectOperation.imp.pas}

{$Include ..\Operations\atDeleteFoldersObjectAddon.imp.pas}

end.