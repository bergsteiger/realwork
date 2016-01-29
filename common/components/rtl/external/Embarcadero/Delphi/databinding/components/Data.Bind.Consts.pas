{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.Bind.Consts;

interface

resourcestring
  SBindingComponentsCategory = 'LiveBindings';
  SBindingComponentsMiscCategory = 'LiveBindings Misc';
  SBindingComponentsDeprecatedCategory = 'LiveBindings Deprecated';  // Temporary
  SInvalidBindCompRegistration = 'Invalid LiveBindings registration';
  SInvalidBindCompUnregistration = 'Invalid LiveBindings unregistration';
  SInvalidBindCompEnumeration = 'Invalid LiveBindings enumeration';
  SInvalidBindCompCreation = 'Invalid LiveBindings creation';
  SInvalidBindCompFactory = 'Invalid LiveBindings factory';
  SInvalidBindCompFactoryEnumeration = 'Invalid LiveBindings factory enumeration';
  SInvalidBindCompDesigner =  'Invalid LiveBindings designer';
  SInvalidBindCompComponents = 'Invalid data bound components';
  sDisplayTextAttr = 'Display Text';
  sMinValueAttr = 'Min Value';
  sMaxValueAttr = 'Max Value';
  sArgCount = 'Unexpected argument count';
  sNameAttr = 'Name';
  sValueAttr = 'Value';
  sControlAttr = 'Control Expression';
  sSourceAttr = 'Source Expression';
  sSourceComponentAttr = 'Source Component';
  sIDAttr = 'ID';
  sStateAttr = 'State';
  sNotImplemented = 'Not implemented';
  sNoListEditor = 'Error in %0:s.  No list control editor available for %1:s';
  sNoNamedListEditor = 'Error in %0:s.  No list control editor "%2:s" available for %1:s';
  sNoEnumerator = 'Error in %0:s.  No enumerator available for %1:s';
  sNoInsertItem = 'Error in %0:s.  Inserted item not available for %1:s';
  sNoControl = 'Error in %0:s.  No control component';
  SDataSourceUnidirectional = 'Error in %0:s: Operation not allowed on a unidirectional data source';
  sNoControlObserverSupport = 'Error in %0:s.  No observer support for %1:s';
  sErrorNoLookupSupport = 'Error in %0:s when attempting to fill a lookup list with a control (%1:s) which does not support lookups';
  sNoLookupSupport = 'A lookup list can''t be created with a control (%0:s) which does not support lookups';
  sObjectValueExpected = 'TObject value expected';
  sLinkFieldNotFound = 'Unable to determine field name in %s';
  sLinkUnexpectedGridCurrentType = 'Unexpected grid current type in %s';
  // Categories
  SDataBindingsCategory_BindingExpressions = 'Binding Expressions';
  SDataBindingsCategory_Links = 'Links';
  SDataBindingsCategory_Lists = 'Lists';
  SQuickBindingsCategory = 'Quick Bindings';
  SDataBindingsCategory_DBLinks = 'DB Links (deprecated)';
  // Method
  sCheckedState = 'CheckedState';
  sCheckedStateDesc = 'Bidirectional method to either get the checked state of a control,'#13#10 +
    'or set the checked state in a control'#13#10 +
    'Example usage when binding to a TCheckBox:'#13#10 +
    '   CheckedState(Self)';
  sSelectedText = 'SelectedText';
  sSelectedTextDesc = 'Bidirectional method to either get the text selected in a control,'#13#10 +
     'or set the text selected in a control'#13#10 +
     'Example usage when binding to a TListBox:'#13#10 +
     '  SelectedText(Self)';
  sSelectedItem = 'SelectedItem';
  sSelectedItemDesc = 'Bidirectional method to either get the selected item in a control,'#13#10 +
     'or set the selected item in a control'#13#10 +
     'Example usage when binding to a TListBox:'#13#10 +
     '  SelectedItem(Self).Text';
  sSelectedLookupValue = 'SelectedLookupValue';
  sSelectedLookupValueDesc = 'Bidirectional method to either get the selected lookup value in a control'#13#10 +
     'Example usage when binding to a TListBox:'#13#10 +
     '  SelectedLookupValue(Self).AsString';
  sSelectedValue = 'SelectedValue';
  sSelectedValueDesc = 'Bidirectional method to either get the selected value in a control,'#13#10 +
     'or set the selected lookup value in a control'#13#10 +
     'Example usage when binding to a TListBox:'#13#10 +
     '  SelectedLookupValue(Self).AsString';
  sLookup = 'Lookup';
  sLookupDesc = 'Lookup a value in a bind scope.  Returns the lookup value.'#13#10 +
     'Example usage:'#13#10 +
     '  Lookup(BindScope, "keyfieldname", lookupkeyvalue, "valuefieldname")';
  //LinkObservers
  sBindLinkIncompatible = 'Error configuring %s: Object must implement IBindLink';
  sBindPositionIncompatible = 'Error configuring %s: Object must implement IBindPosition';
  SDuplicateName = 'Duplicate name ''%s'' in %s';
  SNotEditing = 'Not editing';
  SFieldNotFound = 'Field ''%s'' not found';
  sNoBindsourceAdapter = 'No adapter';
  sSameSourceAndControlComponent = 'Error in %s: Source component and control component cannot be the same';

  // Data generator fields collection
  sTypeAttr = 'Field Type';
  sGeneratorAttr = 'Generator';

  sMemberNotFound = 'Error in %2:s: Member %0:s not found in %1:s';
  sComponentEvalError = 'EvalError in %0:s: %1:s';

  // Navigator hints
  SFirstRecord = 'First record';
  SPriorRecord = 'Prior record';
  SNextRecord = 'Next record';
  SLastRecord = 'Last record';
  SInsertRecord = 'Insert record';
  SDeleteRecord = 'Delete record';
  SEditRecord = 'Edit record';
  SPostEdit = 'Post edit';
  SCancelEdit = 'Cancel edit';
  SConfirmCaption = 'Confirm';
  SRefreshRecord = 'Refresh data';
  SApplyUpdates = 'Apply updates';
  SCancelUpdates = 'Cancel updates';
  SDeleteRecordQuestion = 'Delete record?';
  sScopeLookupNotImplemented = '%s does not implement IScopeLookup';
  sNoBidiLookup = 'Lookup controls do not support bidirectional editing';

  sDataSourceReadOnly = 'Cannot modify a read-only data source';
  sDataSourceClosed = 'Cannot perform this operation on a closed dataset';
  sInvalidInstance = 'New instance of type %0:s does not match expected type %1:s';
  sNilList = 'List is nil';
  sUnknownEditor = 'Unknown editor: %s';

  sControlMember = 'Control Member';
  sSourceMember = 'Source Member';
  sCustomFormat = 'Custom Format';

implementation

end.
