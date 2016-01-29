{*********************************************************************}
{*                                                                   *}
{*             Add-In Express Component Library                      *}
{*                Add-in Express 2010 for VCL                        *}
{*                                                                   *}
{*             Copyright (C) Add-in Express Ltd.                     *}
{*             ALL RIGHTS RESERVED                                   *}
{*                                                                   *}
{*   The entire contents of this file is protected by U.S. and       *}
{*   International Copyright Laws. Unauthorized reproduction,        *}
{*   reverse-engineering, and distribution of all or any portion of  *}
{*   the code contained in this file is strictly prohibited and may  *}
{*   result in severe civil and criminal penalties and will be       *}
{*   prosecuted to the maximum extent possible under the law.        *}
{*                                                                   *}
{*   RESTRICTIONS                                                    *}
{*                                                                   *}
{*   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES ARE       *}
{*   CONFIDENTIAL AND PROPRIETARY TRADE SECRETS OF ADD-IN EXPRESS    *}
{*   LTD.                                                            *}
{*   THE REGISTERED DEVELOPER IS LICENSED TO DISTRIBUTE              *}
{*   THE ADX Extensions VCL for Microsoft Outlook                    *}
{*   AND ALL ACCOMPANYING VCL COMPONENTS AS PART OF                  *}
{*   AN EXECUTABLE PROGRAM ONLY.                                     *}
{*                                                                   *}
{*   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      *}
{*   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        *}
{*   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       *}
{*   AVAILABLE TO OTHER INDIVIDUALS WITHOUT WRITTEN CONSENT          *}
{*   AND PERMISSION FROM ADD-IN EXPRESS LTD.                         *}
{*                                                                   *}
{*   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       *}
{*   ADDITIONAL RESTRICTIONS.                                        *}
{*                                                                   *}
{*********************************************************************}

unit adxolWClasses;

{$I adxolDefs.inc}

interface

uses
  Windows, SysUtils, StdCtrls, ExptIntf, EditIntf, ToolIntf,
  Consts, Dialogs, Classes,
  {$IFDEF ADX_VCL5}
  DsgnIntf, MaskProp,
  {$ELSE}
  Variants,
  DesignIntf,
  DesignEditors,
  {$ENDIF}
  {$IFDEF ADXXOL_TRIAL}
  {$I adxxtrl1.inc}
  {$ENDIF}
  ToolsAPI, ActiveX, Registry;
  //, adxolAbout, adxxlAbout;

const
  // The page name for the Layered Form Wizard
  sLayeredOlFormObjRepositoryPage = 'ADX Outlook Form';
  sLayeredOlFormObjRepositoryPage2 = 'ADX Outlook Form';
  olProductName = 'Add-in Express Extensions 2008 for Microsoft Outlook';
  msgOlTrialExpire = 'Trial period of the ' + olProductName + ' is expired!';

  sLayeredXlFormObjRepositoryPage = 'ADX Excel Task Pane';
  sLayeredXlFormObjRepositoryPage2 = 'ADX Excel Task Pane';
  sLayeredWdFormObjRepositoryPage2 = 'ADX Word Task Pane';
  sLayeredPpFormObjRepositoryPage2 = 'ADX PowerPoint Task Pane';
  xlProductName = 'Add-in Express Extensions 2008 for Microsoft Excel';
  msgXlTrialExpire = 'Trial period of the ' + xlProductName + ' is expired!';

  ProductName = 'Add-in Express Extensions 2008';
  msgTrialExpire = 'Trial period of the ' + ProductName + ' is expired!';

type
  TadxExtCustomExpert = class(TNotifierObject, IOTAWizard, IOTARepositoryWizard, IOTAProjectWizard)
  public
    { IOTAWizard }
    function GetIDString: string; virtual; abstract;
    function GetName: string; virtual; abstract;
    function GetState: TWizardState;
    procedure Execute; virtual; abstract;
    { IOTARepositoryWizard }
    function GetAuthor: string;
    function GetComment: string; virtual; abstract;
    function GetPage: string;
    {$IFDEF ADX_VCL5}
    function GetGlyph: HICON; virtual; abstract;
    {$ELSE}
    function GetGlyph: Cardinal; virtual; abstract;
    {$ENDIF}
  end;

  { TadxolFormExpert2 }
  TadxolFormExpert2 = class(TadxExtCustomExpert)
  public
    { IOTAWizard }
    function GetIDString: string; override;
    function GetName: string; override;
    procedure Execute; override;
    { IOTARepositoryWizard }
    function GetComment: string; override;
    {$IFDEF ADX_VCL5}
    function GetGlyph: HICON; override;
    {$ELSE}
    function GetGlyph: Cardinal; override;
    {$ENDIF}
  end;

  { TadxxlFormExpert2 }
  TadxxlFormExpert2 = class(TadxExtCustomExpert)
  public
    { IOTAWizard }
    function GetIDString: string; override;
    function GetName: string; override;
    procedure Execute; override;
    { IOTARepositoryWizard }
    function GetComment: string; override;
    {$IFDEF ADX_VCL5}
    function GetGlyph: HICON; override;
    {$ELSE}
    function GetGlyph: Cardinal; override;
    {$ENDIF}
  end;

  { TadxwdFormExpert2 }
  TadxwdFormExpert2 = class(TadxExtCustomExpert)
  public
    { IOTAWizard }
    function GetIDString: string; override;
    function GetName: string; override;
    procedure Execute; override;
    { IOTARepositoryWizard }
    function GetComment: string; override;
    {$IFDEF ADX_VCL5}
    function GetGlyph: HICON; override;
    {$ELSE}
    function GetGlyph: Cardinal; override;
    {$ENDIF}
  end;

  { TadxwdFormExpert2 }
  TadxppFormExpert2 = class(TadxExtCustomExpert)
  public
    { IOTAWizard }
    function GetIDString: string; override;
    function GetName: string; override;
    procedure Execute; override;
    { IOTARepositoryWizard }
    function GetComment: string; override;
    {$IFDEF ADX_VCL5}
    function GetGlyph: HICON; override;
    {$ELSE}
    function GetGlyph: Cardinal; override;
    {$ENDIF}
  end;


  TadxolFormExpert = class(TIExpert)
  public
    function GetStyle: TExpertStyle; override;
    function GetName: string; override;
    function GetAuthor: string; override;
    function GetComment: string; override;
    function GetPage: string; override;
    {$IFDEF ADX_VCL5}
    function GetGlyph: HICON; override; stdcall;
    {$ELSE}
    function GetGlyph: HICON; override; stdcall;
    {$ENDIF}
    function GetState: TExpertState; override;
    function GetIDString: string; override;
    function GetMenuText: string; override;
    procedure Execute; override;
  end;

  TadxxlFormExpert = class(TIExpert)
  public
    function GetStyle: TExpertStyle; override;
    function GetName: string; override;
    function GetAuthor: string; override;
    function GetComment: string; override;
    function GetPage: string; override;
    {$IFDEF ADX_VCL5}
    function GetGlyph: HICON; override; stdcall;
    {$ELSE}
    function GetGlyph: HICON; override; stdcall;
    {$ENDIF}
    function GetState: TExpertState; override;
    function GetIDString: string; override;
    function GetMenuText: string; override;
    procedure Execute; override;
  end;

  TadxwdFormExpert = class(TIExpert)
  public
    function GetStyle: TExpertStyle; override;
    function GetName: string; override;
    function GetAuthor: string; override;
    function GetComment: string; override;
    function GetPage: string; override;
    {$IFDEF ADX_VCL5}
    function GetGlyph: HICON; override; stdcall;
    {$ELSE}
    function GetGlyph: HICON; override; stdcall;
    {$ENDIF}
    function GetState: TExpertState; override;
    function GetIDString: string; override;
    function GetMenuText: string; override;
    procedure Execute; override;
  end;

  TadxppFormExpert = class(TIExpert)
  public
    function GetStyle: TExpertStyle; override;
    function GetName: string; override;
    function GetAuthor: string; override;
    function GetComment: string; override;
    function GetPage: string; override;
    {$IFDEF ADX_VCL5}
    function GetGlyph: HICON; override; stdcall;
    {$ELSE}
    function GetGlyph: HICON; override; stdcall;
    {$ENDIF}
    function GetState: TExpertState; override;
    function GetIDString: string; override;
    function GetMenuText: string; override;
    procedure Execute; override;
  end;


  TadxolFormModuleCreator = class(TIModuleCreatorEx)
  private
    FAncestorIdent: string;
    FAncestorClass: TClass;
    FFormIdent: string;
    FUnitIdent: string;
    FFileName: string;
  public
    function Existing: boolean; override;
    function GetFileName: string; override;
    function GetFileSystem: string; override;
    function GetFormName: string; override;
    function GetAncestorName: string; override;
    function NewModuleSource(const UnitIdent,
       FormIdent, AncestorIdent: string): string; override;
    function GetIntfName: string; override;
    function NewIntfSource(const UnitIdent, FormIdent,
       AncestorIdent: string): string; override;
    procedure FormCreated(Form: TIFormInterface); override;
  end;

  TadxxlFormModuleCreator = class(TIModuleCreatorEx)
  private
    FAncestorIdent: string;
    FAncestorClass: TClass;
    FFormIdent: string;
    FUnitIdent: string;
    FFileName: string;
  public
    function Existing: boolean; override;
    function GetFileName: string; override;
    function GetFileSystem: string; override;
    function GetFormName: string; override;
    function GetAncestorName: string; override;
    function NewModuleSource(const UnitIdent,
       FormIdent, AncestorIdent: string): string; override;
    function GetIntfName: string; override;
    function NewIntfSource(const UnitIdent, FormIdent,
       AncestorIdent: string): string; override;
    procedure FormCreated(Form: TIFormInterface); override;
  end;

  TadxwdFormModuleCreator = class(TIModuleCreatorEx)
  private
    FAncestorIdent: string;
    FAncestorClass: TClass;
    FFormIdent: string;
    FUnitIdent: string;
    FFileName: string;
  public
    function Existing: boolean; override;
    function GetFileName: string; override;
    function GetFileSystem: string; override;
    function GetFormName: string; override;
    function GetAncestorName: string; override;
    function NewModuleSource(const UnitIdent,
       FormIdent, AncestorIdent: string): string; override;
    function GetIntfName: string; override;
    function NewIntfSource(const UnitIdent, FormIdent,
       AncestorIdent: string): string; override;
    procedure FormCreated(Form: TIFormInterface); override;
  end;

  TadxppFormModuleCreator = class(TIModuleCreatorEx)
  private
    FAncestorIdent: string;
    FAncestorClass: TClass;
    FFormIdent: string;
    FUnitIdent: string;
    FFileName: string;
  public
    function Existing: boolean; override;
    function GetFileName: string; override;
    function GetFileSystem: string; override;
    function GetFormName: string; override;
    function GetAncestorName: string; override;
    function NewModuleSource(const UnitIdent,
       FormIdent, AncestorIdent: string): string; override;
    function GetIntfName: string; override;
    function NewIntfSource(const UnitIdent, FormIdent,
       AncestorIdent: string): string; override;
    procedure FormCreated(Form: TIFormInterface); override;
  end;

  TadxolModuleEditor = class(TDefaultEditor)
  private
    class procedure ResetRegions(ProgID: string);
    class procedure ResetRoot(CurrentUser: boolean);
    class procedure ResetLocalSettings(CurrentUser: boolean; ProgID: string);
  protected
    {$IFDEF ADX_VCL5}
    procedure EditProperty(PropertyEditor: TPropertyEditor;
      var Continue, FreeEditor: Boolean); override;
    {$ELSE}
    procedure EditProperty(const Prop: IProperty;
      var Continue: Boolean); override;
    {$ENDIF}
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;


  TadxExcelModuleEditor = class(TDefaultEditor)
  private
    class procedure ResetRegions(ProgID: string);
    class procedure ResetRoot(CurrentUser: boolean);
    class procedure ResetLocalSettings(CurrentUser: boolean; ProgID: string);
  protected
    {$IFDEF ADX_VCL5}
    procedure EditProperty(PropertyEditor: TPropertyEditor;
      var Continue, FreeEditor: Boolean); override;
    {$ELSE}
    procedure EditProperty(const Prop: IProperty;
      var Continue: Boolean); override;
    {$ENDIF}
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TadxWordModuleEditor = class(TDefaultEditor)
  private
    class procedure ResetRegions(ProgID: string);
    class procedure ResetRoot(CurrentUser: boolean);
    class procedure ResetLocalSettings(CurrentUser: boolean; ProgID: string);
  protected
    {$IFDEF ADX_VCL5}
    procedure EditProperty(PropertyEditor: TPropertyEditor;
      var Continue, FreeEditor: Boolean); override;
    {$ELSE}
    procedure EditProperty(const Prop: IProperty;
      var Continue: Boolean); override;
    {$ENDIF}
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TadxPowerPointModuleEditor = class(TDefaultEditor)
  private
    class procedure ResetRegions(ProgID: string);
    class procedure ResetRoot(CurrentUser: boolean);
    class procedure ResetLocalSettings(CurrentUser: boolean; ProgID: string);
  protected
    {$IFDEF ADX_VCL5}
    procedure EditProperty(PropertyEditor: TPropertyEditor;
      var Continue, FreeEditor: Boolean); override;
    {$ELSE}
    procedure EditProperty(const Prop: IProperty;
      var Continue: Boolean); override;
    {$ENDIF}
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TSourceIndex = (siXPAppProject, siXPAppModule);

  {$IFDEF DELPHI_9_UP}

  TXPRepositoryWizard = class(TNotifierObject, IOTARepositoryWizard80)
  private
    FIndex: Integer;
    ModuleText: PChar;
    ModuleSources: array[TSourceIndex] of PChar;
    procedure SetIndex(const Value: Integer);
  public
    constructor Create;
    destructor Destroy; override;


    function GetName: string;
    function GetComment: string;
    function GetGlyph: Cardinal;
    function GetState: TWizardState;
    function GetIDString: string;
    function GetAuthor: string;
    function GetPage: string;
    procedure Execute;
