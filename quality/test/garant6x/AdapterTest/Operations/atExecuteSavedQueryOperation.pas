unit atExecuteSavedQueryOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/Operations/atExecuteSavedQueryOperation.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatExecuteSavedQueryOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  SearchUnit,
  atFoldersHelper,
  atOperationBase,
  FoldersUnit,
  atQuery
  ;

type
 _FoldersNodeMatcher_ = TatQueryMatcher;
 _ObjectType_ = IQuery;
 {$Include ..\Operations\atProcessNamedFoldersObjectOperation.imp.pas}
 _atOpenFoldersObjectAddon_Parent_ = _atProcessNamedFoldersObjectOperation_;
 {$Include ..\Operations\atOpenFoldersObjectAddon.imp.pas}
 _atExecutesQueryAddOn_Parent_ = _atOpenFoldersObjectAddon_;
 {$Include ..\Operations\atExecutesQueryAddOn.imp.pas}
 TatExecuteSavedQueryOperation = class(_atExecutesQueryAddOn_)
 protected
 // realized methods
   procedure OnFoldersObject(const aFoldersObject: _ObjectType_); override;
 protected
 // overridden protected methods
   procedure ExecuteChilds; override;
 end;//TatExecuteSavedQueryOperation

implementation

uses
  atSearchHelper,
  atLogger,
  SysUtils,
  BaseTypesUnit,
  atNodeHelper
  ;

{$Include ..\Operations\atProcessNamedFoldersObjectOperation.imp.pas}

{$Include ..\Operations\atOpenFoldersObjectAddon.imp.pas}

{$Include ..\Operations\atExecutesQueryAddOn.imp.pas}

// start class TatExecuteSavedQueryOperation

procedure TatExecuteSavedQueryOperation.OnFoldersObject(const aFoldersObject: _ObjectType_);
//#UC START# *4FD0D2530143_4FD23557001F_var*
//#UC END# *4FD0D2530143_4FD23557001F_var*
begin
//#UC START# *4FD0D2530143_4FD23557001F_impl*
  if ExecuteQuery(aFoldersObject) then
    inherited ExecuteChilds;
//#UC END# *4FD0D2530143_4FD23557001F_impl*
end;//TatExecuteSavedQueryOperation.OnFoldersObject

procedure TatExecuteSavedQueryOperation.ExecuteChilds;
//#UC START# *48089F660238_4FD23557001F_var*
//#UC END# *48089F660238_4FD23557001F_var*
begin
//#UC START# *48089F660238_4FD23557001F_impl*
  //
//#UC END# *48089F660238_4FD23557001F_impl*
end;//TatExecuteSavedQueryOperation.ExecuteChilds

end.