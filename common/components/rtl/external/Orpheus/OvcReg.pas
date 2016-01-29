{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                   OVCREG.PAS 2.17                     *}
{*     Copyright 1995-98 (c) TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$IFDEF Win32}
  {$IFNDEF VER93}                                                      {!!.16}
    {$R OVCREG.R32}
  {$ENDIF}
{$ELSE}
  {$R OVCREG.R16}
{$ENDIF}


unit OvcReg;
  {-Registration unit for the Orpheus components}

{$I l3Define.inc }  

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  {$IfDef Delphi6}
  DesignIntf,
  DesignEditors,
  VCLEditors,
  {$Else  Delphi6}
  DsgnIntf,
  {$EndIf Delphi6}
  Classes, Controls, TypInfo,
  OvcData, OvcValid;


type
  {property editor for the virtual listbox header string property}
  THeaderProperty = class(TCaptionProperty);

type
  {property editor for the timer pool}
  TOvcTimerPoolEditor = class(TDefaultEditor)
  protected
    {$IfDef Delphi6}
    procedure EditProperty(const PropertyEditor: IProperty; var Continue: Boolean);
      override;
    {$Else  Delphi6}
    procedure EditProperty(PropertyEditor : TPropertyEditor;
              var Continue, FreeEditor : Boolean);
      override;
    {$EndIf Delphi6}
  public
    procedure ExecuteVerb(Index : Integer);
      override;
    function GetVerb(Index : Integer) : AnsiString;
      override;
    function GetVerbCount : Integer;
      override;
  end;

type

{property editor to preculde listing components of the same base class}
TExcludeComponentProperty = class(TComponentProperty)
public
  procedure GetValues(Proc : TGetStrProc);
    override;
end;


procedure Register;


implementation


uses
  {$IFDEF NVBUG} LibMain, {$ENDIF}
  SysUtils, Forms, Graphics,
  OvcEf,     {base entry field class--needed for sf, pf, nf, and ae}
  OvcEfPe,   {range property editor}
  OvcSf,     {simple field component}
  OvcSfPE,   {simple mask property editor form}
  OvcPf,     {picture field component}
  OvcPfPE,   {picture mask property editor form}
  OvcNf,     {numeric entry field component}
  OvcNfPE,   {numeric mask property editor}
  OvcAe,     {array editors}
  OvcAePe,   {range property editor}
  //OvcVlb,    {virtual list box component}
  OvcNbk,    {notebook component}
  OvcNbkP0,  {property editor for the notebook pages}
  OvcCal,    {calendar component}
  //OvcViewr,  {viewer and text file viewer components}
  //OvcMeter,  {meter component}
  OvcSc,     {spin components}
  //OvcTimer,  {timer pool}
  //OvcRLbl,   {rotated label component}
  //OvcEdit,   {editor and text editor components}
  OvcXfer,   {form data transfer component}
  OvcXfrC0,  {transfer component component editor}
  OvcFxFnt,  {fixed font class}
  OvcFxFPE,  {fixed font property editor}
  OvcFnPe,   {file name property editor}
  //OvcPLb,    {picture label}
  //OvcABtn,   {attached button component}
  //OvcCkLB,   {checked item listbox component}
  //OvcISLB,   {incremental search listbox component}
  //OvcBtnHd,  {button header component}
  //OvcSplit,  {splitter component}
  //OvcWebP0,  {turbopower web componenteditor class}
  OvcAbot0,
  OvcBase,
  OvcCmd,
  OvcCmdP0,
  OvcVer;


{$I OVCTABS.INC}  {constant declarations for Delphi palette tab names}


{*** TOvcTimerPoolEditor ***}

procedure TOvcTimerPoolEditor.ExecuteVerb(Index : Integer);
begin
{  if Index = 0 then
    ShellWebCall
  else if Index = 1 then
    ShellMailCall;}
end;

{$IfDef Delphi6}
procedure TOvcTimerPoolEditor.EditProperty(const PropertyEditor: IProperty; var Continue: Boolean);
  //override;
{$Else  Delphi6}
procedure TOvcTimerPoolEditor.EditProperty(PropertyEditor : TPropertyEditor;
          var Continue, FreeEditor : Boolean);
{$EndIf Delphi6}
var
  PropName : string;
