{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcidedes;

interface
{$I dc.inc}

uses
  windows, classes, forms, typinfo, sysutils, dcconsts, dcsystem,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  dcgen, dccommon, dcapp, dcfdes,dcdreamlib;

type
  TIDEFormObject = class(TIDEObject)
  private
    FWithResHeader:boolean;
    FFormDesigner:IDCFormDesigner;
    FInstance:TComponent;
    FFormInstance:TCustomForm;
    procedure CreateDesigner(DataModule,AssignWrapper:boolean);
    procedure CloseDesignedForm(Sender:TObject);
    procedure PropCallBack(Instance:TPersistent;PropInfo:PPropInfo;
                UserData:Integer);
  protected
    function  GlobalFindResComp(const AName : string) : TComponent;
    function GetVisible:boolean;override;
    procedure SetModifiedFalse;override;
    function GetModified:boolean;override;
    function GetFocused:boolean;override;
  public
    procedure CreateFromStream(FormStream:TStream);override;
    procedure SetFocused;override;
    procedure FixupReferences;override;
    function GetInstance:TComponent;override;
    procedure GetReferencedObjects(RefObjects:TList);override;
    procedure Hide;override;
    function GetDefaultSaveClass:TSaveObjectClass;override;
    function GetNewClassType:TComponentClass;virtual;{ new item class type (can be TDataModule or TCustomForm descendent }
    function GetFormClassType:TCustomFormClass;virtual;{ form class type used when CreateFrom }
    function GetDesignerClassType:TDCFormDesignerClass;virtual;
    constructor CreateNew(const FileName:TFileName; const FilerID:TFilerID;Dummy:Integer);override;
    destructor Destroy;override;

    procedure CutToClipboard;override;
    procedure PasteFromClipboard;override;
    procedure CopyToClipboard;override;
    procedure DeleteSelection;override;
    procedure SelectAll;override;
    procedure Undo;override;
    procedure Redo;override;

    property FormDesigner:IDCFormDesigner Read FFormDesigner;
    property Instance:TComponent Read FInstance;
    property FormInstance:TCustomForm Read FFormInstance;
  published
    property Visible;
  end;

  TIDEFormObjectClass=class of TIDEFormObject;

  TFormSaveObject = class (TSaveWithBackup)
  protected
  public
    procedure SaveToStream(S:TStream);override;
  end;

  TOpenSimpleForm = class(TOpenIDEObject)
    function GetIDEObjectClass:TIDEObjectClass;override;
  end;

  TIDEDataModuleObject = class(TIDEFormObject)
  public
    function GetNewClassType:TComponentClass;override;
  end;
{==================================================================}

implementation

procedure TIDEFormObject.PropCallBack(Instance:TPersistent;PropInfo:PPropInfo;
            UserData:Integer);
Var
  Value:TObject;
  ValueOwner:TComponent;

  procedure AddValueOwner(AInstance:TComponent);
  var
    I:integer;
  begin
    with MainIDEobject do
      for i:=0 to ObjectCount-1 do
        if Objects[i].GetInstance=AInstance then
        begin
          TList(UserData).Add(Objects[i]);
          break;
        end;
  end;

begin
  Value:=TObject(GetOrdProp(Instance,PropInfo));
  if Value is TPersistent then
  begin
    ValueOwner:=GetTopOwner(TPersistent(Value));
    If (Value<>FInstance) and (ValueOwner<>nil) then
      AddValueOwner(ValueOwner);
  end;
end;

{--------------------------------------------}

procedure TIDEFormObject.GetReferencedObjects(RefObjects:TList);
var
  i:Integer;

  procedure ProcessComp(AComp:TComponent);
  begin
    If not (csDestroying in AComp.ComponentState) then
      IterateProps(AComp,[tkClass],PropCallBack,False,Integer(RefObjects));
  end;

begin
  inherited;
  ProcessComp(FInstance);
  With FInstance do
    for i:=ComponentCount-1 downto 0 do
      ProcessComp(Components[i]);
end;

{--------------------------------------------}

function TIDEFormObject.GetVisible:boolean;
begin
  Result:=IsWindowVisible(FFormInstance.Handle);
end;

{--------------------------------------------}

procedure TIDEFormObject.Hide;
begin
  ShowWindow(FFormInstance.Handle, SW_HIDE);
end;

{--------------------------------------------}

procedure TIDEFormObject.SetModifiedFalse;
begin
  inherited;
  FFormDesigner.WasChanged:=False;
end;

{--------------------------------------------}

procedure TIDEFormObject.SetFocused;
begin
  IF FFormDesigner.ShowInspector=False then
  begin
    ShowObjectInspector;
    FFormDesigner.ShowInspector:=True;
  end;
  If not Focused then
    ShowFormEx(FFormInstance,SW_RESTORE);
end;

{--------------------------------------------}

function TOpenSimpleForm.GetIDEObjectClass:TIDEObjectClass;
begin
  Result:=TIDEFormObject;
end;

{--------------------------------------------}

procedure TIDEFormObject.CutToClipboard;
begin
  FFormDesigner.ClipboardCut;
end;

{--------------------------------------------}

procedure TIDEFormObject.PasteFromClipboard;
begin
  FFormDesigner.ClipboardPaste;
end;

{--------------------------------------------}

procedure TIDEFormObject.CopyToClipboard;
begin
  FFormDesigner.ClipboardCopy;
end;

{--------------------------------------------}

procedure TIDEFormObject.DeleteSelection;
begin
  FFormDesigner.DeleteSelectedComponents;
end;

{--------------------------------------------}

procedure TIDEFormObject.SelectAll;
begin
  FFormDesigner.SelectAll;
end;

{--------------------------------------------}

procedure TIDEFormObject.Undo;
begin
  FFormDesigner.Undo;
end;

{--------------------------------------------}

procedure TIDEFormObject.Redo;
begin
  FFormDesigner.Redo;
end;

{--------------------------------------------}

procedure TFormSaveObject.SaveToStream(S:TStream);
begin
  with TIDEFormObject(IDEObject) do
    FormDesigner.SaveFormToStream(S,FWithResHeader);
end;

{--------------------------------------------}

function TIDEDataModuleObject.GetNewClassType:TComponentClass;
begin
  Result:=DefaultNewDMClassType;
end;

{--------------------------------------------}

function TIDEFormObject.GetDefaultSaveClass:TSaveObjectClass;
begin
  Result:=TFormSaveObject;
end;

{------------------------------------------------------------------}

function TIDEFormObject.GetModified:boolean;
begin
  Result:=FFormDesigner.WasChanged;
end;

{------------------------------------------------------------------}

function TIDEFormObject.GetFocused:boolean;
begin
  With FFormDesigner do
    Result:=(Active and FormIsActive(DCGetDesignerForm(FFormDesigner)));
end;

{------------------------------------------------------------------}

function TIDEFormObject.GetFormClassType:TCustomFormClass;
begin
  Result:=DefaultFormClassType;
end;

{------------------------------------------------------------------}

function TIDEFormObject.GetNewClassType:TComponentClass;
begin
  Result:=DefaultNewFormClassType;
end;

{------------------------------------------------------------------}

function TIDEFormObject.GetDesignerClassType:TDCFormDesignerClass;
begin
  Result:=TDCFormDesigner;
end;

{------------------------------------------------------------------}

procedure TIDEFormObject.CloseDesignedForm(Sender:TObject);
begin
  If MainIDEObject<>nil then
    MainIDEObject.CloseActive;
end;

{------------------------------------------------------------------}

procedure TIDEFormObject.CreateDesigner(DataModule,AssignWrapper:boolean);
begin
  If DataModule then
  begin
    FInstance:=CreateDataModule;
    FFormInstance := TDataModuleWrapper.Create(nil);
    If AssignWrapper then
      TDataModuleWrapper(FFormInstance).DataModule := TDataModule(FInstance);
    SetDesign(FInstance, true);
  end else
    begin
      if not GetFormClassType.InheritsFrom(TCustomForm) then
        raise Exception.CreateFmt(SErrInvalidModuleClass,[GetFormClassType.ClassName]);

      Finstance:=CreateFormWithClass(GetFormClassType);
      FFormInstance:= TCustomForm(FInstance);
    end;

  FFormDesigner:=GetDesignerClassType.Create;
  with FFormDesigner do
  begin
    OnCloseForm:=CloseDesignedForm;
    ShowInspector:=False;
    UseDefaultMenu:=True;
    HideOnClose:=False;
    AllowUndo := true;
    UseGlobalOptions := true;

    DCSetDesignerForm(FFormDesigner,FFormInstance);
    {$IFDEF D6}
    FFormInstance.Designer := FFormDesigner as IDesignerHook;
    {$ELSE}
    FFormInstance.Designer := TFormDesigner(FFormDesigner);
    {$ENDIF}
  end;
end;

{------------------------------------------------------------------}

function  TIDEFormObject.GlobalFindResComp(const AName : string) : TComponent;
var
  i:Integer;

  function OpenInProject(P:TCustomIDEProject):boolean;
  var
    i:Integer;
    Item:TIDEObjectListItem;
  begin
    Result:=False;
    If p=nil then
      exit;
    With P,ProjectItems do
      for i:=0 to Count-1 do
        With TIDEProjectItem(Items[i]) do
          if (RelatedObject=nil) and (CompareText(GetPropValue(SPropInstanceName),AName)=0)
          then
          begin
            if MainIDEObject.FixUpList.IndexOfFileName(FileName,FilerID)<0 then
            begin
              Item:=TIDEObjectListItem(MainIDEObject.FixUpList.Add);
              Item.FileName:=FileName;
              Item.FilerID:=FilerID;
            end;
            Result:=True;
            break;
          end;
  end;

begin
  result := GlobalFindObject(AName);
  If Result<>nil then
    exit;

  With MainIDEObject do
  begin
    If OpenInProject(ActiveProject) then
      exit;
    for i:=0 to ObjectCount-1 do
      if (Objects[i] is TCustomIDEProject) and (Objects[i]<>ActiveProject) then
        if OpenInProject(TCustomIDEProject(Objects[i])) then
          exit;
  end;

end;

{------------------------------------------------------------------}

procedure TIDEFormObject.FixupReferences;
begin
  GlobalFixupReferences;
end;

{------------------------------------------------------------------}

procedure TIDEFormObject.CreateFromStream(FormStream:TStream);
Var
  Hooked:boolean;
begin
  FWithResHeader:=SmartSkipResHeader(FormStream,True);
  CreateDesigner(StreamContainsDataModule(FormStream),False);
  With FFormDesigner do
  Try
    SetDesign(FFormInstance, true);

    Hooked:=SetFindGlobalCompProc(GlobalFindResComp);
    try
      FInstance.Name:=CompFiler.LoadFromStream(FormStream,FInstance);
      If CompFiler.FilerErrors then
      begin
        WasChanged:=True;
        ModifiedDuringOpen:=True;
      end;
    finally
      If Hooked then
        RemoveFindGlobalCompProc;
    end;

    If FInstance is TDataModule then
      TDataModuleWrapper(FFormInstance).DataModule := TDataModule(FInstance);
    Active:=True;
  except
    DCSetDesignerForm(FFormDesigner,nil);
    FFormInstance.Designer:=nil;
    If FFormInstance<>FInstance then
      FreeObject(FFormInstance,FFormInstance)
    else
      FFormInstance:=nil;
    FreeObject(FInstance,FInstance);
    {$IFNDEF D4}
    FreeObject(FFormDesigner,FFormDesigner);
    {$ENDIF}
    SimpleBroadCast(CM_SELECTIONCHANGED);
    raise TSkipException.Create(SErrCreatingForm); // this exception will be skipped later
  end;
end;

{------------------------------------------------------------------}

constructor TIDEFormObject.CreateNew(const FileName:TFileName; const FilerID:TFilerID;Dummy:Integer);
{$IFDEF D3}
Var
  IDEInit:IDCInstantFormInit;
{$ENDIF}
begin
  inherited;
  FWithResHeader:=True;
  CreateDesigner(GetNewClassType.InheritsFrom(TDataModule),True);
  
  {$IFDEF D3}
  If FInstance.GetInterface(IDCInstantFormInit, IDEInit) Then
    IDEInit.Init;
  {$ENDIF}

  With FFormDesigner do
  begin
    FInstance.Name := Copy(FInstance.ClassName,2,MaxInt)+NewUniqueNumberStr;
    CenterDesignedForm(FFormInstance,FInstance.Name);
    WasChanged:=True;
    Active:=True;
  end;
  ObjectCreated;
end;

{------------------------------------------------------------------}

destructor TIDEFormObject.Destroy;
Var
  F:TCustomForm;
begin
  If FFormDesigner<>nil then
    With FFormDesigner do
    begin
      F:=TCustomForm(DCGetDesignerForm(FFormDesigner));
      If F<>nil then
        begin
          Active := false;
          F.Designer:=nil;
        end;
      SimpleBroadCast(CM_SELECTIONCHANGED);
      {$IFNDEF D4}
      Free;
      {$ENDIF}
      if F is TDataModuleWrapper then
        TDataModuleWrapper(F).DataModule.Free;
      If F<>nil then
        F.Release;
    end;
  inherited;
end;

{------------------------------------------------------------------}

function TIDEFormObject.GetInstance:TComponent;
begin
  Result:=FInstance;
end;

{------------------------------------------------------------------}

procedure RunRegister;
begin
  RegisterNewItem(TIDEDataModuleObject,Sunitdfm,'NEWDATA',SPageDataModule,SSimpleDataModule); //don't resource
  RegisterNewItem(TIDEFormObject,Sunitdfm,'NEWFORM',SPageForm,SSimpleForm); //don't resource
  RegisterSaveClass(TFormSaveObject,TIDEFormObject,SExtDFM,SFormFile);
  RegisterOpenClass(TOpenSimpleForm,SExtDFM,SFormFile);
  RegisterClasses([TIDEFormObject,TIDEDataModuleObject]);

end;

initialization
  RunRegister;
end.
