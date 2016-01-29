{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcactlst;

interface
{$I dc.inc}

uses
  classes , messages, sysutils,actnlist,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}
  
  dcsystem,dcgen,dctslite,dctreeed,
  graphics,StdCtrls,treemod,forms,dcconsts, stdactns,dbactns,db,controls,
  dcdreamlib,comctrls;

const
  
  sBegID = 100;


type
  TDCActionListSource = class(TComponentSource)
  private
    FCategories : TStringList;
    procedure SetActionList(Value : TActionList);
    function  GetActionList:TActionList;
    function  FindAction(Category : string):integer;
    function  IsMyItem(C:TPersistent):boolean;
    procedure DoRefreshSelect(ObjId : integer);
    procedure EnumRegisteredActions(const Category: string; ActionClass: TBasicActionClass; Info: Pointer);
  protected
    procedure CMPROPCHANGED(var M:TMessage); message CM_PROPCHANGED;
  public
    constructor Create(AOwner:TComponent); override;
    destructor Destroy ; override;
    procedure GetItems(ObjID:Integer;Iterator:TIteratorProc);override;
    procedure SetCaption(ObjID:Integer; const Caption:string);override;
    procedure Add(ObjID:Integer;const Caption:string;InsertType:TNodeAttachMode);override;
    procedure Clear;override;
    procedure Delete(ObjID:Integer);override;
    function  CanMove(ObjId,DestId:Integer;InsertType:TNodeAttachMode):boolean;override;
    procedure MoveTo(ObjId,DestId:Integer;InsertType:TNodeAttachMode);override;
    function  GetInspectorControl(ObjID:Integer):TPersistent;override;
    function  ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;override;
    function  HasChild(objId:integer):boolean;override;
    function  GetStatusLine(ObjId:Integer):String; override;
    function  GetDisplayName(ObjID:integer):string;override;
    function  GetParentId(ObjId:integer):integer;override;
  published
    property ActionList : TActionList read GetActionList write SetActionList;
  end;

procedure DCRegisterActions(const CategoryName: string; const AClasses: array of TBasicActionClass; Resource: TComponentClass);

implementation

type
  TActionLsitEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{-----------------------------------------------------------}

function GetID(Id:integer) : integer;
begin
  result:= -(sBegId + Id);
end;

{------------------------------------------------------------------}


procedure DCRegisterActions(const CategoryName: string; const AClasses: array of TBasicActionClass; Resource: TComponentClass);
var
  i: integer;
begin
  for i:= Low(AClasses) to High(AClasses) do
  begin
    RegisterClassExt(AClasses[i],[SParRegisterAction,SParCategoryName,
      SParResourceClass], [SParRegisterAction,CategoryName,integer(Resource)]);
    SafeRegisterClass(AClasses[i]);
  end;
end;

{-----------------------------------------------------------}

procedure DCUnRegisterActions(const AClasses: array of TBasicActionClass);
var
  i: integer;
begin
  for i:= Low(AClasses) to High(AClasses) do
    GetItemEx(AClasses[i] , [SParRegisterAction],[SParRegisterAction],[cpPartialCompare]).Free;
end;

{-----------------------------------------------------------}

procedure DCEnumRegisteredActions(Proc: TEnumActionProc; Info: Pointer);
var
  i:integer;
begin
  with ObjectParamList do
    for i:= 0 to Count - 1 do
      with Items[i] do
      begin
        if Params[SParRegisterAction] = SParRegisterAction then
          Proc(Params[SParCategoryName],TBasicActionClass(ClassPtr),Info);
      end;
end;

{-----------------------------------------------------------}

function  DCCreateAction(AOwner: TComponent; ActionClass: TBasicActionClass): TBasicAction;
begin
  result := ActionClass.Create(AOwner);
end;

{-----------------------------------------------------------}

procedure AddStandardAction(Comp:TPersistent);
var
  Sl     : TStrings;
  i      : integer;
  c      : TBasicActionClass;
  Action : TBasicAction;
  cname  : string;
  p      : integer;
