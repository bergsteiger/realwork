{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit vclstdreg;

interface
{.$I dc.inc}
{$I dcprod.inc}

{$IFDEF D6}
{$WARN UNIT_PLATFORM OFF}
{$ENDIF}

uses

// --------------- Delphi Units ----------------

  classes,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  dialogs, stdctrls, extctrls, menus, buttons,
  mask, grids, forms, comctrls, controls, graphics,
  typinfo, sysutils, olectrls,
  olectnrs,
  mplayer,tabs, tabnotbk,

  filectrl,

  {$IFNDEF BCB}{$IFNDEF D6}outline, {$ENDIF}{$ENDIF}
  {$IFDEF D3}checklst,extdlgs,activex,{$ENDIF}
  {$IFNDEF D3}olectl, {$ENDIF}
  {$IFDEF D4} ActnList,{$ENDIF}

// --------------- Dream Company Units -------------
   dcconsts,
   dcgen, dcgenreg,
   dcsystem,dcrespic;

{------------------------------------------------------------------}

procedure Register;
{------------------------------------------------------------------}
type
  TOleComponentEditor = class(TDefaultEditor)
  private
    fVerbs : TStringList;
  protected
    procedure   FillVerbs; virtual; abstract;
  public
    {$IFDEF D6}
    constructor Create(AComponent: TComponent; ADesigner: IDesigner); override;
    {$ELSE}
    constructor Create(AComponent: TComponent; ADesigner: TFormDesigner); override;
    {$ENDIF}
    destructor  Destroy; override;
    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer): string; override;
  end;

  TOleContainerEditor = class(TOleComponentEditor)
  protected
    procedure FillVerbs; override;
  public
    procedure ExecuteVerb(Index: Integer); override;
  end;

