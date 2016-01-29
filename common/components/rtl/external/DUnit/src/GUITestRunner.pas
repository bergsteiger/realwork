{ $Id: GUITestRunner.pas,v 1.119 2015/10/21 08:39:44 dinishev Exp $ }
{: DUnit: An XTreme testing framework for Delphi programs.
   @author  The DUnit Group.
   @version $Revision: 1.119 $ 2001/03/08 uberto
}
(*
 * The contents of this file are subject to the Mozilla Public
 * License Version 1.1 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of
 * the License at http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS
 * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * rights and limitations under the License.
 *
 * The Original Code is DUnit.
 *
 * The Initial Developers of the Original Code are Kent Beck, Erich Gamma,
 * and Juancarlo A±ez.
 * Portions created The Initial Developers are Copyright (C) 1999-2000.
 * Portions created by The DUnit Group are Copyright (C) 2000-2004.
 * All rights reserved.
 *
 * Contributor(s):
 * Kent Beck <kentbeck@csi.com>
 * Erich Gamma <Erich_Gamma@oti.com>
 * Juanco Aсez <juanco@users.sourceforge.net>
 * Chris Morris <chrismo@users.sourceforge.net>
 * Jeff Moore <JeffMoore@users.sourceforge.net>
 * Kenneth Semeijn <dunit@designtime.demon.nl>
 * Uberto Barbini <uberto@usa.net>
 * Brett Shearer <BrettShearer@users.sourceforge.net>
 * Kris Golko <neuromancer@users.sourceforge.net>
 * The DUnit group at SourceForge <http://dunit.sourceforge.net>
 *
 *)
unit GUITestRunner;

{$Include l3Define.inc}

interface

uses
  TestFramework,

  Windows,
  Math,
  Graphics, Controls, Forms,  TestNameList,
  ComCtrls, ExtCtrls, StdCtrls, ImgList, Buttons, Menus, ActnList,
  Classes, IniFiles, ToolWin, OvcBase, afwControlPrim, afwBaseControl,
  afwControl, nevControl, evCustomEditorWindowPrim, evEditorWindow,
  evCustomEditorWindowModelPart, evMultiSelectEditorWindow,
  evCustomEditorModelPart, evCustomEditor, evEditorWithOperations,
  evCustomMemo, evCustomEdit, TestTreeSeacher, evEdit, StdActns,
  l3WinControlCanvas, evCustomEditorWindow, vtCtrls, elCustomEdit,
  elCustomButtonEdit, ctButtonEdit, ctAbstractEdit, AbstractDropDown, DropDownTree,
  EditableBox, FakeBox, vtComboBoxQS
  ;

const
  {: Section of the dunit.ini file where GUI information will be stored }
  cnConfigIniSection = 'GUITestRunner Config';

  {: Color constants for the progress bar and failure details panel }
  clOK      = clGreen;
  clFAILURE = clFuchsia;
  clERROR   = clRed;

  {: Indexes of the color images used in the test tree and failure list }
  imgNONE     = 0;
  imgRUNNING  = 1;
  imgRUN      = 2;
  imgHASPROPS = 3;
  imgFAILED   = 4;
  imgERROR    = 5;

  {: Indexes of the images used for test tree checkboxes }
  imgDISABLED        = 1;
  imgPARENT_DISABLED = 2;
  imgENABLED         = 3;

  csClearEtalonScriptName = 'ClearEtalons.script';
  {$IFDEF Archi}
  csClearDataBase = 'Очистить тестовую базу.script';
  {$ENDIF Archi}

type
 TDictionary = (dCommon, dDictionaries);

 TDictionaryMenuItem = class(TMenuItem)
 private
  f_Dictionary: TDictionary;
 public
  constructor Create(anOwner: TComponent; aDictionary: TDictionary); reintroduce;
 public
  property Dictionary: TDictionary read f_Dictionary;
 end;

