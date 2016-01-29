{$IfNDef nsParentedTagData_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "f1DocumentTagsImplementation"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/f1DocumentTagsImplementation/nsParentedTagData.imp.pas"
// Начат: 23.08.2010 17:52
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> F1 Базовые определения предметной области::LegalDomain::f1DocumentTagsImplementation::TagDataProviders::nsParentedTagData
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nsParentedTagData_imp}
 _nsParentedTagData_ = {mixin} class(_nsParentedTagData_Parent_)
 private
 // private fields
   f_Parent : Tf1ListTagDataFromDTPPrim;
    {* Поле для свойства Parent}
   f_ChildID : TChildID;
    {* Поле для свойства ChildID}
 protected
 // realized methods
   function GetChildID: TChildID; override;
   function GetParentLayerID: DTPLayerID; override;
 protected
 // overridden property methods
   function pm_GetParentPrim: Tf1ListTagDataFromDTPPrim; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aProvider: IDocumentTextProvider;
     aParent: Tf1ListTagDataFromDTPPrim;
     aChildID: TChildID); reintroduce;
 protected
 // protected properties
   property Parent: Tf1ListTagDataFromDTPPrim
     read f_Parent;
   property ChildID: TChildID
     read f_ChildID;
 end;//_nsParentedTagData_

{$Else nsParentedTagData_imp}

// start class _nsParentedTagData_

constructor _nsParentedTagData_.Create(const aProvider: IDocumentTextProvider;
  aParent: Tf1ListTagDataFromDTPPrim;
  aChildID: TChildID);
//#UC START# *4C727EAE031D_4C727CF102FF_var*
//#UC END# *4C727EAE031D_4C727CF102FF_var*
begin
//#UC START# *4C727EAE031D_4C727CF102FF_impl*
 inherited Create(aProvider);
 l3Set(f_Parent, aParent);
 f_ChildID := aChildID;
//#UC END# *4C727EAE031D_4C727CF102FF_impl*
end;//_nsParentedTagData_.Create

function _nsParentedTagData_.GetChildID: TChildID;
//#UC START# *4C7281C90170_4C727CF102FF_var*
//#UC END# *4C7281C90170_4C727CF102FF_var*
begin
//#UC START# *4C7281C90170_4C727CF102FF_impl*
 Result := f_ChildID;
//#UC END# *4C7281C90170_4C727CF102FF_impl*
end;//_nsParentedTagData_.GetChildID

function _nsParentedTagData_.GetParentLayerID: DTPLayerID;
//#UC START# *4C7289B80158_4C727CF102FF_var*
//#UC END# *4C7289B80158_4C727CF102FF_var*
begin
//#UC START# *4C7289B80158_4C727CF102FF_impl*
 Assert(Parent <> nil);
 Result := Parent.LayerID;
//#UC END# *4C7289B80158_4C727CF102FF_impl*
end;//_nsParentedTagData_.GetParentLayerID

procedure _nsParentedTagData_.Cleanup;
//#UC START# *479731C50290_4C727CF102FF_var*
//#UC END# *479731C50290_4C727CF102FF_var*
begin
//#UC START# *479731C50290_4C727CF102FF_impl*
 inherited;
 f_ChildID := High(f_ChildID);
 FreeAndNil(f_Parent);
//#UC END# *479731C50290_4C727CF102FF_impl*
end;//_nsParentedTagData_.Cleanup

function _nsParentedTagData_.pm_GetParentPrim: Tf1ListTagDataFromDTPPrim;
//#UC START# *4C72A6B5000F_4C727CF102FFget_var*
//#UC END# *4C72A6B5000F_4C727CF102FFget_var*
begin
//#UC START# *4C72A6B5000F_4C727CF102FFget_impl*
 Result := Self.Parent;
//#UC END# *4C72A6B5000F_4C727CF102FFget_impl*
end;//_nsParentedTagData_.pm_GetParentPrim

{$EndIf nsParentedTagData_imp}