//
    function GetDesigner: string;
    function GetGalleryCategory: IOTAGalleryCategory;
    function GetPersonality: string;


    property Index: Integer read FIndex write SetIndex;
  end;
  {$ENDIF}

  {$IFDEF DELPHI_9_UP}
var
  //XPAppProjectExpert : TXPAppProjectExpert;
  XPRepositoryWizard : TXPRepositoryWizard;
  //XPAppProject: TXPAppProject;
  OlFormModule : TadxolFormModuleCreator;
  XlFormModule : TadxxlFormModuleCreator;
  WdFormModule : TadxwdFormModuleCreator;
  PpFormModule : TadxppFormModuleCreator;
  {$ENDIF}

function MsgBox(const Msg, ACaption: string; DlgType: TMsgDlgType = mtError;
  Buttons: TMsgDlgButtons = [mbOK]): Integer;

implementation

{$R adxolWizard.res}

uses
  Forms, TypInfo, {$IFDEF DELPHI_9_UP}adxolBDSFormCreator,{$ENDIF}
  adxolFormsManager,
  adxwdFormsManager,
  adxppFormsManager,
  adxxlFormsManager;

const
  CRLF = #13#10;
  COMMENT_LINE =
'//------------------------------------------------------------------------­---' + CRLF;


function MsgBox(const Msg, ACaption: string; DlgType: TMsgDlgType = mtError;
  Buttons: TMsgDlgButtons = [mbOK]): Integer;
begin
  with CreateMessageDialog(Msg, DlgType, Buttons) do
    try
      Caption := ACaption;
      Position := poScreenCenter;
      Result := ShowModal;
    finally
      Free;
    end;
end;


{ TadxolFormModuleCreator }

function TadxolFormModuleCreator.Existing: boolean;
begin
  Result := FALSE;
end;


function TadxolFormModuleCreator.GetFileName: string;
begin
  Result := FFileName;
end;


function TadxolFormModuleCreator.GetFileSystem: string;
begin
  Result := '';
end;


function TadxolFormModuleCreator.GetFormName: string;
begin
  Result := FFormIdent;
end;


function TadxolFormModuleCreator.GetAncestorName: string;
begin
  Result := FAncestorIdent;
end;

{$IFDEF VCL_5}
function GetCustomFormUnit(const AClass: TClass): string;
begin
  {$IFDEF UNICODE}
  Result := string(GetTypeData(PTypeInfo(AClass.ClassInfo))^.UnitName);
  {$ELSE}
  Result := GetTypeData(PTypeInfo(AClass.ClassInfo))^.UnitName;
  {$ENDIF}
end;
{$ENDIF VCL_5}

type
  TResetRegionsMethod = procedure(ProgID: string);
  Globals = class
    class function ADXOLForm(root: boolean): string;
    class function ADXXLForm: string;
    class function ADXWDForm: string;
    class function ADXPPForm: string;

    class procedure ScanTLB(method: TResetRegionsMethod);
  end;


function TadxolFormModuleCreator.GetIntfName: string;
begin
  Result := '';
end;



function TadxolFormModuleCreator.NewIntfSource(const UnitIdent, FormIdent,
   AncestorIdent: string): string;
begin
  Result := ''; // Delphi doesn't use this
end;


function TadxolFormModuleCreator.NewModuleSource(
   const UnitIdent, FormIdent,
   AncestorIdent: string): string;
begin
  Result := 'unit ' + FUnitIdent + ';' + CRLF + CRLF +
     'interface' + CRLF + CRLF +
     'uses' + CRLF +
     '  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs';


  Result := Result + ',' + CRLF +
     '  Outlook2000, adxolFormsManager'; //+ GetCustomFormUnit(FAncestorClass);


  Result := Result + ';' + CRLF + CRLF +
     'type' + CRLF +
     '  T' + FFormIdent + ' = class(' + FAncestorClass.ClassName + ')' +
CRLF +
//     '    Label1: TLabel;' +
//CRLF +
     '  private' + CRLF +
     '    { Private declarations }' + CRLF +
     '  protected' + CRLF +
     '    { Protected declarations }' + CRLF +
     '  public' + CRLF +
     '    { Public declarations }' + CRLF +
     '  published' + CRLF +
     '    { Published declarations }' + CRLF +
     '  end;' + CRLF + CRLF +
     '{NOTE: The ' + FFormIdent + ' variable is intended for the exclusive use' + CRLF +
     '       by the TadxOlFormsCollectionItem Designer.' + CRLF +
     '       NEVER use this variable for other purposes.}' + CRLF +
     'var' + CRLF +
     '  ' + FFormIdent + ' : T' + FFormIdent + ';' + CRLF + CRLF +
     'implementation' + CRLF + CRLF +
     '{$R *.DFM}' + CRLF + CRLF +

     'initialization' + CRLF +

     '  RegisterClass(TPersistentClass(T' + FFormIdent + '));' + CRLF + CRLF +

     'finalization' + CRLF +

     'end.' + CRLF;
end;


procedure TadxolFormModuleCreator.FormCreated(Form: TIFormInterface);
begin
  // do nothing
end;

{ TadxxlFormModuleCreator }

function TadxxlFormModuleCreator.Existing: boolean;
begin
  Result := FALSE;
end;


function TadxxlFormModuleCreator.GetFileName: string;
begin
  Result := FFileName;
end;


function TadxxlFormModuleCreator.GetFileSystem: string;
begin
  Result := '';
end;


function TadxxlFormModuleCreator.GetFormName: string;
begin
  Result := FFormIdent;
end;


function TadxxlFormModuleCreator.GetAncestorName: string;
begin
  Result := FAncestorIdent;
end;

function TadxxlFormModuleCreator.GetIntfName: string;
begin
  Result := '';
end;

function TadxxlFormModuleCreator.NewIntfSource(const UnitIdent, FormIdent,
   AncestorIdent: string): string;
begin
  Result := ''; // Delphi doesn't use this
end;


function TadxxlFormModuleCreator.NewModuleSource(
   const UnitIdent, FormIdent,
   AncestorIdent: string): string;
begin
  Result := 'unit ' + FUnitIdent + ';' + CRLF + CRLF +
     'interface' + CRLF + CRLF +
     'uses' + CRLF +
     '  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs';


  Result := Result + ',' + CRLF +
     '  Excel2000, adxxlFormsManager'; //+ GetCustomFormUnit(FAncestorClass);


  Result := Result + ';' + CRLF + CRLF +
     'type' + CRLF +
     '  T' + FFormIdent + ' = class(' + FAncestorClass.ClassName + ')' +
