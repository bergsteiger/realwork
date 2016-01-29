unit fClass;
{
//
// Components : Registration for 1stClass
//
// Copyright (c) 1999 by Woll2Woll Software
//
}
interface

{$i fcIfDef.pas}

uses Classes, Graphics, DBTables, DB, fcColorCombo, fcButton,
  {$ifdef fcDelphi6Up}
  DesignIntf,
  {$else  fcDelphi6Up}
  dsgnintf,
  {$endif fcDelphi6Up}
  fcLabel,
  fcStatusBar, fcMsg, fcImageForm, fcImager, fcCollectionEditor, fcButtonGroup,
  fcOutlookBar, fcClearPanel, fcDBTreeView, fctreeview,
  Controls, fcPropEdt, fcFontCombo, fcShapeBtn, fcImgBtn, fcTreeCombo,
  fcBitmap, fcOutlookList, fcDemoRichEdit, fcCollection;

procedure Register;

implementation

{$r 1stClass.dcr}

procedure Register;
begin
  RegisterComponents('1stClass', [TfcTreeView]);
  RegisterComponents('1stClass', [TfcDBTreeView]);
  RegisterComponents('1stClass', [TfcButtonGroup, TfcOutlookBar]);
  RegisterComponents('1stClass', [TfcImageForm]);
  RegisterComponents('1stClass', [TfcStatusBar]);
  RegisterComponents('1stClass', [TfcImager]);
  RegisterComponents('1stClass', [TfcShapeBtn]);
  RegisterComponents('1stClass', [TfcImageBtn]);
  RegisterComponents('1stClass', [TfcTreeCombo]);
  RegisterComponents('1stClass', [TfcFontCombo]);
  RegisterComponents('1stClass', [TfcColorCombo]);
  RegisterComponents('1stClass', [TfcColorList]);
  RegisterComponents('1stClass', [TfcLabel]);
  RegisterClasses([TfcDemoRichEdit]);

  RegisterPropertyEditor(TypeInfo(string), TfcCustomButtonGroup,
    'ButtonClassName', TfcButtonGroupControlClassEditor);
  RegisterPropertyEditor(TypeInfo(TCaption), TfcCustomLabel, 'Caption', TfcLabelCaptionEditor);
  RegisterPropertyEditor(TypeInfo(TCaption), TfcCustomBitBtn, 'Caption', TfcButtonCaptionEditor);
//  RegisterPropertyEditor(TypeInfo(TfcButtonGroupItems), TfcCustomButtonGroup,
//    'Items', TfcButtonGroupItemsEditor);
//  RegisterPropertyEditor(TypeInfo(TBitmap), TfcImageBtn, '', TfcImageBtnImageEditor);
  RegisterPropertyEditor(TypeInfo(TfcStatusPanels), TfcCustomStatusBar, 'Panels', TfcStatusBarPanelsEditor);
//  RegisterComponentEditor(TypeInfo(TfcTreeView), TfcTreeHeaderSectionsEditor);
  RegisterPropertyEditor(TypeInfo(TfcTreeNodes), TfcCustomTreeView, 'Items',  TfcTreeViewItemsProperty);
  RegisterPropertyEditor(TypeInfo(TfcTreeNodes), TfcCustomTreeCombo, 'Items',
    TfcTreeComboItemsProperty);
  RegisterPropertyEditor(TypeInfo(TfcBitmap), nil, '', TfcBitmapEditor);
  RegisterPropertyEditor(TypeInfo(TfcButtonGroupItem), nil, '', TfcButtonGroupSelectedEditor);
  RegisterPropertyEditor(TypeInfo(TColor), TfcCustomColorCombo, 'SelectedColor', TfcColorComboSelectedColorEditor);
  RegisterPropertyEditor(TypeInfo(TColor), TfcCustomImageBtn, 'TransparentColor', TfcImageBtnTranColorEditor);
//  RegisterComponents('1stClass', [TfcOutlookList]);
  RegisterPropertyEditor(TypeInfo(TComponent), TfcCustomImageBtn, 'ExtImage', TfcImageBtnExtImageEditor);
  RegisterPropertyEditor(TypeInfo(TComponent), TfcCustomImageBtn, 'ExtImageDown', TfcImageBtnExtImageEditor);
  RegisterPropertyEditor(TypeInfo(TfcCustomBitBtn), TfcCustomOutlookBar, 'ActivePage', TfcOutlookBarActivePageEditor);
  RegisterPropertyEditor(TypeInfo(TfcCollection), TPersistent, '', TfcCollectionEditor);

  RegisterComponentEditor(TfcCustomTreeView, TfcTreeViewEditor);
  RegisterComponentEditor(TfcCustomLabel, TfcComponentEditor);
  RegisterComponentEditor(TfcDBCustomTreeView, TfcComponentEditor);
  RegisterComponentEditor(TfcCustomButtonGroup, TfcButtonGroupEditor);
  RegisterComponentEditor(TfcOutlookList, TfcCustomOutlookListEditor);
  RegisterComponentEditor(TfcOutlookPanel, TfcOutlookPanelEditor);
  RegisterComponentEditor(TfcCustomImageForm, TfcImageFormEditor);
  RegisterComponentEditor(TfcCustomStatusBar, TfcStatusBarEditor);
  RegisterComponentEditor(TfcCustomImager, TfcImagerEditor);
  RegisterComponentEditor(TfcCustomShapeBtn, TfcCustomBtnEditor);
  RegisterComponentEditor(TfcCustomImageBtn, TfcImgBtnEditor);
  RegisterComponentEditor(TfcCustomTreeCombo, TfcTreeComboEditor);
  RegisterComponentEditor(TfcCustomFontCombo, TfcComponentEditor);
  RegisterComponentEditor(TfcCustomColorCombo, TfcComponentEditor);
  RegisterComponentEditor(TfcCustomColorList, TfcComponentEditor);
end;

end.
