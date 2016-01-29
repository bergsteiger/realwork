{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcscdes;

interface
{.$I dc.inc}
{$I dcprod.inc}

uses
  classes, dcsystem, dcfdes, dcconsts,
  dcscript,sysutils, dccdes,dcdreamlib
  {$IFDEF DREAMMEMO}
  ,dcstring, editunit, dcidemem, dcapp
  {$ENDIF}
  ;

type
  TCustomScriptDesigner = class(TCustomLiteDesigner)
  private
    FOnShowSource:TShowSourceEvent;
    FCodeDesignerClass : TCodeDesignerClass;

    function  GetLanguage : string;
    procedure SetLanguage(Const value : string);
    function  GetScript : TStrings;
    procedure SetScript(value : TStrings);
    function  GetEvents : TEventItems;
    procedure SetEvents(value : TEventItems);
    function  GetOnError : TScriptErrorHandler;
    procedure SetOnError(value : TScriptErrorHandler);
    function  GetOnGetUserVarID : TGetUserVarIDProc;
    procedure SetOnGetUserVarID(value : TGetUserVarIDProc);
    function  GetOnGetUserVar : TGetUserVarProc;
    procedure SetOnGetUserVar(value : TGetUserVarProc);
    function  GetOnSetUserVar : TSetUserVarProc;
    procedure SetOnSetUserVar(value : TSetUserVarProc);
    function  GetOnGetUnitFileName : TGetUnitFileNameProc;
    procedure SetOnGetUnitFileName(value : TGetUnitFileNameProc);
    function  GetScripter  : TDCScripter;
    procedure SetScripter(value : TDCScripter);
  protected
    function  GetCodeStrings : TStrings; virtual;
    procedure ShowSourceEvent(Sender : TObject; x, y : integer);virtual;
    procedure UpdateCodeDesigner;virtual;
    procedure GetCodeDesignerClass(Sender:TObject;Var CodeDesignerClass:TCodeDesignerClass);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    
    property Script : TStrings read GetScript write SetScript;
    property Language : string read GetLanguage write SetLanguage;
    property Events : TEventItems read GetEvents write SetEvents;
    property Scripter : TDCScripter read GetScripter write SetScripter;
    property OnError : TScriptErrorHandler read GetOnError write SetOnError;
    property OnGetUserVarID : TGetUserVarIDProc read GetOnGetUserVarID write SetOnGetUserVarID;
    property OnGetUserVar   : TGetUserVarProc   read GetOnGetUserVar   write SetOnGetUserVar;
    property OnSetUserVar   : TSetUserVarProc   read GetOnSetUserVar   write SetOnSetUserVar;
    property OnGetUnitFileName : TGetUnitFileNameProc read GetOnGetUnitFileName write SetOnGetUnitFileName;
    property OnShowSource : TShowSourceEvent read FOnShowSource write FOnShowSource;

  end;

  TDCLiteScriptDsgn = class(TCustomScriptDesigner)
  published
    property AllowedActions;
    property AllowUndo;
    property DesignedComponent;
    property HiddenProps;
    property ReadOnly;
    property ReadOnlyProps;
    property Options;
    property GridStepX;
    property GridStepY;
    property LockControls;
    property LimitControl;
    property LimitInfos;
    property PopupMenu;
    property ShowInspector;
    property ShowComponents;
    property ShowGrid;
    property ShowCaptions;
    property SnapToGrid;
    property NameIsReadOnly;
    property NeedRecreateWnd;
    property PaletteOptions;
    property InspectorOptions;
    property StartHotKey;
    property StopHotKey;
    property ShowHints;
    property ShowPalette;
    property ShowAlignPalette;
    property ShowSelf;
    property ToolsOnTop;
    property UseDefaultMenu;
    property IsStored;
    property UseAncestor;

    property GridColor;
    property UseGlobalOptions;

    property ChangesKey;
    property StoreChanges;

    property Script;
    property Language;
    property Events;

    property CaptionGlyph;
    property UseCaptionButton;

    property OnAction;
    property OnActiveChanged;
    property OnActiveChanging;
    property OnAfterInsertComponent;
    property OnChange;
    property OnCloseForm;
    property OnDeleteComponent;
    property OnGetComponentGlyph;
    property OnInsertComponent;
    property OnKeyDown;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnGetCompNames;
    property OnSelectionChanged;
    property OnEditProperty;
    property OnShowProperty;
    property OnSaveChanges;
    property OnLoadChanges;
    property OnStoreProp;
    property OnSizeChanged;
    property OnGetButtonHint;

    property OnError;
    property OnGetUserVarID;
    property OnGetUserVar;
    property OnSetUserVar;
    property OnGetUnitFileName;
    property OnShowSource;
    property OnAllowPopup;
    property OnProcessMenuItem;
    property OnGetEventsList;
    property OnGetAncestor;
  end;


  {$IFDEF DREAMMEMO}

  TCustomMemoScriptDesigner = class(TCustomScriptDesigner)
  private
    FLinkedMemoObject : TLinkedMemoObject;
    FParser : TSimpleParser;
    FParserClass : TSimpleParserClass;
    procedure SetParserClass(V:TSimpleParserClass);
    property ParserClass:TSimpleParserClass Read FParserClass Write SetParserClass;
  protected
    procedure SetActive(val : boolean);override;
    procedure ShowSourceEvent(Sender : TObject; X, Y : integer);override;
    function  GetCodeStrings : TStrings; override;
    procedure UpdateCodeDesigner;override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner : TComponent); override;
  end;

  TDCLiteMemoScriptDsgn = class(TCustomMemoScriptDesigner)
  published
    property AllowedActions;
    property AllowUndo;
    property DesignedComponent;
    property HiddenProps;
    property ReadOnly;
    property ReadOnlyProps;
    property Options;
    property GridStepX;
    property GridStepY;
    property LockControls;
    property LimitControl;
    property LimitInfos;
    property PopupMenu;
    property ShowInspector;
    property ShowComponents;
    property ShowGrid;
    property ShowCaptions;
    property SnapToGrid;
    property NameIsReadOnly;
    property NeedRecreateWnd;
    property PaletteOptions;
    property InspectorOptions;
    property StartHotKey;
    property StopHotKey;
    property ShowHints;
    property ShowPalette;
    property ShowAlignPalette;
    property UseDefaultMenu;
    property CaptionGlyph;
    property UseCaptionButton;
    property ShowSelf;
    property IsStored;
    property UseAncestor;
    property GridColor;

    property UseGlobalOptions;

    property ChangesKey;
    property StoreChanges;
    property ToolsOnTop;

    property Script;
    property Language;
    property Events;

    property OnAction;
    property OnActiveChanged;
    property OnActiveChanging;
    property OnAfterInsertComponent;
    property OnChange;
    property OnCloseForm;
    property OnDeleteComponent;
    property OnGetComponentGlyph;
    property OnInsertComponent;
    property OnKeyDown;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnGetCompNames;
    property OnSelectionChanged;
    property OnEditProperty;
    property OnShowProperty;
    property OnSaveChanges;
    property OnLoadChanges;
    property OnStoreProp;
    property OnSizeChanged;
    property OnGetButtonHint;

    property OnError;
    property OnGetUserVarID;
    property OnGetUserVar;
    property OnSetUserVar;
    property OnGetUnitFileName;
    property OnAllowPopup;
    property OnProcessMenuItem;
    property OnGetEventsList;
    property OnGetAncestor;
 end;
 {$ENDIF}

