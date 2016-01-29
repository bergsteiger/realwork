{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcidemem;

interface
{$I dc.inc}
uses
  windows,messages,dcconsts,classes,sysutils,dcdreamlib,dcmemo, dccommon,
  dcapp,dcstring,editunit,dcsystem;

type
  TSimpleMemoObject = class(TIDEObject)
  private
    FMemoSource:TCustomMemoSource;
  protected
    procedure ShowSource(Sender : TObject; x, y : integer);
    procedure SetModifiedFalse;override;
    function GetFocused:boolean;override;
  public
    function CanPrint:boolean;override;
    procedure Print;override;
    procedure SetFocused;override;
    function GetDefaultSaveClass:TSaveObjectClass;override;
    procedure Hide;override;
    procedure CutToClipboard;override;
    procedure PasteFromClipboard;override;
    procedure CopyToClipboard;override;
    procedure DeleteSelection;override;
    procedure SelectAll;override;
    procedure Undo;override;
    procedure Redo;override;
    property  MemoSource:TCustomMemoSource Read FMemoSource;
  end;

  TClipboardIDEObject = class(TSimpleMemoObject)
  protected
    function GetModified:boolean;override;
  public
    function GetObjectParams:TIDEObjectParams;override;
    destructor Destroy;override;
    function ExportTo(const FileName:TFileName; const FilerID:TFilerID;
                SaveClass:TSaveObjectClass):boolean;override;
    constructor CreateNew(const FileName:TFileName;
                  const FilerID:TFilerID;Dummy:Integer);override;
  end;

  TOnGetCodeDesignerClass=procedure(Sender:TObject;
    Var CodeDesignerClass:TCodeDesignerClass) of Object;

  TCustomMemoObject = class(TSimpleMemoObject)
  private
    FCodeDesigner:TCodeDesigner;
    FSyntaxParser:TSimpleParser;
    FModuleOwner:TComponent;
    FOnGetCodeDesignerClass:TOnGetCodeDesignerClass;
  protected
    function GetModified:boolean;override;

    function GetCodeDesignerClass:TCodeDesignerClass;virtual;
    procedure CreateSource;virtual;
    procedure UpdateCodeDesigner;

  public
    function ValidObjectName(const ObjName:String):boolean;override;
    procedure CreateFromStream(Stream:TStream);override;
    function ExportTo(const FileName:TFileName; const FilerID:TFilerID;
                SaveClass:TSaveObjectClass):boolean;override;
    constructor CreateNew(const FileName:TFileName;
                  const FilerID:TFilerID;Dummy:Integer);override;
    property ModuleOwner:TComponent Read FModuleOwner Write FModuleOwner;
    property CodeDesigner:TCodeDesigner Read FCodeDesigner;
    property SyntaxParser:TSimpleParser Read FSyntaxParser;
    property OnGetCodeDesignerClass:TOnGetCodeDesignerClass Read
               FOnGetCodeDesignerClass Write FOnGetCodeDesignerClass;
  end;

  TIDEMemoObject = class(TCustomMemoObject)
  published
    property Visible;
  end;

  TCustomUnitObject = class(TCustomMemoObject)
  public
    procedure UseObjects(ObjectList:TList);override;
    procedure GetUsedObjects(UsedObjects:TStrings);override;
    function CanUseObject(IDEObject:TIDEObject):boolean;override;
  end;

  TIDEUnitObject = class(TCustomUnitObject)
  published
    property Visible;
  end;

  TPythonUnitObject=class(TIDEUnitObject);
  TPerlUnitObject=class(TIDEUnitObject);
  TDelphiUnitObject=class(TIDEUnitObject);
  TVBSUnitObject=class(TIDEUnitObject);
  TJSUnitObject=class(TIDEUnitObject);

  TSQLMemoObject=class(TIDEMemoObject);
  THTMLMemoObject=class(TIDEMemoObject);
  TTXTMemoObject=class(TIDEMemoObject);

  TMemoForFormObject = class(TCustomUnitObject)
  protected
    function GetCodeDesignerClass:TCodeDesignerClass;override;
  public
  end;

  TMemoForFormObjectClass = class of TMemoForFormObject;

  TIDEMemoObjectClass=class of TIDEMemoObject;

  TMemoSaveObject = class (TSaveWithBackup)
  public
    procedure SaveToStream(S:TStream);override;
  end;

  TMemoOpenObject = class(TOpenIDEObject)
    function GetIDEObjectClass:TIDEObjectClass;override;
  end;

  TLinkedMemoOpenObject = class(TOpenIDEObject)
    function GetIDEObjectClass:TIDEObjectClass;override;
  end;

  TLinkedMemoObject = class(TIDEMemoObject)
  private
    FLinkedComp:TComponent;
    procedure SetLinkedComp(V:TComponent);
  protected
    procedure Notification(AComponent:TComponent;Operation:TOperation);override;
  public
    function GetObjectParams:TIDEObjectParams;override;
    property LinkedComp:TComponent Read FLinkedComp Write SetLinkedComp;
  end;

procedure UnRegisterDCMemoOpenClasses;// This proc will be removed. Don't use it

function  ActiveMemoSource : TCustomMemoSource;
function  ActiveMemo : TCustomDCMemo;
function  EditTextPropInIDE(Instance:TComponent;const PropName:String) : TLinkedMemoObject;
procedure UpdateCodeDesigners(CodeDesignerClass : TCodeDesignerClass);

implementation

type
  TMMemoSource = class(TCustomMemoSource);

function ActiveMemoSource : TCustomMemoSource;
begin
  if MainIdeObject.ActiveObject  is TCustomMemoObject  then
    result := TCustomMemoObject(MainIdeObject.ActiveObject).MemoSource
  else
    result := nil;
end;

function ActiveMemo : TCustomDCMemo;
var
  source : TCustomMemoSource;
begin
  source := ActiveMemoSource;
  if source <> nil then
    result := TCustomDCMemo(TMMemoSource(source).ActiveMemo)
  else
    result := nil;
end;

{--------------------------------------------}

function TClipboardIDEObject.GetObjectParams:TIDEObjectParams;
begin
  Result:=[opNoRecentFile];
end;

{--------------------------------------------}

function TLinkedMemoObject.GetObjectParams:TIDEObjectParams;
begin
  Result:=[opNoRecentFile];
end;

{--------------------------------------------}

procedure TLinkedMemoObject.SetLinkedComp(V:TComponent);
begin
  If FLinkedComp<>V then
  begin
    FLinkedComp:=V;
    If V<>nil then
      V.FreeNotification(Self);
  end;
end;

{--------------------------------------------}

procedure TLinkedMemoObject.Notification(AComponent:TComponent;Operation:TOperation);
begin
  inherited;
  If (Operation=opRemove) and (AComponent=LinkedComp) and (AComponent<>nil) then
  begin
    LinkedComp.Destroying;
    LinkedComp:=nil;
    SetModifiedFalse;
    MainIDEObject.CloseObject(Self);
  end;
end;

{--------------------------------------------}

procedure TSimpleMemoObject.Hide;
begin
  HideMemoSource(FMemoSource);
end;

{--------------------------------------------}

procedure TSimpleMemoObject.SetModifiedFalse;
begin
  FMemoSource.Modified:=False;
end;

{--------------------------------------------}

procedure TSimpleMemoObject.ShowSource(Sender : TObject; x, y : integer);
begin
  ShowMemoSource(FMemoSource,[spCenterOnLine,spMakeTop]);
  FMemoSource.JumpTo(x,y);   // must be after ShowMemoSource
end;

{--------------------------------------------}

procedure TSimpleMemoObject.SetFocused;
begin
  ShowMemoSource(FMemoSource,[spMakeTop]);
end;

{--------------------------------------------}

procedure TSimpleMemoObject.CutToClipboard;
begin
  FMemoSource.CutBlock;
end;

{--------------------------------------------}

procedure TSimpleMemoObject.PasteFromClipboard;
begin
  FMemoSource.PasteBlock;
end;

{--------------------------------------------}

procedure TSimpleMemoObject.CopyToClipboard;
begin
  FMemoSource.CopyBlock;
end;

{--------------------------------------------}

procedure TSimpleMemoObject.DeleteSelection;
begin
  FMemoSource.DeleteBlock;
end;

{--------------------------------------------}

procedure TSimpleMemoObject.SelectAll;
begin
  FMemoSource.SelectAll;
end;

{--------------------------------------------}

procedure TSimpleMemoObject.Undo;
begin
  FMemoSource.Undo;
end;

{--------------------------------------------}

procedure TSimpleMemoObject.Redo;
begin
  FMemoSource.Redo;
end;

{------------------------------------------------------------------}

function TSimpleMemoObject.GetDefaultSaveClass:TSaveObjectClass;
begin
  Result:=TMemoSaveObject;
end;

{------------------------------------------------------------------}

function TCustomMemoObject.ValidObjectName(const ObjName:String):boolean;
begin
  Result:=(FCodeDesigner=nil) or (FCodeDesigner.ValidIdentifier(ObjName));
end;

{------------------------------------------------------------------}

function TCustomMemoObject.GetCodeDesignerClass:TCodeDesignerClass;
begin
  Result:=nil;
  If Assigned(FOnGetCodeDesignerClass) then
    FOnGetCodeDesignerClass(Self,Result)
  else
    Result:=GetUnitCodeDesignerClass(FileExt);
end;

{------------------------------------------------------------------}

procedure TCustomMemoObject.UpdateCodeDesigner;
Var
  FCodeDesignerClass:TCodeDesignerClass;
begin
  FCodeDesignerClass:=GetCodeDesignerClass;
  FreeObject(FCodeDesigner,FCodeDesigner);
  FreeObject(FSyntaxParser,FSyntaxParser);
  If FCodeDesignerClass<>nil then
  begin
    FCodeDesigner:=TCodeDesigner(FCodeDesignerClass.Create(Self));
    FCodeDesigner.Strings:=FMemoSource.Strings;
    FSyntaxParser:=FCodeDesigner.GetSyntaxParserClass.Create(Self);
  end;

  With FMemoSource do
  begin
    If FCodeDesigner<>nil then
    begin
      Delimeters:=FCodeDesigner.GetDelimiters;
      FCodeDesigner.OnShowSource:=ShowSource;
    end else
    begin
      Delimeters:='';
    end;
    SyntaxParser:=FSyntaxParser;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomMemoObject.CreateSource;
begin
  FMemoSource:=TMemoSource.Create(self);
  FMemoSource.ObjectName:=FileName;
  FMemoSource.UseGlobalOptions:=True;
  UpdateCodeDesigner;
end;

{------------------------------------------------------------------}

procedure TCustomMemoObject.CreateFromStream(Stream:TStream);
begin
  inherited;
  CreateSource;
  With FMemoSource do
  begin
    LoadFromStream(Stream);
//    ParseToString(StrCount);
  end;
  ObjectCreated;
end;

{------------------------------------------------------------------}

function TCustomMemoObject.GetModified:boolean;
begin
  Result:=FMemoSource.Modified;
end;

{------------------------------------------------------------------}

function TSimpleMemoObject.GetFocused:boolean;
begin
  Result:=SourceIsFocused(FMemoSource);
end;

{------------------------------------------------------------------}

constructor TCustomMemoObject.CreateNew(const FileName:TFileName;const FilerID:TFilerID;Dummy:Integer);
begin
  inherited;
  CreateSource;
  If Assigned(FCodeDesigner) then
    FCodeDesigner.FillWithTemplate(ObjectName,True);
  FMemoSource.Modified:=True;
  FMemoSource.JumpTo(0,0);
  ObjectCreated;
end;

{------------------------------------------------------------------}

procedure TMemoSaveObject.SaveToStream(S:TStream);
begin
  TIDEMemoObject(IDEObject).MemoSource.SaveToStream(S);
end;

{------------------------------------------------------------------}

function TCustomMemoObject.ExportTo(const FileName:TFileName;
            const FilerID:TFilerID;SaveClass:TSaveObjectClass):boolean;
begin
  If Assigned(FCodeDesigner) then
    FCodeDesigner.RenameModule(ObjectName,ExtractOnlyName(FileName));
  Result:=inherited ExportTo(FileName,FilerID,SaveClass);
  FMemoSource.ObjectName:=FileName;
  UpdateCodeDesigner;
end;

{--------------------------------------------}

function TLinkedMemoOpenObject.GetIDEObjectClass:TIDEObjectClass;
begin
  Result:=TLinkedMemoObject;
end;

{--------------------------------------------}

function TMemoOpenObject.GetIDEObjectClass:TIDEObjectClass;
begin
  Result:=TIDEMemoObject;
end;

{--------------------------------------------}

function TMemoForFormObject.GetCodeDesignerClass:TCodeDesignerClass;
begin
  Result:=GetFormCodeDesignerClass(FileExt);
end;

{-------------------------------------------------------------}

function TCustomUnitObject.CanUseObject(IDEObject:TIDEObject):boolean;
begin
  Result:=(IDEObject is TCustomUnitObject) or
    (IDEObject is TCustomIDEFormMemoObject);
end;

{-------------------------------------------------------------}

procedure TCustomUnitObject.UseObjects(ObjectList:TList);
begin
  UseObjectsInCodeDesigner(ObjectList,CodeDesigner);
end;

{-------------------------------------------------------------}

procedure TCustomUnitObject.GetUsedObjects(UsedObjects:TStrings);
begin
  UsedObjects.Clear;
  If CodeDesigner<>nil then
    CodeDesigner.GetUsedUnits(UsedObjects,False);
end;

{-------------------------------------------------------------}

destructor TClipboardIDEObject.Destroy;
begin
  HideMemoSource(FMemoSource);
  inherited;
end;

{-------------------------------------------------------------}

function TClipboardIDEObject.GetModified:boolean;
begin
  Result:=False;
end;

{-------------------------------------------------------------}

constructor TClipboardIDEObject.CreateNew(const FileName:TFileName;
              const FilerID:TFilerID;Dummy:Integer);
begin
  inherited CreateNew(SClipboard,'',0);
  FMemoSource:=TClipboardSource.Create(Self);
  FMemoSource.UseGlobalOptions:=True;
  ObjectCreated;
end;

{-------------------------------------------------------------}

function TClipboardIDEObject.ExportTo(const FileName:TFileName; const FilerID:TFilerID;
           SaveClass:TSaveObjectClass):boolean;
begin
  Result:=inherited ExportTo(FileName,FilerID,SaveClass);
  Self.FileName:=SClipboard;
  Self.FilerID:='';
end;

{-------------------------------------------------------------------------}

procedure ViewClipboardHistory;
var
  ClipObject:TClipboardIDEObject;
begin
  ClipObject:=TClipboardIDEObject(MainIDEObject.FindObjectWithClass(TClipboardIDEObject));

  If ClipObject=nil then
  begin
    ClipObject:=TClipboardIDEObject.CreateNew('','',0);
    MainIDEObject.AddObject(ClipObject);
  end;

  ClipObject.Show;
end;

{-------------------------------------------------------------}

Var
  O1,O2,O3,O4,O5,O6:TObjectParamListItem;

procedure UnRegisterDCMemoOpenClasses;
begin
  FreeObject(O1,O1);
  FreeObject(O2,O2);
  FreeObject(O3,O3);
  FreeObject(O4,O4);
  FreeObject(O5,O5);
  FreeObject(O6,O6);
end;

{-------------------------------------------------------------}
//BeginSkipConst
const
  VerbArray:Array[0..0] of TVerbData=(
    (Name:'View.ClipboardHistory'; GetState:nil;Execute:ViewClipboardHistory)
  );

procedure _Register;
begin
  RegisterVerbArray(VerbArray);

  RegisterNewItem(TTXTMemoObject,Sfiletxt,'NEWTEXT',SPageNew,STextFile);

  RegisterNewItem(TPythonUnitObject,SunitPython,'NEWPYTHONUNIT',SPageUnit,SPythonUnit);
  RegisterNewItem(TPerlUnitObject,SunitPerl,'NEWPERLUNIT',SPageUnit,SPerlUnit);
  RegisterNewItem(TDelphiUnitObject,Sunitpas,'NEWDELPHIUNIT',SPageUnit,SDelphiUnit);
  RegisterNewItem(TVBSUnitObject,Sunitvbs,'NEWVBSUNIT',SPageUnit,SVBScriptUnit);
  RegisterNewItem(TJSUnitObject,Sunitjs,'NEWJSUNIT',SPageUnit,SJScriptUnit);

  RegisterNewItem(TSQLMemoObject,StextSql,'NEWSQLUNIT',SPageNew,SSqlText);
  RegisterNewItem(THTMLMemoObject,StextHTML,'NEWHTMLUNIT',SPageNew,SHTMLText);

  {save objects registration }
  RegisterSaveClass(TMemoSaveObject,TSimpleMemoObject,SExtpas,SDelphiUnit);
  RegisterSaveClass(TMemoSaveObject,TSimpleMemoObject,SExtvbs,SVBScriptUnit);
  RegisterSaveClass(TMemoSaveObject,TSimpleMemoObject,SExtjs,SJScriptUnit);
  RegisterSaveClass(TMemoSaveObject,TSimpleMemoObject,SExttxt,STextFile);
  RegisterSaveClass(TMemoSaveObject,TSimpleMemoObject,SExthtml,SHTMLText);
  RegisterSaveClass(TMemoSaveObject,TSimpleMemoObject,SExthtm,SHTMLText);
  RegisterSaveClass(TMemoSaveObject,TSimpleMemoObject,SExtsql,SSqlText);
  RegisterSaveClass(TMemoSaveObject,TSimpleMemoObject,SExtpl,SPerlUnit);
  RegisterSaveClass(TMemoSaveObject,TSimpleMemoObject,SExtpl,SPerlUnit);
  RegisterSaveClass(TMemoSaveObject,TSimpleMemoObject,SExtpy,SPythonUnit);

  { open objects registration }
  RegisterOpenClass(TMemoOpenObject,SExtTXT,STextFile);
  RegisterOpenClass(TMemoOpenObject,SExtsql,SSqlText);
  RegisterOpenClass(TMemoOpenObject,CommaText([SExtHTML,SExthtm]),SHTMLText);

  O1:=RegisterOpenClass(TMemoOpenObject,CommaText([SExtPas,SExtVBS,SExtJs,SExtPl]),SUnitFiles);
  O2:=RegisterOpenClass(TMemoOpenObject,SExtpas,SDelphiUnit);
  O3:=RegisterOpenClass(TMemoOpenObject,SExtvbs,SVBScriptUnit);
  O4:=RegisterOpenClass(TMemoOpenObject,SExtjs,SJScriptUnit);
  O5:=RegisterOpenClass(TMemoOpenObject,SExtpl,SPerlUnit);
  O6:=RegisterOpenClass(TMemoOpenObject,SExtpy,SPythonUnit);

  RegisterClasses([TIDEMemoObject,TIDEUnitObject,TMemoForFormObject,
    TPerlUnitObject, TPythonUnitObject, TDelphiUnitObject,TVBSUnitObject,TJSUnitObject,
    TSQLMemoObject,THTMLMemoObject,TTXTMemoObject,
    TCustomMemoObject,TCustomUnitObject]);

end;
//EndSkipConst
{-------------------------------------------------------------}

procedure RunRegister;
begin
  RegisterForDelphi(_Register);
end;

{-------------------------------------------------------------}

type
  TMyMessageAnswer=class(TMessageAnswer)
  protected
    procedure CMEDITTEXTPROP(Var Message:TMessage);message CM_EDITTEXTPROP;
  end;

var
  MyMessageAnswer:TMyMessageAnswer;

{------------------------------------------------------------------}

function EditTextPropInIDE(Instance : TComponent; const PropName : string) : TLinkedMemoObject;
var
  FilerID : TFilerID;
  s : string;
begin
  result := nil;
  if (MainIDEObject = nil) or (Instance = nil) then
    exit;

  FilerID := getPropFileSystemFilerID(Instance, PropName);
  if FilerID<>'' then
    begin
      s := '';
      if Instance.Owner <> nil then
        s := Instance.Owner.Name + '.';

      result := TLinkedMemoObject(MainIDEObject.OpenFileAs(
        s + Instance.Name + '.' +
        PropName,FilerID,TLinkedMemoOpenObject,True));

      if result <> nil then
        result.LinkedComp := Instance;
    end;

end;

{------------------------------------------------------------------}

procedure TMyMessageAnswer.CMEDITTEXTPROP(Var Message:TMessage);
begin
  EditTextPropInIDE(TComponent(Message.wParam),String(Message.lParam));
end;

{-------------------------------------------------------------}

function TSimpleMemoObject.CanPrint:boolean;
begin
  Result:=Focused;
end;

{-------------------------------------------------------------}

procedure TSimpleMemoObject.Print;
var
  EditForm:TEditForm;
begin
  If GetActiveSource=MemoSource then
  begin
    EditForm:=TEditForm(FindFormWithClass(TEditForm));
    If EditForm<>nil then
      EditForm.Memo.PrintWithDialog;
  end;
end;

{-------------------------------------------------------------}

procedure UpdateCodeDesigners(CodeDesignerClass : TCodeDesignerClass);
var
  i : integer;
begin
  with MainIdeObject do
    for i := 0 to  ObjectCount - 1 do
    begin
      if (Objects[i] is TCustomMemoObject) and (TCustomMemoObject(Objects[i]).CodeDesigner is CodeDesignerClass) then
        TCustomMemoObject(Objects[i]).UpdateCodeDesigner;
    end;
end;

{-------------------------------------------------------------}

initialization
  MyMessageAnswer:=TMyMessageAnswer.Create;
  RunRegister;
finalization
  MyMessageAnswer.Free;
end.
