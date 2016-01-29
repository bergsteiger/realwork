unit nsSaveDialog;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Common$Lib"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Common/nsSaveDialog.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Common$Lib::Dialogs::TnsSaveDialog
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  PresentationInterfaces,
  nsTypes,
  vtPanel,
  vtSaveDialog
  {$If defined(Nemesis)}
  ,
  eeGroupBox
  {$IfEnd} //Nemesis
  ,
  vtCheckBox,
  vtRadioButton
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
//#UC START# *4AF32FBD00F5ci*
{$R *.RES}
//#UC END# *4AF32FBD00F5ci*
//#UC START# *4AF32FBD00F5cit*
//#UC END# *4AF32FBD00F5cit*
 TnsSaveDialog = class(TvtSaveDialog)
 private
 // private fields
   f_ListTargetGroup : TeeGroupBox;
   f_SelectedOnlyCheckBox : TvtCheckBox;
   f_ExtraPanel : TvtPanel;
   f_MergeCheckBox : TvtCheckBox;
   f_SaveFileName : AnsiString;
   f_TitlesRadio : TvtRadioButton;
   f_ContentsRadio : TvtRadioButton;
   f_NumbersRadio : TvtRadioButton;
   f_Executing : Boolean;
   f_DialogKind : TnsSaveDialogKind;
    {* Поле для свойства DialogKind}
 private
 // private methods
   procedure UpdateFileNameEditEnable(ForceEnable: Boolean = False);
   procedure MergeClick(Sender: TObject);
   procedure ListTargetClick(Sender: TObject);
   procedure ClearControls;
 protected
 // property methods
   function pm_GetSelectedOnlyEnabled: Boolean;
   procedure pm_SetSelectedOnlyEnabled(aValue: Boolean);
   function pm_GetSaveListTarget: TnsSaveDialogListTarget;
   procedure pm_SetSaveListTarget(aValue: TnsSaveDialogListTarget);
   function pm_GetMergeChecked: Boolean;
   procedure pm_SetMergeChecked(aValue: Boolean);
   function pm_GetMergeEnabled: Boolean;
   function pm_GetSelectedFileFormat: TnsFileFormat;
   function pm_GetSelectedOnlyChecked: Boolean;
   procedure pm_SetSelectedOnlyChecked(aValue: Boolean);
   procedure pm_SetDialogKind(aValue: TnsSaveDialogKind);
 protected
 // overridden protected methods
   function GetFileNameForAdjust: AnsiString; override;
     {* Получить имя файла для корректировки расширения }
   procedure FirstCorrectFileName; override;
   procedure SetAdjustedFileName(const aFileName: AnsiString); override;
     {* Установить откорректированное имя файла }
    {$If not defined(NoVCL)}
   procedure DoClose; override;
    {$IfEnd} //not NoVCL
    {$If not defined(NoVCL)}
   procedure DoShow; override;
    {$IfEnd} //not NoVCL
    {$If not defined(NoVCL)}
   function DoCanClose: Boolean; override;
    {$IfEnd} //not NoVCL
 public
 // overridden public methods
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;
    {$If not defined(NoVCL)}
   function Execute: Boolean; override;
    {$IfEnd} //not NoVCL
 public
 // public properties
   property SelectedOnlyEnabled: Boolean
     read pm_GetSelectedOnlyEnabled
     write pm_SetSelectedOnlyEnabled;
   property SaveListTarget: TnsSaveDialogListTarget
     read pm_GetSaveListTarget
     write pm_SetSaveListTarget;
   property MergeChecked: Boolean
     read pm_GetMergeChecked
     write pm_SetMergeChecked;
   property MergeEnabled: Boolean
     read pm_GetMergeEnabled;
   property SelectedFileFormat: TnsFileFormat
     read pm_GetSelectedFileFormat;
   property SelectedOnlyChecked: Boolean
     read pm_GetSelectedOnlyChecked
     write pm_SetSelectedOnlyChecked;
   property DialogKind: TnsSaveDialogKind
     read f_DialogKind
     write pm_SetDialogKind;
