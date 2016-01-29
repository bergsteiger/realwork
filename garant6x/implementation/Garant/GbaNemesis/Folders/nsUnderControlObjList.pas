unit nsUnderControlObjList;

////////////////////////////////////////////////////////////////////////////////
// Библиотека : Проект Немезис;
// Назначение : Корень списка документов на контроле;
// Версия     : $Id: nsUnderControlObjList.pas,v 1.13 2014/10/16 15:40:40 kostitsin Exp $
////////////////////////////////////////////////////////////////////////////////

interface

uses
  l3Tree_TLB,
  l3TreeInterfaces,
  l3Interfaces,
  l3LongintList,
  l3NotifyPtrList,

  afwInterfaces,
  
  vcmBase,
  vcmInterfaces,

  BaseTreeSupportUnit,
  UnderControlUnit,
  FoldersUnit,

  nsTypes,

  FoldersDomainInterfaces
  ;

type
  _l3Notifier_Parent_ = TvcmCacheableBase;
  {$Include l3Notifier.imp.pas}
  _afwApplicationDataUpdate_Parent_ = _l3Notifier_;
  {$Include afwApplicationDataUpdate.imp.pas}
  TnsUnderControlObjList = class(_afwApplicationDataUpdate_,
                                 InsChildTree,
                                 InsControlledList)
  {*}
  private
  // internal fields
    f_UnderControlRoot : Il3Node;
  private
    procedure FinishDataUpdate; override;
      {* - вызывается по окончании обновления. }
  private
  // internal methods
    procedure NotifyDataUpdated;
      {-}
    procedure AddFakeNode;
      {-}
    procedure LoadChilds;
      {-}
    function  pm_GetRoot : Il3SimpleNode;
      {-}
    procedure AddChildPrim(const aChild : INode;
                           WithRelocate : boolean = false);
      overload;
      {-}
    procedure AddChildPrim(const aChild : IControllable;
                           WithRelocate : boolean = false);
      overload;
      {-}
    procedure AddChild(const aChild : INode);
      {-}
    procedure DeleteUnderControl(const aNode: INode);
      {-}
    procedure ChangedNotify(const aNode: INode; anEvent: TFoldersNodeChangeEvent);
      {-}
    procedure BeforeDeleteNotify(const aNode: INode; anEvent: TFoldersNodeDeleteEvent);
      {-}
    procedure AfterDeleteNotify(aFlags: LongInt; aNodeType: TFoldersItemType);
      {-}
    procedure AddControllable(const aControllable : IControllable);
      {-}
    procedure DeleteControllable(const aControllable : IControllable);
      {-}
    procedure SetOpenedFlag(const aControllable : IControllable);
      {-}
    procedure DropModifiedFlagForOpened(const aForm : IvcmEntityForm);
      {-}
  protected
  // protected methods
    procedure Cleanup;
      override;
      {-}
  protected
  // properties
    property UnderControlRoot: Il3Node
      read f_UnderControlRoot;
      {-}
  public
  // methods
    constructor Create;
      reintroduce;
      {-}
   function As_Il3ChangeNotifier: Il3ChangeNotifier;
  end;//TnsUnderControlObjList

implementation

uses
  SysUtils,

  l3Nodes,
  l3Base,

  afwFacade,

  vcmGUI,
  
  DocumentUnit,

  nsTreeUtils,
  nsUnderControlNode,
  nsNodes,
  nsUnderControlRoot,
  nsUtils,
  
  DataAdapter,

  StdRes
  ;

{$Include l3Notifier.imp.pas}
{$Include afwApplicationDataUpdate.imp.pas}

// Start class TnsUnderControlObjList

procedure TnsUnderControlObjList.AddChildPrim(const aChild : IControllable;
                                              WithRelocate : boolean = false);
var
 l_ChildNode,
 l_NewNode: Il3Node;
