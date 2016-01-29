{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}
unit IEConst;

interface

resourcestring
  sCannotInsertAtCurrentPosition = 'Element cannot be inserted at the current position';
  sElementCreateError = 'Error creating element: %0:s (%1:s)';

  sFlowLayout = 'The page you are working on is in flow layout mode, and ' +
    'objects will be arranged top-to-bottom as in a word processing document.'#13#10#13#10 +
    'To use absolute (x and y) positioning, change the pageLayout property of the DOCUMENT to GridLayout';
  sFlowLayoutFixed = 'The page you are working on is in flow layout mode, and ' +
    'objects will be arranged top-to-bottom as in a word processing document.';
  sGridLayout = 'The page you are working on is in grid layout mode, and ' +
    'objects will be arranged using absolute (x and y) coordinates.'#13#10#13#10 +
    'To use flow layout (top to bottom, as in a word processing document), change the pageLayout property of the DOCUMENT to FlowLayout';

  sAttachToNilElement = 'Attempting to attach behavior on a nil element';
  sFactoryPropertyNotAssigned = '%s Factory property is not assigned';
  sMultiSelectNotEnabled = 'Multiselect is not enabled';
  sFinishPosNotSet = '%s.FinishPos must be set before calling FindText';
  sNoSearchStringSpecified = 'No search string specified';
  sSetPointerError = 'Both StartPos and FinishPos must be set before calling InsertElement';
  sStartPosNotSet = 'StartPos must be set before calling InsertText';
  sPointersNotSetError = 'StartPos, FinishPos and InsertPos must be set before calling Copy';
  sMarkupServicesNotAvailable = 'IMarkupServices not available';
  sMarkupServices2NotAvailable = 'IMarkupServices2 not available';
  sCallingFindNextBeforeFind = 'Find must be called prior to calling FindNext';
  sFindBehaviorFoundTwoBehaviors = 'Two behaviors (%s, %s) found for one URL (%s)';
  sMarkupServicesUnavailable = 'No markup services available';
  sMarkupServicesPointerError = 'StartPos, FinishPos and InsertPos must be set before calling Move';
  sErrorCreatingBehavior = '%s.CreateBehavior failed with error: %s';

  sNoPageLoaded = 'No page loaded';
  sNilProvider = 'Cannot register a nil provider';
  sInvalidServiceProviderGUID = 'Invalid service provider GUID';
  sClassSinkingError = '%s only supports sinking of method calls!';
  sWebBrowserNotAssigned = '%s.WebBrowser property not assigned';
  sEditDesignerNoPageLoaded = 'Cannot activate an edit designer (%s) when there is no active document';
  sChildWindowsAlreadyHooked = 'Attempting to hook child windows twice';
  sSaveCurrentFile = 'Save the current file?';

implementation

end.