//#UC START# *4AF32FBD00F5publ*
//#UC END# *4AF32FBD00F5publ*
 end;//TnsSaveDialog
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  eeButton,
  l3Base,
  Consts
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  Math,
  l3String
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  Windows
  {$If not defined(NoVCL)}
  ,
  StdCtrls
  {$IfEnd} //not NoVCL
  ,
  Graphics
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Buttons
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Dialogs
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  ComCtrls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  CommDlg
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

const
   { nsSaveDialog Constants }
  c_ListKinds = [ns_sdkListInternal, ns_sdkList];

type
  THackWinControl = class(TWinControl)
  end;//THackWinControl

// start class TnsSaveDialog

procedure TnsSaveDialog.UpdateFileNameEditEnable(ForceEnable: Boolean = False);
//#UC START# *4DD269E001B6_4AF32FBD00F5_var*
var
 l_Edit: THandle;
 l_EditEnable: Boolean;
//#UC END# *4DD269E001B6_4AF32FBD00F5_var*
begin
//#UC START# *4DD269E001B6_4AF32FBD00F5_impl*
 if f_Executing and (f_DialogKind in c_ListKinds) then
 begin
  l_Edit := GetFileNameEditHandle;
  Assert(l_Edit <> 0);
  l_EditEnable := MergeChecked or not MergeEnabled or ForceEnable;
  if (l_EditEnable <> IsWindowEnabled(l_Edit)) then
  begin
   EnableWindow(l_Edit, l_EditEnable);
   if l_EditEnable then
    inherited SetAdjustedFileName(f_SaveFileName)
   else
   begin
    f_SaveFileName := inherited GetFileNameForAdjust;
    inherited SetAdjustedFileName(vcmConstString(str_ChooseCatalog));
   end;//l_EditEnable
  end;//l_EditEnable <> IsWindowEnabled(l_Edit)
 end;//f_Executing and (f_DialogKind in c_ListKinds)
//#UC END# *4DD269E001B6_4AF32FBD00F5_impl*
end;//TnsSaveDialog.UpdateFileNameEditEnable

procedure TnsSaveDialog.MergeClick(Sender: TObject);
//#UC START# *4DD26A2E0223_4AF32FBD00F5_var*
//#UC END# *4DD26A2E0223_4AF32FBD00F5_var*
begin
//#UC START# *4DD26A2E0223_4AF32FBD00F5_impl*
 UpdateFileNameEditEnable;
//#UC END# *4DD26A2E0223_4AF32FBD00F5_impl*
end;//TnsSaveDialog.MergeClick

procedure TnsSaveDialog.ListTargetClick(Sender: TObject);
//#UC START# *4DD26A5D0253_4AF32FBD00F5_var*
//#UC END# *4DD26A5D0253_4AF32FBD00F5_var*
begin
//#UC START# *4DD26A5D0253_4AF32FBD00F5_impl*
 SaveListTarget := TnsSaveDialogListTarget((Sender as TvtRadioButton).Tag);
 UpdateFileNameEditEnable;
//#UC END# *4DD26A5D0253_4AF32FBD00F5_impl*
end;//TnsSaveDialog.ListTargetClick

procedure TnsSaveDialog.ClearControls;
//#UC START# *4DD26A8700A8_4AF32FBD00F5_var*
//#UC END# *4DD26A8700A8_4AF32FBD00F5_var*
begin
//#UC START# *4DD26A8700A8_4AF32FBD00F5_impl*
 f_SelectedOnlyCheckBox := nil;
 f_MergeCheckBox := nil;
 f_ListTargetGroup := nil;
 f_TitlesRadio := nil;
 f_ContentsRadio := nil;
 f_NumbersRadio := nil;
//#UC END# *4DD26A8700A8_4AF32FBD00F5_impl*
end;//TnsSaveDialog.ClearControls

