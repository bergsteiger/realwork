{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit DesignConst;

interface

resourcestring
  srNone = '(None)';
  srLine = 'line';
  srLines = 'lines';

  SInvalidFormat = 'Invalid graphic format';

  SUnableToFindComponent = 'Unable to locate form/component, ''%s''';
  SCantFindProperty = 'Unable to locate property ''%s'' on component ''%s''';
  SStringsPropertyInvalid = 'Property ''%s'' has not been initialized on component ''%s''';

  SLoadPictureTitle = 'Load Picture';
  SSavePictureTitle = 'Save Picture As';

  SAboutVerb = 'About...';
  SNoPropertyPageAvailable = 'No property pages are available for this control';
  SNoAboutBoxAvailable = 'An About Box is not available for this control';
  SNull = '(Null)';
  SUnassigned = '(Unassigned)';
  SUnknown = '(Unknown)';
  SString = 'String';

  SUnknownType = 'Unknown Type';

  SCannotCreateName = 'Cannot create a method for an unnamed component';

  SColEditCaption = 'Editing %s%s%s';

  SCantDeleteAncestor = 'Selection contains a component introduced in an ancestor form which cannot be deleted';
  SCantAddToFrame = 'New components cannot be added to frame instances.';

  SAllFiles = 'All Files (*.*)|*.*';

  SLoadingDesktopFailed = 'Loading the desktop from "%s" for dock host window "%s" failed with message: ' +
    SLineBreak  + SLineBreak + '"%s: %s"';

  sAllConfigurations = 'All configurations';
  sAllPlatforms = 'All platforms';
  sPlatform = ' platform';
  sConfiguration = ' configuration';

  sClassNotApplicable = 'Class %s is not applicable to this module';
  sNotAvailable = '(Not available)';
  sEditSubmenu = 'Edit';
  sUndoComponent = 'Undo';
  sCutComponent = 'Cut';
  sCopyComponent = 'Copy';
  sPasteComponent = 'Paste';
  sDeleteComponent = 'Delete';
  sSelectAllComponent = 'Select All';
  sControlSubmenu = 'Control';

  sUnsupportedChildType = '%s doesn''t support %s children';

const
  SIniEditorsName = 'Property Editors';

implementation

end.
