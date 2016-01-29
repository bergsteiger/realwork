unit atOpenSavedListOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/Operations/atOpenSavedListOperation.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatOpenSavedListOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  DynamicDocListUnit,
  atFoldersHelper,
  atOperationBase,
  FoldersUnit
  ;

type
 _FoldersNodeMatcher_ = TatListMatcher;
 _ObjectType_ = IDynList;
 {$Include ..\Operations\atProcessNamedFoldersObjectOperation.imp.pas}
 _atOpenFoldersObjectAddon_Parent_ = _atProcessNamedFoldersObjectOperation_;
 {$Include ..\Operations\atOpenFoldersObjectAddon.imp.pas}
 TatOpenSavedListOperation = class(_atOpenFoldersObjectAddon_)
 protected
 // realized methods
   procedure OnFoldersObject(const aFoldersObject: _ObjectType_); override;
 protected
 // overridden protected methods
   procedure ExecuteChilds; override;
 end;//TatOpenSavedListOperation

implementation

uses
  atListHelper,
  atLogger,
  SysUtils,
  BaseTypesUnit,
  atNodeHelper
  ;

{$Include ..\Operations\atProcessNamedFoldersObjectOperation.imp.pas}

{$Include ..\Operations\atOpenFoldersObjectAddon.imp.pas}

// start class TatOpenSavedListOperation

procedure TatOpenSavedListOperation.OnFoldersObject(const aFoldersObject: _ObjectType_);
//#UC START# *4FD0D2530143_4FD234F20321_var*
//#UC END# *4FD0D2530143_4FD234F20321_var*
begin
//#UC START# *4FD0D2530143_4FD234F20321_impl*
  with TatList.Create(aFoldersObject) do
  try
    Logger.Info('Открываем сохраненный список с именем "%s"', [Name]);

    if f_IsEmulateOpening then
      TatListHelper.LoadList(Entity, 20);

    ExecutionContext.UserWorkContext.AddListToHistory(Entity);

    inherited ExecuteChilds;
  finally
    Free;
  end;
//#UC END# *4FD0D2530143_4FD234F20321_impl*
end;//TatOpenSavedListOperation.OnFoldersObject

procedure TatOpenSavedListOperation.ExecuteChilds;
//#UC START# *48089F660238_4FD234F20321_var*
//#UC END# *48089F660238_4FD234F20321_var*
begin
//#UC START# *48089F660238_4FD234F20321_impl*
  //
//#UC END# *48089F660238_4FD234F20321_impl*
end;//TatOpenSavedListOperation.ExecuteChilds

end.