CRLF +
//     '    Label1: TLabel;' +
//CRLF +
     '  private' + CRLF +
     '    { Private declarations }' + CRLF +
     '  protected' + CRLF +
     '    { Protected declarations }' + CRLF +
     '  public' + CRLF +
     '    { Public declarations }' + CRLF +
     '  published' + CRLF +
     '    { Published declarations }' + CRLF +
     '  end;' + CRLF + CRLF +
     '{NOTE: The ' + FFormIdent + ' variable is intended for the exclusive use' + CRLF +
     '       by the TadxExcelTaskPanesCollectionItem Designer.' + CRLF +
     '       NEVER use this variable for other purposes.}' + CRLF +
     'var' + CRLF +
     '  ' + FFormIdent + ' : T' + FFormIdent + ';' + CRLF + CRLF +
     'implementation' + CRLF + CRLF +
     '{$R *.DFM}' + CRLF + CRLF +

     'initialization' + CRLF +

     '  RegisterClass(TPersistentClass(T' + FFormIdent + '));' + CRLF + CRLF +

     'finalization' + CRLF +

     'end.' + CRLF;
end;


procedure TadxxlFormModuleCreator.FormCreated(Form: TIFormInterface);
begin
  // do nothing
end;

{ TadxolCustomExpert }

function TadxExtCustomExpert.GetAuthor: string;
begin
  Result := 'Add-in Express Ltd. (www.add-in-express.com)';
end;

function TadxExtCustomExpert.GetPage: string;
begin
  Result := 'Add-in Express VCL';
end;

function TadxExtCustomExpert.GetState: TWizardState;
begin
  // not used in a esForm expert
  Result := [wsEnabled];
end;

{ TadxolFormExpert }
{$HINTS OFF}
procedure TadxolFormExpert.Execute;
var
  IModuleCreator : TadxolFormModuleCreator;
  IModule : TIModuleInterface;
  Check: boolean;
begin
  {$IFDEF ADX_INTERNAL}
  {$IFNDEF ADXXOL_TRIAL}
  {$I adxxcheck.inc}
  {$ELSE}
  {$I adxxtrl3.inc}
  {$ENDIF}
  {$ENDIF}

  IModuleCreator := TadxolFormModuleCreator.Create;
  try
    IModuleCreator.FAncestorIdent := 'adxOlForm'; // Don't include the 'T'!!!!
    IModuleCreator.FAncestorClass := TadxOlForm; //  TadxForm;
    {$IFDEF DELPHI_9_UP}
    OlFormModule := TadxolFormModuleCreator.Create;

    OlFormModule.FAncestorIdent := 'adxOlForm'; // Don't include the 'T'!!!!
    OlFormModule.FAncestorClass := TadxOlForm; //  TadxForm;

    (BorlandIDEServices as IOTAModuleServices70).GetNewModuleAndClassName(OlFormModule.FAncestorIdent,
OlFormModule.FUnitIdent,OlFormModule.FFormIdent,OlFormModule.FFileName);


    IModule:=ToolServices.ModuleCreateEx(OlFormModule, [cmAddToProject, cmShowSource,
    cmShowForm, cmUnNamed, cmNewFile]);
    {$ELSE}
    ToolServices.GetNewModuleAndClassName(IModuleCreator.FAncestorIdent,
      IModuleCreator.FUnitIdent,IModuleCreator.FFormIdent,IModuleCreator.FFileName);

    IModule:=ToolServices.ModuleCreateEx(IModuleCreator, [cmShowSource,
       cmShowForm, cmMarkModified, cmAddToProject, cmUnNamed]);
    {$ENDIF}

    IModule.Free;
  finally
    IModuleCreator.Free;
  end;
end;
{$HINTS ON}

function TadxolFormExpert.GetAuthor: string;
begin
  Result := 'Add-in Express Ltd. (www.add-in-express.com)';
end;

function TadxolFormExpert.GetComment: string;
begin
  Result := 'Create a new TadxOlForm in current project';
end;

{$IFDEF ADX_VCL5}
function TadxolFormExpert.GetGlyph: HICON;
{$ELSE}
function TadxolFormExpert.GetGlyph: HICON;
{$ENDIF}
begin
  Result := LoadIcon(HInstance, 'ADX_OL_NEWFORM_ICON');
end;

function TadxolFormExpert.GetIDString: string;
begin
  // must be unique
  Result := 'ADXOL.adxolFormWizard';
end;

function TadxolFormExpert.GetMenuText: string;
begin
  result := '';
end;

function TadxolFormExpert.GetName: string;
begin
Result := sLayeredOlFormObjRepositoryPage;
end;

function TadxolFormExpert.GetPage: string;
begin
  Result := 'Add-in Express VCL';
end;

function TadxolFormExpert.GetState: TExpertState;
begin
  // not used in a esForm expert
  Result := [esEnabled];
end;

function TadxolFormExpert.GetStyle: TExpertStyle;
begin
  Result := esForm;
end;

{ TadxxlFormExpert }
{$HINTS OFF}
procedure TadxxlFormExpert.Execute;
var
  IModuleCreator : TadxxlFormModuleCreator;
  IModule : TIModuleInterface;
  Check: boolean;
begin
  {$IFDEF ADX_INTERNAL}
  {$IFNDEF ADXXOL_TRIAL}
  {$I adxxcheck.inc}
  {$ELSE}
  {$I adxxtrl3.inc}
  {$ENDIF}
  {$ENDIF}

  IModuleCreator := TadxxlFormModuleCreator.Create;
  try
    IModuleCreator.FAncestorIdent := 'adxExcelTaskPane'; // Don't include the 'T'!!!!
    IModuleCreator.FAncestorClass := TadxExcelTaskPane; //  TadxExcelTaskPane;
    {$IFDEF DELPHI_9_UP}
    XlFormModule := TadxxlFormModuleCreator.Create;

    XlFormModule.FAncestorIdent := 'adxExcelTaskPane'; // Don't include the 'T'!!!!
    XlFormModule.FAncestorClass := TadxExcelTaskPane; //  TadxExcelTaskPane;

    (BorlandIDEServices as IOTAModuleServices70).GetNewModuleAndClassName(XlFormModule.FAncestorIdent,
XlFormModule.FUnitIdent,XlFormModule.FFormIdent,XlFormModule.FFileName);


    IModule:=ToolServices.ModuleCreateEx(XlFormModule, [cmAddToProject, cmShowSource,
    cmShowForm, cmUnNamed, cmNewFile]);
    {$ELSE}
    ToolServices.GetNewModuleAndClassName(IModuleCreator.FAncestorIdent,
      IModuleCreator.FUnitIdent,IModuleCreator.FFormIdent,IModuleCreator.FFileName);

    IModule:=ToolServices.ModuleCreateEx(IModuleCreator, [cmShowSource,
       cmShowForm, cmMarkModified, cmAddToProject, cmUnNamed]);
    {$ENDIF}

    IModule.Free;
  finally
    IModuleCreator.Free;
  end;
end;
{$HINTS ON}

function TadxxlFormExpert.GetAuthor: string;
begin
  Result := 'Add-in Express Ltd. (www.add-in-express.com)';
end;

function TadxxlFormExpert.GetComment: string;
begin
  Result := 'Create a new TadxExcelTaskPane in current project';
end;

{$IFDEF ADX_VCL5}
function TadxxlFormExpert.GetGlyph: HICON;
{$ELSE}
function TadxxlFormExpert.GetGlyph: HICON;
{$ENDIF}
begin
  Result := LoadIcon(HInstance, 'ADX_XL_NEWFORM_ICON');
end;

function TadxxlFormExpert.GetIDString: string;
begin
  // must be unique
  Result := 'ADXXL.adxxlFormWizard';
end;

function TadxxlFormExpert.GetMenuText: string;
begin
  result := '';
end;

function TadxxlFormExpert.GetName: string;
begin
Result := sLayeredXlFormObjRepositoryPage;
end;

function TadxxlFormExpert.GetPage: string;
begin
  Result := 'Add-in Express VCL';
end;

function TadxxlFormExpert.GetState: TExpertState;
begin
  // not used in a esForm expert
  Result := [esEnabled];
end;

function TadxxlFormExpert.GetStyle: TExpertStyle;
begin
  Result := esForm;
end;

{ TadxolModuleEditor }

{$IFDEF ADX_VCL5}
procedure TadxolModuleEditor.EditProperty(PropertyEditor: TPropertyEditor;
  var Continue, FreeEditor: Boolean);
{$ELSE}
procedure TadxolModuleEditor.EditProperty(const Prop: IProperty;
  var Continue: Boolean);
{$ENDIF}
var
  PropName: string;
begin
  {$IFDEF ADX_VCL5}
  inherited EditProperty(PropertyEditor, Continue, FreeEditor);
  PropName := PropertyEditor.GetName;
  {$ELSE}
  inherited EditProperty(Prop, Continue);
  PropName := Prop.GetName;
  {$ENDIF}
  if CompareText(PropName, 'Items') = 0 then begin
    {$IFDEF ADX_VCL5}
    PropertyEditor.Edit;
    {$ELSE}
    Prop.Edit;
    {$ENDIF}
    Continue := False;
  end;
end;

procedure TadxolModuleEditor.ExecuteVerb(Index: Integer);
var
  tlbFile: string;
  i, Count: Integer;
  ILib: ITypeLib;
  IType: ITypeInfo;
  TypeAttr: PTypeAttr;
  tk: ActiveX.TTypeKind;
  PropName: WideString;
  HelpContext: Longint;
  LibName: string;
  ProgID: string;
begin
  {$IFDEF DELPHI_9_UP}
  tlbFile := ChangeFileExt((BorlandIDEServices as IOTAModuleServices).GetActiveProject.FileName, '.tlb');
  {$ELSE}
  tlbFile := ChangeFileExt(ToolServices.GetProjectName, '.tlb');
  {$ENDIF}
  if not FileExists(tlbFile) then
    raise Exception.Create(Format('Cannot find the "%s" file!', [ExtractFileName(tlbFile)]));
  SetLength(PropName, 1024);
  try
    if (LoadTypeLibEx(PWideChar(WideString(tlbFile)), REGKIND_NONE, ILib) = S_OK) and Assigned(ILib) then
      try
        Count := ILib.GetTypeInfoCount;
        ILib.GetDocumentation(MEMBERID_NIL, @PropName, nil, @HelpContext, nil);
        LibName := PropName;
        for i := 0 to Count - 1 do begin
          ILib.GetTypeInfoType(i, tk);
          if tk = TKIND_COCLASS then begin
            ILib.GetTypeInfo(i, IType);
            try
              IType.GetTypeAttr(TypeAttr);
              try
                //if TypeAttr^.wTypeFlags = 34 then // Control & CanCreate
                if ((TypeAttr^.wTypeFlags and TYPEFLAG_FCONTROL) = 0) and
                  ((TypeAttr^.wTypeFlags and TYPEFLAG_FCANCREATE) = TYPEFLAG_FCANCREATE) then
                begin
                  IType.GetDocumentation(MEMBERID_NIL, @PropName, nil, @HelpContext, nil);
                  ProgID := LibName + '.' + PropName;
                  ResetRegions(ProgID);
                end;
              finally
                IType.ReleaseTypeAttr(TypeAttr);
              end;
            finally
              IType := nil;
            end;
          end;
        end;
      finally
        ILib := nil;
      end;
  finally
    SetLength(PropName, 0);
  end;
  MessageDlg('Add-in Express Regions data have been reset.', mtInformation, [mbOk], 0);