function TnsSaveDialog.pm_GetSelectedOnlyEnabled: Boolean;
//#UC START# *4DBB11B8006A_4AF32FBD00F5get_var*
//#UC END# *4DBB11B8006A_4AF32FBD00F5get_var*
begin
//#UC START# *4DBB11B8006A_4AF32FBD00F5get_impl*
 Assert(f_DialogKind <> ns_sdkSimple);
 if Assigned(f_SelectedOnlyCheckBox) then
  result := f_SelectedOnlyCheckBox.Enabled
 else
  Result := false;
//#UC END# *4DBB11B8006A_4AF32FBD00F5get_impl*
end;//TnsSaveDialog.pm_GetSelectedOnlyEnabled

procedure TnsSaveDialog.pm_SetSelectedOnlyEnabled(aValue: Boolean);
//#UC START# *4DBB11B8006A_4AF32FBD00F5set_var*
//#UC END# *4DBB11B8006A_4AF32FBD00F5set_var*
begin
//#UC START# *4DBB11B8006A_4AF32FBD00F5set_impl*
 Assert(f_DialogKind <> ns_sdkSimple);
 if Assigned(f_SelectedOnlyCheckBox) and
    (f_SelectedOnlyCheckBox.Enabled <> aValue) then
  f_SelectedOnlyCheckBox.Enabled := aValue;
//#UC END# *4DBB11B8006A_4AF32FBD00F5set_impl*
end;//TnsSaveDialog.pm_SetSelectedOnlyEnabled

function TnsSaveDialog.pm_GetSaveListTarget: TnsSaveDialogListTarget;
//#UC START# *4DBB1205024C_4AF32FBD00F5get_var*
//#UC END# *4DBB1205024C_4AF32FBD00F5get_var*
begin
//#UC START# *4DBB1205024C_4AF32FBD00F5get_impl*
 Assert(f_DialogKind in c_ListKinds);
 Result := ns_sdlkTitles;
 if Assigned(f_ListTargetGroup) then
 begin
  if f_TitlesRadio.Checked then
   Result := ns_sdlkTitles
  else
  if f_ContentsRadio.Checked then
   Result := ns_sdlkContents
  else
  if Assigned(f_NumbersRadio) and f_NumbersRadio.Checked then
   Result := ns_sdlkIdentifiers;
 end;//Assigned(f_ListTargetGroup)
//#UC END# *4DBB1205024C_4AF32FBD00F5get_impl*
end;//TnsSaveDialog.pm_GetSaveListTarget

procedure TnsSaveDialog.pm_SetSaveListTarget(aValue: TnsSaveDialogListTarget);
//#UC START# *4DBB1205024C_4AF32FBD00F5set_var*
//#UC END# *4DBB1205024C_4AF32FBD00F5set_var*
begin
//#UC START# *4DBB1205024C_4AF32FBD00F5set_impl*
 Assert(f_DialogKind in c_ListKinds);
 if Assigned(f_ListTargetGroup) then
 begin
  case aValue of
   ns_sdlkTitles:
    f_TitlesRadio.Checked := True;
   ns_sdlkContents:
    f_ContentsRadio.Checked := True;
   ns_sdlkIdentifiers:
    begin
     Assert(f_DialogKind = ns_sdkListInternal);
     f_NumbersRadio.Checked := True
    end;//ns_sdlkIdentifiers
  end;//case aValue
  f_MergeCheckBox.Enabled := SaveListTarget = ns_sdlkContents;
 end;//Assigned(f_ListTargetGroup)
//#UC END# *4DBB1205024C_4AF32FBD00F5set_impl*
end;//TnsSaveDialog.pm_SetSaveListTarget

function TnsSaveDialog.pm_GetMergeChecked: Boolean;
//#UC START# *4DBB12460192_4AF32FBD00F5get_var*
//#UC END# *4DBB12460192_4AF32FBD00F5get_var*
begin
//#UC START# *4DBB12460192_4AF32FBD00F5get_impl*
 Assert(f_DialogKind in c_ListKinds);
 if Assigned(f_MergeCheckBox) then
  Result := f_MergeCheckBox.Checked
 else
  Result := False;