begin
 if f_UnderControlRoot <> nil then
 begin
  f_UnderControlRoot.Changing;
  try
   // Удаляем ноду-заглушку, если она была
   l_ChildNode := f_UnderControlRoot.ChildNode; 
   if (l_ChildNode <> nil) and
      not Supports(l_ChildNode, InsUnderControlNode) then
    l_ChildNode.Delete;

   l_NewNode := nil;
   if FindOnControllable(f_UnderControlRoot, aChild) = nil then
    l_NewNode := f_UnderControlRoot.InsertChild(TnsUnderControlNode.Make(aChild));

   if WithRelocate and
      (l_NewNode <> nil) then
    f_UnderControlRoot.SortChilds(l_NewNode);
  finally
   f_UnderControlRoot.Changed;
  end;
 end;
end;

procedure TnsUnderControlObjList.AddChildPrim(const aChild : INode;
                                              WithRelocate : boolean = false);
var
 l_ControlObj : IControllable;
 l_Obj        : IUnknown;
 l_Bookmark   : IBookmark;
 l_Document   : IDocument;
begin
 aChild.Open(l_Obj);
 try
  if Supports(l_Obj, IBookmark, l_Bookmark) then
   try
    l_Bookmark.GetDocument(l_Document);
    try
     if Supports(l_Document, IControllable, l_ControlObj) then
      AddChildPrim(l_ControlObj, WithRelocate);
    finally
     l_Document := nil;
    end;
   finally
    l_Bookmark := nil;
   end;
 finally
  l_Obj := nil;
 end;
end;

procedure TnsUnderControlObjList.DeleteUnderControl(const aNode: INode);
var
 l_ControlObj : IControllable;
 l_Node       : Il3Node;
begin
 if (f_UnderControlRoot <> nil) and
    Supports(aNode, IControllable, l_ControlObj) then
  try
   l_Node := FindOnControllable(f_UnderControlRoot, l_ControlObj);
   if l_Node <> nil then
    try
     l_Node.Delete;
     AddFakeNode;
    finally
     l_Node := nil;
    end;
  finally
   l_ControlObj := nil;
  end;
end;

procedure TnsUnderControlObjList.BeforeDeleteNotify(const aNode: INode; anEvent: TFoldersNodeDeleteEvent);
begin
 if anEvent = fndeControlled then
  DeleteUnderControl(aNode);
end;

procedure TnsUnderControlObjList.AfterDeleteNotify(aFlags: LongInt; aNodeType: TFoldersItemType);
begin
end;

procedure TnsUnderControlObjList.ChangedNotify(const aNode: INode; anEvent: TFoldersNodeChangeEvent);
begin
 if anEvent = fnceChangeControlledState then
 begin
  if aNode.GetFlags and NF_CONTROLLED = NF_CONTROLLED then
   AddChild(aNode)
  else
   DeleteUnderControl(aNode);
 end;
end;

procedure TnsUnderControlObjList.NotifyDataUpdated;
var
 l_Index    : Integer;
 l_Item     : IUnknown;
 l_Listener : InsUnderControlRootListener;
begin
 if NotifiedObjList <> nil then
  with NotifiedObjList do
   for l_Index := 0 to Pred(Count) do
   begin
    l_Item := IUnknown(Items[l_Index]);
    if Supports(l_Item, InsUnderControlRootListener, l_Listener) and
      (l_Item = l_Listener) then
     l_Listener.Updated;
   end;//for l_Index := 0 to Pred(Count) do
end;

procedure TnsUnderControlObjList.AddFakeNode;
var
 l_FakeNode: Il3Node;
begin
 if UnderControlRoot.ChildNode = nil then
 begin
  // Добавляем ноду-заглушку
  l_FakeNode := UnderControlRoot.InsertChild(TnsCacheableNode.Make(nil));
  l_FakeNode.Text := vcmCStr(str_EmptyContolList).AsWStr;
 end;
end;

procedure TnsUnderControlObjList.LoadChilds;
var
 l_CtrlObj: IControlledObjects;
 l_Object: IControllable;
 I,
 l_ChildCount: LongInt;