end;

function TadxolModuleEditor.GetVerb(Index: Integer): string;
begin
  Result := 'Reset Regions';
end;

function TadxolModuleEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{ TadxxlModuleEditor }

{$IFDEF ADX_VCL5}
procedure TadxExcelModuleEditor.EditProperty(PropertyEditor: TPropertyEditor;
  var Continue, FreeEditor: Boolean);
{$ELSE}
procedure TadxExcelModuleEditor.EditProperty(const Prop: IProperty;
  var Continue: Boolean);
{$ENDIF}
var
  PropName: string;
begin
  {$IFDEF ADX_VCL5}
  inherited EditProperty(PropertyEditor, Continue, FreeEditor);
  PropName := PropertyEditor.GetName;
  {$ELSE}
  inherited EditProperty(Prop, Continue);
  PropName := Prop.GetName;
  {$ENDIF}
  if CompareText(PropName, 'Items') = 0 then begin
    {$IFDEF ADX_VCL5}
    PropertyEditor.Edit;
    {$ELSE}
    Prop.Edit;
    {$ENDIF}
    Continue := False;
  end;
end;


{ TadxolFormExpert2 }

function TadxolFormExpert2.GetIDString: string;
begin
  Result := 'ADXOL.adxolFormWizard2';
end;

{$IFDEF ADX_VCL5}
function TadxolFormExpert2.GetGlyph: HICON;
{$ELSE}
function TadxolFormExpert2.GetGlyph: Cardinal;
{$ENDIF}
begin
  Result := LoadIcon(HInstance, 'ADX_OL_NEWFORM_ICON');
end;

function TadxolFormExpert2.GetName: string;
begin
Result := sLayeredOlFormObjRepositoryPage2;
end;

function TadxolFormExpert2.GetComment: string;
begin
  Result := 'Create a new TadxOlForm in current project';
end;
{$HINTS OFF}
procedure TadxolFormExpert2.Execute;

var
  {$IFDEF DELPHI_9_UP}
  OTAModuleServices : IOTAModuleServices;
  myOlCreator: TadxOlFormCreator;
  fNewUnitIdent, fNewClassName, fNewFileName: string;
  {$ELSE}
  IModuleCreator : TadxolFormModuleCreator;
  IModule : TIModuleInterface;
  {$ENDIF}
  Check: boolean;
begin
  {$IFDEF ADX_INTERNAL}
  {$IFNDEF ADXXOL_TRIAL}
  {$I adxxcheck.inc}
  {$ELSE}
  {$I adxxtrl3.inc}
  {$ENDIF}
  {$ENDIF}

  {$IFDEF DELPHI_9_UP}

  try
    if BorlandIDEServices.QueryInterface(IOTAModuleServices, OTAModuleServices) = S_OK then begin
      myOlCreator := TadxOlFormCreator.Create;
      fNewClassName := 'adxOlForm';
      OTAModuleServices.GetNewModuleAndClassName('Unit', fNewUnitIdent, fNewClassName, fNewFileName);

      myOlCreator.NewUnitIdent := fNewUnitIdent;
      myOlCreator.NewClassName := fNewClassName;
      myOlCreator.NewFileName := fNewFileName;
      OTAModuleServices.CreateModule(myOlCreator);
    end; // if BorlandIDEServices.QueryInterface(IOTAModuleServices, OTAModuleServices) = S_OK
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
  {$ELSE}
  IModule := nil;
  IModuleCreator := nil;

  try
    IModuleCreator := TadxolFormModuleCreator.Create;
    IModuleCreator.FAncestorIdent := 'adxOlForm'; // Don't include the 'T'!!!!
    IModuleCreator.FAncestorClass := TadxOlForm; //  TadxForm;

    ToolServices.GetNewModuleAndClassName(IModuleCreator.FAncestorIdent,
      IModuleCreator.FUnitIdent,IModuleCreator.FFormIdent,IModuleCreator.FFileName);
    if (ToolServices <> nil) then  begin
      IModule:=ToolServices.ModuleCreateEx(IModuleCreator, [cmShowSource,
         cmShowForm, cmMarkModified, cmAddToProject, cmUnNamed]);
    end else begin
      ShowMessage('ToolServices is null');
    end;
    if Assigned(IModule) then
      IModule.Free;
  finally
    if IModuleCreator <> nil then
      IModuleCreator.Free;
  end;
  {$ENDIF}

end;
{$HINTS ON}


{ TadxxlFormExpert2 }

function TadxxlFormExpert2.GetIDString: string;
begin
  Result := 'ADXXL.adxxlFormWizard2';
end;

{$IFDEF ADX_VCL5}
function TadxxlFormExpert2.GetGlyph: HICON;
{$ELSE}
function TadxxlFormExpert2.GetGlyph: Cardinal;
{$ENDIF}
begin
  Result := LoadIcon(HInstance, 'ADX_XL_NEWFORM_ICON');
end;

function TadxxlFormExpert2.GetName: string;
begin
Result := sLayeredXlFormObjRepositoryPage2;
end;

function TadxxlFormExpert2.GetComment: string;
begin
  Result := 'Create a new TadxExcelTaskPane in current project';
end;
{$HINTS OFF}
procedure TadxxlFormExpert2.Execute;

var
  {$IFDEF DELPHI_9_UP}
  OTAModuleServices : IOTAModuleServices;
  myXlCreator: TadxXlFormCreator;
  fNewUnitIdent, fNewClassName, fNewFileName: string;
  {$ELSE}
  IModuleCreator : TadxxlFormModuleCreator;
  IModule : TIModuleInterface;
  {$ENDIF}
  Check: boolean;
begin
  {$IFDEF ADX_INTERNAL}
  {$IFNDEF ADXXOL_TRIAL}
  {$I adxxcheck.inc}
  {$ELSE}
  {$I adxxtrl3.inc}
  {$ENDIF}
  {$ENDIF}

  {$IFDEF DELPHI_9_UP}

  try
    if BorlandIDEServices.QueryInterface(IOTAModuleServices, OTAModuleServices) = S_OK then begin
      myXlCreator := TadxXlFormCreator.Create;
      fNewClassName := 'adxExcelTaskPane';
      OTAModuleServices.GetNewModuleAndClassName('Unit', fNewUnitIdent, fNewClassName, fNewFileName);

      myXlCreator.NewUnitIdent := fNewUnitIdent;
      myXlCreator.NewClassName := fNewClassName;
      myXlCreator.NewFileName := fNewFileName;
      OTAModuleServices.CreateModule(myXlCreator);
    end; // if BorlandIDEServices.QueryInterface(IOTAModuleServices, OTAModuleServices) = S_OK
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
  {$ELSE}
  IModule := nil;
  IModuleCreator := nil;

  try
    IModuleCreator := TadxxlFormModuleCreator.Create;
    IModuleCreator.FAncestorIdent := 'adxExcelTaskPane'; // Don't include the 'T'!!!!
    IModuleCreator.FAncestorClass := TadxExcelTaskPane; //  TadxExcelTaskPane;

    ToolServices.GetNewModuleAndClassName(IModuleCreator.FAncestorIdent,
      IModuleCreator.FUnitIdent,IModuleCreator.FFormIdent,IModuleCreator.FFileName);
    if (ToolServices <> nil) then  begin
      IModule:=ToolServices.ModuleCreateEx(IModuleCreator, [cmShowSource,
         cmShowForm, cmMarkModified, cmAddToProject, cmUnNamed]);
    end else begin
      ShowMessage('ToolServices is null');
    end;
    if Assigned(IModule) then
      IModule.Free;
  finally
    if IModuleCreator <> nil then
      IModuleCreator.Free;
  end;
  {$ENDIF}

end;
{$HINTS ON}

{$IFDEF DELPHI_9_UP}

{ TXPRepositoryWizard }


constructor TXPRepositoryWizard.Create;
var
  ResInstance: THandle;
  ResName: PChar;
  P: PChar;
  SourceIndex: TSourceIndex; 
begin 
  ResInstance:= FindResourceHInstance(HInstance); 
  ResName:= 'XPAPPCODE'; 
  ModuleText:= StrNew(PChar(LockResource(LoadResource(ResInstance,
    FindResource(ResInstance, ResName, RT_RCDATA))))); 
  P:= ModuleText; 
  for SourceIndex:= Low(TSourceIndex) to High(TSourceIndex) do 
  begin 
    ModuleSources[SourceIndex]:= P; 
    while P^ <> '|' do 
    begin
      {$IFDEF UNICODE}
      if IsLeadChar(P^) then Inc(P);
      {$ELSE}
      if P^ in LeadBytes then Inc(P);
      {$ENDIF}
      Inc(P); 
    end;
    P^:= #0; 
    Inc(P);
  end;
end;


destructor TXPRepositoryWizard.Destroy;
begin
  XPRepositoryWizard:= nil;
  StrDispose(ModuleText);
  inherited;
end;


procedure TXPRepositoryWizard.Execute;
begin
  //ToolServices.ProjectCreate(XPAppProject, [cpApplication]);
end;


function TXPRepositoryWizard.GetAuthor: string; 
begin
  Result:= 'Borland'; 
end; 


function TXPRepositoryWizard.GetComment: string; 
begin 
  Result:= 'Creates a new XP enabled application'; 
end; 


function TXPRepositoryWizard.GetDesigner: string;
begin 
  Result := '';
end;


function TXPRepositoryWizard.GetGalleryCategory: IOTAGalleryCategory;
var
  Manager: IOTAGalleryCategoryManager;
begin
  raise Exception.Create('/4/');
  if (BorlandIDEServices <> nil) and
    Supports(BorlandIDEServices, IOTAGalleryCategoryManager, Manager) then
    Result := Manager.FindCategory(sCategoryDelphiNew) else
    Result := nil;
end;


function TXPRepositoryWizard.GetGlyph: Cardinal;
begin 
  Result:= LoadIcon(HInstance, 'XPAPP'); 
end; 