//#UC END# *4DBB12460192_4AF32FBD00F5get_impl*
end;//TnsSaveDialog.pm_GetMergeChecked

procedure TnsSaveDialog.pm_SetMergeChecked(aValue: Boolean);
//#UC START# *4DBB12460192_4AF32FBD00F5set_var*
//#UC END# *4DBB12460192_4AF32FBD00F5set_var*
begin
//#UC START# *4DBB12460192_4AF32FBD00F5set_impl*
 Assert(f_DialogKind in c_ListKinds);
 if Assigned(f_MergeCheckBox) and (f_MergeCheckBox.Checked <> aValue) then
  f_MergeCheckBox.Checked := aValue;
//#UC END# *4DBB12460192_4AF32FBD00F5set_impl*
end;//TnsSaveDialog.pm_SetMergeChecked

function TnsSaveDialog.pm_GetMergeEnabled: Boolean;
//#UC START# *4DBB126F02FE_4AF32FBD00F5get_var*
//#UC END# *4DBB126F02FE_4AF32FBD00F5get_var*
begin
//#UC START# *4DBB126F02FE_4AF32FBD00F5get_impl*
 Assert(f_DialogKind in c_ListKinds);
 if Assigned(f_MergeCheckBox) then
  Result := f_MergeCheckBox.Enabled
 else
  Result := False;
//#UC END# *4DBB126F02FE_4AF32FBD00F5get_impl*
end;//TnsSaveDialog.pm_GetMergeEnabled

function TnsSaveDialog.pm_GetSelectedFileFormat: TnsFileFormat;
//#UC START# *4DBB129E010A_4AF32FBD00F5get_var*
//#UC END# *4DBB129E010A_4AF32FBD00F5get_var*
begin
//#UC START# *4DBB129E010A_4AF32FBD00F5get_impl*
 Result := ns_ffRTF;
 case FilterIndex of
  2: Result := ns_ffTxt;
  3: Result := ns_ffHTML;
  4: Result := ns_ffPDF;
  5: Result := ns_ffXML;
  6: Result := ns_ffEvd;
  7: Result := ns_ffNull;
 end;//case SaveDialog.FilterIndex of
//#UC END# *4DBB129E010A_4AF32FBD00F5get_impl*
end;//TnsSaveDialog.pm_GetSelectedFileFormat

function TnsSaveDialog.pm_GetSelectedOnlyChecked: Boolean;
//#UC START# *4DC924D60196_4AF32FBD00F5get_var*
//#UC END# *4DC924D60196_4AF32FBD00F5get_var*
begin
//#UC START# *4DC924D60196_4AF32FBD00F5get_impl*
 Assert(f_DialogKind <> ns_sdkSimple);
 if Assigned(f_SelectedOnlyCheckBox) then
  result := f_SelectedOnlyCheckBox.Checked
 else
  result := false;
//#UC END# *4DC924D60196_4AF32FBD00F5get_impl*
end;//TnsSaveDialog.pm_GetSelectedOnlyChecked

procedure TnsSaveDialog.pm_SetSelectedOnlyChecked(aValue: Boolean);
//#UC START# *4DC924D60196_4AF32FBD00F5set_var*
//#UC END# *4DC924D60196_4AF32FBD00F5set_var*
begin
//#UC START# *4DC924D60196_4AF32FBD00F5set_impl*
 Assert(f_DialogKind <> ns_sdkSimple);
 if Assigned(f_SelectedOnlyCheckBox) and
    (f_SelectedOnlyCheckBox.Checked <> aValue) then
  f_SelectedOnlyCheckBox.Checked := aValue;
//#UC END# *4DC924D60196_4AF32FBD00F5set_impl*
end;//TnsSaveDialog.pm_SetSelectedOnlyChecked