begin
 DefDataAdapter.ControlMgr.GetControlledObjects(l_CtrlObj);
 try
  if Assigned(l_CtrlObj) then
   l_ChildCount := l_CtrlObj.Count
  else
   l_ChildCount := 0;
  //Changing;
  try
   if l_ChildCount > 0 then
   begin
    for I := 0 to l_ChildCount - 1 do
    begin
     l_CtrlObj.pm_GetItem(I, l_Object);
     UnderControlRoot.InsertChild(TnsUnderControlNode.Make(l_Object));
    end;
   end
   else
    AddFakeNode;
  finally
   //Changed;
  end;
 finally
  l_CtrlObj := nil;
 end;
end;

function TnsUnderControlObjList.pm_GetRoot : Il3SimpleNode;
begin
 if (f_UnderControlRoot = nil) then
 begin
  f_UnderControlRoot := TnsUnderControlRoot.Make;
  f_UnderControlRoot.Text := vcmCStr(str_ControlledTree).AsWStr;
  LoadChilds;
 end;//f_UnderControlRoot = nil
 (f_UnderControlRoot as InsUnderControlRoot).SortType := ucstChanging;
 Result := f_UnderControlRoot;
end;

procedure TnsUnderControlObjList.AddChild(const aChild : INode);
begin
 AddChildPrim(aChild, true);
end;

procedure TnsUnderControlObjList.AddControllable(const aControllable : IControllable);
begin
 AddChildPrim(aControllable, true);
end;

procedure TnsUnderControlObjList.DeleteControllable(const aControllable : IControllable);
var
 l_Node: Il3Node;
begin
 if f_UnderControlRoot <> nil then
 begin
  f_UnderControlRoot.Changing;
  try
   l_Node := FindOnControllable(f_UnderControlRoot, aControllable);

   if l_Node <> nil then
   begin
    l_Node.Delete;

    AddFakeNode;
   end;
  finally
   f_UnderControlRoot.Changed;
  end;
 end;
end;

procedure TnsUnderControlObjList.SetOpenedFlag(const aControllable: IControllable);
var
 l_Node: Il3Node;
 l_UnderControlNode: InsUnderControlNode;
begin
 l_Node := FindOnControllable(pm_GetRoot As Il3Node, aControllable);
 try
  if Supports(l_Node, InsUnderControlNode, l_UnderControlNode) then
   try
    l_UnderControlNode.IsOpened := True;
   finally
    l_UnderControlNode := nil;
   end;
 finally
  l_Node := nil;
 end;
end;

procedure TnsUnderControlObjList.DropModifiedFlagForOpened(const aForm : IvcmEntityForm);

 function FindNode(const anIntf: Il3Node) : Boolean;
 var
  l_UnderControlNode : InsUnderControlNode;
 begin
  Result := False;
  if Supports(anIntf, InsUnderControlNode, l_UnderControlNode) then
   try
    Result := (l_UnderControlNode.Status <> 0) and
              l_UnderControlNode.IsOpened;
   finally
    l_UnderControlNode := nil;
   end;
 end;

 function DropStatus(const anIntf: Il3Node) : Boolean;
 var
  l_UnderControlNode : InsUnderControlNode;
 begin
  Result := False;
  if Supports(anIntf, InsUnderControlNode, l_UnderControlNode) then
   try
    if l_UnderControlNode.IsOpened then
     l_UnderControlNode.ResetStatus;
   finally
    l_UnderControlNode := nil;
   end;
 end;

begin
 if f_UnderControlRoot <> nil then
 begin
  if f_UnderControlRoot.IterateF(l3L2NA(@FindNode), imCheckResult) <> nil then
  begin
   if (aForm as IvcmUserInteraction).Ask(qr_DropChangeStatusToOpened) then
    f_UnderControlRoot.IterateF(l3L2NA(@DropStatus));
  end;
 end;
end;

procedure TnsUnderControlObjList.FinishDataUpdate;
begin
 f_UnderControlRoot := nil;
 NotifyDataUpdated;
 inherited;
end;

constructor TnsUnderControlObjList.Create;
begin
 inherited Create;
end;

procedure TnsUnderControlObjList.Cleanup;
begin
 f_UnderControlRoot := nil;
 inherited;
end;

function TnsUnderControlObjList.As_Il3ChangeNotifier: Il3ChangeNotifier;
begin
 Result := Self;
end;

end.