function TXPRepositoryWizard.GetIDString: string; 
begin 
  Result:= 'Borland.XPProject'; 
end; 


function TXPRepositoryWizard.GetName: string; 
begin 
  Result:= 'XP Application'; 
end;


function TXPRepositoryWizard.GetPage: string; 
begin
  Result:= sCategoryDelphiNew;
end;


function TXPRepositoryWizard.GetPersonality: string;
begin
  Result := sDefaultPersonality;
end;

function TXPRepositoryWizard.GetState: TWizardState;
begin
  Result:= [];
end;

procedure TXPRepositoryWizard.SetIndex(const Value: Integer);
begin
  FIndex := Value;
end;

{$ENDIF}

{ TadxWordModuleEditor }

{$IFDEF ADX_VCL5}
procedure TadxWordModuleEditor.EditProperty(PropertyEditor: TPropertyEditor;
  var Continue, FreeEditor: Boolean);
{$ELSE}
procedure TadxWordModuleEditor.EditProperty(const Prop: IProperty;
  var Continue: Boolean);
{$ENDIF}
var
  PropName: string;
begin
  {$IFDEF ADX_VCL5}
  inherited EditProperty(PropertyEditor, Continue, FreeEditor);
  PropName := PropertyEditor.GetName;
  {$ELSE}
  inherited EditProperty(Prop, Continue);
  PropName := Prop.GetName;
  {$ENDIF}
  if CompareText(PropName, 'Items') = 0 then begin
    {$IFDEF ADX_VCL5}
    PropertyEditor.Edit;
    {$ELSE}
    Prop.Edit;
    {$ENDIF}
    Continue := False;
  end;
end;

class procedure TadxWordModuleEditor.ResetRegions(ProgID: string);
begin
  ResetRoot(true);
  ResetLocalSettings(true, ProgID);
  ResetLocalSettings(false, ProgID);
end;

class procedure TadxWordModuleEditor.ResetRoot(CurrentUser: boolean);
var
  Reg: TRegistry;
  i: integer;
  valueNames: TStringList;
  key: string;
begin

  key := '\Software\Microsoft\Office\Word\AddIns\' + Globals.ADXWDForm + '\';

  Reg := TRegistry.Create;
  valueNames := TStringList.Create;
  try
    if (CurrentUser) then begin
      Reg.RootKey := HKEY_CURRENT_USER;
    end
    else begin
      Reg.RootKey := HKEY_LOCAL_MACHINE;
    end;

    if (Reg.OpenKey(key, false)) then begin
      Reg.GetValueNames(valueNames);
      for i := 0 to valueNames.Count - 1 do begin
        Reg.DeleteValue(valueNames[i]);
      end;
    end;

  finally
    Reg.CloseKey;
    Reg.Free;
    valueNames.Free;
  end;
end;

class procedure TadxWordModuleEditor.ResetLocalSettings(CurrentUser: boolean; ProgID: string);
var
  Reg: TRegistry;
  i: integer;
  valueNames: TStringList;
  keyNames: TStringList;
  key: string;
begin
  //Local
  key := '\Software\Microsoft\Office\Word\AddIns\' + ProgID + '\' + Globals.ADXWDForm + '\';

  Reg := TRegistry.Create;
  valueNames := TStringList.Create;
  keyNames := TStringList.Create;
  try

    if (CurrentUser) then begin
      Reg.RootKey := HKEY_CURRENT_USER;
    end
    else begin
      Reg.RootKey := HKEY_LOCAL_MACHINE;
    end;

    if (Reg.OpenKey(key, false)) then begin

      Reg.GetValueNames(valueNames);
      for i := 0 to valueNames.Count - 1 do begin
        Reg.DeleteValue(valueNames[i]);
      end;

      Reg.GetKeyNames(keyNames);
      for i := 0 to keyNames.Count - 1 do begin
        if (Pos(TadxWordTaskPanesCollectionItem.ClassName, keyNames[i]) > 0) then begin
          Reg.DeleteKey(keyNames[i]);
        end;
      end;

    end;

  finally
    Reg.CloseKey;
    Reg.Free;
    valueNames.Free;
    keyNames.Free;
  end;
end;


procedure TadxWordModuleEditor.ExecuteVerb(Index: Integer);
var
  tlbFile: string;
  i, Count: Integer;
  ILib: ITypeLib;
  IType: ITypeInfo;
  TypeAttr: PTypeAttr;
  tk: ActiveX.TTypeKind;
  PropName: WideString;
  HelpContext: Longint;
  LibName: string;
  ProgID: string;
begin
  {$IFDEF DELPHI_9_UP}
  tlbFile := ChangeFileExt((BorlandIDEServices as IOTAModuleServices).GetActiveProject.FileName, '.tlb');
  {$ELSE}
  tlbFile := ChangeFileExt(ToolServices.GetProjectName, '.tlb');
  {$ENDIF}
  if not FileExists(tlbFile) then
    raise Exception.Create(Format('Cannot find the "%s" file!', [ExtractFileName(tlbFile)]));
  SetLength(PropName, 1024);
  try
    if (LoadTypeLibEx(PWideChar(WideString(tlbFile)), REGKIND_NONE, ILib) = S_OK) and Assigned(ILib) then
      try
        Count := ILib.GetTypeInfoCount;
        ILib.GetDocumentation(MEMBERID_NIL, @PropName, nil, @HelpContext, nil);
        LibName := PropName;
        for i := 0 to Count - 1 do begin
          ILib.GetTypeInfoType(i, tk);
          if tk = TKIND_COCLASS then begin
            ILib.GetTypeInfo(i, IType);
            try
              IType.GetTypeAttr(TypeAttr);
              try
                //if TypeAttr^.wTypeFlags = 34 then // Control & CanCreate
                if ((TypeAttr^.wTypeFlags and TYPEFLAG_FCONTROL) = 0) and
                  ((TypeAttr^.wTypeFlags and TYPEFLAG_FCANCREATE) = TYPEFLAG_FCANCREATE) then
                begin
                  IType.GetDocumentation(MEMBERID_NIL, @PropName, nil, @HelpContext, nil);
                  ProgID := LibName + '.' + PropName;
                  ResetRegions(ProgID);
                end;
              finally
                IType.ReleaseTypeAttr(TypeAttr);
              end;
            finally
              IType := nil;
            end;
          end;
        end;
      finally
        ILib := nil;
      end;
  finally
    SetLength(PropName, 0);
  end;
  MessageDlg('Add-in Express Task Panes data have been reset.', mtInformation, [mbOk], 0);
end;

function TadxWordModuleEditor.GetVerb(Index: Integer): string;
begin
  Result := 'Reset Task Panes';
end;

function TadxWordModuleEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{ TadxPowerPointModuleEditor }

class procedure TadxPowerPointModuleEditor.ResetRegions(ProgID: string);
begin
  ResetRoot(true);
  ResetLocalSettings(true, ProgID);
  ResetLocalSettings(false, ProgID);
end;

class procedure TadxPowerPointModuleEditor.ResetRoot(CurrentUser: boolean);
var
  Reg: TRegistry;
  i: integer;
  valueNames: TStringList;
  key: string;
begin
  key := '\Software\Microsoft\Office\PowerPoint\AddIns\' + Globals.ADXPPForm + '\';

  Reg := TRegistry.Create;
  valueNames := TStringList.Create;
  try
    if (CurrentUser) then begin
      Reg.RootKey := HKEY_CURRENT_USER;
    end
    else begin
      Reg.RootKey := HKEY_LOCAL_MACHINE;
    end;

    if (Reg.OpenKey(key, false)) then begin
      Reg.GetValueNames(valueNames);
      for i := 0 to valueNames.Count - 1 do begin
        Reg.DeleteValue(valueNames[i]);
      end;
    end;

  finally
    Reg.CloseKey;
    Reg.Free;
    valueNames.Free;
  end;
end;

class procedure TadxPowerPointModuleEditor.ResetLocalSettings(CurrentUser: boolean; ProgID: string);
var
  Reg: TRegistry;
  i: integer;
  valueNames: TStringList;
  keyNames: TStringList;
  key: string;
begin
  //Local
  key := '\Software\Microsoft\Office\PowerPoint\AddIns\' + ProgID + '\' + Globals.ADXPPForm + '\';

  Reg := TRegistry.Create;
  valueNames := TStringList.Create;
  keyNames := TStringList.Create;

  try

    if (CurrentUser) then begin
      Reg.RootKey := HKEY_CURRENT_USER;
    end
    else begin
      Reg.RootKey := HKEY_LOCAL_MACHINE;
    end;

    if (Reg.OpenKey(key, false)) then begin

      Reg.GetValueNames(valueNames);
      for i := 0 to valueNames.Count - 1 do begin
        Reg.DeleteValue(valueNames[i]);
      end;

      Reg.GetKeyNames(keyNames);
      for i := 0 to keyNames.Count - 1 do begin
        if (Pos(TadxPowerPointTaskPanesCollectionItem.ClassName, keyNames[i]) > 0) then begin
          Reg.DeleteKey(keyNames[i]);
        end;
      end;

    end;

  finally
    Reg.CloseKey;
    Reg.Free;
    valueNames.Free;
    keyNames.Free;
  end;
end;


procedure TadxPowerPointModuleEditor.ExecuteVerb(Index: Integer);
var
  tlbFile: string;
  i, Count: Integer;
  ILib: ITypeLib;
  IType: ITypeInfo;
  TypeAttr: PTypeAttr;
  tk: ActiveX.TTypeKind;
  PropName: WideString;
  HelpContext: Longint;
  LibName: string;
  ProgID: string;
