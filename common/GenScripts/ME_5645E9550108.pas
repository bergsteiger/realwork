unit nsDocumentWithSnippetList;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\nsDocumentWithSnippetList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsDocumentWithSnippetList" MUID: (5645E9550108)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsDataResetTreeStruct
 , DynamicDocListUnit
 , l3TreeInterfaces
 , DynamicTreeUnit
 , nsINodeWrapBase
 , l3Interfaces
 , l3InternalInterfaces
;

type
 TnsDocumentWithSnippetList = class(TnsDataResetTreeStruct)
  private
   f_List: IDynList;
  protected
   function ReAqurieUnfilteredRoot: INodeBase; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function RootNodeClass: RnsINodeWrap; override;
    {* определяет класс обертки для Root }
   function DoMakeDataObject(const aData: Il3SimpleNode;
    const aBitmap: Il3Bitmap): IDataObject; override;
    {* объект данных дерева. aData - текущий элемент списка. aBitmap (Il3Bitmap) - картинка для перетаскивания }
  public
   constructor Create(const aRoot: INodeBase;
    const aDynList: IDynList); reintroduce;
   class function Make(const aRoot: INodeBase;
    const aDynList: IDynList): Il3SimpleTree; reintroduce;
 end;//TnsDocumentWithSnippetList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsDocumentWithSnippetNode
 , bsListTreeData
 , bsListDataObject
;

constructor TnsDocumentWithSnippetList.Create(const aRoot: INodeBase;
 const aDynList: IDynList);
//#UC START# *5649C48002E2_5645E9550108_var*
//#UC END# *5649C48002E2_5645E9550108_var*
begin
//#UC START# *5649C48002E2_5645E9550108_impl*
 inherited Create(aRoot, False);
 f_List := aDynList;
//#UC END# *5649C48002E2_5645E9550108_impl*
end;//TnsDocumentWithSnippetList.Create

class function TnsDocumentWithSnippetList.Make(const aRoot: INodeBase;
 const aDynList: IDynList): Il3SimpleTree;
var
 l_Inst : TnsDocumentWithSnippetList;
begin
 l_Inst := Create(aRoot, aDynList);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsDocumentWithSnippetList.Make

function TnsDocumentWithSnippetList.ReAqurieUnfilteredRoot: INodeBase;
//#UC START# *48FF64F60078_5645E9550108_var*
//#UC END# *48FF64F60078_5645E9550108_var*
begin
//#UC START# *48FF64F60078_5645E9550108_impl*
 Assert(Assigned(f_List));
 f_List.GetRoot(Result);
//#UC END# *48FF64F60078_5645E9550108_impl*
end;//TnsDocumentWithSnippetList.ReAqurieUnfilteredRoot

procedure TnsDocumentWithSnippetList.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5645E9550108_var*
//#UC END# *479731C50290_5645E9550108_var*
begin
//#UC START# *479731C50290_5645E9550108_impl*
 f_List := nil;
 inherited;
//#UC END# *479731C50290_5645E9550108_impl*
end;//TnsDocumentWithSnippetList.Cleanup

function TnsDocumentWithSnippetList.RootNodeClass: RnsINodeWrap;
 {* определяет класс обертки для Root }
//#UC START# *48FEE3640227_5645E9550108_var*
//#UC END# *48FEE3640227_5645E9550108_var*
begin
//#UC START# *48FEE3640227_5645E9550108_impl*
 Result := TnsDocumentWithSnippetNode;
//#UC END# *48FEE3640227_5645E9550108_impl*
end;//TnsDocumentWithSnippetList.RootNodeClass

function TnsDocumentWithSnippetList.DoMakeDataObject(const aData: Il3SimpleNode;
 const aBitmap: Il3Bitmap): IDataObject;
 {* объект данных дерева. aData - текущий элемент списка. aBitmap (Il3Bitmap) - картинка для перетаскивания }
//#UC START# *48FEE6210205_5645E9550108_var*
//#UC END# *48FEE6210205_5645E9550108_var*
begin
//#UC START# *48FEE6210205_5645E9550108_impl*
 Result := inherited DoMakeDataObject(aData, aBitmap);
 if Result = nil then
  Result := TbsListDataObject.Make(aData, aBitmap, TbsListTreeData.Make(f_List, RootNode, aData));
//#UC END# *48FEE6210205_5645E9550108_impl*
end;//TnsDocumentWithSnippetList.DoMakeDataObject
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
