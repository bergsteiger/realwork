unit atExecuteSavedQueryOperation;

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atExecuteSavedQueryOperation.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , atFoldersHelper
 , SearchUnit
 , atOperationBase
 , FoldersUnit
 , atQuery
;

type
 _FoldersNodeMatcher_ = TatQueryMatcher;
 _ObjectType_ = IQuery;
 {$Include atProcessNamedFoldersObjectOperation.imp.pas}
 _atOpenFoldersObjectAddon_Parent_ = _atProcessNamedFoldersObjectOperation_;
 {$Include atOpenFoldersObjectAddon.imp.pas}
 _atExecutesQueryAddOn_Parent_ = _atOpenFoldersObjectAddon_;
 {$Include atExecutesQueryAddOn.imp.pas}
 TatExecuteSavedQueryOperation = class(_atExecutesQueryAddOn_)
  protected
   procedure OnFoldersObject(const aFoldersObject: _ObjectType_); override;
   procedure ExecuteChilds; override;
 end;//TatExecuteSavedQueryOperation

implementation

uses
 l3ImplUses
 , atSearchHelper
 , atLogger
 , SysUtils
 , BaseTypesUnit
 , atNodeHelper
;

{$Include atProcessNamedFoldersObjectOperation.imp.pas}

{$Include atOpenFoldersObjectAddon.imp.pas}

{$Include atExecutesQueryAddOn.imp.pas}

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