implementation

{------------------------------------------------------------------}
type
  TMScripter = class(TDCScripter);

constructor TCustomScriptDesigner.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  Scripter := TDCScripter.Create(nil);
  TMScripter(Scripter).AddRef;
  Scripter.Module := Owner;
  Language := SLangVBScript;
end;

{------------------------------------------------------------------}

destructor TCustomScriptDesigner.Destroy;
begin
  Scripter.Free;
  inherited;
end;

{------------------------------------------------------------------}

function  TCustomScriptDesigner.GetScripter  : TDCScripter;
begin
  result := TDCScripter(inherited Scripter);
end;

{------------------------------------------------------------------}

procedure TCustomScriptDesigner.SetScripter(value : TDCScripter);
begin
  inherited Scripter := value;
end;

{------------------------------------------------------------------}

function  TCustomScriptDesigner.GetEvents : TEventItems;
begin
  result := Scripter.Events;
end;

{------------------------------------------------------------------}

procedure TCustomScriptDesigner.SetEvents(value : TEventItems);
begin
  Scripter.Events := value;
end;

{------------------------------------------------------------------}

procedure TCustomScriptDesigner.SetLanguage(Const Value : string);
begin
  if (Scripter.Language <> value) then  
    begin
      Scripter.Language := value;
      UpdateCodeDesigner;
    end;
