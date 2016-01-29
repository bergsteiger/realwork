{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit BindCompDsnResStrs;

interface

resourcestring

  SBindCompListEdit = '&Binding Components...';
  SBindCompExpressionEdit = '&Expressions...';
  SEvaluateFormat = 'Format';
  SEvaluateClear = 'Clear';
  SEvaluate = 'Evaluate';
  SBindFillList = 'Fill List';
  SBindClearList = 'Clear List';
  SBindFillGrid = 'Fill Grid';
  SBindClearGrid = 'Clear Grid';
  sAllCollections = '(All Collections)';

  SNewBindingDlgCommand = 'New LiveBinding Component...';
  SBindVisuallyCommand = 'Bind Visually...';
  SNewBindingWizard = 'LiveBindings Wizard...';
  SRepeatLinkToNewCommand = 'Link to new %s';
  SLinkToNewControlCommand = 'Link to new control...';
  SRemoveDiagramLink = 'Remove Link';
  SNewDBLinkFieldDlgCommand = 'Link to DB Field...';
  SNewDBLinkDataSourceDlgCommand = 'Link to DB DataSource...';
  SNewDataBinding = 'New %s';
  SNewDataBindingHint = 'New %s|Create new %s';
  SCreateNewDataBinding = 'New Binding Component';
  SDeleteDataBinding = 'Delete';
  SSelectDataBinding = 'Select';
  SDataBindingCategoryNone = '(No Category)';
  SDataBindingCategoryAll = '(All LiveBindings)';
  SDataBindingListEditorCaption = 'Editing %s%s%s';

  sCaptionName = 'Name';
  sCaptionOutputScope = 'Output Scope';
  sCaptionOutputExpr = 'Output Expr';
  sCaptionValueScope = 'Value Scope';
  sCaptionValueExpr = 'Value Expr';
  sCaptionControl = 'Control';
  sCaptionSource = 'Source';
  sCaptionOperation = 'Operation';
  sAssignToControl = 'Assign to control';
  sAssignToSource = 'Assign to source';
  sAssignBidirectional = 'Bidirectional assignment';
  sControlExpressionFor = 'Control expression for %s:';
  sSourceExpressionFor = 'Source expression for %s:';
  sControlExpression = 'Control expression:';
  sSourceExpression = 'Source expression:';

  sStringVisualizer = 'String';
  sTypeVisualizer = 'Type';
  sPictureVisualizer = 'Picture';

  sBindLinkDescription = 'Link control "%0:s" to source "%1:s"';
  sBindGridLinkDescription = 'Link grid control "%0:s" to source "%1:s"';
  sBindExpressionDescription = 'Bind control "%0:s" from source "%1:s"';
  sBindExprItemsDescription = 'Bind control "%0:s" from source "%1:s" (%2:d expressions)';
  sBindListDescription = 'Populate list control "%0:s" from source "%1:s"';
  sBindPositionDescription = 'Position link using control "%0:s" from source "%1:s"';
  sBindControlValueDescription = 'Bind control "%0:s" to component "%1:s"';
  sExpressionsBindCompDesc = 'Bind expressions component "%0:s" to component "%1:s"';

  SConfirmDelete = 'Delete %s?';

  SDeleteColumnsQuestion = 'Delete existing columns?';
  SDBGridColEditor = 'Co&lumns Editor...';

  sSelectAdDataSource = 'Select a data source';
  sSelectAField = 'Select a field';

  // Expression collection names
  sParse = 'Parse';
  sFormat = 'Format';
  sFormatCell = 'CellFormat';
  sFormatColumn = 'ColFormat';
  sParseCell = 'CellParse';
  sClear = 'Clear';
  sPosControl = 'PosControl';
  sPosSource = 'PosSource';
  sPosClear = 'PosClear';
  sColumns = 'Columns';
  sFormatControl = 'FormatControl';
  sClearControl = 'ClearControl';
  sExpression = 'Expression';

  // Wizard
  sBindingTypeDescription = 'Select a binding task';
  sBindingTypeTitle = 'Binding task';
  sComponentPropertyDescription = 'Select a component and a property';
  sComponentPropertyTitle = 'Component property';
  sGridPageDescription = 'Select a grid or a grid class';
  sGridPageTitle = 'Grid';
  sControlPageDescription = 'Select a control or control class';
  sControlPageTitle = 'Control';
  sDataSourcePageDescription = 'Choose a datasource';
  sDataSourcePageTitle = 'Data source';
  sFieldPageDescription = 'Choose a field';
  sFieldPageTitle = 'Field';
  sAddFieldPageDescription = 'Add fields';
  sAddFieldPageTitle = 'Fields';
//  sCreateFieldPageDescription = 'Create a field';
//  sCreateFieldPageTitle = 'Field';
  sCreateDataSourcePageDescription = 'Select a data source class';
  sCreateDataSourcePageTitle = 'Data source';
  sCreateControlPageDescription = 'Control';
  sCreateControlPageTitle = 'Create a control';
  sOptionsPageDescription = 'Set create options';
  sOptionsPageTitle = 'Options';
  sScopePropertiesPageDescription = 'Specify data source properties';
  sScopePropertiesPageTitle = 'Data source properties';
  sNewGrid = 'New grid';
  sExistingGrid = 'Existing grid';

  sLinkFieldToControlInfo = 'Display the value of a field in a control.  Use the control to modify the field value.';
  sLinkControlToFieldInfo = 'Use a control to display the value of a field.  Use the control to modify the field value.';
  sLinkPropertyToControlInfo = 'Display the value of a property in a control.  Some types of controls can also edit the property.';
  sLinkControlToPropertyInfo = 'Use a control to display the value of a property.  Some types of controls can also edit the property.';
  sLinkFieldToPropertyInfo = 'Write the value of field to a property.  Update the property when the field value changes.';
  sLinkPropertyToFieldInfo = 'Set a property with the value of a field.  Update the property when the field value changes.';
  sLinkDataSourceToGridInfo = 'Display the fields of a data source in a grid.';
  sLInkGridToDataSourceInfo = 'Use a grid to display fields of a data source.';
  sNewDataSourceInfo = 'Create a new data source.';


  sRadioButtonLinkControlToFieldCaption = 'Link %s with a field';
  sRadioButtonBindControlToPropertyCaption = 'Link %s to a component property';
  sRadioButtonLinkPropertyToFieldCaption = 'Link a property of %s To a field';
  sRadioButtonLinkPropertyToFieldMemberCaption = 'Link "%1:s" of %0:s to a field';
  sRadioButtonLinkFieldToControlCaption = 'Link a field of %s to a control';
  sRadioButtonLinkFieldToControlMemberCaption = 'Link field "%1:s" of %0:s to a control';
  sRadioButtonBindPropertyToControlCaption = 'Link a property of %s to a control';
  sRadioButtonBindPropertyToControlMemberCaption = 'Link property "%1:s" of %0:s to a control';
  sRadioButtonLinkFieldToPropertyCaption = 'Link a field of %s to a component property';
  sRadioButtonLinkFieldToPropertyMemberCaption = 'Link field "%1:s" of %0:s with a component property';
  sRadioButtonLinkDataSourceToGridCaption = 'Link %s with a grid control';
  sRadioButtonLinkGridToDataSourceCaption = 'Link %s with a data source';
  sRadioButtonNewDataSourceCaption = 'Create a new data source';

  sChooseADataSource = 'Choose a data source';
  sChooseAField = 'Choose a field';
  sNewScope = '<New source>';
  sNewField = '<New field>';

  sNewControl = '<New control>';
  sChooseAControl = 'Choose a control';
  sChooseAControlClass = 'Choose a control class';

  sChooseAComponent = 'Choose a component';
  sChooseAProperty = 'Choose a property';

  sChooseAClass = 'Select a control class';

  // Visualization Graph plugin
  sVisualizationGroup = 'LiveBindings Designer';
  sVisualizationOptions = 'LiveBindings';
  sNodeVisibility = 'Visible Element';
  sNodeLayerNames = 'Element Layers';
  sFindLinkableSubNode = 'See all members..';
  sLinkToSubNode = 'Bind to ''%s''';
  sLinkToCategory = 'Bind To';
  sLinkFromSubNode = 'Bind from ''%s''';
  sLinkFromCategory = 'Bind From';
  sSubNodeCustomization = 'Bindable Members..';
  sReloadDesigner = 'Refresh Designer';
  sSubNodeCustomizeCaption = 'Bindable Members';
  sDeleteSubNode = 'Delete Member';
  sShowEmbeddedNode = 'Show Embedded Component';
//  sDeleteLink = 'Delete Binding';
  sDeleteWarning = 'This will also remove associated components from the module %s. Are you sure?';
  sHideNodes = 'Hide Element(s)';
  sHiddenNodesCustomization = 'Show/Hide elements..';
  sHiddenNodesCustomizeCaption = 'Element Visibility';
  sLBLayersCategory = 'Layers';
  sLBAddNewLayer = 'Add to new layer';
  sLBAddToLayer = 'Add to layer %s';
  sLBRemoveLayer = 'Remove from layer %s';
  sNotImplemented = 'Not implemented';
  sNewLayerName = 'New Layer';
  sNewLayerPrompt = 'Layer Name:';
  sAddCustomMember = 'Custom Bindable Member';
  sCustomMemberAlreadyExists = 'Custom member already exists!';

  sBindScopeDataSource = '%0:s (%1:s)';

  sWildcardMemberName = '*';
  sGridColumnMember = 'Column[%d]';

  // options dialogs
  sExcludedItems = 'Excluded Items';
  sIncludedItems = 'Included Items';

  sNoDataSourceDelete = '%0:s does not reference a data source component. Delete %0:s?';
  sNoControlDelete = '%0:s does not reference a control component. Delete %0:s?';
  sNoComponentDelete = '%0:s does not reference a component property. Delete %0:s?';

implementation

end.