begin
  PropName := PropertyEditor.GetName;
  if CompareText(PropName, 'ONALLTRIGGERS') = 0 then begin
    PropertyEditor.Edit;
    Continue := False;
  end;
end;

function TOvcTimerPoolEditor.GetVerb(Index : Integer) : AnsiString;
begin
(*  case Index of
    0 : Result := WebText;
    1 : Result := MailText;
  else*)
    Result := '?';
//  end;
end;

function TOvcTimerPoolEditor.GetVerbCount : Integer;
begin
  Result := 0{2};
end;

{*** TExcludeComponentProperty ***}

procedure TExcludeComponentProperty.GetValues(Proc : TGetStrProc);
var
  I, J      : Integer;
  Component : TComponent;
  PropClass : TClass;
  Skip      : Boolean;
begin
  PropClass := GetTypeData(GetPropType)^.ClassType;
  {$IfDef Delphi6}
  for I := 0 to Designer.Root.ComponentCount - 1 do begin
    Component := Designer.Root.Components[I];
  {$Else  Delphi6}
  for I := 0 to Designer.Form.ComponentCount - 1 do begin
    Component := Designer.Form.Components[I];
  {$EndIf Delphi6}

    {don't list component(s) being edited}
    Skip := False;
    for J := 0 to PropCount-1 do
      if GetComponent(J) = Component then begin
        Skip := True;
        Break;
      end;

    if (Component is PropClass) and (Component.Name <> '') and not Skip then
      Proc(Component.Name);
  end;
end;


{*** component registration ***}

procedure Register;
begin
  {register property editor for the controller}
  RegisterPropertyEditor(
    TypeInfo(TOvcCommandProcessor), nil, '', TOvcCommandProcessorProperty);

  {register component editor for the controller}
  RegisterComponentEditor(TOvcController, TOvcControllerEditor);

  {register property editors for the entry fields}
  RegisterPropertyEditor(
    TypeInfo(Char), TOvcSimpleField, 'PictureMask', TSimpleMaskProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcPictureField, 'PictureMask', TPictureMaskProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcNumericField, 'PictureMask', TNumericMaskProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcSimpleField, 'RangeHi', OvcEfPe.TEfRangeProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcSimpleField, 'RangeLo', OvcEfPe.TEfRangeProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcPictureField, 'RangeHi', OvcEfPe.TEfRangeProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcPictureField, 'RangeLo', OvcEfPe.TEfRangeProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcNumericField, 'RangeHi', OvcEfPe.TEfRangeProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcNumericField, 'RangeLo', OvcEfPe.TEfRangeProperty);
//  RegisterPropertyEditor(
//    TypeInfo(string), TOvcPictureLabel, 'PictureMask', TPictureMaskProperty);

  {register property editors for the array editors}
  RegisterPropertyEditor(
    TypeInfo(Char), TOvcSimpleArrayEditor, 'PictureMask', TSimpleMaskProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcPictureArrayEditor, 'PictureMask', TPictureMaskProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcNumericArrayEditor, 'PictureMask', TNumericMaskProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcSimpleArrayEditor, 'RangeHi', OvcAePe.TAeRangeProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcSimpleArrayEditor, 'RangeLo', OvcAePe.TAeRangeProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcPictureArrayEditor, 'RangeHi', OvcAePe.TAeRangeProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcPictureArrayEditor, 'RangeLo', OvcAePe.TAeRangeProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcNumericArrayEditor, 'RangeHi', OvcAePe.TAeRangeProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcNumericArrayEditor, 'RangeLo', OvcAePe.TAeRangeProperty);

  {register component editor for the timer pool component}
//  RegisterComponentEditor(TOvcTimerPool, TOvcTimerPoolEditor);

  {register component editor for the transfer component}
  RegisterComponentEditor(TOvcTransfer, TOvcTransferEditor);

  {register property editors and component editor for the notebook component}
  RegisterPropertyEditor(
    TypeInfo(string), TOvcNotebook, 'ActivePageName', TOvcTabPageNameProperty);
  RegisterPropertyEditor(
    TypeInfo(TStrings), TOvcNotebook, 'Pages', TOvcTabPageListProperty);
  RegisterComponentEditor(TOvcNotebook, TOvcNotebookEditor);

  {register property editor for the header of the virtual list box}
//  RegisterPropertyEditor(
//    TypeInfo(string), TOvcVirtualListBox, 'Header', THeaderProperty);

  {register property editors for the fixed font class}
  RegisterPropertyEditor(
    TypeInfo(string), TOvcFixedFont, 'Name', TOvcFixFontNameProperty);
  RegisterPropertyEditor(
    TypeInfo(TOvcFixedFont), nil, '', TOvcFixFontProperty);

  {register property editor and viewer for FileName properties}
//  RegisterPropertyEditor(
//    TypeInfo(string), TOvcTextFileEditor, 'FileName', TOvcFileNameProperty);
//  RegisterPropertyEditor(
//    TypeInfo(string), TOvcFileViewer, 'FileName', TOvcFileNameProperty);
//  RegisterPropertyEditor(
//   TypeInfo(string), TOvcTextFileViewer, 'FileName', TOvcFileNameProperty);

  {register property editor for the spinner components}
  RegisterPropertyEditor(
    TypeInfo(TWinControl), TOvcBaseSpinner, 'AttachedControl', TExcludeComponentProperty);
  RegisterPropertyEditor(
    TypeInfo(TWinControl), TOvcBaseSpinner, 'FocusedControl', TExcludeComponentProperty);

  {register property editor for the attached button component}
//  RegisterPropertyEditor(
//    TypeInfo(TWinControl), TOvcAttachedButton, 'AttachedControl', TExcludeComponentProperty);

  {!!.13}
  {register property editor for version property}
  RegisterPropertyEditor(
    TypeInfo(string), TOvcBase, 'Version', TOvcVersionProperty);
//  RegisterPropertyEditor(
//    TypeInfo(string), TOvcTimerPool, 'Version', TOvcVersionProperty);
  RegisterPropertyEditor(
    TypeInfo(string), TOvcTransfer, 'Version', TOvcVersionProperty);
//  RegisterPropertyEditor(
//    TypeInfo(string), TOvcCustomRotatedLabel, 'Version', TOvcVersionProperty);
//  RegisterPropertyEditor(
//    TypeInfo(string), TOvcAttachedButton, 'Version', TOvcVersionProperty);
//  RegisterPropertyEditor(
//    TypeInfo(string), TOvcCheckList, 'Version', TOvcVersionProperty);

  {register component editors for the turbopower web}
//  RegisterComponentEditor(TOvcBase, TOvcWebEditor);
//  RegisterComponentEditor(TOvcCheckList, TOvcWebEditor);
//  RegisterComponentEditor(TOvcAttachedButton, TOvcWebEditor);
//  RegisterComponentEditor(TOvcCustomRotatedLabel, TOvcWebEditor);

  {register our components}
  RegisterComponents(OrpheusTabName,
    [TOvcSimpleField,
     TOvcPictureField,
     TOvcNumericField,
     TOvcSimpleArrayEditor,
     TOvcPictureArrayEditor,
     TOvcNumericArrayEditor,
//     TOvcVirtualListbox,
//     TOvcEditor,
//     TOvcTextFileEditor,
//     TOvcFileViewer,
//     TOvcTextFileViewer,
     TOvcNotebook,
//     TOvcAttachedButton,
//     TOvcCheckList,
//     TOvcSearchList,
//     TOvcSplitter,
//     TOvcButtonHeader,
//     TOvcTimerPool,
//     TOvcRotatedLabel,
//     TOvcPictureLabel,
     TOvcCalendar,
//     TOvcMeter,
     TOvcSpinner,
//     TOvcFourWaySpinner,
//     TOvcStarSpinner,
     TOvcTransfer,
     TOvcController
    ]);

{$IFDEF NVBUG}
  {assign pointer to CompLib for use in OvcBase}
  OvcBase.ICompLib := LibMain.CompLib;
{$ENDIF}
end;


end.