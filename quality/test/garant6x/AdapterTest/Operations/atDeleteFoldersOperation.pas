unit atDeleteFoldersOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/Operations/atDeleteFoldersOperation.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatDeleteFoldersOperation
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
 _FoldersNodeMatcher_ = TatFolderMatcher;
 {$Include ..\Operations\atProcessNamedFoldersObjectOperation.imp.pas}
 _atDeleteFoldersObjectAddon_Parent_ = _atProcessNamedFoldersObjectOperation_;
 {$Include ..\Operations\atDeleteFoldersObjectAddon.imp.pas}
 TatDeleteFoldersOperation = class(_atDeleteFoldersObjectAddon_)
 end;//TatDeleteFoldersOperation

implementation

uses
  atLogger
  ;

{$Include ..\Operations\atProcessNamedFoldersObjectOperation.imp.pas}

{$Include ..\Operations\atDeleteFoldersObjectAddon.imp.pas}

end.