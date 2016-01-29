unit atDeleteBookmarkOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/Operations/atDeleteBookmarkOperation.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatDeleteBookmarkOperation
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
 _FoldersNodeMatcher_ = TatBookmarkMatcher;
 {$Include ..\Operations\atProcessNamedFoldersObjectOperation.imp.pas}
 _atDeleteFoldersObjectAddon_Parent_ = _atProcessNamedFoldersObjectOperation_;
 {$Include ..\Operations\atDeleteFoldersObjectAddon.imp.pas}
 TatDeleteBookmarkOperation = class(_atDeleteFoldersObjectAddon_)
 end;//TatDeleteBookmarkOperation

implementation

uses
  atLogger
  ;

{$Include ..\Operations\atProcessNamedFoldersObjectOperation.imp.pas}

{$Include ..\Operations\atDeleteFoldersObjectAddon.imp.pas}

end.