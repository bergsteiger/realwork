unit deSimpleTree;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/deSimpleTree.pas"
// Начат: 12.01.2011 18:27
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Business::BaseDocument::TdeSimpleTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3TreeInterfaces,
  DocumentAndListInterfaces,
  l3ProtoObject,
  F1TagDataProviderInterface,
  DocumentUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TdeSimpleTree = class(Tl3ProtoObject, IdeSimpleTree)
 private
 // private fields
   f_Tree : Il3SimpleTree;
   f_Adornments : InsDocumentAdornments;
 protected
 // realized methods
   function Get_Contents: Il3SimpleTree;
   function Get_Bookmarks: IBookmarkList;
   function Get_Comments: ICommentsParaList;
   function Get_ExternalObjects: IExternalObjectDataList;
   function Get_Empty: Boolean;
   function Get_Adornments: InsDocumentAdornments;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aTree: Il3SimpleTree;
     const anAdorments: InsDocumentAdornments); reintroduce;
   class function Make(const aTree: Il3SimpleTree;
     const anAdorments: InsDocumentAdornments): IdeSimpleTree; reintroduce;
     {* Сигнатура фабрики TdeSimpleTree.Make }
 end;//TdeSimpleTree
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TdeSimpleTree

constructor TdeSimpleTree.Create(const aTree: Il3SimpleTree;
  const anAdorments: InsDocumentAdornments);
//#UC START# *4D2F170B02AD_4D2DC8590283_var*
//#UC END# *4D2F170B02AD_4D2DC8590283_var*
begin
//#UC START# *4D2F170B02AD_4D2DC8590283_impl*
 inherited Create;
 f_Tree := aTree;
 f_Adornments := anAdorments;
//#UC END# *4D2F170B02AD_4D2DC8590283_impl*
end;//TdeSimpleTree.Create

class function TdeSimpleTree.Make(const aTree: Il3SimpleTree;
  const anAdorments: InsDocumentAdornments): IdeSimpleTree;
var
 l_Inst : TdeSimpleTree;
begin
 l_Inst := Create(aTree, anAdorments);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TdeSimpleTree.Get_Contents: Il3SimpleTree;
//#UC START# *4D2DC8190360_4D2DC8590283get_var*
//#UC END# *4D2DC8190360_4D2DC8590283get_var*
begin
//#UC START# *4D2DC8190360_4D2DC8590283get_impl*
 Result := f_Tree;
//#UC END# *4D2DC8190360_4D2DC8590283get_impl*
end;//TdeSimpleTree.Get_Contents

function TdeSimpleTree.Get_Bookmarks: IBookmarkList;
//#UC START# *4D2DDF6D0139_4D2DC8590283get_var*
//#UC END# *4D2DDF6D0139_4D2DC8590283get_var*
begin
//#UC START# *4D2DDF6D0139_4D2DC8590283get_impl*
 if (f_Adornments = nil) then
  Result := nil
 else
  Result := f_Adornments.Bookmarks;
//#UC END# *4D2DDF6D0139_4D2DC8590283get_impl*
end;//TdeSimpleTree.Get_Bookmarks

function TdeSimpleTree.Get_Comments: ICommentsParaList;
//#UC START# *4D2DDF7A0260_4D2DC8590283get_var*
//#UC END# *4D2DDF7A0260_4D2DC8590283get_var*
begin
//#UC START# *4D2DDF7A0260_4D2DC8590283get_impl*
 if (f_Adornments = nil) then
  Result := nil
 else
  Result := f_Adornments.Comments;
//#UC END# *4D2DDF7A0260_4D2DC8590283get_impl*
end;//TdeSimpleTree.Get_Comments

function TdeSimpleTree.Get_ExternalObjects: IExternalObjectDataList;
//#UC START# *4D2DDF8301DF_4D2DC8590283get_var*
//#UC END# *4D2DDF8301DF_4D2DC8590283get_var*
begin
//#UC START# *4D2DDF8301DF_4D2DC8590283get_impl*
 if (f_Adornments = nil) then
  Result := nil
 else
  Result := f_Adornments.ExternalObjects;
//#UC END# *4D2DDF8301DF_4D2DC8590283get_impl*
end;//TdeSimpleTree.Get_ExternalObjects

function TdeSimpleTree.Get_Empty: Boolean;
//#UC START# *4D2DDF9B034E_4D2DC8590283get_var*
//#UC END# *4D2DDF9B034E_4D2DC8590283get_var*
begin
//#UC START# *4D2DDF9B034E_4D2DC8590283get_impl*
 Result := ((f_Tree = nil) OR (f_Tree.CountView = 0)) AND
           (
            (f_Adornments = nil) OR
            (
             ((Get_Bookmarks = nil) OR (Get_Bookmarks.Count = 0)) AND
             ((Get_Comments = nil) OR (Get_Comments.Count = 0)) AND
             ((Get_ExternalObjects = nil) OR (Get_ExternalObjects.Count = 0))
            )
           );
//#UC END# *4D2DDF9B034E_4D2DC8590283get_impl*
end;//TdeSimpleTree.Get_Empty

function TdeSimpleTree.Get_Adornments: InsDocumentAdornments;
//#UC START# *4D3048370128_4D2DC8590283get_var*
//#UC END# *4D3048370128_4D2DC8590283get_var*
begin
//#UC START# *4D3048370128_4D2DC8590283get_impl*
 Result := f_Adornments;
//#UC END# *4D3048370128_4D2DC8590283get_impl*
end;//TdeSimpleTree.Get_Adornments

procedure TdeSimpleTree.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Tree := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Adornments := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TdeSimpleTree.ClearFields

{$IfEnd} //not Admin AND not Monitorings

end.