type
  {: Function type used by the TDUnitDialog.ApplyToTests method
     @param item  The ITest instance on which to act
     @return true if processing should continue, false otherwise
  }
  TTestFunc = function (anItem: ITest): Boolean of object;

  TGUITestRunner = class(TForm, ITestListener, ITestListenerX)
    StateImages: TImageList;
    RunImages: TImageList;
    DialogActions: TActionList;
    SelectAllAction: TAction;
    DeselectAllAction: TAction;
    SelectFailedAction: TAction;
    MainMenu: TMainMenu;
    TestTreeMenu: TMenuItem;
    SelectAllItem: TMenuItem;
    DeselectAllItem: TMenuItem;
    SelectFailedItem: TMenuItem;
    FileMenu: TMenuItem;
    SaveConfigurationAction: TAction;
    AutoSaveAction: TAction;
    SaveConfigurationItem: TMenuItem;
    AutoSaveItem: TMenuItem;
    RestoreSavedAction: TAction;
    RestoreSavedConfigurationItem: TMenuItem;
    ViewMenu: TMenuItem;
    HideErrorBoxItem: TMenuItem;
    BodyPanel: TPanel;
    ErrorBoxVisibleAction: TAction;
    TopPanel: TPanel;
    TreePanel: TPanel;
    TestTree: TTreeView;
    ResultsPanel: TPanel;
    ProgressPanel: TPanel;
    ResultsView: TListView;
    FailureListView: TListView;
    ErrorBoxPanel: TPanel;
    ErrorBoxSplitter: TSplitter;
    ResultsSplitter: TSplitter;
    AutoChangeFocusItem: TMenuItem;
    TopProgressPanel: TPanel;
    ProgressBar: TProgressBar;
    pnlProgresslabel: TPanel;
    ScorePanel: TPanel;
    ScoreLabel: TPanel;
    ScoreBar: TProgressBar;
    pmTestTree: TPopupMenu;
    pmiSelectAll: TMenuItem;
    pmiDeselectAll: TMenuItem;
    pmiSelectFailed: TMenuItem;
    HideTestNodesAction: TAction;
    CollapseLowestSuiteNodesItem: TMenuItem;
    CollapseLowestSuiteNodes1: TMenuItem;
    HideTestNodesOnOpenAction: TAction;
    HideTestNodesItem: TMenuItem;
    ExpandAllNodesAction: TAction;
    TestTreeMenuSeparator: TMenuItem;
    ExpandAllItem: TMenuItem;
    TestTreeLocalMenuSeparator: TMenuItem;
    ExpandAll2: TMenuItem;
    lblTestTree: TLabel;
    RunAction: TAction;
    ExitAction: TAction;
    BreakOnFailuresAction: TAction;
    BreakonFailuresItem: TMenuItem;
    ShowTestedNodeAction: TAction;
    SelectTestedNodeItem: TMenuItem;
    ErrorMessagePopup: TPopupMenu;
    CopyFailureMessage: TMenuItem;
    CopyMessageToClipboardAction: TAction;
    ActionsMenu: TMenuItem;
    CopyMessagetoCllipboardItem: TMenuItem;
    LbProgress: TLabel;
    UseRegistryAction: TAction;
    UseRegistryItem: TMenuItem;
    ErrorMessageRTF: TRichEdit;
    SelectCurrentAction: TAction;
    DeselectCurrentAction: TAction;
    SelectCurrent1: TMenuItem;
    DeselectCurrent1: TMenuItem;
    ActionsImages: TImageList;
    CloseItem: TMenuItem;
    RunItem: TMenuItem;
    StopAction: TAction;
    StopActionItem: TMenuItem;
    ToolBar1: TToolBar;
    SelectAllButton: TToolButton;
    DeselectAllButton: TToolButton;
    ToolButton1: TToolButton;
    SelectFailedButton: TToolButton;
    ToolButton2: TToolButton;
    SelectCurrentButton: TToolButton;
    DeselectCurrentButton: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    Alt_R_RunAction: TAction;
    Alt_S_StopAction: TAction;
    N1: TMenuItem;
    DeselectCurrent2: TMenuItem;
    SelectCurrent2: TMenuItem;
    N2: TMenuItem;
    CopyProcnameToClipboardAction: TAction;
    N3: TMenuItem;
    Copytestnametoclipboard1: TMenuItem;
    N4: TMenuItem;
    Copytestnametoclipboard2: TMenuItem;
    RunSelectedTestAction: TAction;
    N5: TMenuItem;
    Runcurrenttest1: TMenuItem;
    N6: TMenuItem;
    Runcurrenttest2: TMenuItem;
    RunSelectedTestItem: TMenuItem;
    RunSelectedTestButton: TToolButton;
    GoToNextSelectedTestAction: TAction;
    GoToPrevSelectedTestAction: TAction;
    N7: TMenuItem;
    GoToNextSelectedNode1: TMenuItem;
    GoToPreviousSelectedNode1: TMenuItem;
    N8: TMenuItem;
    GoToNextSelectedNode2: TMenuItem;
    GoToPreviousSelectedNode2: TMenuItem;
    FailIfNoChecksExecuted: TMenuItem;
    FailIfNoChecksExecutedAction: TAction;
    FailTestCaseIfMemoryLeaked: TMenuItem;
    FailTestCaseIfMemoryLeakedAction: TAction;
    TestCaseProperty: TPopupMenu;
    TestCaseProperties: TMenuItem;
    N10: TMenuItem;
    FailNoCheckExecutedMenuItem: TMenuItem;
    FailsOnMemoryLeakMenuItem: TMenuItem;
    N11: TMenuItem;
    TestCasePopup: TMenuItem;
    FailsOnMemoryRecoveryMenuItem: TMenuItem;
    AllowedLeakSizeMemuItem: TMenuItem;
    ShowTestCaseswithRunTimeProperties: TMenuItem;
    ShowTestCasesWithRunTimePropertiesAction: TAction;
    N9: TMenuItem;
    WarnOnFailTestOverride: TMenuItem;
    WarnOnFailTestOverrideAction: TAction;
    N12: TMenuItem;
    TestCasePropertiesAction: TAction;
    PropertyPopUpAction: TAction;
    N13: TMenuItem;
    Previous1: TMenuItem;
    Next1: TMenuItem;
    RunSelectedTest1: TMenuItem;
    RunSelectedTestAltAction: TAction;
    N14: TMenuItem;
    ReportMemoryLeakTypeOnShutdown: TMenuItem;
    IgnoreMemoryLeakInSetUpTearDown: TMenuItem;
    IgnoreMemoryLeakInSetUpTearDownAction: TAction;
    ReportMemoryLeakTypeOnShutdownAction: TAction;
    TestCaseIgnoreSetUpTearDownLeaksMenuItem: TMenuItem;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    FindBtn: TToolButton;
    FindDirBtn: TToolButton;
    N15: TMenuItem;
    FindPM: TMenuItem;
    acFindNode: TAction;
    acFindDirection: TAction;
    NeedSelectBtn: TToolButton;
    acNeedSelect: TAction;
    acNeedSelectAll: TAction;
    btnNeedSelectAll: TToolButton;
    ToolButton8: TToolButton;
    btnShowFolder: TToolButton;
    acShowFolder: TAction;
    acFolderMode: TAction;
    FolderNodeBtm: TToolButton;
    acSelectExcluded: TAction;
    acDeselectExcluded: TAction;
    ToolButton9: TToolButton;
    SelectExcludedBtn: TToolButton;
    DeselectExcluded: TToolButton;
    acDeleteEtalons: TAction;
    ToolButton12: TToolButton;
    DeleteEtalonsBtn: TToolButton;
    acOpenExcludeFile: TFileOpen;
    ToolButton10: TToolButton;
    OpenFileExcludeBtn: TToolButton;
    LoadExcludeListPM: TMenuItem;
    acOpenTestList: TFileOpen;
    OpenTestListBtn: TToolButton;
    OpenTestListPM: TMenuItem;
    acSelect2Current: TAction;
    Select2CurrentBtn: TToolButton;
    acInvertTests: TAction;
    InvertTestsBtn: TToolButton;
    acRandomTests: TAction;
    RandomBtn: TToolButton;
    ToolButton13: TToolButton;
    Save2FileBTN: TToolButton;
    acSaveSelected: TFileSaveAs;
    SaveSelectedPM: TMenuItem;
    PresetsPM: TMenuItem;
    RunScirpt: TMenuItem;
    RunScriptAction: TFileOpen;
    MacrosPM: TMenuItem;
    ToolButton11: TToolButton;
    PrevSelectedTestsBtn: TToolButton;
    NextSelectedTestsBtn: TToolButton;
    N16: TMenuItem;
    FolderModePM: TMenuItem;
    RandomPM: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    NeedSelectPM: TMenuItem;
    acReReadAutoTests: TAction;
    ToolButton14: TToolButton;
    ReReadAutoTestsBtn: TToolButton;
    evFindEdit: TvtComboBoxQS;
    acOpenScript: TAction;
    N19: TMenuItem;
    N20: TMenuItem;
    LoadOperationBTN: TToolButton;
    acLoadOperation: TAction;
    CompileAction: TAction;
    ToolButton15: TToolButton;
    btnDebugger: TToolButton;
    acDebugger: TAction;
    ClearDBBtn: TToolButton;
    acClearDaaBase: TAction;
    procedure FormCreate(Sender: TObject);
    procedure TestTreeClick(Sender: TObject);
    procedure FailureListViewSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure FailureListViewClick(Sender: TObject);
    procedure TestTreeKeyPress(Sender: TObject; var Key: Char);
    procedure SelectAllActionExecute(Sender: TObject);
    procedure DeselectAllActionExecute(Sender: TObject);
    procedure SelectFailedActionExecute(Sender: TObject);
    procedure SaveConfigurationActionExecute(Sender: TObject);
    procedure RestoreSavedActionExecute(Sender: TObject);
    procedure AutoSaveActionExecute(Sender: TObject);
    procedure ErrorBoxVisibleActionExecute(Sender: TObject);
    procedure ErrorBoxSplitterMoved(Sender: TObject);
    procedure ErrorBoxPanelResize(Sender: TObject);
    procedure HideTestNodesActionExecute(Sender: TObject);
    procedure HideTestNodesOnOpenActionExecute(Sender: TObject);
    procedure ExpandAllNodesActionExecute(Sender: TObject);
    procedure RunActionExecute(Sender: TObject);
    procedure ExitActionExecute(Sender: TObject);
    procedure BreakOnFailuresActionExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ShowTestedNodeActionExecute(Sender: TObject);
    procedure CopyMessageToClipboardActionExecute(Sender: TObject);
    procedure UseRegistryActionExecute(Sender: TObject);
    procedure RunActionUpdate(Sender: TObject);
    procedure CopyMessageToClipboardActionUpdate(Sender: TObject);
    procedure SelectCurrentActionExecute(Sender: TObject);
    procedure DeselectCurrentActionExecute(Sender: TObject);
    procedure StopActionExecute(Sender: TObject);
    procedure StopActionUpdate(Sender: TObject);
    procedure TestTreeChange(Sender: TObject; Node: TTreeNode);
    procedure CopyProcnameToClipboardActionExecute(Sender: TObject);
    procedure CopyProcnameToClipboardActionUpdate(Sender: TObject);
    procedure RunSelectedTestActionExecute(Sender: TObject);
    procedure RunSelectedTestActionUpdate(Sender: TObject);
    procedure TestTreeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GoToNextSelectedTestActionExecute(Sender: TObject);
    procedure GoToPrevSelectedTestActionExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FailIfNoChecksExecutedActionExecute(Sender: TObject);
    procedure FailTestCaseIfMemoryLeakedActionExecute(Sender: TObject);
    procedure ShowTestCasesWithRunTimePropertiesActionExecute(
      Sender: TObject);
    procedure WarnOnFailTestOverrideActionExecute(Sender: TObject);
    procedure TestCasePropertiesActionExecute(Sender: TObject);
    procedure Previous1Click(Sender: TObject);
    procedure Next1Click(Sender: TObject);
    procedure TestCasePropertiesMeasureItem(Sender: TObject;
      ACanvas: TCanvas; var Width, Height: Integer);
    procedure TestCasePropertiesDrawItem(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; Selected: Boolean);
    procedure FailNoCheckExecutedMenuItemDrawItem(Sender: TObject;
      ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
    procedure AllowedLeakSizeMemuItemDrawItem(Sender: TObject;
      ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
    procedure FailsOnMemoryRecoveryMenuItemDrawItem(Sender: TObject;
      ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
    procedure FailsOnMemoryLeakMenuItemDrawItem(Sender: TObject;
      ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
    procedure pmTestTreePopup(Sender: TObject);
    procedure FailNoCheckExecutedMenuItemClick(Sender: TObject);
    procedure AllowedLeakSizeMemuItemClick(Sender: TObject);
    procedure FailsOnMemoryLeakMenuItemClick(Sender: TObject);
    procedure FailsOnMemoryRecoveryMenuItemClick(Sender: TObject);
    procedure RunSelectedTestAltActionExecute(Sender: TObject);
    procedure Previous1DrawItem(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; Selected: Boolean);
    procedure RunSelectedTest1DrawItem(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; Selected: Boolean);
    procedure Next1DrawItem(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; Selected: Boolean);
    procedure ReportMemoryLeakTypeOnShutdownActionExecute(Sender: TObject);
    procedure IgnoreMemoryLeakInSetUpTearDownActionExecute(
      Sender: TObject);
    procedure TestCaseIgnoreSetUpTearDownLeaksMenuItemClick(Sender: TObject);
    procedure TestCaseIgnoreSetUpTearDownLeaksMenuItemDrawItem(Sender: TObject;
      ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
    procedure acFindNodeUpdate(Sender: TObject);
    procedure acFindNodeExecute(Sender: TObject);
    procedure acFindDirectionExecute(Sender: TObject);
    procedure TestTreeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure acShowFolderExecute(Sender: TObject);
    procedure acFolderModeUpdate(Sender: TObject);
    procedure TestTreeCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure acSelectExcludedExecute(Sender: TObject);
    procedure acDeselectExcludedExecute(Sender: TObject);
    procedure acDeleteEtalonsExecute(Sender: TObject);
    procedure acOpenExcludeFileAccept(Sender: TObject);
    procedure acOpenExcludeFileBeforeExecute(Sender: TObject);
    procedure acOpenTestListAccept(Sender: TObject);
    procedure acOpenTestListBeforeExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ExitActionUpdate(Sender: TObject);
    procedure acSelect2CurrentExecute(Sender: TObject);
    procedure acInvertTestsExecute(Sender: TObject);
    procedure acRandomTestsUpdate(Sender: TObject);
    procedure acSaveSelectedAccept(Sender: TObject);
    procedure RunScriptActionAccept(Sender: TObject);
    procedure RunScriptActionUpdate(Sender: TObject);
    procedure acReReadAutoTestsExecute(Sender: TObject);
    procedure acOpenScriptExecute(Sender: TObject);
    procedure acOpenScriptUpdate(Sender: TObject);
    procedure TestTreeDblClick(Sender: TObject);
    procedure acLoadOperationExecute(Sender: TObject);
    procedure CompileActionUpdate(Sender: TObject);
    procedure CompileActionExecute(Sender: TObject);
    procedure acDebuggerExecute(Sender: TObject);
    procedure acClearDaaBaseExecute(Sender: TObject);
    procedure acDebuggerUpdate(Sender: TObject);
  private
    FNoCheckExecutedPtyOverridden: Boolean;
    FMemLeakDetectedPtyOverridden: Boolean;
    FIgnoreSetUpTearDownLeakPtyOverridden: Boolean;
    FPopupY: Integer;
    FPopupX: Integer;
    FTestTreeSeacher: TTestTreeSeacher;
    FInitDirForExclude : string;
    FInitDirForError   : string;
    FClearEtalonPM: TMenuItem;
    FLoadOperation: TLoadOperation;
    FWasStarted: Boolean;
    {$IFDEF Archi}
    FClearBaseMenuItem: TMenuItem;
    {$ENDIF Archi}
    procedure DoDeselectAllActionExecute(Sender: TObject);
    procedure CheckMenuItem(const aMenuItem: TMenuItem); // Для "вылавливания" нужных пунктов меню...
    procedure ResetProgress;
    procedure MenuLooksInactive(ACanvas: TCanvas; ARect: TRect; Selected: Boolean;
      ATitle: string; TitlePosn: UINT; PtyOveridesGUI: boolean);
    procedure MenuLooksActive(ACanvas: TCanvas; ARect: TRect; Selected: Boolean;
      ATitle: string; TitlePosn: UINT);
    function  GetPropertyName(const Caption: string): string;
    procedure CheckDirection(Sender: TObject; Key: Word);
    procedure ChangeState4Test(anEnable, anExcluded: Boolean);
    procedure CheckStartParams;
    procedure ReadSubMenuItems(aMenuItem: TMenuItem; aExt: string; aSubDir: string; anEvent: TNotifyEvent; aStartIndex: Integer);
    procedure ReadSubDirs(aMenuItem: TMenuItem; aExt: string; aSubDir: string; anEvent: TNotifyEvent);
    procedure OnSelectPreset(Sender: TObject);
    procedure OnSelectMacros(Sender: TObject);
    procedure Try2RemeberInHistory;
    function CheckParentDir(Sender: TObject; aParentPM: TMenuItem): String;
    procedure InitLogicalOperation;
    procedure UpdateLogicalOpearation;
    procedure LoadItemFlagsFromFile(aFileName: AnsiString);
    procedure SetLoadOperation(const Value: TLoadOperation);
  protected
    FSuite:         ITest;
    FTestResult:    TTestResult;
    FRunning:       Boolean;
    FTests:         TInterfaceList;
    FSelectedTests: TInterfaceList;
    FTotalTime:     Int64;
    FRunTimeStr:    string;
    FNoChecksStr:   string;
    FMemLeakStr:    string;
    FMemGainStr:    string;
    FMemBytesStr:   string;
    FIgnoreLeakStr: string;
    FBytes:         string;
    FErrorCount:    Integer;
    FFailureCount:  Integer;
    FStrMaxLen:     Integer;
    FValMaxLen:     Integer;
    FUpdateTimer:   TTimer;
    FTimerExpired:  Boolean;
    FTotalTestsCount: Integer;
    f_DisableClose : Boolean;
    f_InternalStart: Boolean;

    procedure Setup;
    procedure SetUpStateImages;
    procedure SetSuite(value: ITest);
    procedure ClearResult;
    procedure DisplayFailureMessage(Item :TListItem);
    procedure ClearFailureMessage;

    function  AddFailureItem(failure: TTestFailure): TListItem;
    procedure UpdateStatus(const fullUpdate:Boolean);

    procedure FillTestTree(RootNode: TTreeNode; ATest: ITest); overload;
    procedure FillTestTree(ATest: ITest);                      overload;
    function GetTestFileName(aTest: ITest): string;
    procedure OpenFile(const aFileName: string);

    function DictionariesPath(aDictionary: TDictionary): string;
    procedure LoadDictionariesMenu;
    procedure DictionaryMenuItemClick(aSender: TObject);

    procedure UpdateNodeImage(aNode: TTreeNode);
    procedure UpdateNodeState(aNode: TTreeNode);
    procedure SetNodeState(aNode: TTreeNode; anEnabled: Boolean);
    procedure SwitchNodeState(aNode: TTreeNode);
    procedure UpdateTestTreeState;

    procedure MakeNodeVisible(aNode :TTreeNode);
    procedure SetTreeNodeImage(Node :TTReeNode; imgIndex :Integer);
    procedure SelectNode(node: TTreeNode);

    function GetNodeEnabled(aNode: TTreeNode): Boolean;
    {function} procedure SetNodeEnabled(aNode: TTreeNode; aValue: Boolean){: Boolean};
    function  TestToNode(aTest: ITest) :TTreeNode;
    function  SelectedTest :ITest;
    procedure ListSelectedTests;

    function  EnableTest(aTest: ITest): Boolean;
    function  DisableTest(aTest: ITest): Boolean;
    function  InvertTest(aTest: ITest): Boolean;
    procedure ApplyToTests(aRoot: TTreeNode; const aFunc: TTestFunc; aStopOnSelect: Boolean);

    procedure EnableUI(enable :Boolean);
    procedure RunTheTest(aTest: ITest; aRandom: Boolean);

    procedure InitTree; virtual;

    function  IniFileName :string;
    function  GetIniFile( const FileName : string ) : tCustomIniFile;

    procedure LoadRegistryAction;
    procedure SaveRegistryAction;

  public
    function  NodeToTest(aNode: TTreeNode) :ITest;
    procedure LoadFormPlacement;
    procedure ShowDebugForm;
  protected
    procedure SaveFormPlacement;

    procedure SaveConfiguration;
    procedure LoadConfiguration;

    procedure LoadSuiteConfiguration;
    procedure AutoSaveConfiguration;

    function NodeIsGrandparent(aNode: TTreeNode): Boolean;
    procedure CollapseNonGrandparentNodes(aRootNode: TTreeNode);

    procedure ProcessClickOnStateIcon;
    procedure ClearStatusMessage;

    procedure CopyTestNametoClipboard(ANode: TTreeNode);

    procedure SetupCustomShortcuts;
    procedure SetupGUINodes;

    function SelectNodeIfTestEnabled(aNode: TTreeNode): boolean;

    procedure OnUpdateTimer(Sender: TObject);
  public
    {: implement the ITestListener interface }
    procedure AddSuccess(const test: ITest);
    procedure AddError(failure: TTestFailure);
    procedure AddFailure(failure: TTestFailure);
    function  ShouldRunTest(aTest: ITest): Boolean;
    procedure StartSuite(suite: ITest); virtual;
    procedure EndSuite(suite: ITest); virtual;
    procedure StartTest(aTest: ITest); virtual;
    procedure EndTest(aTest: ITest); virtual;
    procedure TestingStarts;
    procedure TestingEnds(TestResult :TTestResult);
    procedure Status(test :ITest; const Msg : AnsiString);
    procedure Warning(test :ITest; const Msg : string);
    procedure ToFront;

    property LoadOperation: TLoadOperation read FLoadOperation write SetLoadOperation;
    {: The number of errors in the last test run }
    property ErrorCount: Integer read FErrorCount;
    {: The number of failures in the last test run }
    property FailureCount: Integer read FFailureCount;
    {: The test suite to be run in this runner }
    property Suite: ITest read FSuite write SetSuite;
    {: The result of the last test run }
    property TestResult : TTestResult read FTestResult write FTestResult;

    property DisableClose: Boolean
      read f_DisableClose
      write f_DisableClose;

    class procedure RunTest(test: ITest);
    class procedure RunRegisteredTests;
  end;

procedure RunTest(test: ITest);
procedure RunRegisteredTests;

procedure RunTestModeless(test: ITest);
procedure RunRegisteredTestsModeless;

// Run all tests in unattended mode, i.e. automatically
function RunRegisteredTestsModelessUnattended: Integer;

implementation

uses
{$IFDEF FASTMM}
  {$IFNDEF VER180}
    {$IFNDEF CLR}
      {$IFNDEF ManualLeakReportingControl}
        {$I FastMM4Options.inc}
      {$ENDIF}
      FastMM4,
    {$ENDIF}
  {$ENDIF}
{$ENDIF}
  FolderSupport,
  {$If not defined(NoScripts)}
  TestForm4Scripts,
  {$IfEnd}

  KTestRunner,
  
  Registry,
  SysUtils,
  Clipbrd,
  Dialogs,
  ShellAPI,

  MacroTest,
  
  l3Base,
  l3Filer,
  l3Types,
  l3FileUtils,
  l3BatchService,

  afwFacade
  {$IfDef InsiderTest}
  ,
  tfwScriptDebugger
  {$EndIf InsiderTest}

  ,
  vcmInsiderTest
  ;


{$BOOLEVAL OFF}  // Required or you'll get an AV
{$R *.DFM}

const
 csDictionaryMenuItemCaption: array[TDictionary] of AnsiString = ('Common', 'Dictionaries');
 csDictionarySubDir: array[TDictionary] of AnsiString = ('Common\', 'Dictionary\');
 csDictionaryExt = '*.script';

const
 cnIndexDown = 12;
 cnIndexUp   = 13;
 csHintStr   : array [cnIndexDown..cnIndexUp] of string = ('Искать вниз', 'Искать вверх');
 csPresetsSubDir = 'Presets\';
 csPresetsExt    = '*.txt';
 csMacrosSubDir  = 'Macros\';
 csMacrosExt     = '*.script';
 cnStartLogicalIndex = 31;
 csLogicalHintArray : array [TLoadOperation] of string = ('Очищать список',
                                                       'Пересечение списков',
                                                       'Объединение списков',
                                                       'Вычитание списков');

type
  TProgressBarCrack = class(TProgressBar);

procedure RunTest(test: ITest);
begin
  with TGUITestRunner.Create(nil) do
  begin
    try
      Suite := test;
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure RunTestModeless(test: ITest);
var
  GUI :TGUITestRunner;
begin
  Application.CreateForm(TGUITestRunner, GUI);
  GUI.Suite := test;
  GUI.Show;
end;

procedure RunRegisteredTests;
begin
 RunTest(registeredTests)
end;

procedure RunRegisteredTestsModeless;
begin
 RunTestModeless(registeredTests)
end;

// Run all tests in unattended mode, i.e. automatically
function RunRegisteredTestsModelessUnattended: Integer;
var
  GUI :TGUITestRunner;
begin
  // Create and show the GUI runner form

  Application.CreateForm(TGUITestRunner, GUI);
  GUI.Suite := registeredTests;
  GUI.Show;

  GUI.RunActionExecute(GUI.RunItem);

  // Process messages until the tests have finished

  repeat
    try
      Application.HandleMessage;
    except
      Application.HandleException(Application);
    end;
  until TGUITestRunner(Application.MainForm).RunAction.Enabled;

  // Return the number of errors and failures and free the runner form

  Result := GUI.ErrorCount + GUI.FailureCount;

  GUI.Free;
end;

{ TGUITestRunner }

procedure TGUITestRunner.InitTree;
begin
 FTests.Clear;
 FillTestTree(Suite);
 Setup;
 if HideTestNodesOnOpenAction.Checked then
   HideTestNodesAction.Execute
 else
   ExpandAllNodesAction.Execute;
 TestTree.Selected := TestTree.Items.GetFirstNode;
end;

function TGUITestRunner.NodeToTest(aNode: TTreeNode): ITest;
var
 l_Index: Integer;
begin
 Assert(Assigned(aNode));
 l_Index := Integer(aNode.Data);
 if IsNodeFolder(aNode) then
  Result := nil // Папка...
 else
 begin
  Assert((l_Index >= 0) and (l_Index < FTests.Count)); 
  Result := FTests[l_Index] as ITest;
 end; 
end;

procedure TGUITestRunner.OnUpdateTimer(Sender: TObject);
begin
 FTimerExpired := True;
 FUpdateTimer.Enabled := False;
end;

function TGUITestRunner.TestToNode(aTest: ITest): TTreeNode;
begin
 Assert(Assigned(aTest));
 Result := aTest.GUIObject as TTreeNode;
 Assert(Assigned(Result));
end;

function TGUITestRunner.ShouldRunTest(aTest: ITest): Boolean;
begin
 if FSelectedTests = nil then
  Result := aTest.Enabled
 else
  Result := FSelectedTests.IndexOf(aTest as ITest) >= 0;
end;

procedure TGUITestRunner.StartTest(aTest: ITest);
var
 l_Node: TTreeNode;
begin
 if f_InternalStart then Exit;
 Assert(Assigned(TestResult));
 Assert(Assigned(aTest));
 l_Node := TestToNode(aTest);
 Assert(Assigned(l_Node));
 SetTreeNodeImage(l_Node, imgRunning);
 if ShowTestedNodeAction.Checked then
 begin
  MakeNodeVisible(l_Node);
  TestTree.Update;
 end;
 ClearStatusMessage;
 UpdateStatus(False);
end;

procedure TGUITestRunner.EndTest(aTest: ITest);
begin
 if f_InternalStart then Exit;
 UpdateStatus(False);
end;

procedure TGUITestRunner.TestingStarts;
begin
 FTotalTime := 0;
 UpdateStatus(True);
 TProgressBarCrack(ScoreBar).Color := clOK;
 TProgressBarCrack(ScoreBar).RecreateWnd;
end;

procedure TGUITestRunner.AddSuccess(const test: ITest);
var
  OverridesGUI: Boolean;
  HasRunTimePropsSet: Boolean;
begin
  assert(assigned(test));
  if not IsTestMethod(test) then
    SetTreeNodeImage(TestToNode(Test), imgRun)
  else
  begin
    OverridesGUI :=
      ((FailIfNoChecksExecuted.Checked and not Test.FailsOnNoChecksExecuted) or
       (FailTestCaseIfMemoryLeaked.Checked and not Test.FailsOnMemoryLeak)) or
       (FailTestCaseIfMemoryLeaked.Checked and Test.IgnoreSetUpTearDownLeaks and
         not IgnoreMemoryLeakInSetUpTearDown.Checked);
    HasRunTimePropsSet :=
      ((Test.FailsOnNoChecksExecuted and not FailIfNoChecksExecuted.Checked) or
       (Test.FailsOnMemoryLeak and not FailTestCaseIfMemoryLeaked.Checked) or
       (FailTestCaseIfMemoryLeaked.Checked and Test.IgnoreSetUpTearDownLeaks) or
       (Test.AllowedMemoryLeakSize <> 0));

    if OverridesGUI then
      FTestResult.Overrides := FTestResult.Overrides + 1;

    if f_InternalStart then Exit;  
    if (WarnOnFailTestOverride.Checked and OverridesGUI) or
       (ShowTestCaseswithRunTimeProperties.Checked and HasRunTimePropsSet) then
      SetTreeNodeImage(TestToNode(Test), imgHASPROPS)
    else
      SetTreeNodeImage(TestToNode(Test), imgRun);
  end;
end;

procedure TGUITestRunner.AddError(failure: TTestFailure);
var
  ListItem: TListItem;
begin
  ListItem := AddFailureItem(failure);
  ListItem.ImageIndex := imgERROR;
  TProgressBarCrack(ScoreBar).Color := clERROR;
  TProgressBarCrack(ScoreBar).RecreateWnd;

  if f_InternalStart then Exit;
  SetTreeNodeImage(TestToNode(failure.failedTest), imgERROR);
  UpdateStatus(False);
end;

procedure TGUITestRunner.AddFailure(failure: TTestFailure);
var
  ListItem: TListItem;
begin
  ListItem := AddFailureItem(failure);
  ListItem.ImageIndex := imgFAILED;
  if TestResult.errorCount = 0 then
  begin
    TProgressBarCrack(ScoreBar).Color := clFAILURE;
    TProgressBarCrack(ScoreBar).RecreateWnd;
  end;
  if f_InternalStart then Exit;
  SetTreeNodeImage(TestToNode(failure.failedTest), imgFAILED);
  UpdateStatus(False);
end;

function TGUITestRunner.IniFileName: string;
const
  TEST_INI_FILE = 'dunit.ini';
begin
    result := ExtractFilePath(Application.ExeName) + TEST_INI_FILE
end;

procedure TGUITestRunner.LoadFormPlacement;
begin
  with GetIniFile( IniFileName ) do
  try
    Self.SetBounds(
                   ReadInteger(cnConfigIniSection, 'Left',   Left),
                   ReadInteger(cnConfigIniSection, 'Top',    Top),
                   ReadInteger(cnConfigIniSection, 'Width',  Width),
                   ReadInteger(cnConfigIniSection, 'Height', Height)
                   );
    if ReadBool(cnConfigIniSection, 'Maximized', False ) then
      WindowState := wsMaximized;
  finally
    Free;
  end;
end;

procedure TGUITestRunner.SaveFormPlacement;
begin
  with GetIniFile(IniFileName) do
    try
      WriteBool(cnConfigIniSection, 'AutoSave', AutoSaveAction.Checked);

      if WindowState <> wsMaximized then
      begin
        WriteInteger(cnConfigIniSection, 'Left',   Left);
        WriteInteger(cnConfigIniSection, 'Top',    Top);
        WriteInteger(cnConfigIniSection, 'Width',  Width);
        WriteInteger(cnConfigIniSection, 'Height', Height );
      end;

      WriteBool(cnConfigIniSection, 'Maximized', WindowState = wsMaximized );
    finally
      Free
    end;
end;

procedure TGUITestRunner.LoadConfiguration;
var
 i         : Integer;
 l_Count   : Integer;
 l_Item    : String;
 l_SelType : Integer;
begin
 LoadRegistryAction;
 LoadFormPlacement;
 LoadSuiteConfiguration;
 with GetIniFile(IniFileName) do
 try
  with AutoSaveAction do
   Checked := ReadBool(cnConfigIniSection, 'AutoSave', Checked);

  { center splitter location }
  with ResultsPanel do
   Height := ReadInteger(cnConfigIniSection, 'ResultsPanel.Height', Height);

  { error splitter location }
  with ErrorBoxPanel do
   Height := ReadInteger(cnConfigIniSection, 'ErrorMessage.Height', Height);
  with ErrorBoxVisibleAction do
   Checked := ReadBool(cnConfigIniSection, 'ErrorMessage.Visible', Checked);

  ErrorBoxSplitter.Visible := ErrorBoxVisibleAction.Checked;
  ErrorBoxPanel.Visible    := ErrorBoxVisibleAction.Checked;

  { failure list configuration }
  with FailureListView do
  for i := 0 to Columns.Count-1 do
   Columns[i].Width := Max(4, ReadInteger(cnConfigIniSection,
                                          Format('FailureList.ColumnWidth[%d]', [i]),
                                          Columns[i].Width)
                                         );

  { other options }
  acShowFolder.Checked := ReadBool(cnConfigIniSection,
    csRegistryShowFolder, acShowFolder.Checked);
  HideTestNodesOnOpenAction.Checked := ReadBool(cnConfigIniSection,
    'HideTestNodesOnOpen', HideTestNodesOnOpenAction.Checked);
  BreakOnFailuresAction.Checked := ReadBool(cnConfigIniSection,
    'BreakOnFailures', BreakOnFailuresAction.Checked);
  FailIfNoChecksExecutedAction.Checked := ReadBool(cnConfigIniSection,
    'FailOnNoChecksExecuted', FailIfNoChecksExecutedAction.Checked);
  FailTestCaseIfMemoryLeakedAction.Checked := ReadBool(cnConfigIniSection,
    'FailOnMemoryLeaked', FailTestCaseIfMemoryLeakedAction.Checked);
  IgnoreMemoryLeakInSetUpTearDownAction.Checked := ReadBool(cnConfigIniSection,
    'IgnoreSetUpTearDownLeaks', IgnoreMemoryLeakInSetUpTearDownAction.Checked);
  ReportMemoryLeakTypeOnShutdownAction.Checked := ReadBool(cnConfigIniSection,
    'ReportMemoryLeakTypes', ReportMemoryLeakTypeOnShutdownAction.Checked);
  WarnOnFailTestOverrideAction.Checked := ReadBool(cnConfigIniSection,
    'WarnOnFailTestOverride', WarnOnFailTestOverrideAction.Checked);
  ShowTestedNodeAction.Checked := ReadBool(cnConfigIniSection,
    'SelectTestedNode', ShowTestedNodeAction.Checked);
  FInitDirForExclude := ReadString(cnConfigIniSection,
    'InitDirForExclude', GetAppTestSetPath);
  FInitDirForError := ReadString(cnConfigIniSection,
    'InitDirForError', GetAppTestSetPath);
  acRandomTests.Checked := ReadBool(cnConfigIniSection,
    'RandomExecuting', False);
  LoadOperation := TLoadOperation(ReadInteger(cnConfigIniSection, 'LoadListFlagsOperation', Ord(lo_Clear)));

  acDebugger.Checked := ReadBool(cnConfigIniSection, 'ShowDebugger', True);
  
  l_Count := ReadInteger(cnConfigIniSection, 'HistorySize', 0);
  if l_Count > 0 then
   for i := 0 to l_Count - 1 do
   begin
    l_Item := ReadString(cnConfigIniSection, Format('History[%d]', [i]), '');
    if l_Item <> '' then
     evFindEdit.Items.Add(l_Item);
   end; // for i := 0 to l_Count - 1 do

  FPopupX := ReadInteger(cnConfigIniSection, 'PopupX', 350);
  FPopupY := ReadInteger(cnConfigIniSection, 'PopupY', 30);
  l_SelType := ReadInteger(cnConfigIniSection, 'SelectTestFind', 0);
  case l_SelType of
   0:;
   1: acNeedSelect.Checked := True;
   2: acNeedSelectAll.Checked := True;
  end; // case l_SelType of
 finally
  Free;
 end;

 if Suite <> nil then
   UpdateTestTreeState;
end;

procedure TGUITestRunner.AutoSaveConfiguration;
begin
  if AutoSaveAction.Checked then
    SaveConfiguration;
end;

procedure TGUITestRunner.SaveConfiguration;
var
  i         : Integer;
  l_SelType : Integer;
begin
 if Suite <> nil then
  Suite.SaveConfiguration(IniFileName, UseRegistryAction.Checked, True);

 SaveFormPlacement;
 SaveRegistryAction;

 with GetIniFile(IniFileName) do
  try
   { center splitter location }
   WriteInteger(cnConfigIniSection, 'ResultsPanel.Height', ResultsPanel.Height);

    { error box }
   WriteInteger(cnConfigIniSection, 'ErrorMessage.Height', ErrorBoxPanel.Height);
   WriteBool(cnConfigIniSection, 'ErrorMessage.Visible', ErrorBoxVisibleAction.Checked);

   { failure list configuration }
   with FailureListView do
    for i := 0 to Columns.Count - 1 do
     WriteInteger(cnConfigIniSection,
                  Format('FailureList.ColumnWidth[%d]', [i]),
                  Columns[i].Width);

    { other options }
   WriteBool(cnConfigIniSection, csRegistryShowFolder,       acShowFolder.Checked);
   WriteBool(cnConfigIniSection, 'HideTestNodesOnOpen',      HideTestNodesOnOpenAction.Checked);
   WriteBool(cnConfigIniSection, 'BreakOnFailures',          BreakOnFailuresAction.Checked);
   WriteBool(cnConfigIniSection, 'FailOnNoChecksExecuted',   FailIfNoChecksExecutedAction.Checked);
   WriteBool(cnConfigIniSection, 'FailOnMemoryLeaked',       FailTestCaseIfMemoryLeakedAction.Checked);
   WriteBool(cnConfigIniSection, 'IgnoreSetUpTearDownLeaks', IgnoreMemoryLeakInSetUpTearDownAction.Checked);
   WriteBool(cnConfigIniSection, 'ReportMemoryLeakTypes',    ReportMemoryLeakTypeOnShutdownAction.Checked);
   WriteBool(cnConfigIniSection, 'SelectTestedNode',         ShowTestedNodeAction.Checked);
   WriteBool(cnConfigIniSection, 'WarnOnFailTestOverride',   WarnOnFailTestOverrideAction.Checked);
   WriteBool(cnConfigIniSection, 'RandomExecuting',          acRandomTests.Checked);

   WriteInteger(cnConfigIniSection, 'PopupX',                FPopupX);
   WriteInteger(cnConfigIniSection, 'PopupY',                FPopupY);
   WriteInteger(cnConfigIniSection, 'LoadListFlagsOperation', Ord(LoadOperation));
   WriteString(cnConfigIniSection, 'InitDirForError',        FInitDirForError);
   WriteString(cnConfigIniSection, 'InitDirForExclude',      FInitDirForExclude);
   WriteBool(cnConfigIniSection, 'ShowDebugger', acDebugger.Checked);
   if acNeedSelect.Checked then
    l_SelType := 1
   else
    if acNeedSelectAll.Checked then
     l_SelType := 2
    else
     l_SelType := 0;
   WriteInteger(cnConfigIniSection, 'SelectTestFind', l_SelType);

   WriteInteger(cnConfigIniSection, 'HistorySize', evFindEdit.Items.Count);
   for i := 0 to evFindEdit.Items.Count - 1 do
    WriteString(cnConfigIniSection,
                Format('History[%d]', [i]),
                evFindEdit.Items[i].AsString);
  finally
   Free;
  end;
end;

procedure TGUITestRunner.TestingEnds(TestResult :TTestResult);
begin
  FTotalTime := TestResult.TotalTime;
end;

procedure TGUITestRunner.UpdateNodeState(aNode: TTreeNode);
begin
 Assert(Assigned(aNode));
 UpdateNodeImage(aNode);
 if aNode.HasChildren then
 begin
  aNode := aNode.GetFirstChild;
  while aNode <> nil do
  begin
   UpdateNodeState(aNode);
   aNode := aNode.getNextSibling;
  end;
 end;
end;

procedure TGUITestRunner.SetNodeState(aNode: TTreeNode; anEnabled: Boolean);
var
 l_Test              : ITest;
 l_MostSeniorChanged : TTreeNode;
begin
 Assert(aNode <> nil);
 // update ancestors if enabling
 SetNodeEnabled(aNode, anEnabled);
 l_MostSeniorChanged := aNode;
 if anEnabled then
 begin
  while aNode.Parent <> nil do
  begin
   aNode := aNode.Parent;
   if not GetNodeEnabled(aNode) then
   begin // changed
    SetNodeEnabled(aNode, True);
    l_MostSeniorChanged := aNode;
    UpdateNodeImage(aNode);
   end
  end;
 end;
 TestTree.Items.BeginUpdate;
 try
   UpdateNodeState(l_MostSeniorChanged);
 finally
   TestTree.Items.EndUpdate;
 end
end;

procedure TGUITestRunner.SwitchNodeState(aNode: TTreeNode);
begin
 Assert(aNode <> nil);
 SetNodeState(aNode, not GetNodeEnabled(aNode));
end;

procedure TGUITestRunner.UpdateTestTreeState;
var
  node :TTreeNode;
begin
  if TestTree.Items.Count > 0 then
  begin
    TestTree.Items.BeginUpdate;
    try
      node := TestTree.Items.GetFirstNode;
      while node <> nil do
      begin
        UpdateNodeState(node);
        node := node.getNextSibling;
      end
    finally
      TestTree.Items.EndUpdate;
    end;
  end;
end;

procedure TGUITestRunner.UpdateStatus(const fullUpdate:Boolean);
var
  i :Integer;
  TestNumber: Integer;

   function FormatElapsedTime(milli: Int64):string;
   var
     h,nn,ss,zzz: Cardinal;
   begin
     h := milli div 3600000;
     milli := milli mod 3600000;
     nn := milli div 60000;
     milli := milli mod 60000;
     ss := milli div 1000;
     milli := milli mod 1000;
     zzz := milli;
     Result := Format('%d:%2.2d:%2.2d.%3.3d', [h, nn, ss, zzz]);
   end;
begin
  if ResultsView.Items.Count = 0 then
    Exit;

  if fullUpdate then
  begin
    FTotalTestsCount := Suite.countEnabledTestCases;
    if Assigned(Suite) then
      ResultsView.Items[0].SubItems[0] := IntToStr(FTotalTestsCount)
    else
      ResultsView.Items[0].SubItems[0] := '';
  end;
  
  if TestResult <> nil then
  begin
    // Save the test number as we use it a lot
    TestNumber := TestResult.runCount;

    if fullUpdate or FTimerExpired or ((TestNumber and 15) = 0) then
    begin
      with ResultsView.Items[0] do
      begin
        SubItems[1] := IntToStr(TestNumber);
        SubItems[2] := IntToStr(TestResult.failureCount);
        SubItems[3] := IntToStr(TestResult.errorCount);
        SubItems[4] := IntToStr(TestResult.Overrides);
        SubItems[5] := FormatElapsedTime(TestResult.TotalTime);
        SubItems[6] := FormatElapsedTime(max(TestResult.TotalTime, FTotalTime));
      end;
      with TestResult do
      begin
        ScoreBar.Position  := TestNumber - (failureCount + errorCount);
        ProgressBar.Position := TestNumber;

        // There is a possibility for zero tests
        if (TestNumber = 0) and (Suite.CountEnabledTestCases = 0) then
          LbProgress.Caption := '100%'
        else
          LbProgress.Caption := IntToStr((100 * ScoreBar.Position) div ScoreBar.Max) + '%';
      end;
      if FTimerExpired and (TestNumber < FTotalTestsCount) then
      begin
        FTimerExpired := False;
        FUpdateTimer.Enabled := True;
      end;
    end;
    // Allow just the results pane to catch up

    ResultsPanel.Update;
  end
  else
  begin
    with ResultsView.Items[0] do
    begin
      if (SubItems[0] = '0') or (subItems[0] = '') then
      begin
        for i := 1 to 6 do
          SubItems[i] := ''
      end
      else
      begin
        if SubItems[0] <> subItems[1] then
          for i := 1 to 6 do
            SubItems[i] := ''
        else
        begin
          SubItems[5] := FormatElapsedTime(SelectedTest.ElapsedTestTime);
          SubItems[6] := FormatElapsedTime(Max(SelectedTest.ElapsedTestTime, FTotalTime));
        end;
      end;
    end;

    ResetProgress;
  end;

  if fullUpdate then
  begin
    // Allow the whole display to catch up and check for key strokes

    Update;
    Application.ProcessMessages;
  end;
end;

procedure TGUITestRunner.ResetProgress;
begin
  TProgressBarCrack(ScoreBar).ParentColor := True;
  TProgressBarCrack(ScoreBar).RecreateWnd;
  ScoreBar.Position := 0;
  ProgressBar.Position := 0;
  LbProgress.Caption := '';
end;

function TGUITestRunner.AddFailureItem(failure: TTestFailure): TListItem;
var
 item : TListItem;
 node : TTreeNode;
begin
 assert(assigned(failure));
 item := FailureListView.Items.Add;
 if not f_InternalStart then
  item.data := Pointer(TestToNode(failure.failedTest));
 item.Caption := failure.failedTest.Name;
 item.SubItems.Add(failure.thrownExceptionName);
 item.SubItems.Add(failure.thrownExceptionMessage);
 item.SubItems.Add( failure.LocationInfo
                    + ' ' +
                    failure.AddressInfo
                    );
 item.SubItems.Add(failure.StackTrace);

 if not f_InternalStart then
 begin
  node := testToNode(failure.failedTest);
  while node <> nil do
  begin
   node.Expand(false);
   node := node.Parent;
  end;
 end; // if not f_InternalStart then
 Result := item;
end;

procedure TGUITestRunner.FillTestTree(RootNode: TTreeNode; ATest: ITest);
var
 i            : Integer;
 l_FolderNode : TTreeNode;
 l_TestTests  : IInterfaceList;
begin
 if ATest = nil then Exit;
 if acShowFolder.Checked then
  l_FolderNode := AddFolderNode(TestTree, RootNode, ATest.Folder)
 else
  l_FolderNode := RootNode;

 RootNode := TestTree.Items.AddChild(l_FolderNode, ATest.GetDisplayName);
 RootNode.Data := TObject(FTests.Add(ATest));

 l_TestTests := ATest.Tests;
 for i := 0 to l_TestTests.count - 1 do
  FillTestTree(RootNode, l_TestTests[i] as ITest);
end;

procedure TGUITestRunner.FillTestTree(ATest: ITest);
begin
 TestTree.Items.Clear;
 FTests.Clear;
 FillTestTree(nil, Suite);
end;

procedure TGUITestRunner.SetTreeNodeImage(Node :TTReeNode; imgIndex :Integer);
begin
  while Node <> nil do
  begin
    if imgIndex > Node.ImageIndex then
    begin
       Node.ImageIndex    := imgIndex;
       Node.SelectedIndex := imgIndex;
    end;
    if imgIndex = imgRunning then
      Node := nil
    else
      Node := Node.Parent;
  end;
end;

procedure TGUITestRunner.SetSuite(value: ITest);
begin
  FSuite := value;
  if FSuite <> nil then
  begin
    LoadSuiteConfiguration;
    EnableUI(True);
    InitTree;
  end
  else
    EnableUI(False)
end;

procedure TGUITestRunner.DisplayFailureMessage(Item: TListItem);
var
 l_Color  : TColor;
 l_Test   : ITest;
 l_Status : string;
begin
 TestTree.Selected := TTreeNode(Item.Data);
 if TestTree.Selected = nil then Exit;
 l_Test := NodeToTest(TestTree.Selected);
 if l_Test = nil then Exit;
 l_Color := clFAILURE;
 if Item.ImageIndex >= imgERROR then l_Color := clERROR;
 with ErrorMessageRTF do
 begin
  Clear;
  SelAttributes.Size  := Self.Font.Size;
  SelAttributes.Style := [fsBold];
  SelText := Item.Caption + ': ';

  SelAttributes.Color := l_Color;
  SelAttributes.Style := [fsBold];
  SelText := Item.SubItems[0];

  Lines.Add('');
  SelAttributes.Color := clWindowText;
  SelAttributes.Style := [];
  SelText := 'at ' + Item.SubItems[2];

  if Item.SubItems[1] <> '' then
  begin
   SelAttributes.Color := clWindowText;
   Lines.Add('');
   SelAttributes.Size  := 12;
   SelAttributes.Style := [];
   SelText := Item.SubItems[1];
   SelAttributes.Size  := self.Font.Size;
  end;

  l_Status := l_Test.Status;
  if l_Status <> '' then
  begin
   Lines.Add('');
   Lines.Add('');
   SelAttributes.Style := [fsBold];
   Lines.Add('Status Messages');
   SelAttributes.Style := [];
   Lines.Add(l_Status);
  end;

  if Item.SubItems[3] <> '' then
  begin
   Lines.Add('');
   SelAttributes.Style := [fsBold];
   Lines.Add('StackTrace');
   SelAttributes.Style := [];
   SelText := Item.SubItems[3];
  end;
 end
end;

procedure TGUITestRunner.ClearFailureMessage;
begin
 ErrorMessageRTF.Clear;
end;

procedure TGUITestRunner.ClearResult;
begin
 if FTestResult <> nil then
 begin
  FTestResult.Free;
  FTestResult := nil;
  ClearFailureMessage;
 end;
end;

procedure TGUITestRunner.SetUp;
var
  i: Integer;
  node: TTreeNode;
begin
  FailureListView.Items.Clear;
  ResetProgress;
  Update;

  if (ResultsView.Items[0] <> nil) then
   with ResultsView.Items[0] do
   begin
     if Suite <> nil then
     begin
       i := Suite.countEnabledTestCases;
       SubItems[0] := IntToStr(i);
       ProgressBar.Max := i
     end
     else
     begin
       SubItems[0] := '';
       ProgressBar.Max:= 10000;
     end;
     ScoreBar.Max := ProgressBar.Max;

     SubItems[1] := '';
     SubItems[2] := '';
     SubItems[3] := '';
     SubItems[4] := '';
     SubItems[5] := '';
     SubItems[6] := '';
   end;//ResultsView.Items[0]

  for i := 0 to TestTree.Items.Count - 1 do
  begin
    node := TestTree.Items[i];
    node.ImageIndex    := imgNONE;
    node.SelectedIndex := imgNONE;
  end;
  UpdateTestTreeState;
end;

procedure TGUITestRunner.EnableUI(enable: Boolean);
begin
  SelectAllAction.Enabled    := enable;
  DeselectAllAction.Enabled  := enable;
  SelectFailedAction.Enabled := enable;
  SelectCurrentAction.Enabled := enable;
  DeselectCurrentAction.Enabled := enable;
  HideTestNodesAction.Enabled   := enable;
  ExpandAllNodesAction.Enabled  := enable;
end;

procedure TGUITestRunner.FormCreate(Sender: TObject);
begin
 inherited;
 InitLogicalOperation;
 FWasStarted := False;
 acShowFolder.Checked := False;
 FTests := TInterfaceList.Create;
 LoadConfiguration;

 {$IfDef XE}
 {$Else}
 TimeSeparator := ':';
 {$EndIf}
 SetUpStateImages;
 SetupCustomShortcuts;
 TestTree.Items.Clear;
 EnableUI(false);
 ClearFailureMessage;
 FUpdateTimer := TTimer.Create(Self);
 FUpdateTimer.Interval := 200;
 FUpdateTimer.Enabled := False;
 FUpdateTimer.OnTimer := OnUpdateTimer;
 Setup;

 {$IFDEF VER180} //FastMM built in already
   FailTestCaseIfMemoryLeakedAction.Enabled := True;
   ReportMemoryLeaksOnShutdown := ReportMemoryLeakTypeOnShutdownAction.Checked;
 {$ELSE}
   {$IFDEF FASTMM}
     FailTestCaseIfMemoryLeakedAction.Enabled := True;
     {$IFDEF ManualLeakReportingControl}
       ReportMemoryLeaksOnShutdown := ReportMemoryLeakTypeOnShutdownAction.Checked;
     {$ELSE}
       ReportMemoryLeakTypeOnShutdownAction.Checked := False;
       ReportMemoryLeakTypeOnShutdownAction.Enabled := False;
     {$ENDIF}
   {$ELSE}
     FailTestCaseIfMemoryLeakedAction.Enabled := False;
     ReportMemoryLeakTypeOnShutdownAction.Checked := False;
     ReportMemoryLeakTypeOnShutdownAction.Enabled := False;
   {$ENDIF}
 {$ENDIF}
 if not FailTestCaseIfMemoryLeakedAction.Enabled then
   FailTestCaseIfMemoryLeakedAction.Checked := False;
 IgnoreMemoryLeakInSetUpTearDownAction.Enabled :=
   FailTestCaseIfMemoryLeakedAction.Checked;
 if not IgnoreMemoryLeakInSetUpTearDownAction.Enabled then
   IgnoreMemoryLeakInSetUpTearDownAction.Checked := False;
 evFindEdit.TextSource.Document.IsValid;
 FTestTreeSeacher := TTestTreeSeacher.Create(TestTree.Items);
 {$IFNDEF Archi}
 ClearDBBtn.Visible := False;
 {$ENDIF Archi}
 {$IfDef InsiderTest}
 BorderIcons := BorderIcons - [biSystemMenu];
 DefaultMonitor := dmDesktop;
 RunScriptAction.OnUpdate := RunScriptActionUpdate;
 {$EndIf InsiderTest}
 LoadDictionariesMenu;
 ReadSubDirs(PresetsPM, csPresetsExt, csPresetsSubDir, OnSelectPreset);
 ReadSubDirs(MacrosPM, csMacrosExt, csMacrosSubDir, OnSelectMacros);
 FClearEtalonPM := nil;
 {$IfNDef NoScripts}
 LinkTestForm(Self);
 {$EndIf  NoScripts}
end;

procedure TGUITestRunner.FormDestroy(Sender: TObject);
begin
 FreeAndNil(FUpdateTimer);
 ClearResult;
 AutoSaveConfiguration;
 Suite := nil;
 FTests.Free;
 FTests := nil;
 FClearEtalonPM := nil;
 FreeAndNil(FTestTreeSeacher);
 {$IfNDef NoScripts}
 UnLinkTestForm;
 {$EndIf  NoScripts}
 inherited;
end;

procedure TGUITestRunner.FormShow(Sender: TObject);
begin
  { Set up the GUI nodes in the test nodes. We do it here because the form,
    the tree and all its tree nodes get recreated in TCustomForm.ShowModal
    in D8+ so we cannot do it sooner. }

  SetupGUINodes;
  CheckStartParams;
end;

procedure TGUITestRunner.TestTreeClick(Sender: TObject);
begin
 if FRunning then Exit;
 ProcessClickOnStateIcon;
 TestTreeChange(Sender, TestTree.Selected);
end;

procedure TGUITestRunner.TestTreeChange(Sender: TObject; Node: TTreeNode);
var
 i : Integer;
begin
 if (Node <> nil) and (Node = TestTree.Selected) then
 begin
  FailureListView.Selected := nil;
  for i := 0 to FailureListView.Items.Count - 1 do
  begin
   if TTreeNode(FailureListView.Items[i].Data) = Node then
   begin
    FailureListView.Selected := FailureListView.Items[i];
    Break;
   end;
  end;
  UpdateStatus(True);
 end;
end;

procedure TGUITestRunner.FailureListViewClick(Sender: TObject);
begin
 if FailureListView.Selected <> nil then
  TestTree.Selected := TTreeNode(FailureListView.Selected.data);
end;

procedure TGUITestRunner.FailureListViewSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
 if not Selected then
  ClearFailureMessage
 else
  DisplayFailureMessage(Item);
end;

function TGUITestRunner.DisableTest(aTest: ITest): Boolean;
begin
 if aTest <> nil then
  aTest.Enabled := False;
 Result := True;
end;

function TGUITestRunner.EnableTest(aTest: ITest): Boolean;
begin
 if aTest <> nil then
  aTest.Enabled := True;
 Result := True;
end;

procedure TGUITestRunner.ApplyToTests(aRoot :TTreeNode; const aFunc :TTestFunc; aStopOnSelect: Boolean);
var
 l_NeedStop: Boolean;

 procedure lp_DoApply(aRootNode: TTreeNode);
 var
   l_Test: ITest;
   l_Node: TTreeNode;
 begin
  if aRootNode <> nil then
  begin
   l_Test := NodeToTest(aRootNode);
   if aFunc(l_Test) then
   begin
    l_Node := aRootNode.GetFirstChild;
    while l_Node <> nil do
    begin
     lp_DoApply(l_Node);
     if aStopOnSelect and ((TestTree.Selected = l_Node) or l_NeedStop) then
     begin
      l_NeedStop := True;
      Break;
     end; // if aStopOnSelect and ((TestTree.Selected = l_Node) or l_NeedStop) then
     l_Node := l_Node.GetNextSibling;
    end; // while l_Node <> nil do
   end; // if aFunc(l_Test) then
  end; // if aRootNode <> nil then
 end;

begin
 TestTree.Items.BeginUpdate;
 try
  l_NeedStop := False;
  lp_DoApply(aRoot)
 finally
  TestTree.Items.EndUpdate
 end;
 UpdateTestTreeState;
end;

procedure TGUITestRunner.TestTreeKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = ' ') and (TestTree.Selected <> nil) then
 begin
  SwitchNodeState(TestTree.Selected);
  UpdateStatus(True);
  Key := #0
 end;
end;

procedure TGUITestRunner.SelectAllActionExecute(Sender: TObject);
begin
 ClearTestNamesList;
 ApplyToTests(TestTree.Items.GetFirstNode, EnableTest, False);
 UpdateStatus(True);
end;

procedure TGUITestRunner.DeselectAllActionExecute(Sender: TObject);
begin
 ClearTestNamesList;
 DoDeselectAllActionExecute(Sender);
end;

procedure TGUITestRunner.SelectFailedActionExecute(Sender: TObject);
var
  i      : Integer;
  l_Node : TTreeNode;
begin
 { deselect all }
 ApplyToTests(TestTree.Items[0], DisableTest, False);

 { select failed }
 for i := 0 to FailureListView.Items.Count - 1 do
 begin
  l_Node := TTreeNode(FailureListView.Items[i].Data);
  SetNodeState(l_Node, True);
 end;
 UpdateStatus(True);
end;

procedure TGUITestRunner.SaveConfigurationActionExecute(Sender: TObject);
begin
 SaveConfiguration
end;

procedure TGUITestRunner.RestoreSavedActionExecute(Sender: TObject);
begin
 LoadConfiguration
end;

procedure TGUITestRunner.AutoSaveActionExecute(Sender: TObject);
begin
 with AutoSaveAction do
  Checked := not Checked;
 AutoSaveConfiguration;
end;

procedure TGUITestRunner.ErrorBoxVisibleActionExecute(Sender: TObject);
begin
 with ErrorBoxVisibleAction do
 begin
  Checked := not Checked;
  ErrorBoxSplitter.Visible := Checked;
  ErrorBoxPanel.Visible    := Checked;
  if Checked then
  begin
   // Solve bugs with Delphi4 resizing with constraints
   ErrorBoxSplitter.Top := ErrorBoxPanel.Top - 8;
  end
 end;
end;

procedure TGUITestRunner.ErrorBoxSplitterMoved(Sender: TObject);
begin
 // Solve bugs with Delphi4 resizing with constraints
 ErrorBoxSplitter.Top := ErrorBoxPanel.Top - 8;
 Self.Update;
end;

procedure TGUITestRunner.ErrorBoxPanelResize(Sender: TObject);
begin
 // Solve bugs with Delphi4 resizing with constraints
 ErrorBoxSplitter.Top := ErrorBoxPanel.Top - 8;
end;

function TGUITestRunner.NodeIsGrandparent(aNode: TTreeNode): Boolean;
var
 l_ChildNode: TTreeNode;
begin
 Result := False;
 if IsNodeFolder(aNode) then Exit;
 if aNode.HasChildren then
 begin
  l_ChildNode := aNode.GetFirstChild;
  while l_ChildNode <> nil do
  begin
   Result := l_ChildNode.HasChildren or Result;
   l_ChildNode := aNode.GetNextChild(l_ChildNode);
  end;
 end;
end;

procedure TGUITestRunner.CollapseNonGrandparentNodes(aRootNode: TTreeNode);
var
 l_ChildNode: TTreeNode;
begin
 if not NodeIsGrandparent(aRootNode) then
  aRootNode.Collapse(false);

 l_ChildNode := aRootNode.GetFirstChild;
 while l_ChildNode <> nil do
 begin
  CollapseNonGrandparentNodes(l_ChildNode);
  l_ChildNode := aRootNode.GetNextChild(l_ChildNode);
 end;
end;

procedure TGUITestRunner.HideTestNodesActionExecute(Sender: TObject);
var
 l_Node: TTreeNode;
begin
 inherited;
 if TestTree.Items.Count = 0 then Exit;

 TestTree.Items.BeginUpdate;
 try
  l_Node := TestTree.Items[0];
  if l_Node <> nil then
  begin
   l_Node.Expand(true);
   CollapseNonGrandparentNodes(l_Node);
   SelectNode(l_Node);
  end;
 finally
  TestTree.Items.EndUpdate;
 end;
end;

procedure TGUITestRunner.HideTestNodesOnOpenActionExecute(Sender: TObject);
begin
 HideTestNodesOnOpenAction.Checked := not HideTestNodesOnOpenAction.Checked;
end;

procedure TGUITestRunner.ExpandAllNodesActionExecute(Sender: TObject);
begin
 TestTree.FullExpand;
 if (TestTree.Selected <> nil) then
   MakeNodeVisible(TestTree.Selected)
 else if(TestTree.Items.Count > 0) then
   TestTree.Selected := TestTree.Items[0];
end;

procedure TGUITestRunner.RunTheTest(aTest: ITest; aRandom: Boolean);
begin
 if aTest = nil then Exit;
 if FRunning then
 begin
  // warning: we're reentering this method if FRunning is true
  Assert(FTestResult <> nil);
  FTestResult.Stop;
  Exit;
 end;

 afw.TryActivateKeyboardLayout;
 Tl3BatchService.Instance.EnterBatchMode;
 try
  FRunning := True;
  try
   RunAction.Enabled  := False;
   StopAction.Enabled := True;
   CopyMessageToClipboardAction.Enabled := False;

   EnableUI(False);
   AutoSaveConfiguration;
   ClearResult;
   TestResult := TTestResult.Create;
   try
    TestResult.addListener(self);
    TestResult.BreakOnFailures := BreakOnFailuresAction.Checked;
    TestResult.FailsIfNoChecksExecuted := FailIfNoChecksExecutedAction.Checked;
    TestResult.FailsIfMemoryLeaked := FailTestCaseIfMemoryLeakedAction.Checked;
    TestResult.IgnoresMemoryLeakInSetUpTearDown := IgnoreMemoryLeakInSetUpTearDownAction.Checked;
    aTest.Run(TestResult, aRandom);
   finally
    FErrorCount := TestResult.ErrorCount;
    FFailureCount := TestResult.FailureCount;
    TestResult.Free;
    TestResult := nil;
   end;
  finally
   FRunning := False;
   EnableUI(True);
  end;
 finally
  Tl3BatchService.Instance.LeaveBatchMode;
 end;//try..finally
end;

procedure TGUITestRunner.RunActionExecute(Sender: TObject);
begin
 f_InternalStart := False;
 if Suite = nil then Exit;
 Setup;
 RunTheTest(Suite, acRandomTests.Checked);
end;

procedure TGUITestRunner.ExitActionExecute(Sender: TObject);
begin
 if FTestResult <> nil then FTestResult.Stop;
 Self.ModalResult := mrCancel;
 Close;
end;

procedure TGUITestRunner.BreakOnFailuresActionExecute(Sender: TObject);
begin
 with BreakOnFailuresAction do
  Checked := not Checked;
end;

procedure TGUITestRunner.FailIfNoChecksExecutedActionExecute(Sender: TObject);
begin
 with FailIfNoChecksExecutedAction do
  Checked := not Checked;
end;

procedure TGUITestRunner.FailTestCaseIfMemoryLeakedActionExecute(Sender: TObject);
begin
 with FailTestCaseIfMemoryLeakedAction do
 begin
  Checked := not Checked;
  IgnoreMemoryLeakInSetUpTearDownAction.Enabled := Checked;
  if not Checked then
   IgnoreMemoryLeakInSetUpTearDownAction.Checked := False;
 end;
end;

procedure TGUITestRunner.ShowTestCasesWithRunTimePropertiesActionExecute(
  Sender: TObject);
begin
 with ShowTestCasesWithRunTimePropertiesAction do
 begin
  Checked := not Checked;
  if Checked then
   WarnOnFailTestOverrideAction.Checked := False;
 end;
end;

procedure TGUITestRunner.WarnOnFailTestOverrideActionExecute(
  Sender: TObject);
begin
 with WarnOnFailTestOverrideAction do
 begin
  Checked := not Checked;
  if Checked then
   ShowTestCasesWithRunTimePropertiesAction.Checked := False;
 end;
end;

procedure TGUITestRunner.ShowTestedNodeActionExecute(Sender: TObject);
begin
 with ShowTestedNodeAction do
  Checked := not Checked;
end;

procedure TGUITestRunner.SetUpStateImages;
begin
 TestTree.Images             := RunImages;
 TestTree.StateImages        := StateImages;
 FailureListView.SmallImages := RunImages;
end;

procedure TGUITestRunner.LoadSuiteConfiguration;
begin
 if Suite <> nil then
  Suite.LoadConfiguration(IniFileName, UseRegistryAction.Checked, True);
end;

procedure TGUITestRunner.MakeNodeVisible(aNode: TTreeNode);
begin
 aNode.MakeVisible
end;

procedure TGUITestRunner.ProcessClickOnStateIcon;
var
 l_HitInfo  : THitTests;
 l_Node     : TTreeNode;
 l_PointPos : TPoint;
begin
 GetCursorPos(l_PointPos);
 l_PointPos := TestTree.ScreenToClient(l_PointPos);
 with l_PointPos do
 begin
  l_HitInfo := TestTree.GetHitTestInfoAt(X, Y);
  l_Node := TestTree.GetNodeAt(X, Y);
 end;
 if (l_Node <> nil) and (HtOnStateIcon in l_HitInfo) then
  SwitchNodeState(l_Node);
end;

procedure TGUITestRunner.UpdateNodeImage(aNode: TTreeNode);
begin
 if not GetNodeEnabled(aNode) then
  aNode.StateIndex := imgDISABLED
 else
  if (aNode.Parent <> nil) and (aNode.Parent.StateIndex <= imgPARENT_DISABLED) then
   aNode.StateIndex := imgPARENT_DISABLED
  else
   aNode.StateIndex := imgENABLED;
end;

procedure TGUITestRunner.CopyMessageToClipboardActionExecute(Sender: TObject);
begin
 ErrorMessageRTF.SelectAll;
 ErrorMessageRTF.CopyToClipboard;
end;

procedure TGUITestRunner.UseRegistryActionExecute(Sender: TObject);
begin
 with UseRegistryAction do
  Checked := not Checked;
end;

function TGUITestRunner.GetIniFile(const FileName: string) : tCustomIniFile;
begin
 if UseRegistryAction.Checked then
   Result := TRegistryIniFile.Create(GetDUnitRegistryKey + FileName)
 else
   Result := TIniFile.Create(FileName);
end;

procedure TGUITestRunner.LoadRegistryAction;
begin
 with TIniFile.Create(IniFileName) do
  try
   UseRegistryAction.Checked := ReadBool(cnConfigIniSection,
     'UseRegistry', UseRegistryAction.Checked);
  finally
   Free;
  end;
end;

procedure TGUITestRunner.SaveRegistryAction;
begin
  if UseRegistryAction.Checked then
    DeleteFile( IniFileName );

  with TIniFile.Create(IniFileName) do
  try
    WriteBool(cnConfigIniSection, 'UseRegistry', UseRegistryAction.Checked);
  finally
    Free;
  end;
end;

procedure TGUITestRunner.RunActionUpdate(Sender: TObject);
begin
 RunAction.Enabled := not FRunning and Assigned( Suite ) and (Suite.CountEnabledTestCases > 0);
end;

procedure TGUITestRunner.CopyMessageToClipboardActionUpdate(Sender: TObject);
begin
 CopyMessageToClipboardAction.Enabled := FailureListView.Selected <> nil;
end;

procedure TGUITestRunner.SelectCurrentActionExecute(Sender: TObject);
begin
 ApplyToTests(TestTree.Selected, EnableTest, False);
 SetNodeState(TestTree.Selected, True);
 UpdateStatus(True);
end;

procedure TGUITestRunner.DeselectCurrentActionExecute(Sender: TObject);
begin
 ApplyToTests(TestTree.Selected, DisableTest, False);
 UpdateStatus(True);
end;

procedure TGUITestRunner.StopActionExecute(Sender: TObject);
begin
 if FTestResult <> nil then
    FTestResult.Stop;
end;

procedure TGUITestRunner.StopActionUpdate(Sender: TObject);
begin
 StopAction.Enabled := FRunning and (FTestResult <> nil);
end;

procedure TGUITestRunner.Status(test: ITest; const Msg: AnsiString);
begin
  if ErrorMessageRTF.Lines.Count = 0 then
    ErrorMessageRTF.Lines.Add(test.Name + ':');

  ErrorMessageRTF.Lines.Add(Msg);

  ErrorMessageRTF.Update;
end;

procedure TGUITestRunner.Warning(test: ITest; const Msg: string);
begin
  if ErrorMessageRTF.Lines.Count = 0 then
    ErrorMessageRTF.Lines.Add(test.Name + ':');

  ErrorMessageRTF.Lines.Add(Msg);

  ErrorMessageRTF.Update;
end;

procedure TGUITestRunner.ClearStatusMessage;
begin
  ErrorMessageRTF.Lines.Clear;
end;

procedure TGUITestRunner.CopyProcnameToClipboardActionExecute(
  Sender: TObject);
begin
  CopyTestNametoClipboard(TestTree.Selected);
end;

procedure TGUITestRunner.CopyTestNametoClipboard(ANode: TTreeNode);
begin
  if Assigned(ANode) then
  begin
    Clipboard.AsText := ANode.Text;
  end;
end;

procedure TGUITestRunner.CopyProcnameToClipboardActionUpdate(
  Sender: TObject);
begin
  (Sender as TAction).Enabled := Assigned(TestTree.Selected);
end;

function TGUITestRunner.SelectedTest: ITest;
begin
 if TestTree.Selected = nil then
  Result := nil
 else
 begin
  Result := NodeToTest(TestTree.Selected);
  if Result = nil then
   Result := NodeToTest(TestTree.Selected.Parent);
 end;
end;

procedure TGUITestRunner.ListSelectedTests;
var
 aTest: ITest;
 aNode: TTreeNode;
begin
 FSelectedTests.Free;
 FSelectedTests := nil;
 FSelectedTests := TInterfaceList.Create;

 aNode := TestTree.Selected;

 while Assigned(aNode) do
 begin
  aTest := NodeToTest(aNode);
  if aTest <> nil then
   FSelectedTests.Add(aTest as ITest);
  aNode := aNode.Parent;
 end;
end;

procedure TGUITestRunner.RunSelectedTestActionExecute(Sender: TObject);
begin
  f_InternalStart := False;
  Setup;
  ListSelectedTests;
  ProgressBar.Max := 1;
  ScoreBar.Max    := 1;
  RunTheTest(Suite, False);
  {$IFDEF VER130}
    FreeAndNil(FSelectedTests);
  {$ELSE}
    FSelectedTests.Free;
    FSelectedTests := nil;
  {$ENDIF}
end;

procedure TGUITestRunner.RunSelectedTestActionUpdate(Sender: TObject);
var
  aTest :ITest;
begin
  ATest := SelectedTest;
  RunSelectedTestAction.Enabled := (aTest <> nil) and (aTest.CountTestCases = 1);
end;

class procedure TGUITestRunner.RunTest(test: ITest);
var
  myform: TGUITestRunner;
begin
  Application.CreateForm(TGUITestRunner, MyForm);
  with MyForm do
  begin
    try
      suite := test;
      ShowModal;
    finally
      MyForm.Free;
    end;
  end;
end;

class procedure TGUITestRunner.RunRegisteredTests;
begin
  RunTest(RegisteredTests);
end;

procedure TGUITestRunner.EndSuite(suite: ITest);
begin
  UpdateStatus(True);
end;

procedure TGUITestRunner.StartSuite(suite: ITest);
begin
end;

procedure TGUITestRunner.TestTreeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  NewNode: TTreeNode;
begin
  { a version of this code was in the pmTestTreePopup event, but it created
    an intermittent bug. OnPopup is executed if any of the ShortCut keys
    belonging to items on the popup menu are used. This caused weird behavior,
    with the selected node suddenly changing to whatever was under the mouse
    cursor (or AV-ing if the mouse cursor wasn't over the DUnit form) when
    the user executed one of the keyboard shortcuts.

    It was intermittent most likely because the ShortCuts belonged to
    Main Menu items as well (shared from the Action.ShortCut), and the bug
    dependended on the Popup menu items receiving the ShortCut Windows message
    first.

    This code ensures that node selection occurs prior to the popup menu
    appearing when the user right-clicks on a non-selected tree node. }

  if (Button = mbRight) and (htOnItem in TestTree.GetHitTestInfoAt(X, Y)) then
  begin
    NewNode := TestTree.GetNodeAt(X, Y);
    if TestTree.Selected <> NewNode then
      TestTree.Selected := NewNode;
  end;
end;

procedure TGUITestRunner.GoToNextSelectedTestActionExecute(
  Sender: TObject);
var
  aNode: TTreeNode;
begin
  if TestTree.Selected <> nil then
  begin
    aNode := TestTree.Selected.GetNext;
    while aNode <> nil do
    begin
      if SelectNodeIfTestEnabled(aNode) then
        break
      else
        aNode := aNode.GetNext;
    end;
  end;
end;

function TGUITestRunner.SelectNodeIfTestEnabled(aNode: TTreeNode): boolean;
var
 l_Test: ITest;
begin
 l_Test := NodeToTest(aNode);
 if (l_Test <> nil) and (l_Test.Enabled) and (IsTestMethod(l_Test)) then
 begin
  Result := True;
  SelectNode(aNode);
 end
 else
  Result := False;
end;

procedure TGUITestRunner.GoToPrevSelectedTestActionExecute(
  Sender: TObject);
var
  aNode: TTreeNode;
begin
  if TestTree.Selected <> nil then
  begin
    aNode := TestTree.Selected.GetPrev;
    while aNode <> nil do
    begin
      if SelectNodeIfTestEnabled(aNode) then
        break
      else
        aNode := aNode.GetPrev;
    end;
  end;
end;

procedure TGUITestRunner.SelectNode(node: TTreeNode);
begin
  node.Selected := true;
  MakeNodeVisible(node);
end;

procedure TGUITestRunner.SetupCustomShortcuts;
begin
  { the following shortcuts are not offered as an option in the
    form designer, but can be set up here }
  GoToNextSelectedTestAction.ShortCut := ShortCut(VK_RIGHT, [ssCtrl]);
  GoToPrevSelectedTestAction.ShortCut := ShortCut(VK_LEFT, [ssCtrl]);
end;

procedure TGUITestRunner.SetupGUINodes;
var
 l_Node: TTreeNode;
 l_Test: ITest;
begin
 { Set up the GUI nodes in the test nodes. We do it here because the form,
   the tree and all its tree nodes get recreated in TCustomForm.ShowModal
   in D8+ so we cannot do it sooner.
   This method is also called after loading test libraries }
 l_Node := TestTree.Items.GetFirstNode;
 while Assigned(l_Node) do
 begin
  // Get and check the test for the tree node
  l_Test := NodeToTest(l_Node);
  if l_Test <> nil then
   // Save the tree node in the test and get the next tree node
   l_Test.GUIObject := l_Node;
  l_Node := l_Node.GetNext;
 end;
end;

const
  PopupTitle   = 'TestCase Run-Time Applied Properties';
  PopupPrevious= ' Previous';
  PopupRun     = ' Run Selected Test';
  PopupNext    = ' Next';
  NoChecksStrT = ' FailsOnNoChecksExecuted  := True ';
  NoChecksStrF = ' FailsOnNoChecksExecuted  := False';
  MemLeakStrT  = ' FailsOnMemoryLeak        := True ';
  MemLeakStrF  = ' FailsOnMemoryLeak        := False';
  MemGainStrT  = ' FailsOnMemoryRecovery    := True ';
  MemGainStrF  = ' FailsOnMemoryRecovery    := False';
  MemBytesStr0 = ' AllowedMemoryLeakSize '           ;
  IgnoreStrT   = ' IgnoreSetUpTearDownLeaks := True ';
  IgnoreStrF   = ' IgnoreSetUpTearDownLeaks := False';

procedure TGUITestRunner.TestCasePropertiesActionExecute(Sender: TObject);
var
 l_Node: TTreeNode;
 l_Test: ITest;
begin
 if TestTree.Selected <> nil then
 begin
  l_Node := TestTree.Selected;
  if (l_Node <> nil) then
  begin
   l_Test := NodeToTest(l_Node);
   if (l_Test <> nil) and IsTestMethod(l_Test) then
   begin
    if l_Test.FailsOnNoChecksExecuted then
      FNoChecksStr := NoChecksStrT
    else
      FNoChecksStr := NoChecksStrF;
    fNoCheckExecutedPtyOverridden := FailIfNoChecksExecutedAction.Checked and
      (not l_Test.FailsOnNoChecksExecuted);

    if l_Test.FailsOnMemoryLeak then
      FMemLeakStr := MemLeakStrT
    else
      FMemLeakStr := MemLeakStrF;
    fMemLeakDetectedPtyOverridden := FailTestCaseIfMemoryLeakedAction.Checked and
      (not l_Test.FailsOnMemoryLeak);
    if (l_Test.FailsOnMemoryLeak and l_Test.FailsOnMemoryRecovery) then
      FMemGainStr := MemGainStrT
    else
      FMemGainStr := MemGainStrF;

    if (l_Test.IgnoreSetUpTearDownLeaks) and l_Test.FailsOnMemoryLeak then
      FIgnoreLeakStr := IgnoreStrT
    else
      FIgnoreLeakStr := IgnoreStrF;
    FIgnoreSetUpTearDownLeakPtyOverridden := l_Test.IgnoreSetUpTearDownLeaks and
      l_Test.FailsOnMemoryLeak and (not IgnoreMemoryLeakInSetUpTearDownAction.Checked);

    FBytes := ':= ' + IntToStr(l_Test.AllowedMemoryLeakSize) + ' Bytes';
    FMemBytesStr := MemBytesStr0 + FBytes;
    TestCaseProperty.Popup(Self.Left + FPopupX,Self.Top + FPopupY);
   end; // if IsTestMethod(l_Test) then
  end;
  l_Test := nil;
 end;
end;

procedure TGUITestRunner.Previous1Click(Sender: TObject);
begin
  GoToPrevSelectedTestActionExecute(Self);
  TestCasePropertiesActionExecute(self);
end;

procedure TGUITestRunner.Next1Click(Sender: TObject);
begin
  GoToNextSelectedTestActionExecute(Self);
  TestCasePropertiesActionExecute(self);
end;

procedure TGUITestRunner.TestCasePropertiesMeasureItem(Sender: TObject;
  ACanvas: TCanvas; var Width, Height: Integer);
var
  ImageSize: TSize;
begin
  if GetTextExtentPoint32(ACanvas.Handle,
                          PChar(PopupTitle),
                          Length(PopupTitle),
                          ImageSize) then
  begin
    Width  := ImageSize.cx + 60;
    Height := ImageSize.cy + 4;
  end;
end;

procedure TGUITestRunner.MenuLooksInactive(ACanvas: TCanvas;
                                           ARect: TRect;
                                           Selected: Boolean;
                                           ATitle: string;
                                           TitlePosn: UINT;
                                           PtyOveridesGUI: boolean);
var
  Count: integer;
  SecondPart: string;
  SecondRect: TRect;
begin
  if TitlePosn = DT_CENTER then
    ACanvas.Font.Style := [fsBold];
  if Selected then
    ACanvas.Font.Color := clBlack;
  if PtyOveridesGUI then
    ACanvas.Brush.Color := clYellow
  else
    ACanvas.Brush.Color := TColor($C0FCC0);  //Sort of Moneygreen
  ACanvas.FillRect(ARect);
  Count := Pos(':=', ATitle);
  if Count = 0 then
    DrawText(ACanvas.Handle,
             PChar(ATitle),
             Length(ATitle),
             ARect,
             DT_VCENTER or DT_SINGLELINE or DT_NOCLIP or DT_NOPREFIX or TitlePosn)
  else
  begin
    DrawText(ACanvas.Handle,
             PChar(ATitle),
             Count-1,
             ARect,
             DT_VCENTER or DT_SINGLELINE or DT_NOCLIP or DT_NOPREFIX or TitlePosn);

    SecondPart := Copy(ATitle, Count, Length(ATitle));
    SecondRect := ARect;
    SecondRect.Left := 5 * ((ARect.Right - ARect.Left) div 8);
    DrawText(ACanvas.Handle,
             PChar(SecondPart),
             Length(SecondPart),
             SecondRect,
             DT_VCENTER or DT_SINGLELINE or DT_NOCLIP or DT_NOPREFIX or TitlePosn)
  end;
end;

procedure TGUITestRunner.MenuLooksActive(ACanvas: TCanvas;
                                         ARect: TRect;
                                         Selected: Boolean;
                                         ATitle: string;
                                         TitlePosn: UINT);
begin
  ACanvas.FillRect(ARect);
  DrawText(ACanvas.Handle,
           PChar(ATitle),
           Length(ATitle),
           ARect,
           DT_VCENTER or DT_SINGLELINE or DT_NOCLIP or DT_NOPREFIX or TitlePosn);
end;

procedure TGUITestRunner.TestCasePropertiesDrawItem(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
begin
  MenuLooksInactive(ACanvas, ARect, Selected, PopupTitle, DT_CENTER, False);
end;

procedure TGUITestRunner.Previous1DrawItem(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
begin
  MenuLooksActive(ACanvas, ARect, Selected, PopupPrevious, DT_LEFT);
end;

procedure TGUITestRunner.RunSelectedTest1DrawItem(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
begin
  MenuLooksActive(ACanvas, ARect, Selected, PopupRun, DT_LEFT);
end;

procedure TGUITestRunner.Next1DrawItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; Selected: Boolean);
begin
  MenuLooksActive(ACanvas, ARect, Selected, PopupNext, DT_LEFT);
end;

procedure TGUITestRunner.FailNoCheckExecutedMenuItemDrawItem(
  Sender: TObject; ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
begin
  MenuLooksInactive(ACanvas, ARect, Selected, FNoChecksStr,
    DT_LEFT, fNoCheckExecutedPtyOverridden);
end;

procedure TGUITestRunner.FailsOnMemoryLeakMenuItemDrawItem(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
begin
  MenuLooksInactive(ACanvas, ARect, Selected, FMemLeakStr,
    DT_LEFT, fMemLeakDetectedPtyOverridden);
end;

procedure TGUITestRunner.FailsOnMemoryRecoveryMenuItemDrawItem(
  Sender: TObject; ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
begin
  MenuLooksInactive(ACanvas, ARect, Selected, FMemGainStr,
    DT_LEFT, False);
end;

procedure TGUITestRunner.AllowedLeakSizeMemuItemDrawItem(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
begin
  MenuLooksInactive(ACanvas, ARect, Selected, FMemBytesStr, DT_LEFT, False);
end;

procedure TGUITestRunner.TestCaseIgnoreSetUpTearDownLeaksMenuItemDrawItem(
  Sender: TObject; ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
begin
  MenuLooksInactive(ACanvas, ARect, Selected, FIgnoreLeakStr,
    DT_LEFT, FIgnoreSetUpTearDownLeakPtyOverridden);
end;

procedure TGUITestRunner.pmTestTreePopup(Sender: TObject);
var
 l_Node: TTreeNode;
 l_Test: ITest;
begin
 if TestTree.Selected <> nil then
 begin
  l_Node := TestTree.Selected;
  if (l_Node <> nil) then
  begin
   l_Test := NodeToTest(l_Node);
   TestCasePopup.Enabled := (l_Test <> nil) and IsTestMethod(l_Test);
  end;
  l_Test := nil;
 end;
end;

function TGUITestRunner.GetPropertyName(const Caption: string): string;
var
  TempStr: string;
  PosSpace: integer;
begin
  TempStr := Trim(Caption);
  PosSpace := Pos(' ',TempStr);
  if (PosSpace > 1)  then
    result := Copy(TempStr, 1, PosSpace-1);
end;

procedure TGUITestRunner.FailNoCheckExecutedMenuItemClick(Sender: TObject);
begin
  Clipboard.AsText := GetPropertyName(NoChecksStrT);
end;

procedure TGUITestRunner.FailsOnMemoryLeakMenuItemClick(Sender: TObject);
begin
  Clipboard.AsText := GetPropertyName(MemLeakStrT);
end;

procedure TGUITestRunner.AllowedLeakSizeMemuItemClick(Sender: TObject);
begin
  Clipboard.AsText := GetPropertyName(MemBytesStr0);
end;

procedure TGUITestRunner.FailsOnMemoryRecoveryMenuItemClick(
  Sender: TObject);
begin
  Clipboard.AsText := GetPropertyName(MemGainStrT);
end;

procedure TGUITestRunner.TestCaseIgnoreSetUpTearDownLeaksMenuItemClick(
  Sender: TObject);
begin
  Clipboard.AsText := GetPropertyName(IgnoreStrT);
end;

procedure TGUITestRunner.RunSelectedTestAltActionExecute(Sender: TObject);
begin
  RunSelectedTestActionExecute(Self);
  TestCasePropertiesActionExecute(Self);
end;

procedure TGUITestRunner.IgnoreMemoryLeakInSetUpTearDownActionExecute(
  Sender: TObject);
begin
  with IgnoreMemoryLeakInSetUpTearDownAction do
    Checked := not Checked;
end;

procedure TGUITestRunner.ReportMemoryLeakTypeOnShutdownActionExecute(
  Sender: TObject);
begin
  with ReportMemoryLeakTypeOnShutdownAction do
  begin
    Checked := not Checked;
  {$IFDEF VER180}
    ReportMemoryLeaksOnShutdown := Checked;
  {$ELSE}
    {$IFDEF FASTMM}
     {$IFDEF ManualLeakReportingControl}
       ReportMemoryLeaksOnShutdown := Checked;
     {$ENDIF}
    {$ENDIF}
  {$ENDIF}
  end;    // with
end;

procedure TGUITestRunner.acFindNodeUpdate(Sender: TObject);
begin
 (Sender as TAction).Enabled := evFindEdit.TextLen > 0;
end;

procedure TGUITestRunner.acFindNodeExecute(Sender: TObject);
var
 l_FirstSelNode: TTreeNode;
begin
 FTestTreeSeacher.aFolderMode := acShowFolder.Checked and acFolderMode.Checked;
 FTestTreeSeacher.aFoundNode := TestTree.Selected;
 if evFindEdit.Modified then
 begin
  FTestTreeSeacher.aFindStr := evFindEdit.Buffer;
  evFindEdit.Modified := False;
  Try2RemeberInHistory;
 end; // if evFindEdit.Modified then
 if FTestTreeSeacher.Find then
 begin
  TestTree.Selected := FTestTreeSeacher.aFoundNode;
  if acNeedSelect.Checked or acNeedSelectAll.Checked then // А здесь мы делаем выделяем все...
  begin
   SelectCurrentActionExecute(TestTree.Selected);
   if acNeedSelectAll.Checked then
   begin
    l_FirstSelNode := TestTree.Selected;
    FTestTreeSeacher.aFoundNode := TestTree.Selected;
    while FTestTreeSeacher.Find do
    begin
     TestTree.Selected := FTestTreeSeacher.aFoundNode;
     SelectCurrentActionExecute(TestTree.Selected);
    end; // while FTestTreeSeacher.Find do
    TestTree.Selected := l_FirstSelNode;
   end; //if acNeedSelectAll.Checked then
  end; // if acNeedSelect.Checked then
 end
 else
  ShowMessage('Тест с подходящим названием не найден!');
 TestTree.SetFocus;
end;

procedure TGUITestRunner.acFindDirectionExecute(Sender: TObject);
begin
 if acFindDirection.ImageIndex = cnIndexDown then
  acFindDirection.ImageIndex := cnIndexUp
 else
  acFindDirection.ImageIndex := cnIndexDown;
 acFindDirection.Caption := csHintStr[acFindDirection.ImageIndex];
 acFindDirection.Hint := csHintStr[acFindDirection.ImageIndex];
 FTestTreeSeacher.aFindDown := acFindDirection.ImageIndex = cnIndexDown;
end;

procedure TGUITestRunner.CheckDirection(Sender: TObject; Key: Word);
begin
 if (Key = 38) and FTestTreeSeacher.aFindDown then
  acFindDirectionExecute(Sender);
 if (Key = 40) and not FTestTreeSeacher.aFindDown then
  acFindDirectionExecute(Sender);
end;

procedure TGUITestRunner.TestTreeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 acNeedSelectAll.Checked := False;
 if Shift = [] then
  if acFindNode.Enabled and ((Key = 40) or (Key = 38)) then
  begin
   CheckDirection(Sender, Key);
   if (FTestTreeSeacher.aFindStatus <> fsNotFound) then
   begin
    acFindNodeExecute(Sender);
    if FTestTreeSeacher.aFindStatus = fsFound then
     Key := 0;
   end; // if (Key = 13) or (Key = 40) or (Key = 38) then
  end;
end;

procedure TGUITestRunner.acShowFolderExecute(Sender: TObject);
begin
 InitTree;
 SetupGUINodes;
end;

function TGUITestRunner.GetNodeEnabled(aNode: TTreeNode): Boolean;
var
 i      : Integer;
 l_Test : ITest;
begin
 l_Test := NodeToTest(aNode);
 if l_Test = nil then
 begin
  Result := False;
  for i := 0 to aNode.Count - 1 do
  begin
   if GetNodeEnabled(aNode[i]) then
   begin
    Result := True;
    Break;
   end; // if GetNodeEnabled(aNode[k]) then
  end; // for i := 0 to aNode.Count - 1 do
 end
 else
  Result := l_Test.Enabled;
end;

{function} procedure TGUITestRunner.SetNodeEnabled(aNode: TTreeNode; aValue: Boolean){: Boolean};
var
 l_Test: ITest;
begin
 l_Test := NodeToTest(aNode);
 if l_Test <> nil then
  l_Test.Enabled := aValue;
end;

procedure TGUITestRunner.acFolderModeUpdate(Sender: TObject);
var
 l_Action: TAction;
begin
 l_Action := (Sender as TAction);
 if evFindEdit.TextLen > 0 then
 begin
  l_Action.Enabled := acShowFolder.Checked;
  if not acShowFolder.Checked then
   l_Action.Checked := False;
 end // if not FShowFolder then
 else
  l_Action.Enabled := False;
end;

procedure TGUITestRunner.TestTreeCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
var
 l_Test: ITest;
begin
 DefaultDraw := True;
 if not (cdsSelected in State) then
  if acShowFolder.Checked and IsNodeFolder(Node) then
   if CheckFolderExcluded(Node.Text) then
    Sender.Canvas.Font.Color := clRed
   else
    Sender.Canvas.Font.Color := clBlue
  else
   if Node.Level > 0 then
   begin
    l_Test := NodeToTest(Node);
    if (l_Test <> nil) and CheckTestExcluded(l_Test.Name, l_Test.Folder) then
     Sender.Canvas.Font.Color := clRed;
    if Node.Level > 1 then
    begin
     l_Test := NodeToTest(Node.Parent);
     if (l_Test <> nil) and CheckTestExcluded(l_Test.Name, l_Test.Folder) then
      Sender.Canvas.Font.Color := clRed;
    end; // if Node.Level > 1 then
   end;
end;

procedure TGUITestRunner.acSelectExcludedExecute(Sender: TObject);
begin
 ChangeState4Test(True, True);
end;

procedure TGUITestRunner.ChangeState4Test(anEnable, anExcluded: Boolean);
var
 l_NextNode : TTreeNode;

 function lp_HasChecked(const aNode: TTreeNode): Boolean;
 var
  i: Integer;
 begin
  Result := False;
  for i := 0 to aNode.Count - 1 do
   if aNode[i].StateIndex = imgENABLED then
   begin
    Result := True;
    Break;
   end; // if aNode[i].StateIndex = imgENABLED then
 end;

 procedure lp_CheckParent(const aNode: TTreeNode);
 var
  l_Node : TTreeNode;
 begin
  l_Node := aNode;
  while l_Node <> nil do
  begin
   if not anEnable and lp_HasChecked(l_Node) then Break;
   SetNodeEnabled(l_Node, anEnable);
   l_Node := l_Node.Parent;
  end; // while l_Node <> l_NextNode then
 end;

 procedure lp_SelectChildren(const aNode: TTreeNode);
 var
  l_Node : TTreeNode;
 begin
  l_NextNode := aNode.GetNextSibling;
  if btnShowFolder.Down and (l_NextNode = nil) then
  begin
   l_NextNode := aNode.Parent;
   l_NextNode := l_NextNode.GetNextSibling;
   if l_NextNode <> nil then
    l_NextNode := l_NextNode.GetNext;
  end; // if FolderNodeBtm.Checked and (l_NextNode = nil) then
  l_Node := aNode;
  while l_Node <> l_NextNode do
  begin
   SetNodeEnabled(l_Node, anEnable);
   l_Node := l_Node.GetNext;
   if IsNodeFolder(l_Node) then Break;
  end; // while l_Node <> l_NextNode then
  lp_CheckParent(aNode);
 end;

var
 l_TopNode : TTreeNode;
 l_Test    : ITest;
begin
 TestTree.Items.BeginUpdate;
 try
  l_TopNode := TestTree.Items[0];
  l_NextNode := l_TopNode.GetNext; // Корневой узел не рассматриваем...
  while l_NextNode <> nil do
  begin
   if anExcluded and IsNodeFolder(l_NextNode) then
    if CheckFolderExcluded(l_NextNode.Text) then
     lp_SelectChildren(l_NextNode)
    else
     l_NextNode := l_NextNode.GetNext
   else
   begin
    if IsNodeFolder(l_NextNode) then
     l_NextNode := l_NextNode.GetNext
    else
    begin
     l_Test := NodeToTest(l_NextNode);
     if anExcluded then
      if CheckTestExcluded(l_Test.Name, l_Test.Folder) then
       lp_SelectChildren(l_NextNode)
      else
       l_NextNode := l_NextNode.GetNext
     else
      if NeedRunTest(l_Test.Name) then
       lp_SelectChildren(l_NextNode)
      else
       l_NextNode := l_NextNode.GetNext;
    end;
   end;//anExcluded and IsNodeFolder(l_NextNode)
  end; // while l_Node <> nil do
//  if anEnable then
//   SetNodeEnabled(l_TopNode, anEnable);
  UpdateNodeState(l_TopNode);
 finally
  TestTree.Items.EndUpdate;
 end;
 UpdateStatus(True);
end;

procedure TGUITestRunner.acDeselectExcludedExecute(Sender: TObject);
begin
 ChangeState4Test(False, True);
end;

procedure TGUITestRunner.acDeleteEtalonsExecute(Sender: TObject);
var
 l_Test       : ITest;
 l_TopNode    : TTreeNode;
 l_NextNode   : TTreeNode;
 l_TestName   : AnsiString;
 l_ParentTest : ITest;
begin
 if FClearEtalonPM <> nil then
 begin
  TestTree.Items.BeginUpdate;
  try
   FClearEtalonPM.OnClick(FClearEtalonPM);
  finally
   TestTree.Items.EndUpdate;
  end;
 end // if FClearEtalonPM then
 else
 begin
  TestTree.Items.BeginUpdate;
  try
   l_TopNode := TestTree.Items[0];
   l_NextNode := l_TopNode.GetNext; // Корневой узел не рассматриваем...
   l_ParentTest := nil;
   while l_NextNode <> nil do
   begin
    if not IsNodeFolder(l_NextNode) and (l_NextNode.HasChildren or (l_ParentTest <> nil)) then
    begin
     l_Test := NodeToTest(l_NextNode);
     if l_Test.HasScriptChildren then
      l_ParentTest := l_Test
     else
      if l_Test.Enabled then
      begin
       l_TestName := FindDocID(l_Test.Name);
       if l_TestName = '' then
        l_TestName := l_Test.Name;
       l_Test.ClearEtalons;
       DeleteEtalons(l_TestName, l_Test.GetSubFolder, l_ParentTest <> nil);
       if l_ParentTest <> nil then
        DeleteEtalons(CorrectScriptKPageName(l_Test), l_Test.GetSubFolder, l_ParentTest <> nil);
      end; // if l_Test.Enabled then
    end; // if not IsNodeFolder(l_NextNode) and l_NextNode.HasChildren then
    l_NextNode := l_NextNode.GetNext;
   end; // while l_NextNode <> nil do
  finally
   TestTree.Items.EndUpdate;
  end;
 end;
end;

procedure TGUITestRunner.acOpenExcludeFileAccept(Sender: TObject);
begin
 with (Sender as TFileOpen) do
 begin
  LoadExcludedFromFile(Dialog.FileName);
  FInitDirForExclude := ExtractFileDir(Dialog.FileName);
 end; // with (Sender as TFileOpen) do
end;

procedure TGUITestRunner.acOpenExcludeFileBeforeExecute(Sender: TObject);
begin
 with (Sender as TFileOpen) do
  Dialog.InitialDir := FInitDirForExclude;
end;

procedure TGUITestRunner.acOpenTestListAccept(Sender: TObject);
begin
 with (Sender as TFileOpen) do
 begin
  LoadItemFlagsFromFile(Dialog.FileName);
  FInitDirForError := ExtractFileDir(Dialog.FileName);
 end; // with (Sender as TFileOpen) do
end;

procedure TGUITestRunner.CheckStartParams;
begin
 CheckFileParam;
 CheckNeedRandom;
 ChangeState4Test(True, False);
 LoadDocumentIDList;
end;

procedure TGUITestRunner.acOpenTestListBeforeExecute(Sender: TObject);
begin
 with (Sender as TFileOpen) do
  Dialog.InitialDir := FInitDirForError;
end;

procedure TGUITestRunner.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 {$IfDef InsiderTest}
 if DisableClose then
  Action := caNone;
 {$EndIf InsiderTest} 
end;

procedure TGUITestRunner.ExitActionUpdate(Sender: TObject);
begin
 {$IfDef InsiderTest}
 ExitAction.Visible := false;
 ExitAction.Enabled := false;
 {$EndIf InsiderTest}
end;

procedure TGUITestRunner.acSelect2CurrentExecute(Sender: TObject);
begin
 ApplyToTests(TestTree.Items.GetFirstNode, EnableTest, True);
 UpdateStatus(True);
end;

function TGUITestRunner.InvertTest(aTest: ITest): Boolean;
begin
 if aTest <> nil then
 begin
  if (aTest.GUIObject as TTreeNode).Level > 0 then
   aTest.Enabled := not aTest.Enabled;
 end; // if aTest <> nil then
 Result := True;
end;

procedure TGUITestRunner.acInvertTestsExecute(Sender: TObject);
begin
 ApplyToTests(TestTree.Items.GetFirstNode, InvertTest, False);
 UpdateStatus(True);
end;

procedure TGUITestRunner.acRandomTestsUpdate(Sender: TObject);
begin
 (Sender as TAction).Enabled := True;
end;

procedure TGUITestRunner.acSaveSelectedAccept(Sender: TObject);
var
 l_Test : ITest;
 l_Out  : Tl3CustomFiler;
 l_Node : TTreeNode;
begin
 l_Out := Tl3CustomDosFiler.Make((Sender as TFileSaveAs).Dialog.FileName, l3_fmWrite);
 try
  l_Out.Open;
  try
   l_Node := FTestTreeSeacher.GetStartNode;
   while l_Node <> nil do
   begin
    l_Test := NodeToTest(l_Node);
    if (l_Test <> nil) and (l_Test.Enabled) and (IsTestMethod(l_Test)) then
    begin
     l_Test := NodeToTest(l_Node.Parent);
     if l_Test.HasScriptChildren then
      l_Test := NodeToTest(l_Node);
     l_Out.WriteLn(l_Test.Name);
    end; // if (l_Test <> nil) and (l_Test.Enabled) and (IsTestMethod(l_Test)) then
    l_Node := l_Node.GetNext;
   end; // while l_Node <> nil do
  finally
   l_Out.Close;
  end;//try..finally
 finally
  FreeAndNil(l_Out);
 end;//try..finally
end;

function TGUITestRunner.GetTestFileName(aTest: ITest): string;
var
 l_Node    : TTreeNode;
 l_Test    : ITest;
 l_FileName: String;
begin
 Result := '';
 l_Test := aTest;
 if Assigned(l_Test) then
 begin
  l_FileName := NormalDir(FileFromCurrent('Auto', True, False)) + l_Test.Name;
  if FileExists(l_FileName) then
   Result := l_FileName
  else
   begin
    if (l_Test.Name = 'DoIt') and (l_Test.GuiObject <> nil) then
    begin
     l_Node := (l_Test.GuiObject as TTreeNode).Parent;
     l_Test := NodeToTest(l_Node);
    end; // if (l_Test.Name = 'DoIt') and (l_Test.GuiObject <> nil) then
    l_FileName := NormalDir(FileFromCurrent('Scripts', True, False)) + l_Test.Name + '.script';
    if FileExists(l_FileName) then
     Result := l_FileName;
   end; // if not FileExists(Result) then
 end; // if Assigned(l_Test) then
end;

procedure TGUITestRunner.OpenFile(const aFileName: string);
const
 c_ErrFNF = 'File not found!';
var
 a_Result: array[0..MAX_PATH - 1] of Char;
begin
 if not FileExists(aFileName) then
  raise Exception.Create(c_ErrFNF);

 if FindExecutable(PChar(ExtractFileName(aFileName)), PChar(ExtractFileDir(aFileName)), a_Result) > 32
  then ShellExecute(0, nil, PChar(aFileName), nil, PChar(ExtractFilePath(aFileName)), SW_SHOWNORMAL)
  else ShellExecute(0, nil, 'notepad', PChar(aFileName), PChar(ExtractFilePath(aFileName)), SW_SHOWNORMAL);
end;

procedure TGUITestRunner.acOpenScriptExecute(Sender: TObject);
var
 l_Test: ITest;
 l_FileName: string;
begin
 l_Test := NodeToTest(TestTree.Selected);
 l_FileName := GetTestFileName(l_Test);
 //ShellExecute(0, nil, 'notepad', PChar(l_FileName), PChar(ExtractFilePath(l_FileName)), SW_SHOWNORMAL);
 OpenFile(l_FileName);
end;

procedure TGUITestRunner.TestTreeDblClick(Sender: TObject);
begin
 acOpenScript.Execute;
end;

function TGUITestRunner.DictionariesPath(aDictionary: TDictionary): string;
begin
 Result := NormalDir(FileFromCurrent(csDictionarySubDir[aDictionary], True, False));
end;

procedure TGUITestRunner.DictionaryMenuItemClick(aSender: TObject);
var
 l_FileName: string;
 l_ParentItem: TDictionaryMenuItem;
begin
 Assert(aSender is TMenuItem);
 Assert(TMenuItem(aSender).Parent is TDictionaryMenuItem);
 l_ParentItem := TDictionaryMenuItem(TMenuItem(aSender).Parent);
 l_FileName := DictionariesPath(l_ParentItem.Dictionary) + TMenuItem(aSender).Caption;
 if FileExists(l_FileName) then
  OpenFile(l_FileName)
 else
  ShowMessageFmt('Словарь %s не найден. Возможно, он был удалён.'#13#10'Попробуйте перечитать тесты.', [l_FileName]);
end;

procedure TGUITestRunner.LoadDictionariesMenu;

 function l_GetDictionaryMenuItem(aDict: TDictionary): TMenuItem;
 var
  I: Integer;
 begin
  for I := 0 to MainMenu.Items.Count - 1 do
   if MainMenu.Items[I] is TDictionaryMenuItem then
    if TDictionaryMenuItem(MainMenu.Items[I]).Dictionary = aDict then
    begin
     Result := MainMenu.Items[I];
     Exit;
    end;
  Result := TDictionaryMenuItem.Create(Self, aDict);
  Result.Caption := csDictionaryMenuItemCaption[aDict];
  MainMenu.Items.Add(Result);
 end;

var
 l_Dict: TDictionary;
 l_MenuItem: TMenuItem;
begin
 for l_Dict := Low(TDictionary) to High(TDictionary) do
 begin
  l_MenuItem := l_GetDictionaryMenuItem(l_Dict);
  l_MenuItem.Clear;
  ReadSubDirs(l_MenuItem, csDictionaryExt, csDictionarySubDir[l_Dict], DictionaryMenuItemClick);
 end;
end;

procedure TGUITestRunner.acOpenScriptUpdate(Sender: TObject);
var
 l_Node: TTreeNode;
 l_Test: ITest;
 l_Result: Boolean;
begin
 l_Result := Assigned(TestTree.Selected);
 if l_Result then
 begin
  l_Test := NodeToTest(TestTree.Selected);
  l_Result := Length(GetTestFileName(l_Test)) > 0;
 end;
 (Sender as TAction).Enabled := l_Result;
end;

procedure TGUITestRunner.OnSelectPreset(Sender: TObject);
var
 l_ParentDir  : string;
 l_PresetName : string;
begin
 l_ParentDir := CheckParentDir(Sender, PresetsPM);
 FInitDirForError := FileFromCurrent(csPresetsSubDir, True, false) + l_ParentDir;
 l_PresetName := FInitDirForError + (Sender as TMenuItem).Caption;
 LoadItemFlagsFromFile(l_PresetName);
end;

procedure TGUITestRunner.RunScriptActionAccept(Sender: TObject);
begin
 with (Sender as TFileOpen) do
 begin
  {$IfDef InsiderTest}
  if g_DebuggerForm <> nil then
  begin
   g_DebuggerForm.LoadScriptFromFile(Dialog.FileName);
   g_DebuggerForm.Show;
   g_DebuggerForm.RunScript;
  end; // if g_DebuggerForm <> nil then
  {$ENDIF InsiderTest}
 end; // with (Sender as TFileOpen) do
end;

procedure TGUITestRunner.RunScriptActionUpdate(Sender: TObject);
begin
 {$IfDef InsiderTest}
 (Sender as TCustomAction).Visible := g_DebuggerForm <> nil;
 {$ELSE}
 (Sender as TCustomAction).Visible := False;
 {$ENDIF InsiderTest}
end;

procedure TGUITestRunner.OnSelectMacros(Sender: TObject);
var
 l_ParentDir  : string;
 l_PresetName : string;
 {$IFDEF RunInDebugger}
 l_MacrosName   : string;
 l_DirForMacros : string;
 {$ELSE}
 l_Test         : ITest;
{$ENDIF RunInDebugger}
begin
 l_PresetName := CheckParentDir(Sender, MacrosPM);
 {$IFDEF RunInDebugger}
 l_DirForMacros := FileFromCurrent('Macros\', True, false) + l_PresetName;
 l_MacrosName := l_DirForMacros + (Sender as TMenuItem).Caption;
 if g_DebuggerForm <> nil then
 begin
  g_DebuggerForm.LoadScriptFromFile(l_MacrosName);
  g_DebuggerForm.Show;
  g_DebuggerForm.RunScript;
 end; // if g_DebuggerForm <> nil then
 {$ELSE}
 f_InternalStart := True;
 l_ParentDir := CheckParentDir(Sender, PresetsPM);
 {$IfDef NoScripts}
 Assert(false);
 {$Else  NoScripts}
 l_Test := TMacroTest.Create(l_PresetName + (Sender as TMenuItem).Caption, '');
 try
  RunTheTest(l_Test, False);
 finally
  l_Test := nil;
 end;
 {$EndIf NoScripts}
 {$ENDIF RunInDebugger}
end;

procedure TGUITestRunner.ReadSubMenuItems(aMenuItem: TMenuItem; aExt,
  aSubDir: string; anEvent: TNotifyEvent; aStartIndex: Integer);
var
 l_Index: Integer;

 function l_PresetAdd(const aFileName: string): Boolean;
 var
  l_Item       : TMenuItem;
  l_PresetName : string;
 begin
  l_PresetName := ExtractFileName(aFileName);
  l_Item := TMenuItem.Create(Self);
  l_Item.AutoHotkeys := maManual;
  l_Item.Caption := l_PresetName;
  aMenuItem.Insert(l_Index, l_Item);
  l_Item.OnClick := anEvent;
  CheckMenuItem(l_Item);
  Result := True;
  Inc(l_Index);
 end;

var
 l_Dir    : String;
 l_FPStub : Pointer;
begin
 l_Index := aStartIndex;
 aMenuItem.AutoHotkeys := maManual;
 l_Dir := FileFromCurrent(aSubDir, True, false);
 l_FPStub := l3LocalStub(@l_PresetAdd);
 try
  ProcessFilesWithMask(l_Dir, aExt, TFileProcessingFunc(l_FPStub));
 finally
  l3FreeLocalStub(l_FPStub);
 end;
 aMenuItem.Visible := aMenuItem.Count > 0;
end;

procedure TGUITestRunner.acReReadAutoTestsExecute(Sender: TObject);
var
 i          : Integer;
 l_List     : IInterfaceList;
 l_Count    : Integer;
 l_Test     : ITest;
 l_TestSuite: ITestSuite;
 l_RootSuite: ITestSuite;
begin
 l_RootSuite := RegisteredTests;
 Assert(l_RootSuite <> nil);
 l_List := l_RootSuite.Tests;
 try
  l_Count := l_List.Count - 1;
  for i := 0 to l_Count do
  begin
   l_Test := ITest(l_List[i]);
   if Supports(l_Test, ITestSuite, l_TestSuite) then
    l_TestSuite.ReReadAbstractTests;
  end; // for i := 0 to l_Count do
 finally
  l_List := nil;
 end;
 InitTree;
 SetupGUINodes;
 LoadDictionariesMenu;
end;

procedure TGUITestRunner.Try2RemeberInHistory;
var
 l_Index: Integer;
begin
 if not evFindEdit.Items.FindData(evFindEdit.Buffer, l_Index) then
 begin
  evFindEdit.Items.Add(evFindEdit.Text);
  if evFindEdit.Items.Count > 20 then
   evFindEdit.Items.DeleteLast;
 end;
end;

procedure TGUITestRunner.ReadSubDirs(aMenuItem: TMenuItem; aExt,
  aSubDir: string; anEvent: TNotifyEvent);
var
 l_Index: Integer;

 function l_DirAdd(const aDirName: string): Boolean;
 var
  l_Item: TMenuItem;
 begin
  l_Item := TMenuItem.Create(Self);
  l_Item.AutoHotkeys := maManual;
  l_Item.Caption := aDirName;
  aMenuItem.Insert(l_Index, l_Item);
  ReadSubDirs(l_Item, aExt, aSubDir + aDirName + '\', anEvent);
  Result := True;
  Inc(l_Index);
 end;

var
 l_Dir    : String;
 l_FPStub : Pointer;
begin
 l_Index := 0;
 aMenuItem.AutoHotkeys := maManual;
 l_Dir := FileFromCurrent(aSubDir, True, false);
 l_FPStub := l3LocalStub(@l_DirAdd);
 try
  ProcessSubDirectories(l_Dir, TFileProcessingFunc(l_FPStub));
 finally
  l3FreeLocalStub(l_FPStub);
 end;
 ReadSubMenuItems(aMenuItem, aExt, aSubDir, anEvent, l_Index);
 aMenuItem.Visible := aMenuItem.Count > 0;
end;

function TGUITestRunner.CheckParentDir(Sender: TObject; aParentPM: TMenuItem): String;
var
 l_Item: TMenuItem;
begin
 Result := '';
 l_Item := Sender as TMenuItem;                           
 while aParentPM <> l_Item.Parent do
 begin
  l_Item := l_Item.Parent;
  if l_Item = nil then Break;
  Result := Result + l_Item.Caption + '\';
 end; // while PresetsPM <> l_Item.Parent do
end;

procedure TGUITestRunner.CheckMenuItem(const aMenuItem: TMenuItem);
begin
 if aMenuItem.Caption = csClearEtalonScriptName then
  FClearEtalonPM := aMenuItem;
 {$IFDEF Archi}
 if aMenuItem.Caption = csClearDataBase then
  FClearBaseMenuItem := aMenuItem;
 {$ENDIF Archi}
end;

procedure TGUITestRunner.acLoadOperationExecute(Sender: TObject);

begin
 if FLoadOperation < High(TLoadOperation) then
  Inc(FLoadOperation)
 else
  FLoadOperation := Low(TLoadOperation);
 UpdateLogicalOpearation;
end;

procedure TGUITestRunner.InitLogicalOperation;
begin
 LoadOperation := lo_Clear;
 UpdateLogicalOpearation;
end;

procedure TGUITestRunner.UpdateLogicalOpearation;
begin
 with acLoadOperation do
 begin
  ImageIndex := cnStartLogicalIndex + Ord(FLoadOperation);
  Caption := csLogicalHintArray[FLoadOperation];
  Hint := csLogicalHintArray[FLoadOperation];
 end;
end;

procedure TGUITestRunner.LoadItemFlagsFromFile(aFileName: AnsiString);
begin
 ApplyToTests(TestTree.Items.GetFirstNode, DisableTest, False);
 UpdateStatus(True);
 LoadTestNamesFromFile(aFileName, FLoadOperation);
 ChangeState4Test(True, False);
end;

procedure TGUITestRunner.SetLoadOperation(const Value: TLoadOperation);
begin
 FLoadOperation := Value;
 UpdateLogicalOpearation;
end;

procedure TGUITestRunner.DoDeselectAllActionExecute(Sender: TObject);
begin
 ApplyToTests(TestTree.Items.GetFirstNode, DisableTest, False);
 UpdateStatus(True);
end;

procedure TGUITestRunner.CompileActionUpdate(Sender: TObject);
begin
 {$If not defined(NoScripts)}
 CompileAction.Enabled := RunAction.Enabled;
 {$Else }
 CompileAction.Visible := false;
 {$IfEnd}
end;

procedure TGUITestRunner.CompileActionExecute(Sender: TObject);
begin
 {$If not defined(NoScripts)}
 vcmInsiderTest.g_CompileOnly := true;
 try
 {$IfEnd}
  RunAction.Execute;
 {$If not defined(NoScripts)}
 finally
  vcmInsiderTest.g_CompileOnly := false;
 end;//try..finally
 {$IfEnd}
end;

procedure TGUITestRunner.acDebuggerExecute(Sender: TObject);
begin
 {$IfDef InsiderTest}
 if g_DebuggerForm <> nil then
  if (Sender as TAction).Checked then
   g_DebuggerForm.Show
  else
   g_DebuggerForm.Hide;
 {$EndIf InsiderTest}
end;

procedure TGUITestRunner.ShowDebugForm;
begin
 acDebuggerExecute(acDebugger);
end;

procedure TGUITestRunner.ToFront;
begin
 if not IsWritingToK  then
  if not FWasStarted then
   SetFocus;
 FWasStarted := True;
end;

procedure TGUITestRunner.acClearDaaBaseExecute(Sender: TObject);
begin
{$IFDEF Archi}
 if FClearBaseMenuItem <> nil then
  FClearBaseMenuItem.OnClick(FClearBaseMenuItem);
{$ENDIF Archi}
end;

procedure TGUITestRunner.acDebuggerUpdate(Sender: TObject);
begin
 {$IfDef InsiderTest}
 if g_DebuggerForm <> nil then
  if (Sender as TAction).Checked <> g_DebuggerForm.Visible then
   (Sender as TAction).Checked := g_DebuggerForm.Visible;
 {$EndIf InsiderTest}
end;

{ TDictionaryMenuItem }

constructor TDictionaryMenuItem.Create(anOwner: TComponent; aDictionary: TDictionary);
begin
 inherited Create(anOwner);
 f_Dictionary := aDictionary;
end;

end.
