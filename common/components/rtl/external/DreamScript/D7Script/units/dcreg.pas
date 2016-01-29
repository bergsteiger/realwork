{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcreg;

interface
{.$I dc.inc}
{$I dcprod.inc}

uses
  // if you get a compilation error after any of the conditional defines below
  // just comment out corresponding define from the dc.inc or prod.inc files

  {$IFDEF PRODELPHI}
  {$IFDEF USEOWNDSGNSTUFF}
  {$ELSE}
  toolintf, exptintf,
  {$ENDIF}
  {$ENDIF}

  windows, dcconsts, dcdreamlib, dcvcllib, classes,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  dcrespic

  {$IFDEF DREAMLIB}
  , dcsystem, dcStdCtl, DCGlobalImages,
  dcstdctlreg, dcgenreg, dcpaletreg,
  dcmenureg, rerrdlg, dcCommon, dccommonreg, dcButtonPanelReg,
  diffmakereg, formfillreg, aviplayreg, dcenvopt, dccbutreg
  {$ENDIF}
  {$IFDEF COMMONTREE}
  , dcdtree
  {$ENDIF}

  {$IFDEF DREAMINFOTREE}
  , dcItReg
  {$ENDIF}

  {$IFDEF DREAMDESIGNER}
  , dsize, aligunit, dalign, dcfdesreg, dcddesreg

  , DCMenuDsgnUnit
  {$IFDEF DCEDIT}
  , dcfdopt
  {$ENDIF}

  {$IFDEF DREAMSCRIPTER}
  , dcscdesreg
  {$ENDIF}

  {$IFDEF DREAMMEMO}
  , dcfdmemo
  {$ENDIF}

  {$IFDEF DREAMIDE}
  , dcidedes
  {$ENDIF}
  {$ENDIF}

  {$IFDEF DREAMSCRIPTER}
  , unitpars, dcscriptreg, import, dcpascal
  {$ENDIF}

  {$IFDEF DREAMTREE}
  {$IFDEF DCEDIT}
  , dtreeEdreg
  {$ENDIF}

  , dctreeedreg, treemod, pstoredreg, dcTreeReg, dctsrcreg{$IFDEF D4}, dcactlstreg{$ENDIF}

  {$IFDEF DCEDIT}
  , dcimged {,optunit}
  {$ENDIF}

  {$IFDEF DREAMINSPECTOR}
  {$DEFINE TREEINSP}
  , treeinspreg
  {$ENDIF}
  {$ENDIF}

  {$IFDEF DREAMINSPECTOR}
  , glyphed, maskpr, MskText, oinspectreg, inspunit, dcstrled
  {$IFDEF DCEDIT}
  , dcinspopt
  {$ENDIF}
  {$ENDIF}

  {$IFDEF DREAMMEMO}
  , dcstring, dcmemoreg, replunit, searunit, dcSyntaxReg
  {$IFDEF DCEDIT}
  {$IFDEF DREAMTREE}
  , dcmemopt
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}

  {$IFDEF DREAMPARSER}
  , dcparser, dccdes
  {$ENDIF}

  {$IFDEF DREAMIDE}
  {$IFDEF D3}, dcploadreg, dcappreg{$ENDIF}
  {$ENDIF}

  {$IFDEF DCEDIT}
  , dcEdit, dceditreg, histed, dcpedit
  , propcbreg, dcColorCombo, dcinpfrm, FltrEdReg
  {$ENDIF}

  {$IFDEF DREAMTREE}
  {$IFDEF DREAMIDE}
  , dcpmanreg
  {$ENDIF}
  {$ENDIF}

  {$IFDEF PRODELPHI}{$IFDEF DCEDIT}
  , dcdbctl
  , dcdbctlreg
  {$ENDIF}{$ENDIF}
  {$IFDEF DREAMTREE}
  , dcdbtreereg
  {$ENDIF}
  {$IFDEF DREAMINSPECTOR}
  , dbinspreg
  {$ENDIF}
  {$IFDEF DREAMMEMO}
  , dcdbmemo
  {$ENDIF}
  //{$ENDIF}
  ;

procedure Register;

{$IFDEF PRODELPHI}
{$IFDEF TREEINSP}
type
  TDCExpert = class(TIExpert)
  private
    ExpertItem: TIMenuItemIntf;
    FCaption: string;
    FVerbName: string;
  public
    constructor Create(const Caption, VerbName: string);
    destructor Destroy; override;
    procedure ExpertItemClick(Sender: TIMenuItemIntf);
    function GetName: string; override;
    function GetComment: string; override;
    function GetAuthor: string; override;
    function GetStyle: TExpertStyle; override;
    function GetIDString: string; override;
    function GetPage: string; override;
    function GetState: TExpertState; override;
    function GetMenuText: string; override;
    function GetGlyph: HICON; override;
    procedure Execute; override;
  end;