begin
  {$IFDEF DELPHI_9_UP}
  tlbFile := ChangeFileExt((BorlandIDEServices as IOTAModuleServices).GetActiveProject.FileName, '.tlb');
  {$ELSE}
  tlbFile := ChangeFileExt(ToolServices.GetProjectName, '.tlb');
  {$ENDIF}
  if not FileExists(tlbFile) then
    raise Exception.Create(Format('Cannot find the "%s" file!', [ExtractFileName(tlbFile)]));
  SetLength(PropName, 1024);
  try
    if (LoadTypeLibEx(PWideChar(WideString(tlbFile)), REGKIND_NONE, ILib) = S_OK) and Assigned(ILib) then
      try
        Count := ILib.GetTypeInfoCount;
        ILib.GetDocumentation(MEMBERID_NIL, @PropName, nil, @HelpContext, nil);
        LibName := PropName;
        for i := 0 to Count - 1 do begin
          ILib.GetTypeInfoType(i, tk);
          if tk = TKIND_COCLASS then begin
            ILib.GetTypeInfo(i, IType);
            try
              IType.GetTypeAttr(TypeAttr);
              try
                //if TypeAttr^.wTypeFlags = 34 then // Control & CanCreate
                if ((TypeAttr^.wTypeFlags and TYPEFLAG_FCONTROL) = 0) and
                  ((TypeAttr^.wTypeFlags and TYPEFLAG_FCANCREATE) = TYPEFLAG_FCANCREATE) then
                begin
                  IType.GetDocumentation(MEMBERID_NIL, @PropName, nil, @HelpContext, nil);
                  ProgID := LibName + '.' + PropName;
                  ResetRegions(ProgID);
                end;
              finally
                IType.ReleaseTypeAttr(TypeAttr);
              end;
            finally
              IType := nil;
            end;
          end;
        end;
      finally
        ILib := nil;
      end;
  finally
    SetLength(PropName, 0);
  end;
  MessageDlg('Add-in Express Task Panes data have been reset.', mtInformation, [mbOk], 0);
end;

function TadxPowerPointModuleEditor.GetVerb(Index: Integer): string;
begin
  Result := 'Reset Task Panes';
end;

function TadxPowerPointModuleEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;


{$IFDEF ADX_VCL5}
procedure TadxPowerPointModuleEditor.EditProperty(PropertyEditor: TPropertyEditor;
  var Continue, FreeEditor: Boolean);
{$ELSE}
procedure TadxPowerPointModuleEditor.EditProperty(const Prop: IProperty;
  var Continue: Boolean);
{$ENDIF}
var
  PropName: string;
begin
  {$IFDEF ADX_VCL5}
  inherited EditProperty(PropertyEditor, Continue, FreeEditor);
  PropName := PropertyEditor.GetName;
  {$ELSE}
  inherited EditProperty(Prop, Continue);
  PropName := Prop.GetName;
  {$ENDIF}
  if CompareText(PropName, 'Items') = 0 then begin
    {$IFDEF ADX_VCL5}
    PropertyEditor.Edit;
    {$ELSE}
    Prop.Edit;
    {$ENDIF}
    Continue := False;
  end;
end;


{ TadxwdFormModuleCreator }

function TadxwdFormModuleCreator.Existing: boolean;
begin
  Result := FALSE;
end;


function TadxwdFormModuleCreator.GetFileName: string;
begin
  Result := FFileName;
end;


function TadxwdFormModuleCreator.GetFileSystem: string;
begin
  Result := '';
end;


function TadxwdFormModuleCreator.GetFormName: string;
begin
  Result := FFormIdent;
end;


function TadxwdFormModuleCreator.GetAncestorName: string;
begin
  Result := FAncestorIdent;
end;

function TadxwdFormModuleCreator.GetIntfName: string;
begin
  Result := '';
end;

function TadxwdFormModuleCreator.NewIntfSource(const UnitIdent, FormIdent,
   AncestorIdent: string): string;
begin
  Result := ''; // Delphi doesn't use this
end;


function TadxwdFormModuleCreator.NewModuleSource(
   const UnitIdent, FormIdent,
   AncestorIdent: string): string;
begin
  Result := 'unit ' + FUnitIdent + ';' + CRLF + CRLF +
     'interface' + CRLF + CRLF +
     'uses' + CRLF +
     '  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs';


  Result := Result + ',' + CRLF +
     '  Word2000, adxwdFormsManager'; //+ GetCustomFormUnit(FAncestorClass);


  Result := Result + ';' + CRLF + CRLF +
     'type' + CRLF +
     '  T' + FFormIdent + ' = class(' + FAncestorClass.ClassName + ')' +
CRLF +
//     '    Label1: TLabel;' +
//CRLF +
     '  private' + CRLF +
     '    { Private declarations }' + CRLF +
     '  protected' + CRLF +
     '    { Protected declarations }' + CRLF +
     '  public' + CRLF +
     '    { Public declarations }' + CRLF +
     '  published' + CRLF +
     '    { Published declarations }' + CRLF +
     '  end;' + CRLF + CRLF +
     '{NOTE: The ' + FFormIdent + ' variable is intended for the exclusive use' + CRLF +
     '       by the TadxWordTaskPanesCollectionItem Designer.' + CRLF +
     '       NEVER use this variable for other purposes.}' + CRLF +
     'var' + CRLF +
     '  ' + FFormIdent + ' : T' + FFormIdent + ';' + CRLF + CRLF +
     'implementation' + CRLF + CRLF +
     '{$R *.DFM}' + CRLF + CRLF +

     'initialization' + CRLF +

     '  RegisterClass(TPersistentClass(T' + FFormIdent + '));' + CRLF + CRLF +

     'finalization' + CRLF +

     'end.' + CRLF;
end;


procedure TadxwdFormModuleCreator.FormCreated(Form: TIFormInterface);
begin
  // do nothing
end;

{ TadxppFormModuleCreator }

function TadxppFormModuleCreator.Existing: boolean;
begin
  Result := FALSE;
end;


function TadxppFormModuleCreator.GetFileName: string;
begin
  Result := FFileName;
end;


function TadxppFormModuleCreator.GetFileSystem: string;
begin
  Result := '';
end;


function TadxppFormModuleCreator.GetFormName: string;
begin
  Result := FFormIdent;
end;


function TadxppFormModuleCreator.GetAncestorName: string;
begin
  Result := FAncestorIdent;
end;

function TadxppFormModuleCreator.GetIntfName: string;
begin
  Result := '';
end;

function TadxppFormModuleCreator.NewIntfSource(const UnitIdent, FormIdent,
   AncestorIdent: string): string;
begin
  Result := ''; // Delphi doesn't use this
end;


function TadxppFormModuleCreator.NewModuleSource(
   const UnitIdent, FormIdent,
   AncestorIdent: string): string;
begin
  Result := 'unit ' + FUnitIdent + ';' + CRLF + CRLF +
     'interface' + CRLF + CRLF +
     'uses' + CRLF +
     '  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs';


  Result := Result + ',' + CRLF +
     '  MSPpt2000, adxppFormsManager'; //+ GetCustomFormUnit(FAncestorClass);


  Result := Result + ';' + CRLF + CRLF +
     'type' + CRLF +
     '  T' + FFormIdent + ' = class(' + FAncestorClass.ClassName + ')' +
CRLF +
//     '    Label1: TLabel;' +
//CRLF +
     '  private' + CRLF +
     '    { Private declarations }' + CRLF +
     '  protected' + CRLF +
     '    { Protected declarations }' + CRLF +
     '  public' + CRLF +
     '    { Public declarations }' + CRLF +
     '  published' + CRLF +
     '    { Published declarations }' + CRLF +
     '  end;' + CRLF + CRLF +
     '{NOTE: The ' + FFormIdent + ' variable is intended for the exclusive use' + CRLF +
     '       by the TadxPowerPointTaskPanesCollectionItem Designer.' + CRLF +
     '       NEVER use this variable for other purposes.}' + CRLF +
     'var' + CRLF +
     '  ' + FFormIdent + ' : T' + FFormIdent + ';' + CRLF + CRLF +
     'implementation' + CRLF + CRLF +
     '{$R *.DFM}' + CRLF + CRLF +

     'initialization' + CRLF +

     '  RegisterClass(TPersistentClass(T' + FFormIdent + '));' + CRLF + CRLF +

     'finalization' + CRLF +

     'end.' + CRLF;
end;


procedure TadxppFormModuleCreator.FormCreated(Form: TIFormInterface);
begin
  // do nothing
end;

{ TadxwdFormExpert }

{$HINTS OFF}
procedure TadxwdFormExpert.Execute;
var
  IModuleCreator : TadxwdFormModuleCreator;
  IModule : TIModuleInterface;
  Check: boolean;
begin
  {$IFDEF ADX_INTERNAL}
  {$IFNDEF ADXXOL_TRIAL}
  {$I adxxcheck.inc}
  {$ELSE}
  {$I adxxtrl3.inc}
  {$ENDIF}
  {$ENDIF}

  IModuleCreator := TadxwdFormModuleCreator.Create;
  try
    IModuleCreator.FAncestorIdent := 'adxWordTaskPane'; // Don't include the 'T'!!!!
    IModuleCreator.FAncestorClass := TadxWordTaskPane; //  TadxWordTaskPane;
    {$IFDEF DELPHI_9_UP}
    WdFormModule := TadxwdFormModuleCreator.Create;

    WDFormModule.FAncestorIdent := 'adxWordTaskPane'; // Don't include the 'T'!!!!
    WDFormModule.FAncestorClass := TadxWordTaskPane; //  TadxWordTaskPane;

    (BorlandIDEServices as IOTAModuleServices70).GetNewModuleAndClassName(WdFormModule.FAncestorIdent,
WdFormModule.FUnitIdent, WdFormModule.FFormIdent, WdFormModule.FFileName);


    IModule:=ToolServices.ModuleCreateEx(WdFormModule, [cmAddToProject, cmShowSource,
    cmShowForm, cmUnNamed, cmNewFile]);
    {$ELSE}
    ToolServices.GetNewModuleAndClassName(IModuleCreator.FAncestorIdent,
      IModuleCreator.FUnitIdent,IModuleCreator.FFormIdent,IModuleCreator.FFileName);

    IModule:=ToolServices.ModuleCreateEx(IModuleCreator, [cmShowSource,
       cmShowForm, cmMarkModified, cmAddToProject, cmUnNamed]);
    {$ENDIF}

    IModule.Free;
  finally
    IModuleCreator.Free;
  end;
end;
{$HINTS ON}

function TadxwdFormExpert.GetAuthor: string;
begin
  Result := 'Add-in Express Ltd. (www.add-in-express.com)';
end;

function TadxwdFormExpert.GetComment: string;
begin
  Result := 'Create a new TadxWordTaskPane in current project';
end;

{$IFDEF ADX_VCL5}
function TadxwdFormExpert.GetGlyph: HICON;
{$ELSE}
function TadxwdFormExpert.GetGlyph: HICON;
{$ENDIF}
begin
  Result := LoadIcon(HInstance, 'ADX_WD_NEWFORM_ICON');
end;

function TadxwdFormExpert.GetIDString: string;
begin
  // must be unique
  Result := 'ADXWD.adxwdFormWizard';
end;

function TadxwdFormExpert.GetMenuText: string;
begin
  result := '';
end;

function TadxwdFormExpert.GetName: string;
begin
Result := sLayeredXlFormObjRepositoryPage;
end;

