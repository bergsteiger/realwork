{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcfdmemo;
{$I dc.inc}

interface
uses
  dcsystem,dcapp,dccdes,classes,sysutils,dcstring,forms,dcfdes,dcgen,
  dialogs,windows,dcconsts,typinfo,dcmemo,messages, editunit,
  dcidemem, dcidedes,dcdreamlib;

type
  TIDEFormMemoObject = class(TCustomIDEFormMemoObject)
  private
    FInstanceName:String;
    FFormObject:TIDEFormObject;
    function GetMemoObject:TCustomMemoObject;
    procedure GetCompNames(Sender:TObject; TypeData: PTypeData; Proc: TGetStrProc);
    procedure AddUses;
  protected
    procedure CMNAMECHANGED(Var Msg:TMessage);message CM_NAMECHANGED;
    function GetDefaultSaveClass:TSaveObjectClass;override;
    procedure AfterCreate;virtual;
    function GetMasterObjectClass:TIDEObjectClass;override;
    function FormFileName(const FileName:String):String;virtual;
    function GetFormObjectClass:TIDEFormObjectClass;virtual;
  public
    procedure Hide; override;
    destructor Destroy;override;
    function GetObjectProps:String;override;
    function GetInstance:TComponent;override;
    function ExportTo(const FileName:TFileName; const FilerID:TFilerID;
                SaveClass:TSaveObjectClass):boolean;override;
    constructor CreateFrom(const FileName:TFileName; const FilerID:TFilerID);override;
    constructor CreateNew(const FileName:TFileName; const FilerID:TFilerID;Dummy:Integer);override;
    property FormObject:TIDEFormObject Read FFormObject;
    property MemoObject:TCustomMemoObject Read GetMemoObject;
  published
  end;

  TIDEDataModuleMemoObject = class(TIDEFormMemoObject)
  protected
    function GetFormObjectClass:TIDEFormObjectClass;override;
  end;

  TOpenFormMemoObject = class(TOpenIDEObject)
    function GetIDEObjectClass:TIDEObjectClass;override;
  end;

  TFormMemoSaveObject = class (TSaveObject)
  public
    procedure SaveProc(
                  const AFileName:TFileName; const AFilerID:TFilerID);override;
  end;

{$IFDEF _USE_DFM2HTML_}
  TForm2HMTLSaveObject = class (TSaveObject)
  public
    procedure SaveProc(
                  const AFileName:TFileName; const AFilerID:TFilerID);override;
  end;
{$ENDIF}

  TJSDataModuleObject=class(TIDEDataModuleMemoObject);
  TVBSDataModuleObject=class(TIDEDataModuleMemoObject);
  TPerlDataModuleObject=class(TIDEDataModuleMemoObject);
  TDelphiDataModuleObject=class(TIDEDataModuleMemoObject);
  TPythonDataModuleObject=class(TIDEDataModuleMemoObject);

  TVBSFormObject=class(TIDEFormMemoObject);
  TJSFormObject=class(TIDEFormMemoObject);
  TPerlFormObject=class(TIDEFormMemoObject);
  TDelphiFormObject=class(TIDEFormMemoObject);
  TPythonFormObject=class(TIDEFormMemoObject);

  TScriptApplication = class(TIDEApplication)
  protected
    function GetDefaultUnitName : string; virtual; abstract;
  public
    procedure AddTo(IDEObject : TCompoundIDEObject); override;
  end;

  TPerlApplication = class(TScriptApplication)
  protected
    function GetDefaultUnitName : string; override;
  end;

  TDelphiApplication = class(TScriptApplication)
  protected
    function GetDefaultUnitName : string; override;
  end;

  TJScriptApplication = class(TScriptApplication)
  protected
    function GetDefaultUnitName : string; override;
  end;

  TVBScriptApplication = class(TScriptApplication)
  protected
    function GetDefaultUnitName : string; override;
  end;

  TPythonApplication = class(TScriptApplication)
  protected
    function GetDefaultUnitName : string; override;
  end;


const
  DefaultNewAppItem:  TIDEObjectClass = TJScriptApplication;
  DefaultNewFormItem: TIDEObjectClass = TJSFormObject;
  DefaultNewDataItem: TIDEObjectClass = TJSDataModuleObject;

implementation

{$IFDEF _USE_DFM2HTML_}
uses
  dfm2html;
{$ENDIF}
type
  TMyMessageAnswer=class(TMessageAnswer)
  protected
    procedure CMSCRIPTERROR(Var Message: TWMScriptError); message CM_SCRIPTERROR;
  end;

{------------------------------------------------------------------}

procedure TMyMessageAnswer.CMSCRIPTERROR(Var Message: TWMScriptError);
var
  iobject : TIDEObject;
  msource : TCustomMemoSource;
  EditForm:TEditForm;
begin
  with Message,ErrorInfo^ do
    begin
      iobject := MainIDEObject.OpenFile(FileName, FilerID, true);
      if iobject is TIDEFormMemoObject then
        begin
          msource := TIDEFormMemoObject(iobject).MemoObject.MemoSource;
          msource.SetCaretPoint(point(CharPos, LinePos));
          EditForm:=ShowMemoSource(msource, [spCenterOnLine, spMakeTop]);
          if EditForm<>nil then
            With EditForm.Memo do
              If lParam=0 then
                TempHighlightLineWithStyle(LinePos,STxtStErrorLn)
              else
                GetSource.TempUnhighlightLine;
        end;
    end;
end;

{-------------------------------------------------------------}

procedure TIDEFormMemoObject.Hide;
begin
  if fFormObject <> nil then
    fFormObject.Hide;
end;

{-------------------------------------------------------------}

procedure TIDEFormMemoObject.CMNAMECHANGED(Var Msg:TMessage);
begin
  If (FormObject<>nil) and (Msg.wParam=Integer(FormObject.Instance)) then
    PropsChanged;
end;

{-------------------------------------------------------------}

destructor TIDEFormMemoObject.Destroy;
begin
  If FFormObject<>nil then
  begin
    FInstanceName:=FFormObject.Instance.Name;
    FFormObject:=nil;
  end;
  inherited;
end;

{-------------------------------------------------------------}

function TIDEFormMemoObject.GetObjectProps:String;
begin
  If FInstanceName<>'' then
    Result:=SPropInstanceName+'='+FInstanceName
  else
  if (FormObject<>nil) then
    Result:=SPropInstanceName+'='+FormObject.Instance.Name
  else
    Result:='';
end;

{--------------------------------------------}

function TIDEFormMemoObject.GetDefaultSaveClass:TSaveObjectClass;
begin
  Result:=TFormMemoSaveObject;
end;

{--------------------------------------------}

function TIDEFormMemoObject.GetMasterObjectClass:TIDEObjectClass;
begin
  Result:=TMemoForFormObject;
end;

{--------------------------------------------}

constructor TIDEFormMemoObject.CreateFrom(const FileName:TFileName; const FilerID:TFilerID);
begin
  try
    If FilerFileExists(FilerID,FormFileName(FileName)) then
      FFormObject:=GetFormObjectClass.CreateFrom(FormFileName(FileName),FilerID);
    inherited;
  finally
    AfterCreate;
  end;
  ObjectCreated;
end;

{--------------------------------------------}

constructor TIDEFormMemoObject.CreateNew(const FileName:TFileName; const FilerID:TFilerID;Dummy:Integer);
begin
  FFormObject:=GetFormObjectClass.CreateNew(FormFileName(FileName),FilerID,0);
  inherited;
  AfterCreate;
  FFormObject.FormDesigner.CodeDesigner.FillWithTemplate(ObjectName,True);
  MemoObject.MemoSource.JumpTo(0,0);
end;

{--------------------------------------------}

function TIDEFormMemoObject.GetMemoObject:TCustomMemoObject;
begin
  Result:=TCustomMemoObject(MasterObject);
end;

{--------------------------------------------}

procedure TIDEFormMemoObject.AfterCreate;
begin
  If Assigned(FFormObject) then
  begin
    AddObject(FFormObject);
    SetObjectOrder(FFormObject,0);
    With FFormObject,FormDesigner do
    begin
      CodeDesigner:=MemoObject.CodeDesigner;
      OnGetCompNames:=GetCompNames;
      if CodeDesigner <> nil then
        CodeDesigner.ModuleOwner := Instance;
      HideOnClose := True;
    end;
  end;
end;

{--------------------------------------------}

function TIDEDataModuleMemoObject.GetFormObjectClass:TIDEFormObjectClass;
begin
  Result:=TIDEDataModuleObject;
end;

{--------------------------------------------}

function TIDEFormMemoObject.GetFormObjectClass:TIDEFormObjectClass;
begin
  Result:=TIDEFormObject;
end;

{--------------------------------------------}

function TOpenFormMemoObject.GetIDEObjectClass:TIDEObjectClass;
begin
  Result:=TIDEFormMemoObject;
end;

{--------------------------------------------}

function TIDEFormMemoObject.FormFileName(const FileName:String):String;
begin
  Result:=ChangeFileExt(FileName,'.'+SExtdfm);
end;

{--------------------------------------------}

procedure TFormMemoSaveObject.SaveProc(
                  const AFileName:TFileName; const AFilerID:TFilerID);
begin
  With TIDEFormMemoObject(IDEObject) do
  begin
    MemoObject.SaveTo(AFileName,AFilerID,TMemoSaveObject); // ExportTo
    If assigned(FFormObject) then
    begin
      FFormObject.SaveTo(FormFileName(AFileName),AFilerID,TFormSaveObject);  // ExportTo
      If MemoObject.CodeDesigner<>nil then
        MemoObject.CodeDesigner.ModuleOwner:=FFormObject.Instance;
    end;
  end;
end;

{--------------------TForm2HMTLSaveObject------------------------}

{$IFDEF _USE_DFM2HTML_}

procedure TForm2HMTLSaveObject.SaveProc(const AFileName: TFileName;
  const AFilerID: TFilerID);
const
  SArrOfExtScr : array [TScriptType] of string = (SExtJS, SExtVBS, '');
var
  ScrFile: TFileName;
  ScrType: TScriptType;
  F: TextFile;
  HtmlStr: string;
{----------------------------------}
  function GetScriptType(Designer: IDCFormDesigner): TScriptType;
  var
    CodeDes: TCodeDesigner;
  begin
    CodeDes := Designer.CodeDesigner;
    if CodeDes is TJsCodeDesigner then
      Result := sctJavaScript
    else
      if CodeDes is TVbsCodeDesigner then
        Result := sctVBScript
      else
        Result := sctUnknown;
  end;
{----------------------------------}
begin
  with TIDEFormMemoObject(IDEObject) do
  begin
    if Assigned(FFormObject) then
      with FFormObject, FormDesigner do
      try
        BeforeSave;
        ScrType := GetScriptType(FormDesigner);
        if ScrType <> sctUnknown then
        begin
          ScrFile := ExtractOnlyName(AFileName) + '.' + SArrOfExtScr[ScrType]; //don't resource
          MemoObject.MemoSource.SaveToFile(ScrFile);
        end
        else
          ScrFile := '';
        HtmlStr := Form2HtmlStr(FFormObject.FormInstance, ScrFile, ScrType);
        AssignFile(F, AFileName);
        try
          Rewrite(F);
          Write(F, HtmlStr);
        finally
          CloseFile(F);
        end;
      finally
        AfterSave;
      end;
  end;
end;

{$ENDIF}

{--------------------------------------------}

procedure TIDEFormMemoObject.GetCompNames(Sender:TObject; TypeData: PTypeData; Proc: TGetStrProc);
Var
  IDEProject:TCustomIDEProject;
  UsedObjects:TStringList;
  UsedList:TList;
  i:Integer;
begin
  IDEProject:=MainIDEObject.ActiveProject;
  If (IDEProject=nil) or (IDEProject.ProjectItems.IndexOfObject(Self,False)<0) then
    exit;

  UsedObjects:=TStringList.Create;
  UsedList:=TList.Create;
  try
    GetUsedObjects(UsedObjects);
    MainIDEObject.ShortNamesToObjList(UsedObjects,UsedList);
    With UsedList do
      for i:=0 to Count-1 do
        if TObject(Items[i]) is TIDEFormMemoObject then
          CompNamesToProc(TIDEFormMemoObject(Items[i]).GetInstance,
            GetInstance, TypeData, Proc); 
  finally
    UsedObjects.Free;
    UsedList.Free;
  end;

end;

{------------------------------------------------------------------}

procedure TIDEFormMemoObject.AddUses;
var
  cdesign : TCodeDesigner;
  ulist   : TStringList;
  i       : integer;
begin
  if Assigned(FormObject) then
    with FormObject, Instance do
      begin
        cdesign := FormDesigner.CodeDesigner;
        if cdesign <> nil then
          begin
            if cdesign.AutoFillUses then
              begin
                ulist := TStringList.Create;
                try
                  for i := 0 to ComponentCount - 1 do
                    if not (Components[i].ClassName = 'TNotifier') then //don't resource
                      ulist.Add(GetClassUnit(Components[i]));

                  cdesign.UseUnits(ulist, true);
                finally
                  ulist.Free;
                end;
              end;  
          end;
      end;
end;

{------------------------------------------------------------------}

function TIDEFormMemoObject.ExportTo(const FileName:TFileName; const FilerID:TFilerID;
                SaveClass:TSaveObjectClass):boolean;
begin
  Result:=False;
  If Assigned(FormObject) then
  begin
    If not FormObject.FormDesigner.DeleteEmptyEvents then
      exit;
    AddUses;
  end;
  try
    Result:=inherited ExportTo(FileName,FilerID,SaveClass);
  finally
    if Assigned(FFormObject) then
      FormObject.FormDesigner.CodeDesigner := MemoObject.CodeDesigner;
  end;
end;

{------------------------------------------------------------------}

procedure TScriptApplication.AddTo(IDEObject : TCompoundIDEObject);
begin
  inherited;
  MainIDEObject.NewObjectOfClass(TIDEFormMemoObject, GetDefaultUnitName, True);
end;

{******************************************************************}

function TDelphiApplication.GetDefaultUnitName : string;
begin
  result := SUnitPas;
end;

{******************************************************************}

function TJScriptApplication.GetDefaultUnitName : string;
begin
  result := SUnitjs;
end;

{******************************************************************}

function TPerlApplication.GetDefaultUnitName : string;
begin
  result := SUnitPerl;
end;

{******************************************************************}

function TPythonApplication.GetDefaultUnitName : string;
begin
  result := SUnitPython;
end;

{******************************************************************}

function TVBScriptApplication.GetDefaultUnitName : string;
begin
  result := sUnitvbs;
end;

{******************************************************************}

function TIDEFormMemoObject.GetInstance:TComponent;
begin
  result := FormObject;
  if result <> nil then
    result := TIDEFormObject(result).Instance;
end;

{------------------------------------------------------------------}

procedure FileNewApplication;
begin
  MainIDEObject.NewRegisteredIDEObject(DefaultNewAppItem,True);
end;

{------------------------------------------------------------------}

procedure FileNewForm;
begin
  MainIDEObject.NewRegisteredIDEObject(DefaultNewFormItem,True);
end;

{------------------------------------------------------------------}

procedure FileNewDataModule;
begin
  MainIDEObject.NewRegisteredIDEObject(DefaultNewDataItem,True);
end;

{------------------------------------------------------------------}
//BeginSkipConst
const
  VerbArray:Array[0..2] of TVerbData=(
    (Name:'File.NewForm'     ; GetState:nil;Execute:FileNewForm),
    (Name:'File.NewApplication'     ; GetState:nil;Execute:FileNewApplication),
    (Name:'File.NewDataModule'     ; GetState:nil;Execute:FileNewDataModule)
  );
//EndSkipConst
{------------------------------------------------------------------}

procedure _Register;
begin
// ---------------------- new items registration ----------------------
//BeginSkipConst
  RegisterNewItem(TPythonDataModuleObject,SunitPython,'NEWPYTHONDATA',SPageDataModule,SPythonDataModule);
  RegisterNewItem(TPerlDataModuleObject,sUnitPerl,'NEWPERLDATA',SPageDataModule,SPerlDataModule);
  RegisterNewItem(TDelphiDataModuleObject,Sunitpas,'NEWDELPHIDATA',SPageDataModule,SDelphiDataModule);
  RegisterNewItem(TVBSDataModuleObject,Sunitvbs,'NEWVBSDATA',SPageDataModule,SVBScriptDataModule);
  RegisterNewItem(TJSDataModuleObject,Sunitjs,'NEWJSDATA',SPageDataModule,SJScriptDataModule);

  RegisterNewItem(TPythonFormObject,SunitPython,'NEWPYTHONFORM',SPageForm,SPythonForm);
  RegisterNewItem(TPerlFormObject,sUnitPerl,'NEWPERLFORM',SPageForm,SPerlForm);
  RegisterNewItem(TDelphiFormObject,Sunitpas,'NEWDELPHIFORM',SPageForm,SDelphiForm);
  RegisterNewItem(TVBSFormObject,Sunitvbs,'NEWVBSFORM',SPageForm,SVBScriptForm);
  RegisterNewItem(TJSFormObject,Sunitjs,'NEWJSFORM',SPageForm,SJScriptForm);

  RegisterNewItem(TPythonApplication,SFileProject,'NEWPythonApp',SProject,SPythonApp);
  RegisterNewItem(TPerlApplication,SFileProject,'NEWPERLAPP',SProject,SPerlApp);
  RegisterNewItem(TDelphiApplication,SFileProject,'NEWDELPHIAPP',SProject,SDelphiApp);
  RegisterNewItem(TVBScriptApplication,SFileProject,'NEWVBScriptApp',SProject,SVBScriptApp);
  RegisterNewItem(TJScriptApplication,SFileProject,'NEWJScriptApp',SProject,SJScriptApp);
// ---------------------- open classes registration ----------------------

  UnRegisterDCMemoOpenClasses;
  RegisterOpenClass(TOpenFormMemoObject,CommaText([SExtPas,SExtVBS,SExtJs,SExtPl, SExtPy]),SUnitFiles);
  RegisterOpenClass(TOpenFormMemoObject,SExtpas,SDelphiUnit);
  RegisterOpenClass(TOpenFormMemoObject,SExtvbs,SVBScriptUnit);
  RegisterOpenClass(TOpenFormMemoObject,SExtjs,SJScriptUnit);
  RegisterOpenClass(TOpenFormMemoObject,SExtpl,SPerlUnit);
  RegisterOpenClass(TOpenFormMemoObject,SExtpy,SPythonUnit);

// ---------------------- save classes registration ----------------------

  RegisterSaveClass(TFormMemoSaveObject,TIDEFormMemoObject,SExtpas,SDelphiUnit);
  RegisterSaveClass(TFormMemoSaveObject,TIDEFormMemoObject,SExtvbs,SVBScriptUnit);
  RegisterSaveClass(TFormMemoSaveObject,TIDEFormMemoObject,SExtjs,SJScriptUnit);
  RegisterSaveClass(TFormMemoSaveObject,TIDEFormMemoObject,SExtpl,SPerlUnit);
  RegisterSaveClass(TFormMemoSaveObject,TIDEFormMemoObject,SExtpy,SPythonUnit);
  {$IFDEF _USE_DFM2HTML_}
  RegisterSaveClass(TForm2HMTLSaveObject,TIDEFormMemoObject,SExtHTML,SHTMLtext);
  {$ENDIF}

  RegisterVerbArray(VerbArray);

  RegisterClasses([TIDEDataModuleMemoObject,TIDEFormMemoObject,
                   TJSDataModuleObject, TVBSDataModuleObject,
                   TPerlDataModuleObject, TPythonDataModuleObject, TDelphiDataModuleObject,
                   TVBSFormObject,  TJSFormObject, TPerlFormObject,
                   TDelphiFormObject, TPythonDataModuleObject]);

//EndSkipConst
end;

{------------------------------------------------------------------}

procedure RunRegister;
begin
  RegisterForDelphi(_Register);
end;

{------------------------------------------------------------------}
Var
  MyMessageAnswer:TMyMessageAnswer;

initialization
  RunRegister;
  MyMessageAnswer:=TMyMessageAnswer.Create;
finalization
  MyMessageAnswer.Free;
end.