begin
  if Comp is TDCActionListSource  then
    with TDCActionListSource(Comp) do
      if Assigned(ActionList) then
      begin
        Action := nil;
        Sl := TStringList.Create;
        try
          DCEnumRegisteredActions(TDCActionListSource(Comp).EnumRegisteredActions,Sl);

          if FilterStringsForm(Sl, SVerbStandardAction,0,[]) then
            for i:= 0 to Sl.Count -1 do
            begin
              C:= TBasicActionClass(Sl.Objects[i]);

              Cname := C.Classname;
              if (Cname<>'') and (CompareText(Copy(Cname,1,Length(ClassPrefix)), ClassPrefix) = 0) then
                System.Delete(Cname,1,Length(ClassPrefix));

              Action :=C.Create(ActionList.Owner);
              if (Action is TContainedAction) then
                with TContainedAction(Action) do
                begin
                  ActionList := TDCActionListSource(Comp).ActionList;
                  Name := UniqueName(ActionList.Owner,Cname);
                  Cname :=Sl[i];
                  p:=pos(':',Cname);
                  if P <>0 then
                    System.Delete(Cname,1,P+1);
                  Category := CName;
                end;
            end;

        finally
          Sl.Free;
        end;
        if Action <> nil then
          DoRefreshSelect(integer(Action));

      end;
end;

{-----------TDCActionListSource--------------------------------------}


constructor TDCActionListSource.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FCategories := TStringList.Create;
end;

{------------------------------------------------------------------}

destructor TDCActionListSource.Destroy ;
begin
  FCategories.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TDCActionListSource.SetActionList(Value:TActionList);
begin
  SetTreeLink(Value);
end;

{------------------------------------------------------------------}

function  TDCActionListSource.GetActionList:TActionList;
begin
  result:=TActionList(GetTreeLink);
end;

{------------------------------------------------------------------}

procedure TDCActionListSource.GetItems(ObjID:Integer;Iterator:TIteratorProc);
var
  i   : integer;
  idx : integer;
  s   : string;
  R   : TNodeRec;
begin
  if not ValidSource then
    Exit;
  with ActionList  do
  begin
    if ObjId = 0 then
    begin
      FCategories.Clear;
      for i:= 0 to ActionCount - 1 do
      begin
        s := Actions[i].Category;
        if s = '' then
          s:= SDefaultCategory;
        idx := FCategories.IndexOf(s);
        if idx < 0  then
        begin
          idx := FCategories.Add(s);
          R:= GetNodeRec(GetID(idx), -1, Self, s);
          R.FontStyle := [fsBold];
          Iterator(R);
        end;
      end;
    end
    else
    if ObjID < 0 then
    begin
      s := FCategories[GetID(objId)];
      if CompareText(S,SDefaultCategory) = 0 then
        s:= '';
      for i:= 0 to ActionCount - 1 do
        if Actions[i].Category = s  then
          Iterator(GetNodeRec(integer(Actions[i]), -1, Self, TCustomAction(Actions[i]).Caption ));

    end;
  end;
end;

{------------------------------------------------------------------}

procedure TDCActionListSource.SetCaption(ObjID:Integer; const Caption:string);
var
  Lst : TList;
  R   : TNodeRec;
begin
  if ObjID > 0 then
  begin
    TCustomAction(ObjID).Caption := Caption;
    CaptionChanged(ObjId,Caption);
    inherited;
  end
  else
  begin
    Lst:=TList.Create;
    try
      Fillchar(R,Sizeof(R),0);
      R.Caption:=Caption;
      R.ObjId:=ObjID;
      R.FontStyle := [fsBold];
      Lst.Add(@R);
      SendNotify(integer(Lst),TSOBJECTCHANGED);
    finally
      Lst.Free;
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TDCActionListSource.Add(ObjID:Integer;const Caption:string;InsertType:TNodeAttachMode);
var
  res : TCustomAction;

  {-------------------------------}

  function CreateAction(const categoryname : string ; idx : integer): TCustomAction;
  begin
    with ActionList do
    begin
      result := TAction.Create(ActionList.Owner);
      with result do
      begin
        ActionList := Self.ActionList;
        Name := UniqueName(Self.ActionList.Owner,'Action'); //don't resource
        if idx <> -1 then
          Index := idx;
        if CompareText(Categoryname,SDefaultCategory) = 0 then
          Category := ''
        else
          Category := Categoryname;
      end;
    end;
  end;

  {-------------------------------}

