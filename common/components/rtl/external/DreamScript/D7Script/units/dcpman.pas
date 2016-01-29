{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcpman;

interface
{$I dc.inc}

uses
  graphics,dcapp,dctree,dctslite,dctreeed,classes,dcgen,dcsystem,windows,sysutils,
  controls,messages,treemod, dcconsts,{$IFDEF D4}imglist,{$ENDIF}
  dialogs,comctrls,newunit,dcdreamlib;

type
  TDCProjectSource=class(TComponentSource)
  private
    FChanged:boolean;
    MyNodeRec:TNodeRec;
    FCheckOld:boolean;
    FImageList:TCustomImageList;
    FLoadedClasses:TStringList;
  protected
    function GetObjCaption(IDEClass:TClass;const FileName:TFileName):String;virtual;
    procedure cmIDEEndUpdate (Var Msg:TMessage);message cm_IDEEndUpdate;
    procedure cmIDEBeginUpdate (Var Msg:TMessage);message cm_IDEBeginUpdate;
    procedure CMIDEAPROJCHANGED(Var Msg:TMessage);message CM_IDEAPROJCHANGED;
    procedure CMIDESAVETO      (Var Msg:TMessage);message CM_IDESAVETO;
//    procedure CMIDEREMOVEFROM  (Var Msg:TMessage);message CM_IDEREMOVEFROM;
    procedure CMIDEADDTO       (Var Msg:TMessage);message CM_IDEADDTO;
    procedure CMOBJDESTROYED(Var Msg:TMessage);message CM_OBJDESTROYED;

  public
    function GetImageIndex(IDEClass:TClass):Integer;virtual;
    procedure  PostRefreshEditor;
    procedure NotifyRefresh;
    procedure Add(ObjID:Integer;const Caption:string;InsertType:TNodeAttachMode);override;
    procedure CheckEmpty(Always:boolean);
    procedure Delete(ObjID:Integer);override;
    function    GetInspectorControl(ObjID:Integer):TPersistent;override;
    function    GetLargeImages:TCustomImageList;override;
    function    GetSmallImages:TCustomImageList;override;
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    procedure  Edit(ObjId:integer);override;
    function   GetStatusLine(ObjId:Integer):String;override;
    function   HasChild(objId:integer):boolean;override;
    procedure  GetItems(ObjID:Integer;Iterator:TIteratorProc);override;
    function   CanMove(ObjId,DestId:Integer;InsertType:TNodeAttachMode):boolean;override;
    procedure  MoveTo(ObjId,DestId:Integer;InsertType:TNodeAttachMode);override;
    function   ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;override;
    property ImageList:TCustomImageList Read FImageList;
  end;

  TOpenResourceMaster = class(TOpenObject)
  public
    function OpenFrom(const FileName:TFileName;
            const FilerID:TFilerID):TIDEObject;override;
  end;

  TFillProjectItemProc=procedure(ASource:TDCProjectSource;Item:TIDEProjectItem;Iterator:TIteratorProc);


procedure RegisterFillProjectItemProc(IDEClass:TIDEObjectClass;FillProc:TFillProjectItemProc);
procedure SetRecParams(ASource:TTreeSource;var Rec:TNodeRec);

implementation

{-------------------------------------------------------------------------}

procedure ViewProjectManager;
begin
  EditObject(MainIDEObject,'').Caption:=SCapProjectManager;
end;

{-------------------------------------------------------------------------}

function CheckObjID(ObjID:Integer;C:TClass):boolean;
begin
  Result:=(ObjID>0) and (TObject(ObjID) is C);
end;

{-------------------------------------------------------------------------}

function   TDCProjectSource.CanMove(ObjId,DestId:Integer;InsertType:TNodeAttachMode):boolean;
begin
  result := CheckObjID(ObjID, TIDEProjectItem) and CheckObjID(DestId, TIDEProjectItem) and
  (TIDEProjectItem(ObjId).Collection = TIDEProjectItem(DestId).Collection);
end;

{-------------------------------------------------------------------------}

procedure  TDCProjectSource.MoveTo(ObjId,DestId:Integer;InsertType:TNodeAttachMode);
var
  Collection : TCollection;
  R          : TNodeRec;
begin
  if (ObjID<>0) and (DestId<>0)  and CanMove(ObjID, DestID, InsertType) then
  begin
    Collection := TIDEProjectItem(ObjID).Collection;
    if Assigned(Collection) then
    begin
      with TCollectionItem(ObjID) do
        if InsertType = naInsert then
        begin
          if Index<TCollectionItem(DestID).Index then
            Index:=TCollectionItem(DestID).Index-1
          else
            Index:=TCollectionItem(DestID).Index;
        end
        else
          Index:=Collection.Count-1;
      FillChar(R,Sizeof(R),0);
      R.ObjId  := ObjId;
      R.DestId := DestId;
      R.InsertType:=InsertType;
      R.Caption:=GetDisplayName(integer(ObjID));
      SendNotify(integer(@R),TSMOVETO);
    end;
  end;
  inherited;
  IDEChanged;

end;

{-------------------------------------------------------------------------}


procedure TDCProjectSource.Add(ObjID:Integer;const Caption:string;InsertType:TNodeAttachMode);
Var
  IDEObject:TIDEObject;
begin
  IDEObject:=nil;
  Case InsertType of
    naAdd,naAddFirst,naInsert:
      IDEObject:=CreateNewIDEObject;
    naAddChild,naAddChildFirst:
      If CheckObjID(ObjID,TCustomIDEProject) then
        IDEObject:=MainIDEObject.AddToProject(TCustomIDEProject(ObjID));
  end;
  If (IDEObject<>nil) then
    NotifyRefresh;
  IDEChanged;
end;

{-------------------------------------------------------------------------}

procedure TDCProjectSource.cmIDEBeginUpdate (Var Msg:TMessage);
begin
  FChanged:=False;
end;

{-------------------------------------------------------------------------}

procedure TDCProjectSource.cmIDEEndUpdate (Var Msg:TMessage);
begin
  if FChanged then
    NotifyRefresh;
end;

{-------------------------------------------------------------------------}

procedure TDCProjectSource.NotifyRefresh;
begin
  If IDEUpdateCount=0 then
    PostRefreshEditor
  else
    FChanged:=True;
end;

{------------------------------------------------------------------}

procedure  TDCProjectSource.PostRefreshEditor;
begin
  MyNodeRec.Data:=Self;
  PostNotify(integer(@MyNodeRec),TSREFRESH);
end;

{-------------------------------------------------------------------------}

procedure TDCProjectSource.CMIDEAPROJCHANGED(Var Msg:TMessage);
begin
  NotifyRefresh;
end;

{-------------------------------------------------------------------------}

procedure TDCProjectSource.CMIDESAVETO(Var Msg:TMessage);
begin
  If TIDEObject(Msg.wParam).OldNameIsSame then
    exit;
  FCheckOld:=True;
  try
    NotifyRefresh;
  finally
    FCheckOld:=False;
  end;
end;

{-------------------------------------------------------------------------}

procedure TDCProjectSource.CMOBJDESTROYED(Var Msg:TMessage);
begin
  If (TObject(Msg.wParam) is TIDEProjectItem) or
     (TObject(Msg.wParam) is TIDEObject)
   then
    NotifyRefresh;
end;

{-------------------------------------------------------------------------}

{procedure TDCProjectSource.CMIDEREMOVEFROM(Var Msg:TMessage);
begin
  If TIDEObject(Msg.wParam).RefCount=1 then
    NotifyRefresh;
end;}

{-------------------------------------------------------------------------}

procedure TDCProjectSource.CMIDEADDTO(Var Msg:TMessage);
begin
  NotifyRefresh;
end;

{-------------------------------------------------------------------------}

function TDCProjectSource.GetInspectorControl(ObjID:Integer):TPersistent;
begin
  If CheckObjID(ObjID,TPersistent) then
    Result:=TPersistent(ObjID)
  else
    Result:=nil;
end;

{-------------------------------------------------------------------------}

function TDCProjectSource.GetLargeImages:TCustomImageList;
begin
  Result:=FImageList;
end;

{-------------------------------------------------------------------------}

function TDCProjectSource.GetSmallImages:TCustomImageList;
begin
  Result:=FImageList;
end;

{-------------------------------------------------------------------------}

procedure TDCProjectSource.Delete(ObjID:Integer);
Var
  IDEObject:TIDEObject;
  ItemOwner:TCollection;

  procedure FreeItem;
  begin
    inherited;
    if TDCNamedItems(ItemOwner).IndexOf(TDCNamedItem(ObjId))>=0 then
      TIDEProjectItem(ObjID).Free;
  end;

  function InternalCloseObject(IDEObject:TIDEObject):boolean;
  begin
    Result:=MainIDEObject.CloseObject(IDEObject);
  end;

begin
  If CheckObjID(ObjID,TIDEProjectItem) then
  begin
    With TIDEProjectItem(ObjID) do
    begin
      ItemOwner:=TIDEProjectItem(ObjID).Collection;
      IDEObject:=MainIDEObject.ObjectByFileName(FileName,FilerID);
      If IDEObject<>nil then
      begin
        If InternalCloseObject(IDEObject) then
          FreeItem;
      end else
            FreeItem;
    end;
  end
  else
    if IsInMainObject(ObjID) then
    begin
      if InternalCloseObject(TIDEObject(ObjID)) then
        inherited;
    end
  else
    exit;
  IDEChanged;
end;

{-------------------------------------------------------------------------}

procedure TDCProjectSource.CheckEmpty(Always:boolean);
begin
  If (Always) or (MainIDEObject.ObjectCount=0) then
    BroadCastToNotifiers(Self,CM_SOURCEEMPTY,Integer(Self),0);
end;

{-------------------------------------------------------------------------}

function TDCProjectSource.ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;
begin
  Result:=(action in [acShowLines,acCanAdd,acCanDelete,acCanDrag, acshowTreeView,
    acCanHaveChild,acShowToolBar,acShowPopup]) or
    (CheckObjID(ObjID,TCustomIDEProject) and (action=acCanAddChild));
end;

{-------------------------------------------------------------------------}

function TDCProjectSource.HasChild(objId:integer):boolean;
begin
  Result:=
   ((ObjID=0) and (MainIDEObject.ObjectCount>0))
   or
    (CheckObjID(ObjID,TCompoundIDEObject) and
     (TCompoundIDEObject(ObjID).ObjectCount>0))
   or
    (CheckObjID(ObjID,TIDEProject) and
      (TIDEProject(ObjID).ProjectItems.Count>0))
   or (CheckObjID(ObjID,TIDEProjectItem) and
      ProjectItemIsCompound(TIDEProjectItem(ObjID)));
end;

{-------------------------------------------------------------------------}

function TDCProjectSource.GetStatusLine(ObjId:Integer):String;
begin
  Result:='';
  If CheckObjID(ObjID,TIDEObject) then
    Result:=TIDEObject(ObjID).FileName
  else
  If CheckObjID(ObjID,TIDEProjectItem) then
    Result:=TIDEProjectItem(ObjID).FileName;
end;

{-------------------------------------------------------------------------}

procedure  TDCProjectSource.Edit(ObjId:integer);
begin
  If CheckObjID(ObjID,TCustomIDEProject) then
    MainIDEObject.ActiveProject:=TCustomIDEProject(ObjID)
  else
    If CheckObjID(ObjID,TIDEObject) then
      TIDEObject(ObjID).Show
    else
      if CheckObjID(ObjID,TIDEProjectItem) then
        With TIDEProjectItem(ObjID) do
          MainIDEObject.OpenFile(FileName,FilerID,True);
end;

{-------------------------------------------------------------------------}

function TDCProjectSource.GetImageIndex(IDEClass:TClass):Integer;
Var
  ResName:String;
  H:THandle;
begin
  If IDEClass=nil then
    IDEClass:=TIDEObject;
  Result:=FLoadedClasses.IndexOf(IDEClass.ClassName);
  If Result>=0 then
    exit;
  ResName:=FindObjectBitmapRes(H,IDEClass,'PM_'); //don't resource
  If H<>0 then
  begin
    If AddBitmapFromResource(FImageList,ResName,H)>=0 then
    begin
      FLoadedClasses.Add(IDEClass.ClassName);
      Result:=FImageList.Count-1;
      exit;
    end;
  end;
  Result:=-1;
end;

{-------------------------------------------------------------------------}

function TDCProjectSource.GetObjCaption(IDEClass:TClass;
           const FileName:TFileName):String;
begin
  Result:=ExtractFileName(FileName);
  If IDEClass=nil then
    exit;
  If (IDEClass.InheritsFrom(TCompoundIDEObject)) or
     (IDEClass.InheritsFrom(TIDEProject))
  then
    Result:=ChangeFileExt(Result,'');
end;

{-------------------------------------------------------------------------}
const
  CMagicConst = 1234;

procedure RegisterFillProjectItemProc(IDEClass:TIDEObjectClass;FillProc:TFillProjectItemProc);
var
  S1,s2:String;
  v1, v2 : variant;
begin
  S1:=SParFillProjectProc;
  s2:=SParFillProjectProcAddr;
  v1 := CMagicConst;
  v2 := Integer(@FillProc);
  RegisterClassExt(IDEClass,[S1,s2], [v1, v2]);
end;

{-------------------------------------------------------------------------}

function GetFillProjectItemProc(Item:TIDEProjectItem):TFillProjectItemProc;
var
  IDEClass:TIDEObjectClass;
  ClassItem:TObjectParamListItem;
begin
  Result:=nil;
  IDEClass:=TIDEObjectClass(GetClass(Item.ObjectClassName));
  If IDEClass=nil then
    exit;
  ClassItem:=GetItemExParent(IDEClass,TIDEObject,[SParFillProjectProc],[CMagicConst],[]);
  If ClassItem=nil then
    exit;
  Result:=TFillProjectItemProc(Integer(ClassItem.Params[SParFillProjectProcAddr]));
end;

{-------------------------------------------------------------------------}

procedure SetRecParams(ASource:TTreeSource;var Rec:TNodeRec);
begin
  With Rec do
  begin
    StateIndex:=-1;
    SelectedIndex:=ImageIndex;
    TreeSource := ASource;
    RootId := -1;
  end;
end;

{-------------------------------------------------------------------------}

procedure  TDCProjectSource.GetItems(ObjID:Integer;Iterator:TIteratorProc);
Var
  Rec:TNodeRec;

  procedure AddIDEObject(IDEObject:TIDEObject);
  begin
    If IDEObject.Closed then
      exit;
    With Rec do
    begin
      ObjId :=Integer(IDEObject);
      Caption:=GetObjCaption(IDEObject.ClassType,IDEObject.FileName);
      ImageIndex:=GetImageIndex(IDEObject.ClassType);
      If MainIDEObject.ActiveProject=IDEObject then
        FontStyle:=[fsBold]
      else
        FontStyle:=[];

    end;
    SetRecParams(Self,Rec);
    Iterator(Rec);
  end;

  procedure FillCompoundItems(Compound:TCompoundIDEObject);
  Var
    i:Integer;
  begin
    With Compound do
      for i:=0 to ObjectCount-1 do
      begin
        If (Compound<>MainIDEObject) or (not IsMemberOfProject(Objects[i],nil,FCheckOld)) then
          AddIDEObject(Objects[i]);
      end;
  end;

  procedure FillProjectItems(IDEProject:TIDEProject);
  Var
    i:Integer;
    IDEClass:TClass;
  begin
    With IDEProject.ProjectItems do
      for i:=0 to Count-1 do
      begin
        With Rec,TIDEProjectItem(Items[i]) do
        begin
          ObjID:=Integer(Items[i]);
          IDEClass:=GetClass(ObjectClassName);
          Caption:=GetObjCaption(IDEClass,FileName);
          ImageIndex:=GetImageIndex(IDEClass);
        end;
        SetRecParams(Self,Rec);
        Iterator(Rec);
      end;
  end;

  procedure DefaultFillProjectItem(Item:TIDEProjectItem);
  Var
    FillProc:TFillProjectItemProc;
  begin
    FillProc:=GetFillProjectItemProc(Item);
    if Assigned(FillProc) then
      FillProc(Self,Item,Iterator);
  end;

  procedure FillItem(Item:TIDEProjectItem);
  Var
    IDEObject:TIDEObject;
  begin
    If not ProjectItemIsCompound(Item) then
      exit;
    With Item do
      IDEObject:=MainIDEObject.ObjectByFileName(FileName,FilerID);
    If IDEObject<>nil then
      FillCompoundItems(TCompoundIDEObject(IDEObject))
    else
      DefaultFillProjectItem(Item);
  end;

begin
  try
    If ObjID=0 then
      ObjID:=Integer(MainIDEObject);

    fillchar(Rec,SizeOf(Rec),0);
    If CheckObjID(OBjID,TCompoundIDEObject) then
      FillCompoundItems(TCompoundIDEObject(ObjID))
    else
      If CheckObjID(OBjID,TIDEProject) then
        FillProjectItems(TIDEProject(ObjID))
    else
      if CheckObjID(OBjID,TIDEProjectItem) then
        FillItem(TIDEProjectItem(ObjID));
  finally
  end;
end;

{-------------------------------------------------------------------------}

constructor TDCProjectSource.Create(AOwner:TComponent);
begin
  inherited;
  FImageList:=TCustomImageList.Create(Self);
  FLoadedClasses:=TStringList.Create;
  RegisterNotifier(Self);
end;

{-------------------------------------------------------------------------}

destructor TDCProjectSource.Destroy;
begin
  UnRegisterNotifier(Self);
  FLoadedClasses.Free;
  inherited;
end;

{------------------------------------------------------------------}

function TOpenResourceMaster.OpenFrom(const FileName:TFileName;
        const FilerID:TFilerID):TIDEObject;
begin
  Result:=nil;
  if FilerID<>'' then
    dcdreamLib.Error(SErrOnlyWin32FileSystem);
  EditResource(FileName);

end;

{------------------------------------------------------------------}

procedure ShowUseObjectsDialog;
Var
  IDEOBject:TIDEObject;
  ObjList:TStringList;
  UsedList:TList;
  UsedObjects:TStringList;
  i:Integer;
  Related:TIDEObject;
begin
  With MainIDEObject do
  begin

    IDEObject:=ActiveObject;
    If (IDEObject=nil) or (ActiveProject=nil) then
      exit;

    if ActiveProject.ProjectItems.IndexOfObject(IDEObject,False)<0 then
    // this is strange check
    // in future need improvement
    begin
      ShowMessage(Format(SErrObjectNotInProject,[IDEObject.ObjectName]));
      exit;
    end;

    ObjList:=TStringList.Create;
    UsedList:=TList.Create;
    UsedObjects:=TStringList.Create;

    IDEObject.GetUsedObjects(UsedObjects);
    ShortNamesToObjList(UsedObjects,UsedList);
    try
      With ActiveProject.ProjectItems do
        for i:=0 to Count-1 do
        begin
          Related:=Items[i].RelatedObject;
          if (Related<>nil)
               and (Related<>IDEObject)
               and (UsedList.IndexOf(Related)<0)
               and (IDEObject.CanUseObject(Related))
          then
             ObjList.AddObject(Related.ObjectName,Related);
        end;
      If ObjList.Count=0 then
      begin
        ShowMessage(Format(SErrAlreadyUseAll,[IDEObject.ObjectName]));
        exit;
      end;
      If FilterStringsForm(ObjList,SCapUseObjects+IDEobject.ObjectName,0,[uoTrackDblClick]) then
      begin
        StringsObjectsToList(ObjList,UsedList);
        IDEObject.UseObjects(UsedList);
      end;
    finally
      ObjList.Free;
      UsedList.Free;
      UsedObjects.Free;
    end;
  end;
end;

{-------------------------------------------------------------------------}

procedure UseObjectActive(Var VerbStates:TVerbStates);
begin
  HasActiveObject(VerbStates);
  HasActiveProject(VerbStates);
end;

{-------------------------------------------------------------------------}
//BeginSkipConst
const
  VerbArray:Array[0..2] of TVerbData=(
    (Name:'File.UseObject';         GetState:UseObjectActive;Execute:ShowUseObjectsDialog),
    (Name:SViewProjectMan;    GetState:nil{HasObjects};Execute:ViewProjectManager),
    (Name:'View.WindowList';        GetState:nil;Execute:ShowWindowList)
//    (Name:'Tools.IDEInspector';GetState:nil;Execute:ShowIDEInspector)
  );
//EndSkipConst

{------------------------------------------------------------------}

procedure FillIDEFormMemoProc(ASource:TDCProjectSource;Item:TIDEProjectItem;Iterator:TIteratorProc);
Var
  Rec:TNodeRec;
  FName:String;

  procedure Addit(Num:Integer;const ACaption:String;IDEClass:TIDEObjectClass);
  begin
    With Rec do
    begin
      ObjID:=-(Integer(Item)+Num);
      Caption:=ACaption;
      ImageIndex:=ASource.GetImageIndex(IDEClass);
    end;
    SetRecParams(ASource,Rec);
    Iterator(Rec);
  end;

begin
  fillchar(Rec,SizeOf(Rec),0);
  FName:=ExtractFileName(Item.FileName);
  AddIt(1,ChangeFileExt(FName,'.'+SExtDfm),TIDEObjectClass(GetClass('TIDEFormObject')));//don't resource
  AddIt(2,FName,TIDEObjectClass(GetClass('TIDEUnitObject')));//don't resource
end;

{-------------------------------------------------------------------------}

procedure _Register;
Var
  C:TClass;
begin
//  RegisterPropertyEditor(TypeInfo(TCollection),TVerbDispatcher,'',treeed.TCollectEdit);
  RegisterTreeSource(TCompoundIDEObject,TDCProjectSource,'');
  RegisterVerbArray(VerbArray);
  RegisterOpenClass(TOpenResourceMaster,'exe,dll,dpl,bpl',SExecutableFiles); //don't resource

  C:=GetClass('TIDEFormMemoObject'); //don't resource
  If C<>nil then
    RegisterFillProjectItemProc(TIDEObjectClass(C),FillIDEFormMemoProc);
end;

{-------------------------------------------------------------------------}

procedure RunRegister;
begin
  RegisterForDelphi(_Register);
end;

{-------------------------------------------------------------------------}

initialization
  RunRegister;
end.
