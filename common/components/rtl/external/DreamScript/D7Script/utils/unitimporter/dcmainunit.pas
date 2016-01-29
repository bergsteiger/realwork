{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit DCMainUnit;

{$I DC.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Buttons, Menus, ToolWin,

  DCEdit, Histed, DCButtonPanel, dcgen,
  DCSystem, DCdreamLib, DCAPI, Import, DCCommon, UnitPars, DCConsts,
  DCImageListBox, DCProcessDlg,

  DCHelpUnit, DCProcCheckUnit, DCImportConsts
  {$IFDEF D4}, ImgList{$ENDIF};
type
  TMainForm = class(TForm)
    SourceFilesPanel: TGroupBox;
    FilesList: TDCImageListBox;
    ImportOptionsPanel: TGroupBox;
    AliasEditor: TDCHistoryEditor;
    LibPathLabel: TLabel;
    LibrariesEditor: TDCDirectoryEdit;
    ConditionalDefinesLabel: TLabel;
    DefinesEditor: TDCHistoryEditor;
    AliasesLabel: TLabel;
    DestPathLabel: TLabel;
    DestEditor: TDCDirectoryEdit;
    DelphiLibsBtn: TSpeedButton;
    ControlButtonsPanel: TDCButtonPanel;
    ImportBtn: TButton;
    CloseBtn: TButton;
    SpacePanel: TPanel;
    FilesControlPanel: TPanel;
    LeftSpacePanel: TPanel;
    StatusPanel: TPanel;
    AddFilesDlg: TOpenDialog;
    DCPropStore: TDCPropStore;
    IncludeCommentsCheck: TCheckBox;
    HeaderPanel: TPanel;
    LeftPanel: TPanel;
    RightPanel: TPanel;
    HelpBtn: TButton;
    CustomImportCheck: TCheckBox;
    ImportSilentlyCheck: TCheckBox;
    MainMenu1: TMainMenu;
    FileItems: TMenuItem;
    NewItem: TMenuItem;
    OpenItem: TMenuItem;
    SaveItem: TMenuItem;
    SaveAsItem: TMenuItem;
    N1: TMenuItem;
    ExitItem: TMenuItem;
    ImageList: TImageList;
    PostfixLabel: TLabel;
    PostfixEditor: TDCHistoryEditor;
    ProjectItems: TMenuItem;
    AddUnitsItem: TMenuItem;
    DeleteItem: TMenuItem;
    ClearAllItem: TMenuItem;
    SaveDialog: TSaveDialog;
    OpenPrjDialog: TOpenDialog;
    CoolBar: TCoolBar;
    ToolBar1: TToolBar;
    NewButton: TToolButton;
    OpenButton: TToolButton;
    SaveButton: TToolButton;
    ToolButton5: TToolButton;
    AddUnitBtn: TToolButton;
    DeleteButton: TToolButton;
    DisabledImageList: TImageList;
    AddUnitsRecursItem: TMenuItem;
    AddUnitsRecursBtn: TToolButton;
    PathDialog: TDCPathDialog;
    AddUnregistrationCheck: TCheckBox;
    Action1: TMenuItem;
    ImportVCLD61: TMenuItem;
    ImportVCLD51: TMenuItem;
    ImportVCLD41: TMenuItem;
    ImportVCLD31: TMenuItem;
    N2: TMenuItem;
    ImportVCLC51: TMenuItem;
    ImportVCLC41: TMenuItem;
    ImportVCLC31: TMenuItem;
    PrepareforImportD61: TMenuItem;
    PrepareforImportD51: TMenuItem;
    PrepareforImportD41: TMenuItem;
    PrepareforImportD31: TMenuItem;
    N4: TMenuItem;
    PrepareforImportC51: TMenuItem;
    PrepareforImportC41: TMenuItem;
    PrepareforImportC31: TMenuItem;
    ImportVCL1: TMenuItem;
    PrepareforImport1: TMenuItem;
    N3: TMenuItem;
    ImportVCLall1: TMenuItem;
    ImportDreamunits1: TMenuItem;
    ImportDreamD61: TMenuItem;
    ImportDreamD51: TMenuItem;
    ImportDreamD41: TMenuItem;
    ImportDreamD31: TMenuItem;
    N5: TMenuItem;
    ImportDreamC51: TMenuItem;
    ImportDreamC41: TMenuItem;
    ImportDreamC31: TMenuItem;
    N6: TMenuItem;
    AddDreamfiles1: TMenuItem;
    N7: TMenuItem;
    ImportDreamall1: TMenuItem;
    ImportQuickReport1: TMenuItem;
    ImportQReportforD61: TMenuItem;
    ImportQReportforD51: TMenuItem;
    ImportQReportforD41: TMenuItem;
    ImportQReportforD31: TMenuItem;
    N8: TMenuItem;
    ImportQReportforC51: TMenuItem;
    ImportQReportforC41: TMenuItem;
    ImportQReportforC31: TMenuItem;
    N9: TMenuItem;
    ImportQReportforall1: TMenuItem;
    PrepareforQReportImport1: TMenuItem;
    PepareforD6QReport1: TMenuItem;
    PepareforD5QReport1: TMenuItem;
    PepareforD4QReport1: TMenuItem;
    PepareforD3QReport1: TMenuItem;
    N10: TMenuItem;
    PepareforC5QReport1: TMenuItem;
    PepareforC4QReport1: TMenuItem;
    PepareforC3QReport1: TMenuItem;
    ImportVCLD71: TMenuItem;
    ImportVCLC61: TMenuItem;
    ImportDreamD71: TMenuItem;
    ImportDreamC61: TMenuItem;
    PrepareforImportD71: TMenuItem;
    PrepareforImportC61: TMenuItem;
    procedure DelphiLibsBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PerformChanges(Sender: TObject);
    procedure ImportBtnClick(Sender: TObject);
    procedure LibrariesEditorChange(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure CustomImportCheckClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure NewActionExecute(Sender: TObject);
    procedure OpenActionExecute(Sender: TObject);
    procedure SaveActionExecute(Sender: TObject);
    procedure SaveAsActionExecute(Sender: TObject);
    procedure ExitActionExecute(Sender: TObject);
    procedure AddUnitsActionExecute(Sender: TObject);
    procedure DeleteActionExecute(Sender: TObject);
    procedure ClearAllActionExecute(Sender: TObject);
    procedure CheckCanProcess(Sender: TObject);
    procedure AddUnitsRecursActionExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FilesListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ImportVCLD61Click(Sender: TObject);
    procedure PrepareforImportD61Click(Sender: TObject);
    procedure ImportVCLall1Click(Sender: TObject);
    procedure ImportDreamD61Click(Sender: TObject);
    procedure AddDreamfiles1Click(Sender: TObject);
    procedure ImportDreamall1Click(Sender: TObject);
    procedure PepareforD6QReport1Click(Sender: TObject);
    procedure ImportQReportforD61Click(Sender: TObject);
    procedure ImportQReportforall1Click(Sender: TObject);
  private
    FShowFinalDialog : boolean;
    NoDefaultDefines : boolean;
    IgnoreProcedures : TStringList;
    FProjectChanged  : Boolean;
    FValidatedName   : Boolean;
    FProjectName     : String;

    function QReportSenderToDelphiVer(Sender: TObject):TDelphiVer;
    Procedure SetProjectChanged( AValue : Boolean );
    procedure AddFilesWithExt(const UnitsPath,FilesExt:String);
    procedure PrepareForImport(DelphiVer:TDelphiVer);
  public
    procedure CheckDestPath;
    procedure ImportVCL(DelphiVer:TDelphiVer;AShowFinalDialog:boolean);

    Constructor Create( AOwner : TComponent ); override;
    Destructor Destroy; override;

    Procedure ValidateCaption;
    Procedure CheckActions;

    Function SaveProjectAs : Boolean;
    Function SaveProject : Boolean;
    Procedure LoadProject;

    Property ProjectName    : String  Read FProjectName Write FProjectName;
    Property ProjectChanged : Boolean Read FProjectChanged Write SetProjectChanged;
  end;

{------------------------------------------------------------------}

  TDCFileCounter = class
    FilesList : TStringList;

    Constructor Create; virtual;
    Destructor Destroy; override;
    Procedure ProcessFile( Const APath : String; Const ASearchRec : TSearchRec;
                           Var Continue : Boolean );
  end;

{------------------------------------------------------------------}

Var
  MainForm: TMainForm;

{------------------------------------------------------------------}

Procedure RunImport( ASourceFiles, AIgnoreTopics : TStrings;
  Const ADestPath, AUnits, ADefines, APostfix, AAliases : String;
  AIncludeComments, ASilentImport, AAddUnregistration,
  AShowFinalDialog,NoDefaultDefines : Boolean );

procedure DCCreateTestUnit(const FileName:String;UnitsInUses:TStrings;DelphiVer:TDelphiVer);
{------------------------------------------------------------------}

implementation

{$R *.DFM}

{------------------------------------------------------------------}

Type
  TDCMessageProcessor = class
    ProcessForm : TDCProcessForm;
    Procedure ErrorOutput( Const MsgText : String );
  end;

{------------------------------------------------------------------}

Procedure TDCMessageProcessor.ErrorOutput( Const MsgText : String );
begin
  ProcessForm.SetStatus( 0, psShowMessage, {sDCErrorPrefix + ' ' + } MsgText );//srarting from V4.1 error string prefix is added automatically
end;

{------------------------------------------------------------------}

Var
  TeminateRequest : Boolean;

Procedure TerminatePressed( ASender : TDCProcessForm );
begin
  TeminateRequest := True;
end;

{------------------------------------------------------------------}

Procedure RunImport( ASourceFiles, AIgnoreTopics : TStrings; Const ADestPath, AUnits, ADefines, APostfix, AAliases : String;
                     AIncludeComments, ASilentImport, AAddUnregistration,
                     AShowFinalDialog,NoDefaultDefines : Boolean );
Var
  ErrorOccurs       : Boolean;
  DestroyIgnTopics  : Boolean;
  I                 : Integer;
  UnitsList         : TStringList;
  ProcessForm       : TDCProcessForm;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Function _GetFinalFileName( Const AFileName : String ) : String;
  begin
    Result := ChangeFileExt( AddSlash( ADestPath ) + ExtractFileName( AFileName ), APostfix + '.' + SExtPas );
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _ProcessFiles;
  Var
    I, ProcessedFiles : Integer;
    Parser            : TUnitParser;
    CallBack          : TDCMessageProcessor;
    ProgressState     : TDCPosType;
    ADelphiVer        : TDelphiVer;
  begin
    If ErrorOccurs Then
      Exit;

    If DestroyIgnTopics Or ASilentImport Then
    begin
      ProgressState := psShowMessage;
      AddBadProcs( AIgnoreTopics );
    end
      Else
    begin
      ProgressState := psCommitStep;
      ProcessForm.SetStatus( ASourceFiles.Count, psStartStep, sDCCollectingTopicsInfo );
    end;

    CallBack := TDCMessageProcessor.Create;
    try
      CallBack.ProcessForm := ProcessForm;
      With ASourceFiles Do
      begin
        ProcessedFiles := 0;
        For I := 0 To Count - 1 Do
          If FileExists( Strings[ I ] ) Then
          begin
            ProcessForm.SetStatus( 0, psPassStep, Strings[ I ] );
            If TeminateRequest Then
            begin
              ProcessForm.SetStatus( 0, psShowMessage, sDCBuildingFinishedByUser );
              break;
            end;

            try
              If DestroyIgnTopics Or ASilentImport Then
                GenerateImportUnit( Strings[ I ], _GetFinalFileName( Strings[ I ] ), ADefines, AUnits,
                                    AAliases, Not AIncludeComments, AAddUnregistration ,NoDefaultDefines,CallBack.ErrorOutput)
              Else
              begin
                DCGetDelphiVerFromDefinesStr(ADefines,ADelphiVer);

                Parser := DCLoadModule( Strings[ I ], ADefines, '', AUnits, AAliases,
                              DCGenDPUPath( ADelphiVer ), TUnitParser, False, NoDefaultDefines, CallBack.ErrorOutput );

                If Parser.ModuleInfo.ModuleType <> moLibrary Then
                  UnitsList.AddObject( _GetFinalFileName( Strings[ I ] ), Parser );
              end;
              Inc( ProcessedFiles );
            except
              ProcessForm.SetStatus( 0, psShowMessage, sDCErrorPrefix + ' ' + Exception(ExceptObject).Message );
            end;
          end;
        ProcessForm.SetStatus( 0, ProgressState, SafeFormat( sDCFileProcessed, [ProcessedFiles] ) );
      end;
    finally
      CallBack.Free;
    end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _ImportFiles;
  Var
    I : Integer;
    CallBack : TDCMessageProcessor;
  begin
    If ErrorOccurs Then
      Exit;
    AddBadProcs( AIgnoreTopics );

    ProcessForm.SetStatus( 0, psShowMessage, '' );
    ProcessForm.SetStatus( UnitsList.Count, psStartStep, sDCImportingUnits );
    With UnitsList Do
      For I := 0 To Count - 1 Do
      begin
        ProcessForm.SetStatus( 0, psPassStep, Strings[ I ] );
        If TeminateRequest Then
        begin
          ProcessForm.SetStatus( 0, psShowMessage, sDCBuildingFinishedByUser );
          Exit;
        end;

        Callback:=TDCMessageProcessor.Create;

        try
          With TUnitParser( Objects[ I ] ) Do
            GenerateImportCode( ModuleInfo, Strings[ I ], Not AIncludeComments,
              AAddUnregistration,NoDefaultDefines,CallBack.ErrorOutput);
        finally
          Callback.Free;
        end;
      end;
    ProcessForm.SetStatus( 0, psCommitStep, SafeFormat( sDCFilesGenerated, [UnitsList.Count] ) );
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Function _AddTopic( AList : TDCCheckImageListBox; Const AUnitName, ATopicName : String ) : TDCCheckListItem;
  begin
    Result := Nil;
    If ATopicName = '' Then
      Exit;
    Result := TDCCheckListItem( AList.Items.Add );
    With Result Do
    begin
      Caption := AUnitName + '.' + ATopicName;
      Checked := AIgnoreTopics.IndexOf( Caption ) < 0;
    end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Function _InitClassProps( AInfo : pTypeDeclInfo ) : pDCClassPropsInfo;
  Var
    Flags     : Byte;
    I, Start  : Integer;
    ATypeName : String;
  begin
    With AInfo^ Do
    begin
      I := SizeOf( AInfo ) + MethodCount Div 8 + PropCount Div 8;
      If MethodCount Mod 8 > 0 Then
        Inc( I );
      If PropCount Mod 8 > 0 Then
        Inc( I );
      GetMem( Result, I );

      FillChar( Result^, I, 0 );
      Result^.ClassInfo := AInfo;

      ATypeName := Minfo.GetGlobalString( TypeName );
      Start := 0;
      Flags := 0;
      If MethodCount > 0 Then
      begin
        For I := 0 To MethodCount - 1 Do
        begin
          If I Mod 8 = 0 Then
          begin
            Result^.TopicChecks[ Start ] := Flags;
            If I <> 0 Then
              Inc( Start );
            Flags := 0;
          end;
{ To Do }            
          If AIgnoreTopics.IndexOf( {MInfo.ModuleName + '.' + }ATypeName + '.' + MInfo.GetGlobalString( pMethodInfo( MInfo.ProcList[ MethodIndex + I ] )^.MName ) ) >= 0 Then
            Flags := Flags Or ( 1 Shl I Mod 8 );
        end;
        If MethodCount Mod 8 <> 0 Then
        begin
          Result^.TopicChecks[ Start ] := Flags;
          Inc( Start );
        end;
      end;

      If PropCount > 0 Then
      begin
        For I := 0 To PropCount - 1 Do
        begin
          If I Mod 8 = 0 Then
          begin
            If I <> 0 Then
            begin
              Result^.TopicChecks[ Start ] := Flags;
              Inc( Start );
            end;
            Flags := 0;
          end;
{ To Do }            
          If AIgnoreTopics.IndexOf( {MInfo.ModuleName + '.' + }ATypeName + '.' + MInfo.GetGlobalString( PPropertyInfo( MInfo.PropList[ PropIndex + I ] )^.PropName ) ) >= 0 Then
            Flags := Flags Or ( 1 Shl I Mod 8 );
        end;
        If PropCount Mod 8 <> 0 Then
          Result^.TopicChecks[ Start ] := Flags;
      end;
    end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _FillFromList( AList : TDCCheckImageListBox );
  Var
    I : Integer;
  begin
    With AList.Items Do
      For I := Count - 1 DownTo 0 Do
        With TDCCheckListItem( Items[ I ] ) Do
          If Not Checked Then
            AIgnoreTopics.Add( Caption );
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _CollectIgnoreTopicsInfo( APropCheckForm : TDCTopicsCheckForm );
  Var
    I, J      : Integer;
    Name      : String;
    Info      : pTypeDeclInfo;
    CheckList : pDCArrayOfByte;
  begin
    AIgnoreTopics.Clear;

    ProcessForm.SetStatus( 0, psPassStep, sDCFormListOfBadClasses );
    With APropCheckForm.ClassesList.Items Do
      For I := Count - 1 DownTo 0 Do
        With TDCCheckListItem( Items[ I ] ) Do
        begin
          If Not Checked Then
            AIgnoreTopics.Add( Caption );

          With pDCClassPropsInfo( UserData )^ Do
          begin
            Info := ClassInfo;
{ To Do }            
            Name := {ClassInfo^.MInfo.ModuleName + '.' + }ClassInfo^.MInfo.GetGlobalString( ClassInfo^.TypeName );
            CheckList := @TopicChecks;
          end;

          With Info^ Do
          begin
            For J := 0 To MethodCount - 1 Do
              If CheckList^[ J Div 8 ] And ( 1 Shl ( J Mod 8 ) ) <> 0 Then
                AIgnoreTopics.Add( Name + '.' + MInfo.GetGlobalString( pMethodInfo( MInfo.ProcList[ MethodIndex + J ] )^.MName ) );

            CheckList := @CheckList[ MethodCount Div 8 ];
            If MethodCount Mod 8 <> 0 Then
              CheckList := Pointer( Integer( CheckList ) + 1 );
            For J := 0 To PropCount - 1 Do
              If CheckList^[ J Div 8 ] And ( 1 Shl ( J Mod 8 ) ) <> 0 Then
                AIgnoreTopics.Add( Name + '.' + MInfo.GetGlobalString( pPropertyInfo( MInfo.PropList[ PropIndex + J ] )^.PropName ) );
          end;

          FreeMem( UserData );
        end;
    ProcessForm.SetStatus( 0, psPassStep, sDCFormListOfBadProcedures );
    _FillFromList( APropCheckForm.ProceduresList );
    ProcessForm.SetStatus( 0, psPassStep, sDCFormListOfBadTypes );
    _FillFromList( APropCheckForm.TypesList );
    ProcessForm.SetStatus( 0, psPassStep, sDCFormListOfBadVariables );
    _FillFromList( APropCheckForm.VariablesList );
    ProcessForm.SetStatus( 0, psPassStep, sDCFormListOfBadConstants );
    _FillFromList( APropCheckForm.ConstantsList );
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _ClearClasses( APropCheckForm : TDCTopicsCheckForm );
  Var
    I : Integer;
  begin
    With APropCheckForm.ClassesList.Items Do
      For I := Count - 1 DownTo 0 Do
        FreeMem( TDCCheckListItem( Items[ I ] ).UserData );
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _CheckBadProcedures;
  Var
    I, J           : Integer;
    Info           : pTypeDeclInfo;
    FirstToLetters : String[2];
    NewItem        : TDCCheckListItem;
    PropCheckForm  : TDCTopicsCheckForm;
  begin
    If ErrorOccurs Then
      Exit;

    ProcessForm.SetStatus( 0, psShowMessage, '' );
    ProcessForm.SetStatus( UnitsList.Count + 5, psStartStep, sDCCollectingTopics );
    PropCheckForm := TDCTopicsCheckForm.Create( ProcessForm );
    With PropCheckForm Do
    try
      ProceduresList.Items.BeginUpdate;
      ClassesList.Items.BeginUpdate;
      TypesList.Items.BeginUpdate;
      VariablesList.Items.BeginUpdate;
      ConstantsList.Items.BeginUpdate;
      try
        For I := 0 To UnitsList.Count - 1 Do
          With TUnitParser( UnitsList.Objects[ I ] ).ModuleInfo Do
          begin
            ProcessForm.SetStatus( 0, psPassStep, SafeFormat( sDCCollectionFrom, [ModuleFile] ) );
            If TeminateRequest Then
              Exit;

            For J := ProcIndex To ProcIndex + ProcCount - 1 Do
              _AddTopic( ProceduresList, ModuleName, GetGlobalString( pMethodInfo( GlobalProcList[J] )^.MName ) );

            For J := 0 To TypeList.Count - 1 Do
            begin
              FirstToLetters := Copy( TypeList[ J ], 1, 2 );
              If ( FirstToLetters = 'V ' ) Or ( FirstToLetters = 'R ' ) Then
                continue;
              Info := pTypeDeclInfo( TypList[ Integer( TypeList.Objects[ J ] ) ] );
              Case Info^.TypeKind Of
                tdClass     : begin
                                NewItem := _AddTopic( ClassesList, ModuleName, TypeList[ J ] );
                                If NewItem <> Nil Then
                                  NewItem.UserData := _InitClassProps( Info );
                              end;
                tdInterface :;
                Else          _AddTopic( TypesList, ModuleName, TypeList[ J ] );
              End;
            end;

            For J := 0 To VarCount - 1 Do
              _AddTopic( VariablesList, ModuleName, GetGlobalString( PVarInfo( VarList[J] )^.VarName ) );

            For J := 0 To ConstList.Count - 1 Do
              _AddTopic( ConstantsList, ModuleName, GetGlobalString( PConstInfo( ConstList[J] )^.ConstName ) );
          end;
      finally
        ConstantsList.Items.EndUpdate;
        VariablesList.Items.EndUpdate;
        TypesList.Items.EndUpdate;
        ClassesList.Items.EndUpdate;
        ProceduresList.Items.EndUpdate;
      end;

      ProcessForm.SetStatus( 0, psShowMessage, sDCCheckinTopics );
      ErrorOccurs := ShowModal = mrCancel;

      If ErrorOccurs Then
      begin
        ProcessForm.SetStatus( 0, psShowMessage, sDCUserCancelProcess );
        _ClearClasses( PropCheckForm );
        Exit;
      end;
      
      _CollectIgnoreTopicsInfo( PropCheckForm );
      ProcessForm.SetStatus( 0, psCommitStep, sDCBadTopicsAreCollected );
    finally
      Free;
    end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _CreateOutputFolder;
  begin
    If ErrorOccurs Or dcapi.DirectoryExists( ADestPath ) Then
      Exit;
    ProcessForm.SetStatus( 0, psShowMessage, SafeFormat( sDCCreateFolders, [ADestPath] ) );
    CreateAllDirectories( ADestPath, Nil );
    If Not dcapi.DirectoryExists( ADestPath ) Then
    begin
      ProcessForm.SetStatus( 0, psShowMessage, sDCErrorPrefix + ' ' + SafeFormat( sDCErrorFolderCannotBeCreated, [ADestPath] ) );
      ErrorOccurs := True;
    end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
begin
  ErrorOccurs := False;
  TeminateRequest := False;

  DestroyIgnTopics := Not Assigned( AIgnoreTopics );
  InitializeBadLists;

  If DestroyIgnTopics Then
    AIgnoreTopics := TStringList.Create;
  UnitsList := TStringList.Create;
  try
    ProcessForm := TDCProcessForm.Create( Nil );
    try
      ProcessForm.OnTerminateEventEx := TerminatePressed;
      If Not ( DestroyIgnTopics Or ASilentImport ) Then
        I := 2
      Else
        I := ASourceFiles.Count;
      ProcessForm.ShowProgressDialog( I + 1, sDCBuildingInProgress );

      If DestroyIgnTopics Or ASilentImport Then
        _CreateOutputFolder;

      _ProcessFiles;

      If Not DestroyIgnTopics And Not ASilentImport Then
      begin
        _CheckBadProcedures;
        _CreateOutputFolder;
        _ImportFiles;
      end;

      If ErrorOccurs Then
        ProcessForm.FinishProcess( sDCBuildingFinishedByError )
      Else
        If AShowFinalDialog Then
        begin
          If TeminateRequest Then
            ProcessForm.FinishProcess( sDCBuildingFinishedByUser )
          Else
            ProcessForm.FinishProcess( sDCBuildingFinished );
        end;
    finally
      ProcessForm.Free;
    end;
  finally
    DCRemoveCreatedParsers;
    UnitsList.Free;
    If DestroyIgnTopics Then
      AIgnoreTopics.Free;
  end;
end;

{------------------------------------------------------------------}

Constructor TDCFileCounter.Create;
begin
  Inherited;
  FilesList := TStringList.Create;
end;

{------------------------------------------------------------------}

Destructor TDCFileCounter.Destroy;
begin
  FilesList.Free;
  Inherited;
end;

{------------------------------------------------------------------}

Procedure TDCFileCounter.ProcessFile( Const APath : String; Const ASearchRec : TSearchRec;
  Var Continue : Boolean );
begin
  FilesList.Add( APath + ASearchRec.Name );
end;

{------------------------------------------------------------------}

procedure TMainForm.DelphiLibsBtnClick( Sender : TObject );
begin
  LibrariesEditor.Text := GetDelphiSourceDirs;
{  DelphiLibsBtn.Enabled := False;}
end;

{------------------------------------------------------------------}

Procedure TMainForm.FormCreate( Sender : TObject );
begin
  With PostfixEditor Do
  begin
    If Text = '' Then
      Text := Items[0];
    If Text = '' Then
      Text := '_imp';
  end;

  If AliasEditor.Text = '' Then
    AliasEditor.Text := 'WinTypes=Windows;WinProcs=Windows;DbiTypes=BDE;DbiProcs=BDE;DbiErrs=BDE;';

  If LibrariesEditor.Text = '' Then
    DelphiLibsBtnClick( Nil );
end;

{------------------------------------------------------------------}

Procedure TMainForm.PerformChanges( Sender : TObject );
begin
  ProjectChanged := True;
end;

{------------------------------------------------------------------}

Procedure TMainForm.ImportBtnClick( Sender : TObject );
Var
  I            : Integer;
  Units, Procs : TStringList;
  ADelphiVer   : TDelphiVer;
begin

{  !!!!!!!!!!! don't uncomment this 
  With DestEditor Do
    If Not DirectoryExists( Text ) Then
      If MessageDlg( Format( sDCFolderCreateConfirmation, [Text] ), mtConfirmation, [mbYes, mbNo], 0 ) = mrNo Then
        Exit;
}
  Caption := sDCFileImportCaption + sDCImportingPosfix;
  Units := TStringList.Create;
  try
    CloseBtn.Enabled := False;
    ImportBtn.Enabled := False;
    With FilesList.Items Do
      For I := 0 To Count - 1 Do
        Units.Add( TDCImageListItem( Items[ I ] ).Caption );

    If CustomImportCheck.Checked Then
      Procs := IgnoreProcedures
    Else
      Procs := Nil;

    NoDefaultDefines:=Trim(DefinesEditor.Text)<>'';

    If NoDefaultDefines then
      DCGetDelphiVerFromDefinesStr(DefinesEditor.Text,ADelphiVer)
    else
      ADelphiVer:=GetThisDelphiVer;

    DCCreateTestUnit(AddSlash(DestEditor.Text)+'dctestunit.pas',Units,ADelphiVer);


    RunImport( Units, Procs, DestEditor.Text, LibrariesEditor.Text, DefinesEditor.Text,
               PostfixEditor.Text, AliasEditor.Text, IncludeCommentsCheck.Checked,
               ImportSilentlyCheck.Checked, AddUnregistrationCheck.Checked, FShowFinalDialog,NoDefaultDefines);
  finally
    Units.Free;
    Caption := sDCFileImportCaption + sDCImportCompletePostfix;
    CloseBtn.Enabled := True;
    ImportBtn.Enabled := True;
  end;
end;

{------------------------------------------------------------------}

Procedure TMainForm.LibrariesEditorChange( Sender : TObject );
begin
{  DelphiLibsBtn.Enabled := True;}
  ProjectChanged := False;
end;

{------------------------------------------------------------------}

Procedure TMainForm.HelpBtnClick( Sender : TObject );
begin
  ShowCommandLineHelp;
end;

{------------------------------------------------------------------}

Procedure TMainForm.CustomImportCheckClick( Sender : TObject );
begin
  ImportSilentlyCheck.Enabled := CustomImportCheck.Checked;
end;

{------------------------------------------------------------------}

Procedure TMainForm.CloseBtnClick( Sender : TObject );
begin
  Close;
end;

{------------------------------------------------------------------}

Constructor TMainForm.Create( AOwner : TComponent );
begin
  Inherited;
  FShowFinalDialog:=True;

  IgnoreProcedures := TStringList.Create;

  FProjectName := sDCNewImportProjectName + sDCImportProjectExt;
  ValidateCaption;

  SourceFilesPanel.Caption  := ' ' + sDCSourceFilesPanelCaption + ' ';
  PostfixLabel.Caption      := sDCPostfixLabelCaption;

  ImportOptionsPanel.Caption      := ' ' + sDCImportOptionsPanelCaption + ' ';
  DestPathLabel.Caption           := sDCDestPathLabelCaption;
  LibPathLabel.Caption            := sDCLibPathLabelCaption;
  ConditionalDefinesLabel.Caption := sDCConditionalDefinesLabelCaption;
  AliasesLabel.Caption            := sDCAliasesLabelCaption;
  DelphiLibsBtn.Hint              := sDCDelphiLibsBtnHint;

  IncludeCommentsCheck.Caption   := sDCIncludeCommentsCheckCaption;
  CustomImportCheck.Caption      := sDCCustomImportCheckCaption;
  ImportSilentlyCheck.Caption    := sDCImportSilentlyCheckCaption;
  AddUnregistrationCheck.Caption := sDCAddUnregistrationCheckCaption; 

  ImportBtn.Caption := sDCImportBtnCaption;
  CloseBtn.Caption  := sDCCloseButton;
  HelpBtn.Caption   := sDCImportHelpButton;

  AddFilesDlg.Title  := sDCAddFilesDlgTitle;
  AddFilesDlg.Filter := sDelphiFiles + ' (*.pas)|*.pas|' + sInterfaceFiles + ' (*.int)|*.int|' + sAllFiles + '|*.*';

  FileItems.Caption    := sFileMenu;

  NewItem.Caption    := sDCNewMenuCaption;
  NewButton.Hint    := sDCNewActionHint;
  OpenItem.Caption   := sDCOpenMenuCaption;
  OpenButton.Hint      := sDCOpenActionHint;
  SaveItem.Caption   := sDCSaveMenuCaption;
  SaveButton.Hint      := sDCSaveActionHint;
  SaveAsItem.Caption := sDCSaveAsMenuCaption;
//  SaveAsAction.Hint    := sDCSaveAsActionHint;
  ExitItem.Caption   := sDCExitMenuCaption;
//  ExitAction.Hint      := sDCExitActionHint;

  AddUnitsItem.Caption := sDCAddUnitsActionCaption;
  AddUnitBtn.Hint    := sDCAddUnitsActionHint;
  AddUnitsRecursItem.Caption := sDCAddUnitsRecursActionCaption;
  AddUnitsRecursBtn.Hint    := sDCAddUnitsRecursActionHint;
  DeleteItem.Caption   := sDCDeleteActionCaption;
  DeleteButton.Hint      := sDCDeleteActionHint;
  ClearAllItem.Caption := sDCClearAllActionCaption;
//  ClearAllAction.Hint    := sDCClearAllActionHint;

  ProjectItems.Caption   := sDCProjectItemsCaption;

  SaveDialog.Filter := sDCFilterImportProject + ' (*' + sDCImportProjectExt + ')' + '|*' + sDCImportProjectExt + '|' + sAllFiles + '|*.*';
  OpenPrjDialog.Title := sDCImportOpenPrjDialogTitle;
  OpenPrjDialog.Filter := SaveDialog.Filter;
  PathDialog.Title := sDCPathDialogTitle;

  CheckActions;
  FProjectChanged := False;
end;

{------------------------------------------------------------------}

Destructor TMainForm.Destroy;
begin
  IgnoreProcedures.Free;
  Inherited;
end;

{------------------------------------------------------------------}

Procedure TMainForm.NewActionExecute( Sender : TObject );
begin
  If ProjectChanged And
     ( MessageDlg( sDCSaveWarning, mtWarning, [mbYes, mbNo], 0 ) = mrYes ) Then
    If Not SaveProject Then
      Exit;

  FilesList.Items.Clear;
  DestEditor.Text := '';
  DelphiLibsBtnClick( Nil );
  DefinesEditor.Text := '';
  AliasEditor.Text := SDCDefAliases;
  IncludeCommentsCheck.Checked := True;
  CustomImportCheck.Checked := False;
  ImportSilentlyCheck.Checked := False;
  AddUnregistrationCheck.Checked := False;
  PostfixEditor.Text := '_imp';

  FProjectName := sDCNewImportProjectName + sDCImportProjectExt;
  FValidatedName := False;
  ValidateCaption;

  FProjectChanged := False;
end;

{------------------------------------------------------------------}

Procedure TMainForm.OpenActionExecute( Sender : TObject );
begin
  LoadProject;
end;

{------------------------------------------------------------------}

Procedure TMainForm.SaveActionExecute( Sender : TObject );
begin
  SaveProject;
end;

{------------------------------------------------------------------}

Procedure TMainForm.LoadProject;
Var
  ProcessForm : TDCProcessForm;
  LoadStream  : TFileStream;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _LoadFiles;
  Var
    I, Number : Integer;
  begin
    With FilesList.Items Do
    begin
      LoadStream.Read( Number, SizeOf( Number ) );
      Clear;
      For I := 1 To Number Do
        TDCImageListItem( Add ).Caption := DCReadStrWithLenFromStream( LoadStream );
    end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _LoadOptions;
  Var
    Options : Byte;
  begin
    DestEditor.Text := DCReadStrWithLenFromStream( LoadStream );
    LibrariesEditor.Text := DCReadStrWithLenFromStream( LoadStream );
    DefinesEditor.Text := DCReadStrWithLenFromStream( LoadStream );
    AliasEditor.Text := DCReadStrWithLenFromStream( LoadStream );
    PostfixEditor.Text := DCReadStrWithLenFromStream( LoadStream );

    LoadStream.Read( Options, SizeOf( Options ) );
    IncludeCommentsCheck.Checked := ( Options And 1 ) <> 0;
    CustomImportCheck.Checked    := ( Options And 2 ) <> 0;
    ImportSilentlyCheck.Checked  := ( Options And 4 ) <> 0;
    AddUnregistrationCheck.Checked := ( Options And 8 ) <> 0;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _LoadIgnoreTopics;
  begin
    IgnoreProcedures.LoadFromStream( LoadStream );
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
begin
  If ProjectChanged And
     ( MessageDlg( sDCSaveWarning, mtWarning, [mbYes, mbNo], 0 ) = mrYes ) Then
    SaveProject;

  If Not OpenPrjDialog.Execute Then
    Exit;

  ProcessForm := TDCProcessForm.Create( Nil );
  try
    ProcessForm.SimpleBar := True;
    ProcessForm.ShowProgressDialog( 3, sDCLoadProjectFile );
    LoadStream := TFileStream.Create( OpenPrjDialog.FileName, fmOpenRead );
    ProjectName := OpenPrjDialog.FileName;
    FValidatedName := True;
    try
      _LoadFiles;
      ProcessForm.SetStatus( 1, psPassStep, '' );
      _LoadOptions;
      ProcessForm.SetStatus( 1, psPassStep, '' );
      _LoadIgnoreTopics;
      ProcessForm.SetStatus( 1, psPassStep, '' );
    except
      MessageDlg( sDCLoadFileError, mtError, [mbOk], 0 );
    end;
    FreeObject( LoadStream,LoadStream );

    ProjectChanged := False;
    CheckActions;
  except
    MessageDlg( sDCOpenFileError, mtError, [mbOk], 0 );
  end;
  FreeObject( ProcessForm,ProcessForm );
end;

{------------------------------------------------------------------}

Function TMainForm.SaveProject : Boolean;
Var
  ProcessForm : TDCProcessForm;
  ATempName   : String;
  SaveStream  : TFileStream;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _SaveFiles;
  Var
    I, Number : Integer;
  begin
    With FilesList.Items Do
    begin
      Number := Count;
      SaveStream.Write( Number, SizeOf( Number ) );
      For I := 0 To Number - 1 Do
        DCWriteStrWithLenToStream( SaveStream, TDCImageListItem( Items[ I ] ).Caption );
    end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _SaveOptions;
  Var
    Options : Byte;
  begin
    DCWriteStrWithLenToStream( SaveStream, DestEditor.Text );
    DCWriteStrWithLenToStream( SaveStream, LibrariesEditor.Text );
    DCWriteStrWithLenToStream( SaveStream, DefinesEditor.Text );
    DCWriteStrWithLenToStream( SaveStream, AliasEditor.Text );
    DCWriteStrWithLenToStream( SaveStream, PostfixEditor.Text );
    If IncludeCommentsCheck.Checked Then
      Options := 1
    Else
      Options := 0;
    If CustomImportCheck.Checked Then
      Options := Options Or 2;
    If ImportSilentlyCheck.Checked Then
      Options := Options Or 4;
    If AddUnregistrationCheck.Checked Then
      Options := Options Or 8;
    SaveStream.Write( Options, SizeOf( Options ) );
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _SaveIgnoreTopics;
  begin
    IgnoreProcedures.SaveToStream( SaveStream );
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
begin
  Result := False;
  If Not FValidatedName Then
  begin
    Result := SaveProjectAs;
    Exit;
  end;

  ProcessForm := TDCProcessForm.Create( Nil );
  try
    ProcessForm.SimpleBar := True;
    ProcessForm.ShowProgressDialog( 4, sDCSaveProjectFile );
    ATempName := GetTemporaryFileName( sDCTempImportFileNamePrefix );
    SaveStream := TFileStream.Create( ATempName, fmCreate );
    try
      _SaveFiles;
      ProcessForm.SetStatus( 1, psPassStep, '' );
      _SaveOptions;
      ProcessForm.SetStatus( 1, psPassStep, '' );
      _SaveIgnoreTopics;
      ProcessForm.SetStatus( 1, psPassStep, '' );
    except
      MessageDlg( sDCSaveFileError, mtError, [mbOk], 0 );
    end;
    FreeObject( SaveStream,SaveStream );

    Sysutils.FileSetAttr( ProjectName, Sysutils.faArchive );
    DeleteFile( ProjectName );
    RenameFile( ATempName, ProjectName );

    ProcessForm.SetStatus( 1, psPassStep, '' );

    ProjectChanged := False;
    Result := True;
  except
    MessageDlg( sDCCreateFileError, mtError, [mbOk], 0 );
  end;
  FreeObject( ProcessForm,ProcessForm );
end;

{------------------------------------------------------------------}

Procedure TMainForm.SaveAsActionExecute( Sender : TObject );
begin
  SaveProjectAs;
end;

{------------------------------------------------------------------}

Function TMainForm.SaveProjectAs : Boolean;
begin
  Result := False;
  SaveDialog.Title := SafeFormat( sDCSaveDialogTitle, [ProjectName] );
  SaveDialog.FileName := ProjectName;
  If Not SaveDialog.Execute Then
    Exit;
  ProjectName := SaveDialog.FileName;
  If ExtractFileExt( ProjectName ) = '' Then
    ProjectName := ProjectName + sDCImportProjectExt;
  FValidatedName := True;
  ValidateCaption;
  Result := SaveProject;
end;

{------------------------------------------------------------------}

Procedure TMainForm.ExitActionExecute( Sender : TObject );
begin
  Close;
end;

{------------------------------------------------------------------}

Procedure TMainForm.SetProjectChanged( AValue : Boolean );
begin
  If FProjectChanged = AValue Then
    Exit;
  FProjectChanged := AValue;

//  SaveItem.Enabled := AValue And FValidatedName;
//  SaveButton.Enabled := AValue And FValidatedName;
end;

{------------------------------------------------------------------}

procedure TMainForm.AddUnitsActionExecute( Sender : TObject );
Var
  I : Integer;
begin
  With AddFilesDlg Do
  begin
    FileName := '';
    If Not Execute Then
      Exit;
    If Files.Count > 0 Then
    begin
//      SaveItem.Enabled := True;
//      SaveButton.Enabled := True;

      FilesList.Items.BeginUpdate;
      try
        With Files Do
          For I := 0 To Count - 1 Do
            If FilesList.IndexOf( Strings[ I ] ) < 0 Then
              With TDCImageListItem( FilesList.Items.Add ) Do
                Caption := Strings[ I ];
        If FilesList.ItemIndex = -1 Then
          FilesList.ItemIndex := 0;
      finally
        FilesList.Items.EndUpdate;
      end;
    end;
  end;
  ProjectChanged := True;
  CheckActions;
end;

{------------------------------------------------------------------}

procedure TMainForm.DeleteActionExecute(Sender: TObject);
begin
  With FilesList Do
    If ItemIndex >= 0 Then
      If MessageDlg( SafeFormat( sDCExcludeConfirm, [TDCImageListItem( Items[ ItemIndex ] ).Caption] ), mtConfirmation, [mbYes, mbNo], 0 ) = mrYes Then
        {$IFDEF D5}Items.Delete( ItemIndex );{$ELSE}Items[ ItemIndex ].Free;{$ENDIF}
  ProjectChanged := True;
  CheckActions;
end;

{------------------------------------------------------------------}

procedure TMainForm.ClearAllActionExecute(Sender: TObject);
begin
  If Sender<>nil then
    begin
      With FilesList Do
        If MessageDlg( sDCImportTerminationConfirm, mtConfirmation,
          [mbYes, mbNo], 0 ) = mrYes
        Then
          Items.Clear
    end
  else
    FilesList.Items.Clear;
    
  ProjectChanged := True;
  CheckActions;
end;

{------------------------------------------------------------------}

Procedure TMainForm.ValidateCaption;
begin
  Caption := sDCImportMainFormCaption + ' [' + ProjectName + ']';
end;

{------------------------------------------------------------------}

Procedure TMainForm.CheckCanProcess(Sender: TObject);
begin
  CheckActions;
  ProjectChanged := True;
end;

{------------------------------------------------------------------}

Procedure TMainForm.CheckActions;
begin
  If FilesList.ItemIndex = -1 Then
    FilesList.ItemIndex := 0;
  ImportBtn.Enabled := ( FilesList.Items.Count > 0 ) And ( Trim( DestEditor.Text ) <> '' );
  DeleteItem.Enabled := FilesList.ItemIndex >= 0;
  DeleteButton.Enabled := FilesList.ItemIndex >= 0;
  ClearAllItem.Enabled := FilesList.Items.Count > 0;
  StatusPanel.Caption := '  ' + SafeFormat( sDCFilesNumber, [FilesList.Items.Count] );
end;

{------------------------------------------------------------------}

procedure TMainForm.AddFilesWithExt(const UnitsPath,FilesExt:String);
Var
  I : Integer;
begin
  With TDCFileCounter.Create Do
  try
    ForEachFile( AddSlash(UnitsPath) + '*'+FilesExt,
      faAnyFile And Not faDirectory, True, ProcessFile );
    If FilesList.Count > 0 Then
    begin
//      SaveItem.Enabled := True;
//      SaveButton.Enabled := True;
      Self.FilesList.Items.BeginUpdate;
      try
        For I := 0 To FilesList.Count - 1 Do
          TDCImageListItem( Self.FilesList.Items.Add ).Caption := FilesList[ I ];

      finally
        Self.FilesList.Items.EndUpdate;
      end;
    end;
  finally
    Free;
  end;
  CheckActions;
  ProjectChanged := True;
end;

{------------------------------------------------------------------}

Procedure TMainForm.AddUnitsRecursActionExecute(Sender: TObject);
begin
  If Not PathDialog.Execute Then
    Exit;
  AddFilesWithExt(PathDialog.SelectedItem,'.pas');
  AddFilesWithExt(PathDialog.SelectedItem,'.int');
end;

{------------------------------------------------------------------}

Procedure TMainForm.FormCloseQuery( Sender : TObject; Var CanClose : Boolean );
begin
  CanClose := True;
  If ProjectChanged Then
    Case MessageDlg( sDCSaveWarning, mtConfirmation, [mbYes, mbNo, mbCancel], 0 ) Of
      mrYes    : If Not SaveProject Then
                   CanClose := False;
      mrCancel : CanClose := False;
    End;
end;

{------------------------------------------------------------------}

Procedure TMainForm.FilesListKeyDown( Sender : TObject; Var Key : Word;
  Shift : TShiftState );
begin
  If ( Shift = [] ) And ( Key = VK_Delete ) Then
    DeleteItem.OnClick( DeleteItem );
end;

{------------------------------------------------------------------}

type
  TDCRunImportParams=class(TPersistent)
  private
    FSourceFiles:TStrings;
    FIgnoreTopics:TStrings;
    FDestPath:String;
    FDefines:String;
    FDelphiVer:TDelphiVer;
    FPostFix:String;
    FSilentImport:boolean;
    FAddUnregister:boolean;
    FShowFinalDialog:boolean;
    FIncludeComments:boolean;
    FAliases:String;
    FSearchPaths:String;
    procedure SetSourceFiles(V:TStrings);
    procedure SetIgnoreTopics(V:TStrings);
  protected
  public
    procedure ImportVCLUnits;
    procedure Execute;
    constructor Create;
    destructor Destroy;override;
    property SourceFiles:TStrings Read FSourceFiles Write SetSourceFiles;
    property IgnoreTopics:TStrings Read FIgnoreTopics Write SetIgnoreTopics;
    property DestPath:String read FDestPath Write FDestPath;
    property Defines:String Read FDefines Write FDefines;
    property DelphiVer:TDelphiVer Read FDelphiVer Write FDelphiVer;
    property PostFix:String read FPostFix Write FPostFix;
    property SilentImport:boolean Read FSilentImport Write FSilentImport;
    property AddUnregister:boolean Read FAddUnregister Write FAddUnregister;
    property ShowFinalDialog:boolean Read FShowFinalDialog Write FShowFinalDialog;
    property IncludeComments:boolean Read FIncludeComments Write FIncludeComments;
    property Aliases:String Read FAliases Write FAliases;
    property SearchPaths:String Read FSearchPaths Write FSearchPaths;
  published
  end;

{------------------------}

constructor TDCRunImportParams.Create;
begin
  inherited;
  FSourceFiles:=TStringList.Create;
  FIgnoreTopics:=TStringList.Create;
end;

{------------------------}

destructor TDCRunImportParams.Destroy;
begin
  FSourceFiles.Free;;
  FIgnoreTopics.Free;
  inherited;
end;

{------------------------}

procedure TDCRunImportParams.Execute;
var
  Procs:TStrings;
begin
  CreateAllDirectories(DestPath, Nil );

  If IgnoreTopics.Count=0 then
    Procs:=nil
  else
    Procs:=IgnoreTopics;

  RunImport(SourceFiles, Procs,DestPath,SearchPaths,Defines,Postfix,
    Aliases,IncludeComments, SilentImport, AddUnregister,ShowFinalDialog,True);
end;

{------------------------}

procedure TDCRunImportParams.SetSourceFiles(V:TStrings);
begin
  FSourceFiles.Assign(V);
end;

{------------------------}

procedure TDCRunImportParams.SetIgnoreTopics(V:TStrings);
begin
  FIgnoreTopics.Assign(V);
end;

{------------------------}

procedure DCEnumVCLUnits(VCLUnits:TStrings;DelphiVer:TDelphiVer);
var
  SourceDirs:TStringList;
  TempFiles:TStringList;
  i:Integer;
begin
  VCLUnits.Clear;
  SourceDirs:=CreateSortedStringList;
  TempFiles:=TStringList.Create;
  try
    ParseString(GetDelphiSourceDirsEx2(DelphiVer,[]), ';',SourceDirs);
    For I := 0 To SourceDirs.Count - 1 Do
    begin
      TempFiles.Clear;
      FindFilesEx( SourceDirs[I], '*.pas', faAnyFile, False, TempFiles);
      VCLUnits.AddStrings(TempFiles);
      TempFiles.Clear;
      FindFilesEx( SourceDirs[I], '*.int', faAnyFile, False, TempFiles);
      VCLUnits.AddStrings(TempFiles);
    end;
    DCRemoveBadVCLUnits(VCLUnits,DelphiVer);
  finally
    SourceDirs.Free;
    TempFiles.Free;
  end;
end;

{------------------------}

function DCGetCompilerPathAndParams(DelphiVer:TDelphiVer;var Params:String):String;
begin
  Result:=GetSpecificDelphiDir(DelphiVer)+'Bin\';
  Case DelphiVer Of
    dvD2,dvD3,dvD4,dvD5,dvd6:
      Begin
        Result:=Result+'dcc32.exe';
        Params:='-B';
      End;
    dvC1,dvC3,dvC4,dvC5:
      Begin
        Result:=Result+'dcc32.exe';
        Params:='-B -JPHN';
      end;
  end;
end;

{------------------------}

const
  SDCLUPackagesStr:Array[TDelphiVer] of String=(
  '',                                      //dvD2
  '',                                      //dvC1
  'dclstd30',                              //dvD3
  'dclstd35',                              //dvC3
  'dclstd40',                              //dvD4
  'dclstd40',                              //dvC4
  'dclstd50;WebMid50;dclwbm50',            //dvD5
  'dclstd50',                              //dvC5
  'designide;dclwbm;dcldss;dclado;dclcds', //dvd6
  'dclstd60',                              //dvC6
  'designide;dclwbm;dcldss;dclado;dclcds'  //dvd7
  );

{------------------------}

function DCGetDreamUnitsPath:String;
var
  AppPath:String;
begin
  AppPath:=AddSlash(ExtractFilePath(ParamStr(0)));
  Result:=AppPath+'..\..\..\UNITS';
  Result:=AddSlash(DCExpandRelativePathEx(AppPath,Result));
end;

{------------------------}

procedure DCCreateTestUnit(const FileName:String;UnitsInUses:TStrings;DelphiVer:TDelphiVer);
var
  IncludePaths:String;
  UnitName,S,S1:String;
  i:Integer;
  UnitPaths:TStringList;
  AdditionalPaths:String;
begin
  UnitPaths:=TStringList.Create;
  try
    ExtractFilePaths(UnitsInUses,UnitPaths);
    DCRemoveVCLPaths(UnitPaths,DelphiVer);
    AdditionalPaths:=DCUnParseString(UnitPaths,';');
  finally
    UnitPaths.Free;
  end;


  S:=
    'unit '+ExtractOnlyName(FileName)+';'+#13#10+
    'interface'+#13#10+
    'uses'+#13#10+
    '%s'+#13#10+
    'implementation'+#13#10+
    'end.';

  S1:='';
  for i:=0 to UnitsInUses.Count-1 do
  begin
    if S1<>'' then
      S1:=S1+','+#13#10;
    UnitName:=ExtractOnlyName(UnitsInUses[i]);
    UnitName:=UnitName+'_'+cDelphiVers[DelphiVer];
    S1:=S1+'  '+UnitName;
  end;
  S1:=S1+';';

  S:=SafeFormat(S,[S1]);

  SaveStringToFile(FileName,S);

  {----------}

  S:=DCGetCompilerPathAndParams(DelphiVer,S1);
  S:=S+' '+S1+' -I%S -U%S';

  IncludePaths:=
    DCEnsureLongPathsAreOk(GetDelphiSourceDirsEx2(DelphiVer,
      [doAddLibFolder,doExcludeSysUnderD3])
      +';'+DCGetDreamUnitsPath+';'+AdditionalPaths);

  S:=SafeFormat(S,[IncludePaths,IncludePaths]);

  If SDCLUPackagesStr[DelphiVer]<>'' then
    S:=S+' -LU'+SDCLUPackagesStr[DelphiVer];

  S:=S+' '+ExtractFileName(FileName);

  SaveStringToFile(ChangeFileExt(FileName,'.bat'),S);

end;

{------------------------}

procedure TDCRunImportParams.ImportVCLUnits;
var
  SaveDefines:String;
begin
  PostFix:='_'+cDelphiVers[DelphiVer];
  Aliases:=SDCDefAliases;
  SearchPaths:=GetDelphiSourceDirsEx(DelphiVer);

  DCEnumVCLUnits(SourceFiles,DelphiVer);

  SaveDefines:=Defines;
  Defines:=Defines+';'+cDCNativeVerDefine[DelphiVer];
  try
    DCCreateTestUnit(AddSlash(DestPath)+'dctestunit.pas',SourceFiles,DelphiVer);
    Execute;
  finally
    Defines:=SaveDefines;
  end;

end;

{------------------------}

procedure TMainForm.CheckDestPath;
begin
  If Trim(DestEditor.Text)='' then
  begin
    Beep;
    ShowMessage('Please specify destination path first');
    exit;
  end;
end;


{------------------------}

procedure TMainForm.ImportVCL(DelphiVer:TDelphiVer;AShowFinalDialog:boolean);
var
  RIP:TDCRunImportParams;
begin
  RIP:=TDCRunImportParams.Create;
  try
    RIP.DestPath:=DestEditor.Text;
    RIP.DelphiVer:=DelphiVer;
    RIP.SilentImport:=ImportSilentlyCheck.Checked;
    RIP.AddUnregister:=AddUnregistrationCheck.Checked;
    RIP.ShowFinalDialog:=AShowFinalDialog;
    RIP.IncludeComments:=IncludeCommentsCheck.Checked;
    RIP.ImportVCLUnits;
  finally
    RIP.Free;
  end;
end;

{------------------------}

procedure TMainForm.ImportVCLD61Click(Sender: TObject);
var
  DelphiVer:TDelphiVer;
begin
  CheckDestPath;

  If Sender=ImportVCLD71 then
    DelphiVer:=dvD7
  else
  If Sender=ImportVCLC61 then
    DelphiVer:=dvC6
  else
  If Sender=ImportVCLD61 then
    DelphiVer:=dvD6
  else
  If Sender=ImportVCLD51 then
    DelphiVer:=dvD5
  else
  If Sender=ImportVCLC31 then
    DelphiVer:=dvC3
  else
  If Sender=ImportVCLC41 then
    DelphiVer:=dvC4
  else
  If Sender=ImportVCLC51 then
    DelphiVer:=dvC5
  else
  If Sender=ImportVCLD31 then
    DelphiVer:=dvD3
  else
  If Sender=ImportVCLD41 then
    DelphiVer:=dvD4
  else
    DelphiVer:=dvD5;

  ImportVCL(DelphiVer,True);
end;

{------------------------}

function DCGetImportedFolder(DelphIVer:TDelphiVer):String;
begin
  Result:='C:\DREAM\IMPORTED\'+cDelphiVers[DelphiVer]
end;

{------------------------}

procedure TMainForm.PrepareforImportD61Click(Sender: TObject);
var
  DelphiVer:TDelphiVer;
begin
  If (Sender=PrepareforImportD71) or (Sender=ImportDreamD71) then
    DelphiVer:=dvD7
  else
  If (Sender=PrepareforImportC61) or (Sender=ImportDreamC61) then
    DelphiVer:=dvC6
  else
  If (Sender=PrepareforImportD61) or (Sender=ImportDreamD61) then
    DelphiVer:=dvD6
  else
  If (Sender=PrepareforImportD51) or (Sender=ImportDreamD51)  then
    DelphiVer:=dvD5
  else
  If (Sender=PrepareforImportC31) or (Sender=ImportDreamC31)  then
    DelphiVer:=dvC3
  else
  If (Sender=PrepareforImportC41) or (Sender=ImportDreamC41)  then
    DelphiVer:=dvC4
  else
  If (Sender=PrepareforImportC51) or (Sender=ImportDreamC51)  then
    DelphiVer:=dvC5
  else
  If (Sender=PrepareforImportD31) or (Sender=ImportDreamD31)  then
    DelphiVer:=dvD3
  else
  If (Sender=PrepareforImportD41) or (Sender=ImportDreamD41)  then
    DelphiVer:=dvD4
  else
    DelphiVer:=dvD5;

  PrepareForImport(DelphiVer);
end;

{------------------------}

procedure TMainForm.PrepareForImport(DelphiVer:TDelphiVer);
begin
  LibrariesEditor.Text:=GetDelphiSourceDirsEx(DelphiVer);
  PostfixEditor.Text:='_'+cDelphiVers[DelphiVer];
  AliasEditor.Text:=SDCDefAliases;
  DefinesEditor.Text:=cDCNativeVerDefine[DelphiVer];
  DestEditor.Text:=DCGetImportedFolder(DelphiVer);
end;

{------------------------}

procedure TMainForm.ImportVCLall1Click(Sender: TObject);
var
  i:TDelphiVer;
begin
  CheckDestPath;

  for i:=dvD3 to High(TDelphiVer) do
  begin
    DestEditor.Text:=DCGetImportedFolder(i);
    ImportVCL(i,False);
  end;
end;

{------------------------}

procedure TMainForm.ImportDreamD61Click(Sender: TObject);
begin
  ClearAllActionExecute(nil);
  PrepareforImportD61Click(Sender);
  AddDreamfiles1Click(nil);
  If ImportBtn.Enabled then
    ImportBtnClick(nil);
end;

{------------------------}

const
  SQReportFolder1='quickrep';
  SQReportFolder2='quickrpt';

function DCGetQReportPath(DelphiVer:TDelphiVer):String;

function FolderIsOk(const TryFolder:String):boolean;
begin
  Result:=DirectoryExists(TryFolder);
  If not Result then
    exit;

  Result:=FileExists(TryFolder+'qrctrls.pas');
end;

var
  TryFolder1,TryFolder2:String;
begin
  TryFolder1:=GetSpecificDelphiDir(DelphiVer)+SQReportFolder1+'\';
  TryFolder2:=GetSpecificDelphiDir(DelphiVer)+SQReportFolder2+'\';

  If FolderIsOk(TryFolder1) then
    Result:=TryFolder1
  else
  If FolderIsOk(TryFolder2) then
    Result:=TryFolder2
  else
    Result:='';
end;

{------------------------}

procedure TMainForm.AddDreamfiles1Click(Sender: TObject);
begin
  AddFilesWithExt(DCGetDreamUnitsPath,'.pas');
  AddFilesWithExt(DCGetDreamUnitsPath,'.int');
end;

{------------------------}

procedure TMainForm.ImportDreamall1Click(Sender: TObject);
begin
  FShowFinalDialog:=False;
  try
    ImportDreamD61Click(ImportDreamD61);
    ImportDreamD61Click(ImportDreamD51);
    ImportDreamD61Click(ImportDreamD41);
    ImportDreamD61Click(ImportDreamD31);
    ImportDreamD61Click(ImportDreamC51);
    ImportDreamD61Click(ImportDreamC41);
    ImportDreamD61Click(ImportDreamC31);
  finally
    FShowFinalDialog:=True;
  end;
end;

{------------------------}

function TMainForm.QReportSenderToDelphiVer(Sender: TObject):TDelphiVer;
begin
  If (Sender=PepareforD6QReport1) or (Sender=ImportQReportforD61) then
    Result:=dvD6
  else
  If (Sender=PepareforD5QReport1) or (Sender=ImportQReportforD51)  then
    Result:=dvD5
  else
  If (Sender=PepareforC3QReport1) or (Sender=ImportQReportforC31)  then
    Result:=dvC3
  else
  If (Sender=PepareforC4QReport1) or (Sender=ImportQReportforC41)  then
    Result:=dvC4
  else
  If (Sender=PepareforC5QReport1) or (Sender=ImportQReportforC51)  then
    Result:=dvC5
  else
  If (Sender=PepareforD3QReport1) or (Sender=ImportQReportforD31)  then
    Result:=dvD3
  else
  If (Sender=PepareforD4QReport1) or (Sender=ImportQReportforD41)  then
    Result:=dvD4
  else
    Result:=dvD5;
end;

{------------------------}

procedure TMainForm.PepareforD6QReport1Click(Sender: TObject);
var
  DelphiVer:TDelphiVer;
begin
  DelphiVer:=QReportSenderToDelphiVer(Sender);
  AddFilesWithExt(DCGetQReportPath(DelphiVer),'.pas');
end;

{------------------------}

procedure TMainForm.ImportQReportforD61Click(Sender: TObject);
var
  DelphiVer:TDelphiVer;
begin
  ClearAllActionExecute(nil);
  DelphiVer:=QReportSenderToDelphiVer(Sender);
  PrepareForImport(DelphiVer);
  PepareforD6QReport1Click(Sender);
  If ImportBtn.Enabled then
    ImportBtnClick(nil);
end;

{------------------------}

procedure TMainForm.ImportQReportforall1Click(Sender: TObject);
begin
  FShowFinalDialog:=False;
  try
    ImportQReportforD61Click(ImportQReportforD61);
    ImportQReportforD61Click(ImportQReportforD51);
    ImportQReportforD61Click(ImportQReportforC31);
    ImportQReportforD61Click(ImportQReportforC41);
    ImportQReportforD61Click(ImportQReportforC51);
    ImportQReportforD61Click(ImportQReportforD31);
    ImportQReportforD61Click(ImportQReportforD41);
  finally
    FShowFinalDialog:=True;
  end;
end;

{------------------------}

initialization
  ParserInfoKinds:=[];
end.