begin
  if not ValidSource then
    exit;

  if  InsertType in [naAddChild , naAddChildFirst ] then
     AddStandardAction(Self)
  else
  if ObjId = 0 then
  begin
    res := CreateAction(SDefaultCategory,-1);
    DoRefreshSelect(integer(res));
  end
  else
  begin
    if ObjId > 0 then
      with TAction(ObjId) do
        if  InsertType = naInsert then
          res := CreateAction(Category,Index)
        else
          res := CreateAction(Category,-1)
    else
    begin
      res := CreateAction(FCategories[GetID(ObjId)],-1);
      InsertType := naAddChild;
    end;
    DoAfterInsert(integer(res),ObjId,res.Name,InsertType);
  end;

end;

{------------------------------------------------------------------}

procedure TDCActionListSource.Clear;
begin
  if ValidSource then
  begin
    FCategories.Clear;
    while ActionList.ActionCount >0 do
      ActionList.Actions[0].Free;
    inherited;
  end;
end;

{------------------------------------------------------------------}

procedure TDCActionListSource.Delete(ObjID:Integer);
var
  s: string;
begin
  if not ValidSource then
    exit;
  if ObjId > 0 then
  begin
    s := TCustomAction(ObjId).CateGory;
    TCustomAction(ObjId).Free;
    SetSelectedObject(0);
    inherited;
    if FIndAction(s) < 0  then
      Refresheditor;
  end;
end;

{------------------------------------------------------------------}

function  TDCActionListSource.CanMove(ObjId,DestId:Integer;InsertType:TNodeAttachMode):boolean;
begin
  result := (objId >0) and (destId >0) and (ObjId <> DestId);
end;

{------------------------------------------------------------------}

procedure TDCActionListSource.MoveTo(ObjId,DestId:Integer;InsertType:TNodeAttachMode);
var
  R:TNodeRec;
begin
  if ValidSource and CanMove(ObjID,DestID,InsertType) then
  begin
    with TCustomAction(ObjID) do
    begin
      if InsertType = naInsert then
      begin
        if Index<TCustomAction(DestID).Index then
          Index:=TCustomAction(DestID).Index-1
        else
          Index:=TCustomAction(DestID).Index;
      end
      else
        Index:=ActionList.ActionCount-1;
    end;
    TCustomAction(ObjID).Category := TCustomAction(DestID).Category;  
    FillChar(R,Sizeof(R),0);
    R.ObjId  := ObjId;
    R.DestId := DestId;
    R.InsertType:=InsertType;
    R.Caption:=(TCustomAction(ObjID).Caption);
    SendNotify(integer(@R),TSMOVETO);
  end;
  inherited;
end;

{------------------------------------------------------------------}

function TDCActionListSource.GetInspectorControl(ObjID:Integer):TPersistent;
begin
  if ObjId >0 then
    result:=TCustomAction(ObjId)
  else
    result := nil;
end;

{------------------------------------------------------------------}

function  TDCActionListSource.ActionAllowed(ObjId:Integer;Action:TActionCode):Boolean;
begin
  if ObjId > 0 then
    result := not (Action in [acRefreshDelete,acShowModal,acShowListView])
  else
    result := not (Action in [acRefreshDelete,acShowModal,acShowListView,acCanEdit,acCanDelete]);
end;

{------------------------------------------------------------------}

function TDCActionListSource.FindAction(Category : string):integer;
var
  i:integer;
begin
  result := -1;
  if CompareText(Category,SDefaultCategory) =0 then
    Category := '';
  if ValidSource then
    with ActionList do
      for i:= 0 to ActionCount - 1 do
        if Actions[i].Category = Category then
        begin
          result := i;
          break;
        end;
end;

{------------------------------------------------------------------}

function  TDCActionListSource.HasChild(objId:integer):boolean;
begin
  if (ObjId = 0) or (integer(FtreeLink) = objId) then
    result := Assigned(ActionList) and (Actionlist.ActionCount >0)
  else
    result := (ObjId < 0) and (FindAction(FCategories[GetID(objId)]) >=0)
end;

{------------------------------------------------------------------}

function  TDCActionListSource.GetStatusLine(ObjId:Integer):String;
begin
  if ObjId >= 0 then
    result := inherited GetStatusLine(ObjId)
  else
    result := FCategories[GetID(ObjId)];
