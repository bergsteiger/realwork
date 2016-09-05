unit F_AttrExplorer;

{ $Id: F_AttrExplorer.pas,v 1.85 2016/06/16 05:38:48 lukyanets Exp $ }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, StdCtrls, Forms, Dialogs,
  vtForm,
  ImgList,
  Main,
  OvcBase, vtlister, vtOutliner,
  l3Types, l3DatLst, l3InternalInterfaces,
  l3Tree, l3Interfaces, l3TreeInterfaces, l3Tree_TLB, l3Nodes,
  daTypes,
  DT_Const, DT_Types, dt_AttrSchema,
  DT_Serv, Dt_Doc, DT_Link, DT_Dict, DT_Log,
  Menus,
  DocIntf,
  AdvMenus,  ComCtrls, vtStatusBar, afwControl,
  afwInputControl, vtComboTree, afwControlPrim, afwBaseControl;

type
  TGetIDProc = function(var aDictID : Longint) : Boolean;

  TAttrListChanged = procedure(Sender: TObject; aAttrID : TdtAttribute; aSub : Longint; ListEmpty : Boolean) of object;

  TOnItemAction = function(aAttrID : TdtAttribute; aNode : Il3HandleNode; aReadOnly : boolean; aSub : Longint) : Boolean of object;

  //TExplorerMode =(emAttrEdit, emSearch);

  TAttrExplorer = class(TvtFrame)
    otlAttributes: TvtOutliner;
    AttrPopUpMenu: TLinkPopUpMenu;
    miEditAttrTree: TMenuItem;
    miInsertAttrsToObjList: TMenuItem;
    miDelDocClass: TMenuItem;
    AttrFooter: TvtStatusBar;

    function  otlAttributesGetItemImage(Sender: TObject; Index: Integer;var aImages : TCustomImageList): Integer;
    procedure otlAttributesGetItemFont(Sender: TObject; Index: Integer; const aFont: Il3Font);
    procedure otlAttributesCurrentChanged(Sender: TObject; aNewCurrent: Integer; aOldCurrent: Integer);
    procedure otlAttributesActionElement(Sender: TObject; Index: Integer);
    procedure miEditAttrTreeClick(Sender: TObject);
    procedure miInsertAttrsToObjListClick(Sender: TObject);
    procedure miDelDocAttrClick(Sender: TObject);
  private
    fAttrSet         : TdtAttributeSet;
    fCurSub          : Longint;
    fFamily          : TdaFamilyID;
    //fExpMode         : TExplorerMode;

    fOnItemAction    : TOnItemAction;

    fDocument        : TarDocumentWithAttr;
    fAttrManager     : TDocAttributeManager;
    fSubsComboBox    : TvtComboTree;

    procedure MakeAttrTree;
    procedure SetAttrSet(Value : TdtAttributeSet);

    function  pmGetAttrManager : TDocAttributeManager;
    procedure pmSetAttrManager(aValue : TDocAttributeManager);

    function  GetFamily      : TdaFamilyID;
    procedure SetFamily(aValue : TdaFamilyID);
    function  GetDocID       : TDocID;

    procedure SetCurSub(aValue : Longint);
    function  GetCurSub : Longint;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DDSupportDropAcceptHandler(var aAddCount   : Longint);
    function  EditDictItem(aAttrID : TdtAttribute; aNode : Il3HandleNode; aSub : Longint) : Boolean;
    //function  FindAttrList(aAttrID : TdtAttribute) : Tl3StringDataList;
    function  FindAttrNode(aAttrID : TdtAttribute) : Il3Node;
    function  GotoOnAttrNode(aAttrID : TdtAttribute) : Boolean;
    function  IsEmpty(aAttrSet : TdtAttributeSet = []) : Boolean;
    //procedure AddBuffDictItems(aAttrID  : TdtAttribute; GetIdProc : TGetIDProc; aSub : TSubID = 0);
    procedure GetAttrTreeListOnSub(aSub        : Integer;
                                   aDictSet    : TdtAttributeSet = []);

    procedure RefreshAttr(aDictSet : TdtAttributeSet = []);
     { - обновление информации в дереве по таблицам}
    procedure SetTreeListReadOnly(aSetted : Boolean; aDictSet : TdtAttributeSet);

    property  AttrSet      : TdtAttributeSet read fAttrSet  write SetAttrSet;
    property  CurSub       : Longint    read GetCurSub write SetCurSub;
    property  Family       : TdaFamilyID  read GetFamily write SetFamily;
    property  DocID        : TDocID     read GetDocID;
    //property  ExpMode      : TExplorerMode read fExpMode write fExpMode;
    property  Document     : TarDocumentWithAttr read fDocument write fDocument;
    property  SubsComboBox : TvtComboTree read fSubsComboBox write fSubsComboBox;
    property  AttrManager  : TDocAttributeManager read  pmGetAttrManager write pmSetAttrManager;
   published
    property  OnItemAction : TOnItemAction read fOnItemAction write fOnItemAction;
  end;