function TadxwdFormExpert.GetPage: string;
begin
  Result := 'Add-in Express VCL';
end;

function TadxwdFormExpert.GetState: TExpertState;
begin
  // not used in a esForm expert
  Result := [esEnabled];
end;

function TadxwdFormExpert.GetStyle: TExpertStyle;
begin
  Result := esForm;
end;

{ TadxppFormExpert }

{$HINTS OFF}
procedure TadxppFormExpert.Execute;
var
  IModuleCreator : TadxppFormModuleCreator;
  IModule : TIModuleInterface;
  Check: boolean;
begin
  {$IFDEF ADX_INTERNAL}
  {$IFNDEF ADXXOL_TRIAL}
  {$I adxxcheck.inc}
  {$ELSE}
  {$I adxxtrl3.inc}
  {$ENDIF}
  {$ENDIF}

  IModuleCreator := TadxppFormModuleCreator.Create;
  try
    IModuleCreator.FAncestorIdent := 'adxPowerPointTaskPane'; // Don't include the 'T'!!!!
    IModuleCreator.FAncestorClass := TadxPowerPointTaskPane; //  TadxPowerPointTaskPane;
    {$IFDEF DELPHI_9_UP}
    PpFormModule := TadxppFormModuleCreator.Create;

    PPFormModule.FAncestorIdent := 'adxPowerPointTaskPane'; // Don't include the 'T'!!!!
    PPFormModule.FAncestorClass := TadxPowerPointTaskPane; //  TadxPowerPointTaskPane;

    (BorlandIDEServices as IOTAModuleServices70).GetNewModuleAndClassName(WdFormModule.FAncestorIdent,
PpFormModule.FUnitIdent, PpFormModule.FFormIdent, PpFormModule.FFileName);


    IModule:=ToolServices.ModuleCreateEx(WdFormModule, [cmAddToProject, cmShowSource,
    cmShowForm, cmUnNamed, cmNewFile]);
    {$ELSE}
    ToolServices.GetNewModuleAndClassName(IModuleCreator.FAncestorIdent,
      IModuleCreator.FUnitIdent,IModuleCreator.FFormIdent,IModuleCreator.FFileName);

    IModule:=ToolServices.ModuleCreateEx(IModuleCreator, [cmShowSource,
       cmShowForm, cmMarkModified, cmAddToProject, cmUnNamed]);
    {$ENDIF}

    IModule.Free;
  finally
    IModuleCreator.Free;
  end;
end;
{$HINTS ON}

function TadxppFormExpert.GetAuthor: string;
begin
  Result := 'Add-in Express Ltd. (www.add-in-express.com)';
end;

function TadxppFormExpert.GetComment: string;
begin
  Result := 'Create a new TadxPowerPointTaskPane in current project';
end;

{$IFDEF ADX_VCL5}
function TadxppFormExpert.GetGlyph: HICON;
{$ELSE}
function TadxppFormExpert.GetGlyph: HICON;
{$ENDIF}
begin
  Result := LoadIcon(HInstance, 'ADX_PP_NEWFORM_ICON');
end;

function TadxppFormExpert.GetIDString: string;
begin
  // must be unique
  Result := 'ADXPP.adxppFormWizard';
end;

function TadxppFormExpert.GetMenuText: string;
begin
  result := '';
end;

function TadxppFormExpert.GetName: string;
begin
Result := sLayeredXlFormObjRepositoryPage;
end;

function TadxppFormExpert.GetPage: string;
begin
  Result := 'Add-in Express VCL';
end;

function TadxppFormExpert.GetState: TExpertState;
begin
  // not used in a esForm expert
  Result := [esEnabled];
end;

function TadxppFormExpert.GetStyle: TExpertStyle;
begin
  Result := esForm;
end;

{ TadxwdFormExpert2 }

function TadxwdFormExpert2.GetIDString: string;
begin
  Result := 'ADXWD.adxwdFormWizard2';
end;

{$IFDEF ADX_VCL5}
function TadxwdFormExpert2.GetGlyph: HICON;
{$ELSE}
function TadxwdFormExpert2.GetGlyph: Cardinal;
{$ENDIF}
begin
  Result := LoadIcon(HInstance, 'ADX_WD_NEWFORM_ICON');
end;

function TadxwdFormExpert2.GetName: string;
begin
  Result := sLayeredWdFormObjRepositoryPage2;
end;

function TadxwdFormExpert2.GetComment: string;
begin
  Result := 'Create a new TadxWordTaskPane in current project';
end;
{$HINTS OFF}
procedure TadxwdFormExpert2.Execute;

var
  {$IFDEF DELPHI_9_UP}
  OTAModuleServices : IOTAModuleServices;
  myWdCreator: TadxWdFormCreator;
  fNewUnitIdent, fNewClassName, fNewFileName: string;
  {$ELSE}
  IModuleCreator : TadxwdFormModuleCreator;
  IModule : TIModuleInterface;
  {$ENDIF}
  Check: boolean;
begin
  {$IFDEF ADX_INTERNAL}
  {$IFNDEF ADXXOL_TRIAL}
  {$I adxxcheck.inc}
  {$ELSE}
  {$I adxxtrl3.inc}
  {$ENDIF}
  {$ENDIF}

  {$IFDEF DELPHI_9_UP}

  try
    if BorlandIDEServices.QueryInterface(IOTAModuleServices, OTAModuleServices) = S_OK then begin
      myWdCreator := TadxWdFormCreator.Create;
      fNewClassName := 'adxWordTaskPane';
      OTAModuleServices.GetNewModuleAndClassName('Unit', fNewUnitIdent, fNewClassName, fNewFileName);

      myWdCreator.NewUnitIdent := fNewUnitIdent;
      myWdCreator.NewClassName := fNewClassName;
      myWdCreator.NewFileName := fNewFileName;
      OTAModuleServices.CreateModule(myWdCreator);
    end; // if BorlandIDEServices.QueryInterface(IOTAModuleServices, OTAModuleServices) = S_OK
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
  {$ELSE}
  IModule := nil;
  IModuleCreator := nil;

  try
    IModuleCreator := TadxwdFormModuleCreator.Create;
    IModuleCreator.FAncestorIdent := 'adxWordTaskPane'; // Don't include the 'T'!!!!
    IModuleCreator.FAncestorClass := TadxWordTaskPane; //  TadxWordTaskPane;

    ToolServices.GetNewModuleAndClassName(IModuleCreator.FAncestorIdent,
      IModuleCreator.FUnitIdent,IModuleCreator.FFormIdent,IModuleCreator.FFileName);
    if (ToolServices <> nil) then  begin
      IModule:=ToolServices.ModuleCreateEx(IModuleCreator, [cmShowSource,
         cmShowForm, cmMarkModified, cmAddToProject, cmUnNamed]);
    end else begin
      ShowMessage('ToolServices is null');
    end;
    if Assigned(IModule) then
      IModule.Free;
  finally
    if IModuleCreator <> nil then
      IModuleCreator.Free;
  end;
  {$ENDIF}

end;
{$HINTS ON}

{ TadxppFormExpert2 }

function TadxppFormExpert2.GetIDString: string;
begin
  Result := 'ADXPP.adxppFormWizard2';
end;

{$IFDEF ADX_VCL5}
function TadxppFormExpert2.GetGlyph: HICON;
{$ELSE}
function TadxppFormExpert2.GetGlyph: Cardinal;
{$ENDIF}
begin
  Result := LoadIcon(HInstance, 'ADX_PP_NEWFORM_ICON');
end;

function TadxppFormExpert2.GetName: string;
begin
Result := sLayeredPpFormObjRepositoryPage2;
end;

function TadxppFormExpert2.GetComment: string;
begin
  Result := 'Create a new TadxPowerPointTaskPane in current project';
end;
{$HINTS OFF}
procedure TadxppFormExpert2.Execute;

var
  {$IFDEF DELPHI_9_UP}
  OTAModuleServices : IOTAModuleServices;
  myPpCreator: TadxPpFormCreator;
  fNewUnitIdent, fNewClassName, fNewFileName: string;
  {$ELSE}
  IModuleCreator : TadxppFormModuleCreator;
  IModule : TIModuleInterface;
  {$ENDIF}
  Check: boolean;
begin
  {$IFDEF ADX_INTERNAL}
  {$IFNDEF ADXXOL_TRIAL}
  {$I adxxcheck.inc}
  {$ELSE}
  {$I adxxtrl3.inc}
  {$ENDIF}
  {$ENDIF}

  {$IFDEF DELPHI_9_UP}

  try
    if BorlandIDEServices.QueryInterface(IOTAModuleServices, OTAModuleServices) = S_OK then begin
      myPpCreator := TadxPpFormCreator.Create;
      fNewClassName := 'adxPowerPointTaskPane';
      OTAModuleServices.GetNewModuleAndClassName('Unit', fNewUnitIdent, fNewClassName, fNewFileName);

      myPpCreator.NewUnitIdent := fNewUnitIdent;
      myPpCreator.NewClassName := fNewClassName;
      myPpCreator.NewFileName := fNewFileName;
      OTAModuleServices.CreateModule(myPpCreator);
    end; // if BorlandIDEServices.QueryInterface(IOTAModuleServices, OTAModuleServices) = S_OK
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
  {$ELSE}
  IModule := nil;
  IModuleCreator := nil;

  try
    IModuleCreator := TadxppFormModuleCreator.Create;
    IModuleCreator.FAncestorIdent := 'adxPowerPointTaskPane'; // Don't include the 'T'!!!!
    IModuleCreator.FAncestorClass := TadxPowerPointTaskPane; //  TadxPowerPointTaskPane;

    ToolServices.GetNewModuleAndClassName(IModuleCreator.FAncestorIdent,
      IModuleCreator.FUnitIdent,IModuleCreator.FFormIdent,IModuleCreator.FFileName);
    if (ToolServices <> nil) then  begin
      IModule:=ToolServices.ModuleCreateEx(IModuleCreator, [cmShowSource,
         cmShowForm, cmMarkModified, cmAddToProject, cmUnNamed]);
    end else begin
      ShowMessage('ToolServices is null');
    end;
    if Assigned(IModule) then
      IModule.Free;
  finally
    if IModuleCreator <> nil then
      IModuleCreator.Free;
  end;
  {$ENDIF}

end;
{$HINTS ON}

{ TadxolModuleEditor }

class procedure TadxolModuleEditor.ResetLocalSettings(
  CurrentUser: boolean; ProgID: string);
var
  Reg: TRegistry;
  i: integer;
  valueNames: TStringList;
  keyNames: TStringList;
  key: string;
