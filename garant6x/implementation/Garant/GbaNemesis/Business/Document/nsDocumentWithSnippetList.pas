unit nsDocumentWithSnippetList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/nsDocumentWithSnippetList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Business::Document::TnsDocumentWithSnippetList
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
  DynamicDocListUnit,
  DynamicTreeUnit,
  l3TreeInterfaces,
  nsDataResetTreeStruct,
  nsINodeWrapBase,
  l3Interfaces,
  l3InternalInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsDocumentWithSnippetList = class(TnsDataResetTreeStruct)
 private
 // private fields
   f_List : IDynList;
 protected
 // realized methods
   function ReAqurieUnfilteredRoot: INodeBase; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   function RootNodeClass: RnsINodeWrap; override;
     {* определяет класс обертки для Root }
   function DoMakeDataObject(const aData: Il3SimpleNode;
    const aBitmap: Il3Bitmap): IDataObject; override;
     {* объект данных дерева. aData - текущий элемент списка. aBitmap (Il3Bitmap) - картинка для перетаскивания }
 public
 // public methods
   constructor Create(const aRoot: INodeBase;
     const aDynList: IDynList); reintroduce;
   class function Make(const aRoot: INodeBase;
     const aDynList: IDynList): Il3SimpleTree; reintroduce;
 end;//TnsDocumentWithSnippetList
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsDocumentWithSnippetNode,
  bsListTreeData,
  bsListDataObject
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsDocumentWithSnippetList

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
end;

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
//#UC START# *479731C50290_5645E9550108_var*
//#UC END# *479731C50290_5645E9550108_var*
begin
//#UC START# *479731C50290_5645E9550108_impl*
 f_List := nil;
 inherited;
//#UC END# *479731C50290_5645E9550108_impl*
end;//TnsDocumentWithSnippetList.Cleanup

function TnsDocumentWithSnippetList.RootNodeClass: RnsINodeWrap;
//#UC START# *48FEE3640227_5645E9550108_var*
//#UC END# *48FEE3640227_5645E9550108_var*
begin
//#UC START# *48FEE3640227_5645E9550108_impl*
 Result := TnsDocumentWithSnippetNode;
//#UC END# *48FEE3640227_5645E9550108_impl*
end;//TnsDocumentWithSnippetList.RootNodeClass

function TnsDocumentWithSnippetList.DoMakeDataObject(const aData: Il3SimpleNode;
  const aBitmap: Il3Bitmap): IDataObject;
//#UC START# *48FEE6210205_5645E9550108_var*
//#UC END# *48FEE6210205_5645E9550108_var*
begin
//#UC START# *48FEE6210205_5645E9550108_impl*
 Result := inherited DoMakeDataObject(aData, aBitmap);
 if Result = nil then
  Result := TbsListDataObject.Make(aData, aBitmap, TbsListTreeData.Make(f_List, RootNode, aData));
//#UC END# *48FEE6210205_5645E9550108_impl*
end;//TnsDocumentWithSnippetList.DoMakeDataObject

{$IfEnd} //not Admin AND not Monitorings

end.