procedure TnsSaveDialog.pm_SetDialogKind(aValue: TnsSaveDialogKind);
//#UC START# *4DC2F34E0143_4AF32FBD00F5set_var*

 function lp_SetupControl(const aControl: TWinControl; const aParent: TWinControl;
   const aTop: Integer; const SetTopToZero: Boolean = False): Integer;
 begin//lp_SetupControl
  //aControl.TabStop := false;
  with THackWinControl(aControl) do
  begin
   Parent := aParent;
   Height := (Abs(Font.Height) * 3) div 2;
   if SetTopToZero then
    Top := 0
   else
    Top := aTop + Abs(Font.Height) div 4;
   Left := Abs(Font.Height) div 2;
   Result := BoundsRect.Bottom;
  end;//with f_MergeCheckBox do
 end;//lp_SetupControl

 procedure lp_MakeDocumentPanel;
 begin//lp_MakeDocumentPanel
  f_ExtraPanel := TvtPanel.Create(Self);
  with f_ExtraPanel do
  begin
   Caption := '';
   BevelOuter := bvNone;
   BorderWidth := 2;
   TabOrder := 1;
  end;//with f_ExtraPanel do
  //http://mdp.garant.ru/pages/viewpage.action?pageId=515838753
  f_SelectedOnlyCheckBox := TvtCheckBox1.Create(f_ExtraPanel);
  f_ExtraPanel.Height := lp_SetupControl(f_SelectedOnlyCheckBox, f_ExtraPanel, 0, True) +
   f_SelectedOnlyCheckBox.Top;
 end;//lp_MakeDocumentPanel

 procedure lp_MakeListPanel(MakeTopcNumberRadio: Boolean);
 var
  l_GroupTop: Integer;
  l_CheckBoxTop: Integer;
 begin//lp_MakeListPanel
  f_ExtraPanel := TvtPanel.Create(Self);
  with f_ExtraPanel do
  begin
   Caption := '';
   BevelOuter := bvNone;
   BorderWidth := 2;
   TabOrder := 1;
  end;//with f_ExtraPanel do

  f_ListTargetGroup := TeeGroupBox.Create(f_ExtraPanel);
  with f_ListTargetGroup do
  begin
   Parent := f_ExtraPanel;
   Left := Abs(Font.Height) div 2;
   Ctl3D := True;
   l_GroupTop := Abs(Font.Height);
  end;//with f_ExtraPanel do

  //http://mdp.garant.ru/pages/viewpage.action?pageId=515838753
  f_TitlesRadio := TvtRadioButton1.Create(f_ListTargetGroup);
  f_TitlesRadio.Tag := Ord(ns_sdlkTitles);
  l_GroupTop := lp_SetupControl(f_TitlesRadio, f_ListTargetGroup, l_GroupTop);

  //http://mdp.garant.ru/pages/viewpage.action?pageId=515838753
  f_ContentsRadio := TvtRadioButton1.Create(f_ListTargetGroup);
  f_ContentsRadio.Tag := Ord(ns_sdlkContents);
  l_CheckBoxTop := l_GroupTop;
  l_GroupTop := lp_SetupControl(f_ContentsRadio, f_ListTargetGroup, l_GroupTop);

  //http://mdp.garant.ru/pages/viewpage.action?pageId=515838753
  f_MergeCheckBox := TvtCheckBox1.Create(f_ListTargetGroup);
  lp_SetupControl(f_MergeCheckBox, f_ListTargetGroup, l_CheckBoxTop);

  if MakeTopcNumberRadio then
  begin
   //http://mdp.garant.ru/pages/viewpage.action?pageId=515838753
   f_NumbersRadio := TvtRadioButton1.Create(f_ListTargetGroup);
   f_NumbersRadio.Tag := Ord(ns_sdlkIdentifiers);
   l_GroupTop := lp_SetupControl(f_NumbersRadio, f_ListTargetGroup, l_GroupTop);
  end;//MakeTopcNumberRadio

  f_ListTargetGroup.Height := l_GroupTop + f_MergeCheckBox.Height div 2;

  l_GroupTop := f_ListTargetGroup.BoundsRect.Bottom;

  //http://mdp.garant.ru/pages/viewpage.action?pageId=515838753
  f_SelectedOnlyCheckBox := TvtCheckBox1.Create(f_ExtraPanel);
  f_ExtraPanel.Height := lp_SetupControl(f_SelectedOnlyCheckBox, f_ExtraPanel, l_GroupTop) +
    (f_SelectedOnlyCheckBox.Top - f_ListTargetGroup.BoundsRect.Bottom);
  SaveListTarget := ns_sdlkTitles;
 end;//lp_MakeListPanel
 