begin
  //Local
  key := '\Software\Microsoft\Office\Outlook\AddIns\' + ProgID + '\' + Globals.ADXOLForm(false) + '\';

  Reg := TRegistry.Create;
  valueNames := TStringList.Create;
  keyNames := TStringList.Create;
  try

    if (CurrentUser) then begin
      Reg.RootKey := HKEY_CURRENT_USER;
    end
    else begin
      Reg.RootKey := HKEY_LOCAL_MACHINE;
    end;

    if (Reg.OpenKey(key, false)) then begin

      Reg.GetValueNames(valueNames);
      for i := 0 to valueNames.Count - 1 do begin
        Reg.DeleteValue(valueNames[i]);
      end;

      Reg.GetKeyNames(keyNames);
      for i := 0 to keyNames.Count - 1 do begin
        if (Pos(TadxOlFormsCollectionItem.ClassName, keyNames[i]) > 0) then begin
          Reg.DeleteKey(keyNames[i]);
        end;
      end;

    end;

  finally
    Reg.CloseKey;
    Reg.Free;
    valueNames.Free;
    keyNames.Free;
  end;
end;

class procedure TadxolModuleEditor.ResetRegions(ProgID: string);
begin
  ResetRoot(true);
  ResetLocalSettings(true, ProgID);
  ResetLocalSettings(false, ProgID);
end;

class procedure TadxolModuleEditor.ResetRoot(CurrentUser: boolean);
var
  Reg: TRegistry;
  i: integer;
  valueNames: TStringList;
  key: string;
begin

  key := '\Software\Microsoft\Office\Outlook\AddIns\' + Globals.ADXOLForm(true) + '\';

  Reg := TRegistry.Create;
  valueNames := TStringList.Create;
  try
    if (CurrentUser) then begin
      Reg.RootKey := HKEY_CURRENT_USER;
    end
    else begin
      Reg.RootKey := HKEY_LOCAL_MACHINE;
    end;

    if (Reg.OpenKey(key, false)) then begin
      Reg.GetValueNames(valueNames);
      for i := 0 to valueNames.Count - 1 do begin
        Reg.DeleteValue(valueNames[i]);
      end;
    end;

  finally
    Reg.CloseKey;
    Reg.Free;
    valueNames.Free;
  end;
end;

{ Globals }

class function Globals.ADXOLForm(root: boolean): string;
begin
  if root then begin
    //This should be ADXForm (without OL) for compatibility
    result := 'ADXForm';
  end
  else begin
    //This should not be changed. See the FoldersForExcludingFromUseWebViewPaneLayout recomendations.
    result := 'ADXXOL';
  end;
end;

class function Globals.ADXPPForm: string;
begin
  result := 'ADXPPForm';
end;

class function Globals.ADXWDForm: string;
begin
  result := 'ADXWDForm';
end;

class function Globals.ADXXLForm: string;
begin
  result := 'ADXXLForm';
end;

class procedure Globals.ScanTLB(method: TResetRegionsMethod);
var
  tlbFile: string;
  i, Count: Integer;
  ILib: ITypeLib;
  IType: ITypeInfo;
  TypeAttr: PTypeAttr;
  tk: ActiveX.TTypeKind;
  PropName: WideString;
  HelpContext: Longint;
  LibName: string;
  ProgID: string;
begin
  {$IFDEF DELPHI_9_UP}
  tlbFile := ChangeFileExt((BorlandIDEServices as IOTAModuleServices).GetActiveProject.FileName, '.tlb');
  {$ELSE}
  tlbFile := ChangeFileExt(ToolServices.GetProjectName, '.tlb');
  {$ENDIF}
  if not FileExists(tlbFile) then
    raise Exception.Create(Format('Cannot find the "%s" file!', [ExtractFileName(tlbFile)]));
  SetLength(PropName, 1024);
  try
    if (LoadTypeLibEx(PWideChar(WideString(tlbFile)), REGKIND_NONE, ILib) = S_OK) and Assigned(ILib) then
      try
        Count := ILib.GetTypeInfoCount;
        ILib.GetDocumentation(MEMBERID_NIL, @PropName, nil, @HelpContext, nil);
        LibName := PropName;
        for i := 0 to Count - 1 do begin
          ILib.GetTypeInfoType(i, tk);
          if tk = TKIND_COCLASS then begin
            ILib.GetTypeInfo(i, IType);
            try
              IType.GetTypeAttr(TypeAttr);
              try
                //if TypeAttr^.wTypeFlags = 34 then // Control & CanCreate
                if ((TypeAttr^.wTypeFlags and TYPEFLAG_FCONTROL) = 0) and
                  ((TypeAttr^.wTypeFlags and TYPEFLAG_FCANCREATE) = TYPEFLAG_FCANCREATE) then
                begin
                  IType.GetDocumentation(MEMBERID_NIL, @PropName, nil, @HelpContext, nil);
                  ProgID := LibName + '.' + PropName;
                  method(ProgID);
                end;
              finally
                IType.ReleaseTypeAttr(TypeAttr);
              end;
            finally
              IType := nil;
            end;
          end;
        end;
      finally
        ILib := nil;
      end;
  finally
    SetLength(PropName, 0);
  end;
end;

{ TadxExcelModuleEditor }


procedure TadxExcelModuleEditor.ExecuteVerb(Index: Integer);
var
  tlbFile: string;
  i, Count: Integer;
  ILib: ITypeLib;
  IType: ITypeInfo;
  TypeAttr: PTypeAttr;
  tk: ActiveX.TTypeKind;
  PropName: WideString;
  HelpContext: Longint;
  LibName: string;
  ProgID: string;
begin
  {$IFDEF DELPHI_9_UP}
  tlbFile := ChangeFileExt((BorlandIDEServices as IOTAModuleServices).GetActiveProject.FileName, '.tlb');
  {$ELSE}
  tlbFile := ChangeFileExt(ToolServices.GetProjectName, '.tlb');
  {$ENDIF}
  if not FileExists(tlbFile) then
    raise Exception.Create(Format('Cannot find the "%s" file!', [ExtractFileName(tlbFile)]));
  SetLength(PropName, 1024);
  try
    if (LoadTypeLibEx(PWideChar(WideString(tlbFile)), REGKIND_NONE, ILib) = S_OK) and Assigned(ILib) then
      try
        Count := ILib.GetTypeInfoCount;
        ILib.GetDocumentation(MEMBERID_NIL, @PropName, nil, @HelpContext, nil);
        LibName := PropName;
        for i := 0 to Count - 1 do begin
          ILib.GetTypeInfoType(i, tk);
          if tk = TKIND_COCLASS then begin
            ILib.GetTypeInfo(i, IType);
            try
              IType.GetTypeAttr(TypeAttr);
              try
                //if TypeAttr^.wTypeFlags = 34 then // Control & CanCreate
                if ((TypeAttr^.wTypeFlags and TYPEFLAG_FCONTROL) = 0) and
                  ((TypeAttr^.wTypeFlags and TYPEFLAG_FCANCREATE) = TYPEFLAG_FCANCREATE) then
                begin
                  IType.GetDocumentation(MEMBERID_NIL, @PropName, nil, @HelpContext, nil);
                  ProgID := LibName + '.' + PropName;
                  ResetRegions(ProgID);
                end;
              finally
                IType.ReleaseTypeAttr(TypeAttr);
              end;
            finally
              IType := nil;
            end;
          end;
        end;
      finally
        ILib := nil;
      end;
  finally
    SetLength(PropName, 0);
  end;
  MessageDlg('Add-in Express Task Panes data have been reset.', mtInformation, [mbOk], 0);
end;

function TadxExcelModuleEditor.GetVerb(Index: Integer): string;
begin
  Result := 'Reset Task Panes';
end;

function TadxExcelModuleEditor.GetVerbCount: Integer;
begin
  result := 1;
end;

class procedure TadxExcelModuleEditor.ResetLocalSettings(
  CurrentUser: boolean; ProgID: string);
var
  Reg: TRegistry;
  i: integer;
  valueNames: TStringList;
  keyNames: TStringList;
  key: string;
begin
  //Local
  key := '\Software\Microsoft\Office\Excel\AddIns\' + ProgID + '\' + Globals.ADXXLForm + '\';

  Reg := TRegistry.Create;
  valueNames := TStringList.Create;
  keyNames := TStringList.Create;
  try

    if (CurrentUser) then begin
      Reg.RootKey := HKEY_CURRENT_USER;
    end
    else begin
      Reg.RootKey := HKEY_LOCAL_MACHINE;
    end;

    if (Reg.OpenKey(key, false)) then begin
      Reg.GetValueNames(valueNames);
      for i := 0 to valueNames.Count - 1 do begin
        Reg.DeleteValue(valueNames[i]);
      end;


      Reg.GetKeyNames(keyNames);
      for i := 0 to keyNames.Count - 1 do begin
        if (Pos(TadxExcelTaskPanesCollectionItem.ClassName, keyNames[i]) > 0) then begin
          Reg.DeleteKey(keyNames[i]);
        end;
      end;
    end;

  finally
    Reg.CloseKey;
    Reg.Free;
    valueNames.Free;
    keyNames.Free;
  end;
end;


class procedure TadxExcelModuleEditor.ResetRegions(ProgID: string);
begin
  ResetRoot(true);
  ResetLocalSettings(true, ProgID);
  ResetLocalSettings(false, ProgID);
end;

class procedure TadxExcelModuleEditor.ResetRoot(CurrentUser: boolean);
var
  Reg: TRegistry;
  i: integer;
  valueNames: TStringList;
  keyNames: TStringList;
  key: string;
begin

  key := '\Software\Microsoft\Office\Excel\AddIns\' + Globals.ADXXLForm + '\';

  Reg := TRegistry.Create;
  valueNames := TStringList.Create;
  keyNames := TStringList.Create;
  try
    if (CurrentUser) then begin
      Reg.RootKey := HKEY_CURRENT_USER;
    end
    else begin
      Reg.RootKey := HKEY_LOCAL_MACHINE;
    end;

    if (Reg.OpenKey(key, false)) then begin
      Reg.GetValueNames(valueNames);
      for i := 0 to valueNames.Count - 1 do begin
        Reg.DeleteValue(valueNames[i]);
      end;
    end;

  finally
    Reg.CloseKey;
    Reg.Free;
    valueNames.Free;
    keyNames.Free;
  end;
end;

initialization

  {$IFDEF ADXXOL_TRIAL}
  {$I adxxtrl2.inc}
  {$ENDIF}

end.