const
 cNonDefSub = -2;

implementation

{$R *.DFM}

uses
  l3Variant,
  l3Base,
  l3Date,
  l3Bits,
  l3String,

  k2Interfaces,

  arAttrNodes,
  StrShop,
  DictsSup,
  ResShop, IniShop,
  dragData,
  ObjList,
  DT_Active, DT_Alarm,
  l3TreeSupport,
  DictMetaForm, TreeDWin,
  DocAttrIntf,
  dt_DictTypes
  ;

constructor TAttrExplorer.Create(AOwner: TComponent);
begin
 inherited Create(AOwner);
 fCurSub := cNonDefSub;
 otlAttributes.Images := ArchiResources.CommonImageList;
 otlAttributes.UseStyleTable := True;
end;

destructor TAttrExplorer.Destroy;
begin
 l3Free(fAttrManager);
 inherited Destroy;
end;

function TAttrExplorer.pmGetAttrManager : TDocAttributeManager;
begin
 if Assigned(Document) then
  Result := Document.AttrManager(CurSub)
 else
 begin
  if fAttrManager = nil then
   fAttrManager := TDocAttributeManager.Create;
  Result := fAttrManager;
 end;
end;

procedure TAttrExplorer.pmSetAttrManager(aValue : TDocAttributeManager);
begin
 l3Set(fAttrManager, aValue);
end;

function  TAttrExplorer.GetFamily : TdaFamilyID;
begin
 if Assigned(Document) then
  Result := Document.DocFamily
 else
  Result := fFamily;
end;

procedure TAttrExplorer.SetFamily(aValue : TdaFamilyID);
begin
 fFamily := aValue;
 AttrManager.DocFamily := fFamily;
end;

function  TAttrExplorer.GetDocID  : TDocID;
begin
 if Assigned(Document) then
  Result := Document.DocID
 else
  Result := 0;
end;

function  TAttrExplorer.GetCurSub : Longint;
begin
 if fCurSub = cNonDefSub then
  Result := 0
 else
  Result := fCurSub;
end;

procedure TAttrExplorer.SetCurSub(aValue : Longint);
var
 l_Node: Il3SimpleNode;
begin
 if (fCurSub = aValue) then Exit;
 fCurSub := aValue;
 if (DocID = 0) then exit;
 GetAttrTreeListOnSub(CurSub);
 if Assigned(fSubsComboBox) and (fSubsComboBox.CurrentNode <> nil) and
    ((fSubsComboBox.CurrentNode as Il3HandleNode).Handle <> CurSub) then
 begin
  l_Node := l3FindNodeByHandle(fSubsComboBox.TreeStruct.RootNode as Il3Node, CurSub);
  if l_Node <> nil then
   fSubsComboBox.CurrentNode := l_Node;
 end;
end;

procedure TAttrExplorer.SetAttrSet(Value : TdtAttributeSet);
begin
 If fAttrSet = [] then
 begin
  fAttrSet := Value;
  MakeAttrTree;
 end;
end;

procedure TAttrExplorer.MakeAttrTree;

 procedure AddAttrSubTree(aAttrID : TdtAttribute);
  var
   SL           : Tl3StringDataList;
   NN           : Il3Node;
   lNode        : TarAttributeContainerNode;
  begin
   with otlAttributes.CTree do
    begin
     lNode := TarAttributeContainerNode.Create;
     try
      with lNode do
      begin
       Text := l3PCharLen(GetAttrName(aAttrID));
       Attribute := AttrManager.GetDocAttribute(aAttrID) as IListDocAttribute;
       InsertNode(CRootNode, lNode);
       with (lNode as Il3HandleNode) do
        Handle := Ord(aAttrID);
       ChangeExpand(lNode, sbSelect, True);
      end;
     finally
      l3Free(lNode);
     end;
    end;
  end;

 var
  I : Integer;
 begin
  otlAttributes.CTree.Changing;
  try
   for I := 0 to High(AttrIDOrder) do
    If AttrIDOrder[I] in fAttrSet then
     AddAttrSubTree(AttrIDOrder[I]);
  finally
   otlAttributes.CTree.Changed;
  end;
 end;

