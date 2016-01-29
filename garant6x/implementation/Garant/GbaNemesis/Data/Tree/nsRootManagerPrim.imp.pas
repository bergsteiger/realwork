{$IfNDef nsRootManagerPrim_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Data"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Tree/nsRootManagerPrim.imp.pas"
// Начат: 2005/11/22 21:28:41
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> F1 Базовые определения предметной области::LegalDomain::Data::Tree::nsRootManagerPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nsRootManagerPrim_imp}
 _nsNodeNotifier_Parent_ = _nsRootManagerPrim_Parent_;
 {$Include ..\Tree\nsNodeNotifier.imp.pas}
 _nsRootManagerPrim_ = {mixin} class(_nsNodeNotifier_)
 private
 // private fields
   f_RootNode : INodeBase;
    {* Поле для свойства RootNode}
 protected
 // property methods
   procedure pm_SetRootNode(const aValue: INodeBase);
 protected
 // overridden protected methods
   procedure Cleanup; override;
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
   procedure BeforeClearFields; override;
     {* Сигнатура метода BeforeClearFields }
 public
 // public properties
   property RootNode: INodeBase
     read f_RootNode
     write pm_SetRootNode;
 end;//_nsRootManagerPrim_

{$Else nsRootManagerPrim_imp}

{$Include ..\Tree\nsNodeNotifier.imp.pas}

// start class _nsRootManagerPrim_

procedure _nsRootManagerPrim_.pm_SetRootNode(const aValue: INodeBase);
//#UC START# *48FDB9E80327_48FDB9BD0325set_var*
//#UC END# *48FDB9E80327_48FDB9BD0325set_var*
begin
//#UC START# *48FDB9E80327_48FDB9BD0325set_impl*
 if (f_RootNode <> aValue) then
 begin
  if (f_RootNode <> nil) then
   f_RootNode.RemoveNotifier(Self);
  f_RootNode := aValue;
  if (f_RootNode <> nil) then
   f_RootNode.AddNotifier(Self);
 end;//f_RootNode <> aValue
//#UC END# *48FDB9E80327_48FDB9BD0325set_impl*
end;//_nsRootManagerPrim_.pm_SetRootNode

procedure _nsRootManagerPrim_.Cleanup;
//#UC START# *48FD97BC0335_48FDB9BD0325_var*
//#UC END# *48FD97BC0335_48FDB9BD0325_var*
begin
//#UC START# *48FD97BC0335_48FDB9BD0325_impl*
 inherited;
 RootNode := nil;
//#UC END# *48FD97BC0335_48FDB9BD0325_impl*
end;//_nsRootManagerPrim_.Cleanup

procedure _nsRootManagerPrim_.ClearFields;
 {-}
begin
 RootNode := nil;
 inherited;
end;//_nsRootManagerPrim_.ClearFields

procedure _nsRootManagerPrim_.BeforeClearFields;
//#UC START# *500056650395_48FDB9BD0325_var*
//#UC END# *500056650395_48FDB9BD0325_var*
begin
//#UC START# *500056650395_48FDB9BD0325_impl*
 RootNode := nil;
 inherited;
//#UC END# *500056650395_48FDB9BD0325_impl*
end;//_nsRootManagerPrim_.BeforeClearFields

{$EndIf nsRootManagerPrim_imp}