end;

{------------------------------------------------------------------}

function  TDCActionListSource.GetDisplayName(ObjID:integer):string;
begin
  if ObjId >= 0 then
    result := inherited GetDisplayName(ObjId)
  else
    result := SDefaultCategory;
end;

{------------------------------------------------------------------}

function TDCActionListSource.IsMyItem(C:TPersistent):boolean;
begin
  result := (C is TCustomAction) and (TCustomAction(C).ActionList = ActionList);
end;

{------------------------------------------------------------------}

procedure TDCActionListSource.CMPROPCHANGED(var M:TMessage);
var
  Item:TPersistent;
  i:integer;
begin
  if  M.LParam = 0 then
    exit;
  for i:= 0 to TList(M.wparam).Count-1 do
  begin
    Item:=TPersistent(TList(M.wparam).Items[i]);
    if  IsMyItem(Item) and (CompareText(pchar(M.LParam),'Category')=0) then  //don't resource
    begin
      RefreshEditor;
      break;
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TDCActionListSource.EnumRegisteredActions(const Category: string; ActionClass: TBasicActionClass; Info: Pointer);
begin
  with TStrings(Info) do
    AddObject(ActionClass.ClassName + ' : ' + Category ,pointer(ActionClass));
end;

{------------------------------------------------------------------}

function  TDCActionListSource.GetParentId(ObjId:integer):integer;
var
  idx : integer;
  S   : string;
begin
  result := 0;
  if ObjId >0 then
  begin
    S := TCustomAction(ObjId).Category ;
    if S = '' then
      S := SDefaultCategory;
    idx := FCategories.IndexOf(S);
    if idx >= 0 then
      result := GetId(idx);
  end;

end;

{------------------------------------------------------------------}

procedure TDCActionListSource.DoRefreshSelect(ObjId : integer);
var
  R: TNodeRec;
begin
  RefreshEditor;
  fillChar(R,sizeof(R),0);
  R.Data := Self;
  R.ObjId:=ObjId;
  SendNotify(integer(@R),TSSELCHANGED);
end;

{------TActionLsitEditor---------------------------------------}


procedure TActionLsitEditor.ExecuteVerb(Index: Integer);
begin
  EditObject(Component,'Actions');  //don't resource
end;

{------------------------------------------------------------------}

function TActionLsitEditor.GetVerb(Index: Integer): string;
begin
  result := SVerbActionListEditor;
end;

{------------------------------------------------------------------}

function TActionLsitEditor.GetVerbCount: Integer;
begin
  result := 1;
end;


{-----------------------------------------------------------}

//BeginSkipConst
procedure _Register;
begin
  RegisterDefaultTreeSource(TActionList,TDCActionListSource,'Actions');
end;

{-----------------------------------------------------------}

procedure RegisterStandardActions;
begin
  DCRegisterActions('Dataset',[TDataSetCancel,TDataSetDelete, TDataSetEdit,
                    TDataSetFirst, TDataSetInsert, TDataSetLast, TDataSetNext,
                    TDataSetPost, TDataSetPrior,  TDataSetRefresh],TDataset);
  DCRegisterActions('Edit',[TEditCopy,  TEditCut, TEditPaste],TCustomEdit);
  DCRegisterActions('Window',[TWindowArrange, TWindowCascade, TWindowClose,
                    TWindowMinimizeAll,  TWindowTileHorizontal,
                    TWindowTileVertical],TWinControl);

end;

{-----------------------------------------------------------}

procedure _InstantRegister;
begin
  RegisterActionsProc := DCRegisterActions;
  UnRegisterActionsProc  := DCUnRegisterActions;
  EnumRegisteredActionsProc := DCEnumRegisteredActions;
  CreateActionProc := DCCreateAction;
  RegisterComponentEditor(TActionList,TActionLsitEditor);
  RegisterComponentAction(SVerbStandardAction,TDCActionListSource,AddStandardAction);
  RegisterStandardActions;
end;
//EndSkipConst

procedure RunRegister;
begin
  RegisterForDelphi(_Register);
  RegisterForInstant(_InstantRegister);
end;

initialization
  RunRegister;
end.