{$IFDEF D3}
type
  TOleControlEditor = class(TOleComponentEditor)
  protected
    procedure FillVerbs; override;
  public
    procedure ExecuteVerb(Index: Integer); override;
  end;

  TAnimateEditor = class(TDefaultEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TToolBarEditor = class(TDefaultEditor)
    procedure ExecuteVerb(AIndex: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{$ENDIF}
implementation
{$IFDEF D3}
{***************************************************************}

procedure TOleControlEditor.ExecuteVerb(Index: Integer);
begin
  TOleControl(Component).DoObjectVerb(index);
end;

{------------------------------------------------------------------}

procedure TOleControlEditor.FillVerbs;
begin
  TOleControl(Component).GetObjectVerbs(fVerbs);
end;

type
  TMToolBar = class(TToolBar)
  end;

{------------------------------------------------------------------}

procedure TToolBarEditor.ExecuteVerb(AIndex: Integer);
Var
  LastButton:TToolButton;
begin
  With TToolButton.Create(TToolBar(Component).Owner) do
  begin
    if AIndex = 1 then
    begin
      Style := tbsSeparator;
      Width :=8;
    end;
    If TToolBar(Component).ButtonCount>0 Then
    Begin
      LastButton:=TToolBar(Component).Buttons[TToolBar(Component).ButtonCount-1];
      Left:=LastButton.Left+LastButton.Width+1;
    End;  
    Parent:=TWinControl(Component);
    Name:=Designer.UniqueName(System.Copy(ClassName,2,MaxInt));
  end;
end;

{------------------------------------------------------------------}

const
  ToolBarVerbs : array[0 .. 1] of string =
  (SVerbNewbutton, SVerbNewseparator);

function TToolBarEditor.GetVerb(Index: Integer): string;
begin
  result := ToolBarVerbs[index];
end;

{------------------------------------------------------------------}

function TToolBarEditor.GetVerbCount: Integer;
begin
  result := 2;
end;

{------------------------------------------------------------------}

const
  AnimateEditorVerbs : array[0 .. 1] of string =
  (SVerbNextframe, SVerbPreviousframe);

function TAnimateEditor.GetVerb(Index: Integer): string;
begin
  result := AnimateEditorVerbs[index];
end;

{------------------------------------------------------------------}

function TAnimateEditor.GetVerbCount: Integer;
begin
  result := 2;
end;

{------------------------------------------------------------------}

procedure TAnimateEditor.ExecuteVerb(Index: Integer);
begin
  with TAnimate(Component) do
    if index = 0 then
      StartFrame := StartFrame + 1
    else
      StartFrame := StartFrame - 1;
end;
{$ENDIF}


{***************************************************************}

{$IFDEF D6}
constructor TOleComponentEditor.Create(AComponent: TComponent; ADesigner: IDesigner);
{$ELSE}
constructor TOleComponentEditor.Create(AComponent: TComponent; ADesigner: TFormDesigner);
{$ENDIF}
begin
  inherited;
  fVerbs := TStringList.Create;
  FillVerbs;
end;

{---------------------------------------------------------------}

destructor  TOleComponentEditor.Destroy;
begin
  fVerbs.Free;
  inherited;
end;

{---------------------------------------------------------------}

function TOleComponentEditor.GetVerbCount: Integer;
begin
  result := fVerbs.Count;
end;

{---------------------------------------------------------------}

function TOleComponentEditor.GetVerb(Index: Integer): string;
begin
  result := fVerbs[index];
end;

{***************************************************************}

procedure TOleContainerEditor.ExecuteVerb(Index: Integer);
begin
  with (Component as TOleContainer) do
    case Index of
      0 : InsertObjectDialog;
      1 : ObjectPropertiesDialog;
      else DoVerb(index - 2);
    end;
end;

{---------------------------------------------------------------}

procedure TOleContainerEditor.FillVerbs;
begin
  with (Component as TOleContainer), fVerbs do
    begin
      Add(SVerbInsertObject);
      if (State <> osEmpty) then
        begin
          Add(SVerbObjectProperties);
          AddStrings(ObjectVerbs);
        end;
    end;
end;
{---------------------------------------------------------------}
//BeginSkipConst
procedure _InstantRegister;
begin
  {$IFDEF D4}
  SafeRegisterClass(TAction);
  {$ENDIF}

  RegisterComponents(SPalStandard, [TMainMenu, TPopupMenu, TLabel, TEdit, TMemo,
    TButton, TCheckBox, TRadioButton, TListBox, TComboBox, TScrollBar,
    TGroupBox, TRadioGroup, TPanel
    {$IFDEF D4}
    ,ActnList.TActionList
    {$ENDIF}
     ]);

  RegisterComponents(SPalAdditional, [TBitBtn, TSpeedButton, TMaskEdit,
    TStringGrid, TDrawGrid, TImage, TShape, TBevel, TScrollBox]);

  RegisterComponents(SPalWin32, [TTabControl, TPageControl, TImageList, TRichEdit,
    TTrackBar, TProgressBar,TUpDown, THotKey,
    {$IFDEF D3}
    TAnimate, TDateTimePicker,
    {$ENDIF}
    TTreeView, TListView,THeaderControl, TStatusBar
    {$IFDEF D3}
    ,TToolBar, TCoolBar
    {$ENDIF}
    {$IFDEF D4}
    ,TMonthCalendar,TPageScroller
    {$ENDIF}
    ]);

   
  RegisterComponents(SPalSystem, [TTimer, TPaintBox, TMediaPlayer, TOleContainer]);

  RegisterComponents(SPalDialogs, [TOpenDialog, TSaveDialog,
  {$IFDEF D3}
  TOpenPictureDialog,TSavePictureDialog,
  {$ENDIF}
  TFontDialog, TColorDialog, TPrintDialog,TPrinterSetupDialog, TFindDialog,
  TReplaceDialog]);

  RegisterComponents(SPalWin31, [TTabSet, {$IFNDEF BCB} {$IFNDEF D6}TOutline, {$ENDIF}{$endif} TTabbedNotebook,
    TNotebook, THeader, TFileListBox, TDirectoryListBox, TDriveComboBox,
    TFilterComboBox]);

  RegisterNoIcon([TMenuItem{$IFDEF D4},TCustomAction{$ENDIF}]);

  RegisterPropertyEditor(TypeInfo(string), TMediaPlayer, 'Filename', TMPFilenameProperty);
  RegisterClass(TTabSheet);

{$IFDEF D3}
  RegisterComponents(SPalAdditional, [TCheckListBox,TSplitter,TStaticText
  {$IFDEF D4},TControlBar{$ENDIF} ]);
  RegisterClass(TToolButton);
{$ENDIF}

  {$IFDEF D3}
  RegisterComponentEditor(TOleControl, TOleControlEditor);
  RegisterComponentEditor(TToolBar, TToolBarEditor);
  RegisterComponentEditor(TAnimate, TAnimateEditor);
  {$ENDIF}
  RegisterComponentEditor(TOleContainer, TOleContainerEditor);
  {$IFDEF D3}
  RegisterPropertyEditor(TypeInfo(string), TAnimate, 'FileName', TAVIFileNameEdit); //don't resource
  {$ENDIF}
end;
//EndSkipConst
procedure Register;
begin
  RegisterForInstant(_InstantRegister);
end;

{------------------------------------------------------------------}
initialization
  RegisterForInstant(_InstantRegister);
end.