//#UC END# *4DC2F34E0143_4AF32FBD00F5set_var*
begin
//#UC START# *4DC2F34E0143_4AF32FBD00F5set_impl*
 if (f_DialogKind <> aValue) then
 begin
  l3Free(f_ExtraPanel);
  ClearControls;
  f_DialogKind := aValue;
  case f_DialogKind of
   ns_sdkDocument:
    lp_MakeDocumentPanel;
   ns_sdkList,
   ns_sdkListInternal:
    lp_MakeListPanel(f_DialogKind = ns_sdkListInternal);
  end;//case f_DialogKind
 end;//f_DialogKind <> aValue
//#UC END# *4DC2F34E0143_4AF32FBD00F5set_impl*
end;//TnsSaveDialog.pm_SetDialogKind

constructor TnsSaveDialog.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4AF32FBD00F5_var*
//#UC END# *47D1602000C6_4AF32FBD00F5_var*
begin
//#UC START# *47D1602000C6_4AF32FBD00F5_impl*
 inherited;
 f_DialogKind := ns_sdkSimple;
 Options := Options + [ofOverwritePrompt];
//#UC END# *47D1602000C6_4AF32FBD00F5_impl*
end;//TnsSaveDialog.Create

destructor TnsSaveDialog.Destroy;
//#UC START# *48077504027E_4AF32FBD00F5_var*
//#UC END# *48077504027E_4AF32FBD00F5_var*
begin
//#UC START# *48077504027E_4AF32FBD00F5_impl*
 l3Free(f_ExtraPanel);
 ClearControls;
 inherited;
//#UC END# *48077504027E_4AF32FBD00F5_impl*
end;//TnsSaveDialog.Destroy

function TnsSaveDialog.GetFileNameForAdjust: AnsiString;
//#UC START# *4DCAD2B2008F_4AF32FBD00F5_var*
//#UC END# *4DCAD2B2008F_4AF32FBD00F5_var*
begin
//#UC START# *4DCAD2B2008F_4AF32FBD00F5_impl*
 if (f_DialogKind in c_ListKinds) and MergeChecked then
  Result := f_SaveFileName
 else
  Result := inherited GetFileNameForAdjust;
//#UC END# *4DCAD2B2008F_4AF32FBD00F5_impl*
end;//TnsSaveDialog.GetFileNameForAdjust

procedure TnsSaveDialog.FirstCorrectFileName;
//#UC START# *4DCAD9560008_4AF32FBD00F5_var*
//#UC END# *4DCAD9560008_4AF32FBD00F5_var*
begin
//#UC START# *4DCAD9560008_4AF32FBD00F5_impl*
 inherited;
 UpdateFileNameEditEnable;
//#UC END# *4DCAD9560008_4AF32FBD00F5_impl*
end;//TnsSaveDialog.FirstCorrectFileName

procedure TnsSaveDialog.SetAdjustedFileName(const aFileName: AnsiString);
//#UC START# *4DCBC96000E3_4AF32FBD00F5_var*
//#UC END# *4DCBC96000E3_4AF32FBD00F5_var*
begin
//#UC START# *4DCBC96000E3_4AF32FBD00F5_impl*
 if (f_DialogKind in c_ListKinds) and MergeChecked then
  f_SaveFileName := aFileName
 else
  inherited SetAdjustedFileName(aFileName);
