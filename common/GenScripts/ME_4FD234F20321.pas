unit atOpenSavedListOperation;

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atOpenSavedListOperation.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , atFoldersHelper
 , DynamicDocListUnit
 , atOperationBase
 , FoldersUnit
;

type
 _FoldersNodeMatcher_ = TatListMatcher;
 _ObjectType_ = IDynList;
 {$Include w:\quality\test\garant6x\AdapterTest\Operations\atProcessNamedFoldersObjectOperation.imp.pas}
 _atOpenFoldersObjectAddon_Parent_ = _atProcessNamedFoldersObjectOperation_;
 {$Include w:\quality\test\garant6x\AdapterTest\Operations\atOpenFoldersObjectAddon.imp.pas}
 TatOpenSavedListOperation = class(_atOpenFoldersObjectAddon_)
  protected
   procedure OnFoldersObject(const aFoldersObject: _ObjectType_); override;
   procedure ExecuteChilds; override;
 end;//TatOpenSavedListOperation

implementation

uses
 l3ImplUses
 , atListHelper
 , atLogger
 , SysUtils
 , BaseTypesUnit
 , atNodeHelper
;

{$Include w:\quality\test\garant6x\AdapterTest\Operations\atProcessNamedFoldersObjectOperation.imp.pas}

{$Include w:\quality\test\garant6x\AdapterTest\Operations\atOpenFoldersObjectAddon.imp.pas}

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
