unit deSimpleTree;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\deSimpleTree.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdeSimpleTree" MUID: (4D2DC8590283)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ProtoObject
 , DocumentAndListInterfaces
 , l3TreeInterfaces
 , F1TagDataProviderInterface
 , DocumentUnit
;

type
 TdeSimpleTree = class(Tl3ProtoObject, IdeSimpleTree)
  private
   f_Tree: Il3SimpleTree;
   f_Adornments: InsDocumentAdornments;
  protected
   function Get_Contents: Il3SimpleTree;
   function Get_Bookmarks: IBookmarkList;
   function Get_Comments: ICommentsParaList;
   function Get_ExternalObjects: IExternalObjectDataList;
   function Get_Empty: Boolean;
   function Get_Adornments: InsDocumentAdornments;
   procedure ClearFields; override;
  public
   constructor Create(const aTree: Il3SimpleTree;
    const anAdorments: InsDocumentAdornments); reintroduce;
   class function Make(const aTree: Il3SimpleTree;
    const anAdorments: InsDocumentAdornments): IdeSimpleTree; reintroduce;
 end;//TdeSimpleTree
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 //#UC START# *4D2DC8590283impl_uses*
 //#UC END# *4D2DC8590283impl_uses*
;

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
end;//TdeSimpleTree.Make

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
begin
 f_Tree := nil;
 f_Adornments := nil;
 inherited;
end;//TdeSimpleTree.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