function TAttrExplorer.GotoOnAttrNode(aAttrID : TdtAttribute) : Boolean;
 var
  lNode : Il3Node;

 begin
  lNode := FindAttrNode(aAttrID);
  Result := lNode <> nil;
  If Result then
  begin
   otlAttributes.GotoOnNode(lNode);
   otlAttributes.ShowMoreChildrenOnScreen(lNode);
  end;
 end;

function TAttrExplorer.FindAttrNode(aAttrID : TdtAttribute) : Il3Node;
 var
  lNode : Il3Node;

 function IterHandler(CurNode : Il3Node) : Boolean; far;
  begin
   With (CurNode as Il3HandleNode) do
   begin
    Result := Handle = Ord(aAttrID);
    If Result then lNode := CurNode;
   end;
  end;

 begin
  lNode := nil;
  otlAttributes.IterateF(Tl3NodeAction(l3L2FA(@IterHandler)), imOneLevel or imCheckResult);
  Result := lNode;
 end;

function TAttrExplorer.IsEmpty(aAttrSet : TdtAttributeSet) : Boolean;

 function IterHandler(CurNode : Il3Node) : Boolean; far;
 begin
  if (aAttrSet = []) or (TdtAttribute((CurNode as Il3HandleNode).Handle) in aAttrSet) then
   Result := CurNode.ThisChildrenCount > 0;
 end;

begin
 Result := otlAttributes.IterateF(Tl3NodeAction(l3L2FA(@IterHandler)), imOneLevel or imCheckResult) = nil;
end;

function TAttrExplorer.EditDictItem(aAttrID : TdtAttribute; aNode : Il3HandleNode; aSub : Longint) : Boolean;
var
 lInd : Integer;
begin
 CurSub := aSub;

 if (aNode = nil) or
    (((aNode As Il3Node).ParentNode as Il3HandleNode).Handle = 0) then  //нода - контейнер атрибута
  lInd := -1
 else
  lInd := Tl3ListItemNode((aNode as Il3NodeWrap).GetSelf).ListItem;
 Result := (AttrManager.GetDocAttribute(aAttrID) as IListDocAttribute).EditItem(lInd);
end;

procedure TAttrExplorer.otlAttributesActionElement(Sender: TObject; Index: Integer);
 var
  lAttrID  : TdtAttribute;
  lCNode   : Il3Node;
  lPNode   : Il3Node;
  lReadOnly : Boolean;
 begin
  lCNode := otlAttributes.CurrentCNode;
  lPNode := lCNode;
  If (lPNode.ParentNode as Il3HandleNode).Handle <> 0
   then lPNode := lPNode.ParentNode;

  lReadOnly :=  otlAttributes.CTree.TestFlagMask(lPNode as Il3Node, nfReadOnly);
  lAttrID := TdtAttribute((lPNode as Il3HandleNode).Handle);

  if not (Assigned(fOnItemAction) and fOnItemAction(lAttrID, lCNode as Il3HandleNode, lReadOnly, CurSub))
     and not lReadOnly then
   EditDictItem(lAttrID, lCNode as Il3HandleNode, CurSub);
 end;

procedure TAttrExplorer.GetAttrTreeListOnSub(aSub : Integer; aDictSet : TdtAttributeSet = []);
{ - Заполнение дерева классификаторов для метки}

  {-todo Reload attribute НАДО вместо всей этой шняги}

 function IterHandler(CurNode : Il3Node) : Boolean; far;
  var
   I           : Integer;
   lDictText   : PAnsiChar;
   lUserText   : PAnsiChar;
   lDictItemID : TDictID;
   NN          : Il3Node;
   lDocAttr    : IDocAttribute;

  begin
   //(CurNode as IListDocAttribute).Attribute := AttrManager.GetDocAttribute(aDictID) as IListDocAttribute;

   with TarAttributeContainerNode((CurNode as Il3NodeWrap).GetSelf) do
    if (TdtAttribute(Handle) in aDictSet) then
    begin
     lDocAttr := AttrManager.GetDocAttribute(TdtAttribute(Handle));
     Attribute := (lDocAttr as IListDocAttribute);
    end;

  end;

 begin
  Screen.Cursor := crHourGlass;
  if CurSub <> aSub then
   CurSub := aSub
  else
   try
    if aDictSet = [] then aDictSet := fAttrSet;
    if (aDictSet * fAttrSet <> []) then
    try
     otlAttributes.Changing;
     otlAttributes.IterateF(Tl3NodeAction(l3L2FA(@IterHandler)), imOneLevel);
    finally
     otlAttributes.Changed;
    end;
   finally
    Screen.Cursor:=crDefault;
   end;
 end;