end;

{------------------------------------------------------------------}

function  TCustomScriptDesigner.GetLanguage : string;
begin
  result := Scripter.Language;
end;

{------------------------------------------------------------------}

procedure TCustomScriptDesigner.SetScript(value : TStrings);
begin
  Scripter.Script := Value;
end;

{------------------------------------------------------------------}

function  TCustomScriptDesigner.GetScript : TStrings;
begin
  result := Scripter.Script;
end;

{------------------------------------------------------------------}

function  TCustomScriptDesigner.GetOnError : TScriptErrorHandler;
begin
  result := Scripter.OnError;
end;

{------------------------------------------------------------------}

procedure TCustomScriptDesigner.SetOnError(value : TScriptErrorHandler);
begin
  Scripter.OnError := value;
end;

{------------------------------------------------------------------}

function  TCustomScriptDesigner.GetOnGetUserVarID : TGetUserVarIDProc;
begin
  result := Scripter.OnGetUserVarID;
end;

{------------------------------------------------------------------}

procedure TCustomScriptDesigner.SetOnGetUserVarID(value : TGetUserVarIDProc);
begin
  Scripter.OnGetUserVarID := value;
end;

{------------------------------------------------------------------}

function  TCustomScriptDesigner.GetOnGetUserVar : TGetUserVarProc;
begin
  result := Scripter.OnGetUserVar;
end;

{------------------------------------------------------------------}

procedure TCustomScriptDesigner.SetOnGetUserVar(value : TGetUserVarProc);
begin
  Scripter.OnGetUserVar := value;
end;

{------------------------------------------------------------------}

function  TCustomScriptDesigner.GetOnSetUserVar : TSetUserVarProc;
begin
  result := Scripter.OnSetUserVar;
end;

{------------------------------------------------------------------}

procedure TCustomScriptDesigner.SetOnSetUserVar(value : TSetUserVarProc);
begin
  Scripter.OnSetUserVar := value;
end;

{------------------------------------------------------------------}

function  TCustomScriptDesigner.GetOnGetUnitFileName : TGetUnitFileNameProc;
begin
  result := Scripter.OnGetUnitFileName;
end;

{------------------------------------------------------------------}

procedure TCustomScriptDesigner.SetOnGetUnitFileName(value : TGetUnitFileNameProc);
begin
  Scripter.OnGetUnitFileName := value;
end;

{------------------------------------------------------------------}

procedure TCustomScriptDesigner.ShowSourceEvent(Sender : TObject; x, y : integer);
begin
  If Assigned(FOnShowSource) then
    FOnShowSource(Sender,X,Y);
end;

{------------------------------------------------------------------}

procedure TCustomScriptDesigner.GetCodeDesignerClass(Sender:TObject;Var CodeDesignerClass:TCodeDesignerClass);
begin
  CodeDesignerClass:=FCodeDesignerClass;