procedure RegisterExpertVerb(const Caption, VerbName: string);
{$ENDIF}
{$ENDIF}

implementation

{$IFDEF PRODELPHI}
{$IFDEF TREEINSP}

{--------------TIDEExpert--------------------------------------------}

constructor TDCExpert.Create(const Caption, VerbName: string);
var
  MainMenu: TIMainMenuIntf;
  ToolsMenu: TIMenuItemIntf;
  MenuItems: TIMenuItemIntf;
begin
  inherited Create;

  if ToolServices = nil then
    exit;

  FCaption := Caption;
  FVerbName := VerbName;
  MainMenu := ToolServices.GetMainMenu;

  if MainMenu <> nil then
  try
    MenuItems := MainMenu.GetMenuItems;

    if MenuItems <> nil then
    try
      ToolsMenu := MainMenu.FindMenuItem('ToolsMenu'); //don't resource

      if ToolsMenu <> nil then
      try
        with ToolsMenu do
          ExpertItem := InsertItem(GetItemCount - 1, Caption, RemoveNonIdentChars(VerbName), '', 0, 0, 0,
            [mfVisible, mfEnabled], ExpertItemClick);

      finally
        ToolsMenu.Free;
      end;
    finally
      MenuItems.Free;
    end;
  finally
    MainMenu.Free;
  end;
end;

{------------------------------------------------------------------}

destructor TDCExpert.Destroy;
begin
  ExpertItem.Free;
  inherited;
end;

{------------------------------------------------------------------}

procedure TDCExpert.ExpertItemClick(Sender: TIMenuItemIntf);
begin
  CallVerbByName(FVerbName);
end;
{------------------------------------------------------------------}

function TDCExpert.GetName: string;
begin
  Result := FCaption + ' Expert'; //don't resource
end;
{------------------------------------------------------------------}

function TDCExpert.GetMenuText: string;
begin
  Result := FCaption + '...';
end;

{------------------------------------------------------------------}

function TDCExpert.GetStyle: TExpertStyle;
begin
  Result := esAddIn;
end;

{------------------------------------------------------------------}

function TDCExpert.GetState: TExpertState;
begin
  Result := [esEnabled];
end;

{------------------------------------------------------------------}

function TDCExpert.GetIDString: string;
begin
  Result := 'DreamCompany.' + FCaption; //don't resource
end;

{------------------------------------------------------------------}

function TDCExpert.GetAuthor: string;
begin
  Result := 'Dream Company'; //don't resource
end;

{------------------------------------------------------------------}

function TDCExpert.GetComment: string;
begin
  Result := '';
end;

{------------------------------------------------------------------}

function TDCExpert.GetPage: string;
begin
end;

{------------------------------------------------------------------}

function TDCExpert.GetGlyph: HICON;
begin
  Result := 0;
end;

{------------------------------------------------------------------}

procedure TDCExpert.Execute;
begin
end;

{------------------------------------------------------------------}

procedure RegisterExpertVerb(const Caption, VerbName: string);
begin
  if @LibraryExpertProc <> nil then
  begin
    RegisterLibraryExpert(TDCExpert.Create(Caption, VerbName));
  end;
end;

{$ENDIF}
{$ENDIF}

{------------------------------------------------------------------}

procedure _Register;
begin
  {$IFDEF PRODELPHI}
  {$IFDEF TREEINSP}
  RegisterExpertVerb(SVerbIdeInspector, 'Tools.IDEInspector'); //don't resource
  {$ENDIF}
  {$ENDIF}

end;

{------------------------------------------------------------------}
{$IFDEF DREAMLIB}
var
  RegisterCalled: boolean = false;