procedure TAttrExplorer.RefreshAttr(aDictSet : TdtAttributeSet = []{; aStopNotify : Boolean = True});
{ - обновление информации в дереве по таблицам}
begin
 Screen.Cursor := crHourGlass;
 try
  if aDictSet = [] then aDictSet := fAttrSet;

  if (aDictSet * fAttrSet <> []) then
  try
   otlAttributes.Changing;
   AttrManager.ReloadDocAttributes(aDictSet);
  finally
   otlAttributes.Changed;
  end;
 finally
  Screen.Cursor:=crDefault;
 end;
end;

function TAttrExplorer.otlAttributesGetItemImage(Sender: TObject; Index: Integer;var aImages : TCustomImageList): Integer;
 var
  lNode : Il3SimpleNode;
  lPrm   : TdtAttribute;
 begin
  Result := -1;
  If not (Sender is TvtOutliner) then Exit;
  lNode := TvtOutliner(Sender).GetNode(Index);
  lPrm := TdtAttribute((lNode.Parent as Il3HandleNode).Handle);

  If lPrm = atNothing
   then Result := picDir //FirstLevel
   else  Result := GetDictItemImageIndex(AttrID2DLType(lPrm));
 end;

procedure TAttrExplorer.otlAttributesGetItemFont(Sender: TObject; Index: Integer; const aFont: Il3Font);
 var
  lNode : Il3Node;
 begin
  If (Sender is TvtOutliner) then
   begin
    lNode := TvtOutliner(Sender).GetNode(Index) as Il3Node;
    If (lNode.ParentNode as Il3HandleNode).Handle = 0 then //FirstLevel
     begin
      aFont.Style := aFont.Style + [fsBold];
      if not TvtOutliner(Sender).CTree.TestFlagMask(lNode, nfReadOnly)
       {((lNode as Il3HandleNode).Flags and nfReadOnly = 0)} then
       aFont.Style := aFont.Style + [fsUnderline];
     end;
   end;
 end;

procedure TAttrExplorer.otlAttributesCurrentChanged(Sender: TObject; aNewCurrent: Integer; aOldCurrent: Integer);
 begin
  If otlAttributes.Total > 0
   then
    begin
     AttrFooter.Panels[0].Text:=Format(scFmtFuterCounter,[Succ(aNewCurrent),otlAttributes.Total]);
     AttrFooter.Panels[1].Text:=Format(scFmtFuterID,[Abs((otlAttributes.GetNode(aNewCurrent) as Il3HandleNode).Handle)]);
    end
   else
    begin
     AttrFooter.Panels[0].Text:='';
     AttrFooter.Panels[1].Text:='';
    end;
 end;

procedure TAttrExplorer.miEditAttrTreeClick(Sender: TObject);
 begin
  otlAttributesActionElement(Sender, otlAttributes.Current);
 end;

procedure TAttrExplorer.miInsertAttrsToObjListClick(Sender: TObject);
 var
  ItDataRec : TDictItemAddr;

 function IterHandler(CurNode : Il3Node) : Boolean; far;
  begin
   with (CurNode as Il3HandleNode) do
   If otlAttributes.CTree.IsSelect(CurNode) and ((CurNode.ParentNode as Il3HandleNode).Handle <> 0) then
    With ItDataRec do
     Begin
      FamID  := Family;
      DictID := (CurNode.ParentNode as Il3HandleNode).Handle;
      ItemID := Handle;
      ArchiObjectList.AddObjRec(PAnsiChar(l3PCharLen2String(CurNode.Text)), ddDictItem, @ItDataRec);
     end;
  end;

 begin
  otlAttributes.IterateF(Tl3NodeAction(l3L2FA(@IterHandler)), 0);
 end;

procedure TAttrExplorer.miDelDocAttrClick(Sender: TObject);

 function IterHandler(CurNode : Il3Node) : Boolean; far;
  begin
   with (CurNode as Il3HandleNode) do
   if otlAttributes.CTree.IsSelect(CurNode) and
      not otlAttributes.CTree.TestFlagMask(CurNode.ParentNode, nfReadOnly) and
      ((CurNode.ParentNode as Il3HandleNode).Handle <> 0) then
    CurNode.Delete;
  end;

begin
 With otlAttributes do
 begin
  ChangeNotifyOff;
  try
   otlAttributes.IterateF(Tl3NodeAction(l3L2FA(@IterHandler)), 0);
  finally
   ChangeNotifyOn;
  end;
 end;
end;