//#UC END# *4DCBC96000E3_4AF32FBD00F5_impl*
end;//TnsSaveDialog.SetAdjustedFileName

{$If not defined(NoVCL)}
procedure TnsSaveDialog.DoClose;
//#UC START# *4DCC1EF50061_4AF32FBD00F5_var*
//#UC END# *4DCC1EF50061_4AF32FBD00F5_var*
begin
//#UC START# *4DCC1EF50061_4AF32FBD00F5_impl*
 inherited;
 Application.HideHint;
//#UC END# *4DCC1EF50061_4AF32FBD00F5_impl*
end;//TnsSaveDialog.DoClose
{$IfEnd} //not NoVCL

{$If not defined(NoVCL)}
procedure TnsSaveDialog.DoShow;
//#UC START# *4DCC1FEE0352_4AF32FBD00F5_var*

 function lp_AdjustControlWidth(aControl: TWinControl;
                                aCurrentWidth: Integer;
                                const aCaption: TvcmStringID): Integer;
 begin//lp_AdjustControlWidth
  with f_ExtraPanel.Canvas do
  begin
   THackWinControl(aControl).Caption := vcmCOnstString(aCaption);
   Font.AssignFont(THackWinControl(aControl).Font);
   aControl.Width := Canvas.TextWidth(THackWinControl(aControl).Caption) + 2 * aControl.Height;
   Result := Max(aCurrentWidth, aControl.BoundsRect.Right + aControl.Height);
  end;//with f_ExtraPanel.Canvas
 end;//lp_AdjustControlWidth

var
 l_ExtRect: TRect;
 l_MergeLeft: Integer;
 l_Style: Cardinal;
//#UC END# *4DCC1FEE0352_4AF32FBD00F5_var*
begin
//#UC START# *4DCC1FEE0352_4AF32FBD00F5_impl*
 if Assigned(f_ExtraPanel) then
 begin
  Assert(f_DialogKind <> ns_sdkSimple);
  l_Style := GetWindowLong(Handle, GWL_EXSTYLE);
  SetWindowLong(Handle, GWL_EXSTYLE, l_Style or WS_EX_CONTROLPARENT);
  f_ExtraPanel.ParentWindow := Handle;
  GetClientRect(Handle, l_ExtRect);
  with GetStaticRect do
  begin
   l_ExtRect.Top := Bottom;
   l_ExtRect.Left := Left;
   l_ExtRect.Right := Right;
  end;//with GetStaticRect
  f_ExtraPanel.BoundsRect := l_ExtRect;
  f_ExtraPanel.Color := clBtnFace;
  f_SelectedOnlyCheckBox.Width := f_ExtraPanel.ClientWidth - f_SelectedOnlyCheckBox.Top*2;
  if (f_DialogKind in c_ListKinds) then
  begin
   f_ListTargetGroup.Caption := vcmConstString(str_SaveDialogListTarget);
   l_MergeLeft := lp_AdjustControlWidth(f_TitlesRadio, 0, str_SaveDialogListTitles);
   f_TitlesRadio.OnClick := ListTargetClick;
   l_MergeLeft := lp_AdjustControlWidth(f_ContentsRadio, l_MergeLeft, str_SaveDialogListContents);
   f_ContentsRadio.OnClick := ListTargetClick;
   if Assigned(f_NumbersRadio) then
   begin
    l_MergeLeft := lp_AdjustControlWidth(f_NumbersRadio, l_MergeLeft, str_SaveDialogListIdentifiers);
    f_NumbersRadio.OnClick := ListTargetClick;
   end;//Assigned(f_NumbersRadio)
   lp_AdjustControlWidth(f_MergeCheckBox, 0, str_SaveDialogListWithMerge);
   f_MergeCheckBox.Left := l_MergeLeft;
   f_ListTargetGroup.Width := f_MergeCheckBox.BoundsRect.Right + 3 * f_MergeCheckBox.Height;
   f_SelectedOnlyCheckBox.Caption := vcmConstString(str_SaveDialogListSelection);
   f_MergeCheckBox.OnClick := MergeClick;
  end//f_DialogKind in c_ListKinds
  else
   f_SelectedOnlyCheckBox.Caption := vcmConstString(str_SaveDialogDocumentSelection);
 end; {if..}
 inherited;