end;

{------------------------------------------------------------------}

procedure TCustomScriptDesigner.UpdateCodeDesigner;
var
  ACodeDesignerClass : TCodeDesignerClass;
begin
  ACodeDesignerClass := Scripter.GetCodeDesignerClass;

  If FCodeDesignerClass<>ACodeDesignerClass then
  begin

    If CodeDesigner<>nil then
    begin
      CodeDesigner.Free;
      CodeDesigner:=nil;
    end;

    FCodeDesignerClass:=ACodeDesignerClass;

    if ACodeDesignerClass <> nil then
      CodeDesigner := ACodeDesignerClass.Create(Self);
  end;

  If CodeDesigner<>nil then
  begin
    CodeDesigner.OnShowSource := ShowSourceEvent;
    CodeDesigner.Strings := GetCodeStrings;
    CodeDesigner.ModuleOwner:=GetRealDesignedComponent;
  end;
end;

{------------------------------------------------------------------}

function  TCustomScriptDesigner.GetCodeStrings : TStrings;
begin
  Result:=Script;
end;

{$IFDEF DREAMMEMO}

{------------------------------------------------------------------}

constructor TCustomMemoScriptDesigner.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
end;

{------------------------------------------------------------------}

procedure TCustomMemoScriptDesigner.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FLinkedMemoObject) then
  begin
    FLinkedMemoObject := nil;
    Active := false;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomMemoScriptDesigner.SetActive(val : boolean);
begin
  if val <> Active then
    if Val then
    begin
      FLinkedMemoObject := EditTextPropInIDE(Self,'Script'); //don't resource
      if FLinkedMemoObject <> nil then
      begin
        FLinkedMemoObject.FreeNotification(Self);
        UpdateCodeDesigner;
        if FLinkedMemoObject <> nil then
          begin
            FLinkedMemoObject.MemoSource.SyntaxParser:=FParser;
            FLinkedMemoObject.OnGetCodeDesignerClass:=GetCodeDesignerClass;
          end;
      end;
    end
    else
      if FLinkedMemoObject <> nil then
      begin
        Designer.DeleteEmptyEvents;

        MainIDEObject.SaveObject(FLinkedMemoObject);
        if MainIdeObject.CloseObject(FLinkedMemoObject) then
          begin
            FLinkedMemoObject := nil;

            BroadCastToNotifiers(self, CM_DESIGNFINISHED, 0, 0);
          end;
      end;

  inherited;
end;

{------------------------------------------------------------------}

function  TCustomMemoScriptDesigner.GetCodeStrings : TStrings;
begin
  if FLinkedMemoObject<>nil then
    Result:=FLinkedMemoObject.MemoSource.Strings
  else
    Result:=inherited GetCodeStrings;
end;

{------------------------------------------------------------------}

procedure TCustomMemoScriptDesigner.ShowSourceEvent
            (Sender : TObject; X, Y : integer);
begin
  If FLinkedMemoObject<>nil then
    With FLinkedMemoObject do
    begin
      ShowMemoSource(MemoSource,[spCenterOnLine,spMakeTop]);
      MemoSource.JumpTo(X,Y);
    end;
end;

{------------------------------------------------------------------}

procedure TCustomMemoScriptDesigner.SetParserClass(V:TSimpleParserClass);
begin
  If V<>FParserClass then
  begin
    FreeObject(FParser,FParser);
    FParserClass:=V;
    If FParserClass<>nil then
      FParser:=FParserClass.Create(Self);
  end;
end;

{------------------------------------------------------------------}

procedure TCustomMemoScriptDesigner.UpdateCodeDesigner;
begin
  inherited;
  if CodeDesigner <> nil then
    ParserClass := CodeDesigner.GetSyntaxParserClass;
end;

{$ENDIF}

end.