(*procedure TAttrExplorer.AddBuffDictItems(aAttrID  : TdtAttribute; GetIdProc : TGetIDProc; aSub : TSubID = 0);
var
 lDictItemID : longint;
begin
 try
  While GetIdProc(lDictItemID) do
   (AttrManager.GetDocAttribute(aAttrID) as IListDocAttribute).Add(Pointer(lDictItemID));
 finally
  l3FreeFA(Tl3FreeAction(GetIdProc));
 end;
end; *)

procedure TAttrExplorer.DDSupportDropAcceptHandler(var aAddCount : Longint);

 function AddNodesIterHandler(CurNode : Il3Node) : Boolean; far;
 var
  lCnt        : Integer;
  lCurrent    : Longint;
  lCurAttrID  : TdtAttribute;
  lRec        : PDNDictRec;

  procedure lpAddBuffDictItems(aAttrID  : TdtAttribute; aSub : TSubID = 0);

   (*function GetIDProc(var aDictItemID : Longint) : Boolean; far;
   var
    ItData       : PAnsiChar;
    lListNode    : Il3HandleNode;
    lInd         : Integer;

   begin
    With TArchiObjectList(TDragDataSupport.Instance.DragData) do
    begin
     Result := False;
     While lCurrent < Count do
     begin
      ItData := Data[lCurrent];
      If (TDragDataType(ItData[0]) in [ddDictItem]) and
         (PDictItemAddr(ItData+1)^.FamID = Family) and
         (PDictItemAddr(ItData+1)^.DictID = Byte(lCurAttrID)) then
      begin
       aDictItemID := PDictItemAddr(ItData+1)^.ItemID;
       Result := True;
       Inc(lCurrent);
       Inc(aAddCount);
       Break;
      end;
      Inc(lCurrent);
     end;
    end;
   end;
   *)

   procedure lpAddBuffNonDictItems(aAttrID  : TdtAttribute; aSub : TSubID = 0);
   var
    ItData       : PAnsiChar;
    lCurItemList : Tl3StringDataList;
    lListNode    : Il3HandleNode;
    lInd         : Integer;

   begin
    With TArchiObjectList(TDragDataSupport.Instance.DragData) do
    begin
     Result := False;
     While lCurrent < Count do
     begin
      ItData := Data[lCurrent];
      If (TDragDataType(ItData[0]) in [ddDictItem]) and
         (PDictItemAddr(ItData+1)^.FamID = Family) and
         (PDictItemAddr(ItData+1)^.DictID = Ord(lCurAttrID)) then
      begin
       with (AttrManager.GetDocAttribute(lCurAttrID) as IListDocAttribute) do
        Add(Il3TagRef(PDictItemAddr(ItData+1)^.ItemTag).AsObject);
       Inc(aAddCount);
      end;
      Inc(lCurrent);
     end;
    end;

   end;

  begin
   {if IsStdDictAttr(aAttrID) then
    AddBuffDictItems(lCurAttrID, TGetIDProc(l3L2FA(@GetIDProc)), CurSub)
   else  }
    lpAddBuffNonDictItems(lCurAttrID, CurSub);
  end;

 begin
  if not otlAttributes.CTree.TestFlagMask(CurNode, nfReadOnly) then
  begin
   lCurAttrID  := TdtAttribute((CurNode as Il3HandleNode).Handle);
   lCurrent := 0;
   lpAddBuffDictItems(lCurAttrID, CurSub);
  end;
 end;

begin
 If (TDragDataSupport.Instance.DragDataType = Ord(ddDragObj)) or
    (TDragDataSupport.Instance.DragDataType = Ord(ddDictItem)) then
 begin
  aAddCount := 0;
  otlAttributes.IterateF(Tl3NodeAction(l3L2FA(@AddNodesIterHandler)), imOneLevel);
 end;
end;

procedure TAttrExplorer.SetTreeListReadOnly(aSetted : Boolean; aDictSet : TdtAttributeSet);
 const
  cMode : array [Boolean] of Tl3SetBitType = (sbDeselect, sbSelect);

 function IterHandler(CurNode : Il3Node) : Boolean; far;
  begin
   with (CurNode as Il3HandleNode) do
    if (TdtAttribute(Handle) in aDictSet) then
     otlAttributes.CTree.SetFlagMask(CurNode, nfReadOnly, cMode[aSetted]);
  end;

begin
 try
  Screen.Cursor:=crHourGlass;
  otlAttributes.IterateF(Tl3NodeAction(l3L2FA(@IterHandler)), imOneLevel);
 finally
  Screen.Cursor:=crDefault;
 end;
end;


end.