//#UC END# *4DCC1FEE0352_4AF32FBD00F5_impl*
end;//TnsSaveDialog.DoShow
{$IfEnd} //not NoVCL

{$If not defined(NoVCL)}
function TnsSaveDialog.DoCanClose: Boolean;
//#UC START# *4DCC203E0199_4AF32FBD00F5_var*
var
 l_Edit: THandle;
//#UC END# *4DCC203E0199_4AF32FBD00F5_var*
begin
//#UC START# *4DCC203E0199_4AF32FBD00F5_impl*
 Result := inherited DoCanClose;
 if not Result then
 begin
  l_Edit := GetFileNameEditHandle;
  UpdateFileNameEditEnable(True);
  SetFocus(l_Edit);
  UpdateFileNameEditEnable;
 end;
//#UC END# *4DCC203E0199_4AF32FBD00F5_impl*
end;//TnsSaveDialog.DoCanClose
{$IfEnd} //not NoVCL

{$If not defined(NoVCL)}
function TnsSaveDialog.Execute: Boolean;
//#UC START# *4DCC20C10116_4AF32FBD00F5_var*
var
 l_Cursor: TCursor;
 l_OwnerHandle: HWND;
 l_FocusedWnd: HWND;
//#UC END# *4DCC20C10116_4AF32FBD00F5_var*
begin
//#UC START# *4DCC20C10116_4AF32FBD00F5_impl*
 if NewStyleControls and
    not (ofOldStyleDialog in Options) and
    (f_DialogKind in [ns_sdkDocument, ns_sdkList, ns_sdkListInternal]) then
 begin
  Assert(Assigned(f_ExtraPanel));
  case f_DialogKind of
   ns_sdkDocument:
    Template := 'DOCUMENTPANEL';
   ns_sdkList:
    Template := 'LISTPANEL';
   ns_sdkListInternal:
    Template := 'LISTINTERNALPANEL';
  end;//case f_DialogKind
 end//NewStyleControls..
 else
  Template := nil;
 l_Cursor := Screen.Cursor;
 if Assigned(f_ExtraPanel) then
  Screen.Cursor := f_ExtraPanel.Cursor;
 try
  l_OwnerHandle := 0;
  l_FocusedWnd := 0;
  if (vcmBase.g_Dispatcher <> nil) then
  begin
   l_OwnerHandle := vcmBase.g_Dispatcher.FormDispatcher.CurrentMainForm.VCLWinControl.Handle;
   // запоминаем окно с фокусом - сам он туда не возвращается почему-то...
   l_FocusedWnd := Windows.GetFocus;
  end;//vcmBase.g_Dispatcher <> nil
  f_Executing := True;
  try
   Result := DoExecute(@GetSaveFileName, l_OwnerHandle);
  finally
   f_Executing := False;
  end;//try..finally
  if (l_OwnerHandle <> 0) AND (l_FocusedWnd <> 0) then
   SetFocus(l_FocusedWnd);
 finally
  Screen.Cursor := l_Cursor;
 end;//try..finally
//#UC END# *4DCC20C10116_4AF32FBD00F5_impl*
end;//TnsSaveDialog.Execute
{$IfEnd} //not NoVCL

//#UC START# *4AF32FBD00F5impl*
//#UC END# *4AF32FBD00F5impl*

{$IfEnd} //not Admin AND not Monitorings

end.