procedure _InstantRegister;
begin
  if RegisterCalled then
    exit;

  RegisterCalled := true;

  {$IFDEF DREAMLIB}
  dcStdCtl.Register;
  dcstdctlreg.Register;
  dcpaletreg.Register;
  dcgenreg.Register;
  diffmakereg.Register;
  formfillreg.Register;
  dcmenureg.Register;
  dcCommon.Register;
  dccommonreg.Register;
  aviplayreg.Register;
  dcCButReg.Register;
  dcButtonPanelReg.Register;
  {$ENDIF}

  {$IFDEF PRODELPHI}{$IFDEF DREAMINSPECTOR}
  dbinspreg.Register;
  {$ENDIF}{$ENDIF}
  {$IFDEF D4}{$IFDEF DREAMTREE}
  dcactlstreg.Register;
  {$ENDIF}{$ENDIF}
  {$IFDEF DREAMIDE}
  dcappreg.Register;
  {$ENDIF}
  {$IFDEF DREAMPARSER}
  dccdes.Register;
  {$ENDIF}
  {$IFDEF PRODELPHI}{$IFDEF DCEDIT}
  dcdbctl.Register;
  dcdbctlreg.Register;
  {$ENDIF}{$ENDIF}
  {$IFDEF PRODELPHI}{$IFDEF DREAMMEMO}
  dcdbmemo.Register;
  {$ENDIF}{$ENDIF}
  {$IFDEF PRODELPHI}{$IFDEF DREAMTREE}
  dcdbtreereg.Register;
  {$ENDIF}{$ENDIF}
  {$IFDEF DREAMDESIGNER}
  dcddesreg.Register;
  {$ENDIF}
  {$IFDEF DCEDIT}
  dcEdit.Register;
  dceditreg.Register;
  {$ENDIF}
  {$IFDEF DCEDIT}
  histed.Register;
  {$ENDIF}
  {$IFDEF DCEDIT}
  propcbreg.Register;
  dcColorCombo.Register;
  {$ENDIF}
  {$IFDEF DCEDIT}
  fltredreg.Register;
  {$ENDIF}
  {$IFDEF DREAMDESIGNER}
  dcfdesreg.Register;
  {$ENDIF}
  {$IFDEF DREAMMEMO}
  dcmemoreg.Register;
  dcSyntaxReg.Register;
  {$ENDIF}
  {$IFDEF DREAMPARSER}
  dcparser.Register;
  {$ENDIF}
  {$IFDEF DREAMIDE}{$IFDEF D3}
  dcploadreg.Register;
  {$ENDIF}{$ENDIF}
  {$IFDEF DREAMTREE}{$IFDEF DREAMIDE}
  dcpmanreg.Register;
  {$ENDIF}{$ENDIF}
  {$IFDEF DREAMSCRIPTER}
  dcscriptreg.Register;
  {$ENDIF}
  {$IFDEF DREAMMEMO}
  dcstring.Register;
  {$ENDIF}
  {$IFDEF DREAMTREE}
  dctreereg.Register;
  {$ENDIF}
  {$IFDEF DREAMTREE}
  dctreeedreg.Register;
  {$ENDIF}
  {$IFDEF DREAMTREE}
  dctsrcreg.Register;
  {$ENDIF}
  {$IFDEF DREAMINSPECTOR}
  oinspectreg.Register;
  {$ENDIF}
  {$IFDEF DREAMTREE}
  pstoredreg.Register;
  {$ENDIF}
  {$IFDEF TREEINSP}
  treeinspreg.Register;
  {$ENDIF}
  {$IFDEF DREAMTREE}{$IFDEF DCEDIT}
  dtreeEdreg.Register;
  {$ENDIF}{$ENDIF}

  (*
    {$IFDEF DREAMDESIGNER}{$IFDEF DCEDIT}dcfdopt.Register;{$ENDIF}{$ENDIF}
    {$IFDEF DREAMINSPECTOR}{$IFDEF DCEDIT}dcinspopt.Register;{$ENDIF}{$ENDIF}
    {$IFDEF DREAMMEMO}{$IFDEF DCEDIT}{$IFDEF DREAMTREE}dcmemopt.Register;{$ENDIF}{$ENDIF}{$ENDIF}
  *)
  //  {$IFDEF DREAMDESIGNER}{$IFDEF DREAMMEMO}dcfdmemo.Register;{$ENDIF}{$ENDIF}

  {$IFDEF COMMONTREE}
  dcdtree.Register;
  {$ENDIF}

  {$IFDEF DREAMINFOTREE}
  dcITReg.Register;
  {$ENDIF}

  {$IFDEF DREAMDESIGNER}{$IFDEF DREAMSCRIPTER}
  dcscdesreg.Register;
  {$ENDIF}{$ENDIF}
  dcvcllib.Register;

  {$IFDEF DREAMCODEMANAGER}
  DCCodeMngReg.Register;
  {$ENDIF}

  {$IFDEF DREAMDESIGNER}
  DCMenuDsgnUnit.DCRegisterMenuEditor;
  {$ENDIF}
end;

{------------------------------------------------------------------}
{$ENDIF}

procedure Register;
begin
  _Register;
  {$IFNDEF D3}
  {$IFDEF DREAMLIB}
  _InstantRegister;
  {$ENDIF}
  {$ENDIF}
end;

{------------------------------------------------------------------}

initialization
  {$IFDEF DREAMLIB}
  RegisterForInstant(_InstantRegister);
  {$ENDIF}
end.

