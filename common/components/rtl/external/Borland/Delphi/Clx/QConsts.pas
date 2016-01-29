{ *************************************************************************** }
{                                                                             }
{ Delphi and Kylix Cross-Platform Visual Component Library                    }
{                                                                             }
{ Copyright (c) 2000-2002 Borland Software Corporation                        }
{                                                                             }
{ This file may be distributed and/or modified under the terms of the GNU     }
{ General Public License (GPL) version 2 as published by the Free Software    }
{ Foundation and appearing at http://www.borland.com/kylix/gpl.html.          }
{                                                                             }
{ Licensees holding a valid Borland No-Nonsense License for this Software may }
{ use this file in accordance with such license, which appears in the file    }
{ license.txt that came with this Software.                                   }
{                                                                             }
{ *************************************************************************** }

unit QConsts;

interface

const
  // Delphi mime types
  SDelphiBitmap = 'image/delphi.bitmap';
  SDelphiComponent = 'application/delphi.component';
  SDelphiPicture = 'image/delphi.picture';
  SDelphiDrawing = 'image/delphi.drawing';
  SBitmapExt = 'BMP';

resourcestring
  SInvalidCreateWidget = 'Class %s could not create QT widget';
  STooManyMessageBoxButtons = 'Too many buttons specified for message box';

  SmkcBkSp = 'Backspace';
  SmkcTab = 'Tab';
  SmkcBackTab = 'BackTab';
  SmkcEsc = 'Esc';
  SmkcReturn = 'Return';
  SmkcEnter = 'Enter';
  SmkcSpace = 'Space';
  SmkcPgUp = 'PgUp';
  SmkcPgDn = 'PgDn';
  SmkcEnd = 'End';
  SmkcHome = 'Home';
  SmkcLeft = 'Left';
  SmkcUp = 'Up';
  SmkcRight = 'Right';
  SmkcDown = 'Down';
  SmkcIns = 'Ins';
  SmkcDel = 'Del';
  SmkcShift = 'Shift+';
  SmkcCtrl = 'Ctrl+';
  SmkcAlt = 'Alt+';

  SOpenFileTitle = 'Open';
  SDuplicateReference = 'WriteObject called twice for the same instance';
  SClassMismatch = 'Resource %s is of incorrect class';
  SInvalidTabIndex = 'Tab index out of bounds';
  SInvalidTabPosition = 'Tab position incompatible with current tab style';
  SInvalidTabStyle = 'Tab style incompatible with current tab position';
  SInvalidBitmap = 'Bitmap image is not valid';
  SInvalidIcon = 'Icon image is not valid';
  SInvalidPixelFormat = 'Invalid pixel format';
  SBitmapEmpty = 'Bitmap is empty';
  SScanLine = 'Scan line index out of range';
  SChangeIconSize = 'Cannot change the size of an icon';
  SUnknownExtension = 'Unknown picture file extension (.%s)';
  SUnknownClipboardFormat = 'Unsupported clipboard format';
  SOutOfResources = 'Out of system resources';
  SNoCanvasHandle = 'Canvas does not allow drawing';
  SInvalidCanvasState = 'Invalid canvas state request';
  SInvalidImageSize = 'Invalid image size';
  SInvalidWidgetHandle = 'Invalid widget handle';
  SInvalidColorDepth = 'Color depth must be 1, 8 or 32 bpp';
  SInvalidXImage = 'Invalid XImage';
  STooManyImages = 'Too many images';
  SWidgetCreate = 'Error creating widget';
  SCannotFocus = 'Cannot focus a disabled or invisible window (%s)';
  SParentRequired = 'Control ''%s'' has no parent widget';
  SParentGivenNotAParent = 'Parent given is not a parent of ''%s''';
  SVisibleChanged = 'Cannot change Visible in OnShow or OnHide';
  SCannotShowModal = 'Cannot make a visible window modal';
  SScrollBarRange = 'Scrollbar property out of range';
  SPropertyOutOfRange = '%s property out of range';
  SMenuIndexError = 'Menu index out of range';
  SMenuReinserted = 'Menu inserted twice';
  SNoMenuRecursion = 'Menu insertion recursion not allowed';
  SMenuNotFound = 'Sub-menu is not in menu';
  SMenuSetFormError = 'TMenu.SetForm: argument must be TCustomForm';
  SNoTimers = 'Not enough timers available';
  SNoAdapter = 'No printer adapter available for printing';
  SPrinterIndexError = 'Printer index out of range';
  SInvalidPrinter = 'Printer selected is not valid';
  SDeviceOnPort = '%s on %s';
  SGroupIndexTooLow = 'GroupIndex cannot be less than a previous menu item''s GroupIndex';
  SNoMDIForm = 'Cannot create form. No MDI forms are currently active';
  SNotAnMDIForm = 'Invalid MDIParent for class %s';
  SMDIChildNotVisible = 'Cannot hide an MDI Child Form';
  SImageCanvasNeedsBitmap = 'Can only modify an image if it contains a bitmap';
  SControlParentSetToSelf = 'A control cannot have itself as its parent';
  SOKButton = 'OK';
  SCancelButton = 'Cancel';
  SYesButton = '&Yes';
  SNoButton = '&No';
  SHelpButton = '&Help';
  SCloseButton = '&Close';
  SIgnoreButton = '&Ignore';
  SRetryButton = '&Retry';
  SAbortButton = 'Abort';
  SAllButton = '&All';

  SCannotDragForm = 'Cannot drag a form';
  SPutObjectError = 'PutObject to undefined item';

  SFB = 'FB';
  SFG = 'FG';
  SBG = 'BG';
  SVIcons = 'Icons';
  SVBitmaps = 'Bitmaps';
  SVPixmaps = 'Pixmaps';
  SVPNGs = 'PNGs';
  SDrawings = 'Drawings';
  SVJpegs = 'Jpegs';
  SInvalidNumber = 'Invalid numeric value';
  SInvalidCurrentItem = 'Invalid value for current item';

  SMsgDlgWarning = 'Warning';
  SMsgDlgError = 'Error';
  SMsgDlgInformation = 'Information';
  SMsgDlgConfirm = 'Confirm';
  SMsgDlgYes = '&Yes';
  SMsgDlgNo = '&No';
  SMsgDlgOK = 'OK';
  SMsgDlgCancel = 'Cancel';
  SMsgDlgHelp = '&Help';
  SMsgDlgHelpNone = 'No help available';
  SMsgDlgHelpHelp = 'Help';
  SMsgDlgAbort = '&Abort';
  SMsgDlgRetry = '&Retry';
  SMsgDlgIgnore = '&Ignore';
  SMsgDlgAll = '&All';
  SMsgDlgNoToAll = 'N&o to All';
  SMsgDlgYesToAll = 'Yes to &All';

  srUnknown = '(Unknown)';
  srNone = '(None)';
  SOutOfRange = 'Value must be between %d and %d';
  SCannotCreateName = 'Cannot create a default method name for an unnamed component';
  SUnnamed = 'Unnamed';

  SInsertLineError = 'Unable to insert a line';

  SConfirmCreateDir = 'The specified directory does not exist. Create it?';
  SSelectDirCap = 'Select Directory';
  SCannotCreateDirName = 'Unable to create directory "%s".';
  SAccessDeniedTo = 'Access denied to "%s"';
  SCannotReadDirectory = 'Cannot read directory:' + sLineBreak + '"%s"';
  SDirectoryNotEmpty = 'Directory "%s" is not empty.';
  SNotASubDir = '"%s" is not a subdirectory of "%s"';
  SDirNameCap = 'Directory &Name:';
  SDrivesCap = 'D&rives:';
  SDirsCap = '&Directories:';
  SFilesCap = '&Files: (*.*)';
  SNetworkCap = 'Ne&twork...';
  SInvalidDirectory = 'Unable to read directory "%s".';
  SNewFolder = 'New Folder';
  SFileNameNotFound = '"%s"'#10'File not found.';
  SAlreadyExists = 'A file with that name already exists. Please specify a '+
    'different filename.';
  SConfirmDeleteTitle = 'Confirm file deletion';
  SConfirmDeleteMany = 'Are you sure you want to delete these %d items?';
  SConfirmDeleteOne = 'Are you sure you want to delete "%s"?';
  SContinueDelete = 'Continue delete operation?';
  SAdditional = 'Additional';
  SName = 'Name';
  SSize = 'Size';
  SType = 'Type';
  SDate = 'Date Modified';
  SAttributes = 'Attributes';
{$IFDEF LINUX}
  SOwner = 'Owner';
  SGroup = 'Group';
  SDefaultFilter = 'All Files (*)|*|';
{$ENDIF}
{$IFDEF MSWINDOWS}
  SPermissions = 'Attributes';
  SDefaultFilter = 'All Files (*.*)|*.*|';
  SVolume = 'Volume';
  SFreeSpace = 'Free Space';
  SAnyKnownDrive = ' any known drive';
  SMegs = '%d MB';
{$ENDIF}

  SDirectory = 'Directory';
  SFile = 'File';
  SLinkTo = 'Link to ';

  SInvalidClipFmt = 'Invalid clipboard format';
  SIconToClipboard = 'Clipboard does not support Icons';
  SCannotOpenClipboard = 'Cannot open clipboard';

  SDefault = 'Default';

  SInvalidMemoSize = 'Text exceeds memo capacity';
  SCustomColors = 'Custom Colors';
  SInvalidPrinterOp = 'Operation not supported on selected printer';
  SNoDefaultPrinter = 'There is no default printer currently selected';

  SUntitled = '(Untitled)';

  SDuplicateMenus = 'Menu ''%s'' is already being used by another form';

  SPictureLabel = 'Picture:';
  SPictureDesc = ' (%dx%d)';
  SPreviewLabel = 'Preview';
  SNoPreview = 'No Preview Available';

  SBoldItalicFont = 'Bold Italic';
  SBoldFont = 'Bold';
  SItalicFont = 'Italic';
  SRegularFont = 'Regular';

  SPropertiesVerb = 'Properties';

  SAllCommands = 'All Commands';

  SDuplicatePropertyCategory = 'A property category called %s already exists';
  SUnknownPropertyCategory = 'Property category does not exist (%s)';

  SInvalidFilter = 'Property filters may only be name, class or type based (%d:%d)';
  SInvalidCategory = 'Categories must define their own name and description';

  sOperationNotAllowed = 'Operation not allowed while dispatching application events';
  STextNotFound = 'Text not found: "%s"';

  SImageIndexError = 'Invalid ImageList Index';
  SReplaceImage = 'Unable to Replace Image';
  SInvalidImageType = 'Invalid image type';
  SInvalidImageDimensions = 'Image width and heigth must match';
  SInvalidImageDimension = 'Invalid image dimension';
  SErrorResizingImageList = 'Error resizing ImageList';

  SInvalidRangeError = 'Range of %d to %d is invalid';
  SInvalidMimeSourceStream = 'MimeSource format must have an associated data stream';
  SMimeNotSupportedForIcon = 'Mime format not supported for TIcon';

  SOpen = 'Open';
  SSave = 'Save';
  SSaveAs = 'Save As';
  SFindWhat = 'Fi&nd what:';
  SWholeWord = 'Match &whole word only';
  SMatchCase = 'Match &case';
  SFindNext = '&Find Next';
  SCancel = 'Cancel';
  SHelp = 'Help';
  SFindTitle = 'Find';
  SDirection = 'Direction';
  SUp = '&Up';
  SDown = '&Down';
  SReplaceWith = 'Rep&lace with:';
  SReplace = '&Replace';
  SReplaceTitle = 'Replace';
  SReplaceAll = 'Replace &All';
  SOverwriteCaption = 'Save %s as';
  SOverwriteText = '"%s" already exists.' + sLineBreak + 'Do you want to replace it?';
  SFileMustExist = '"%s"' + sLineBreak + 'File not found.' + sLineBreak + 'Please verify the correct '+
    'filename was given.';
  SPathMustExist = '"%s"' + sLineBreak + 'Path not found.' + sLineBreak + 'Please verify the correct '+
    'path was given.';
  SDriveNotFound = 'Drive %s does not exist.' + sLineBreak + 'Please verify the correct '+
    'drive was given.';

  SUnknownImageFormat = 'Image format not recognized';
  SInvalidHandle = 'Invalid handle value for %s';
  SUnableToWrite = 'Unable to write bitmap';
  sAllFilter = 'All';

  sInvalidSetClipped = 'Cannot set Clipped property while painting';

  sInvalidLCDValue = 'Invalid LCDNumber value';

  sTabFailDelete = 'Failed to delete tab at index %d';
  sPageIndexError = '%d is an invalid PageIndex value.  PageIndex must be ' +
    'between 0 and %d';
  sInvalidLevel = 'Invalid item level assignment';
  sInvalidLevelEx = 'Invalid level (%d) for item "%s"';
  sTabMustBeMultiLine = 'MultiLine must be True when TabPosition is tpLeft or tpRight';
  sStatusBarContainsControl = '%s is already in the StatusBar';
  sListRadioItemBadParent = 'Radio items must have a Controller as a parent';
  sOwnerNotCustomHeaderSections = 'Owner is not a TCustomHeaderSection';
  sHeaderSectionOwnerNotHeaderControl = 'Header Section owner must be a TCustomHeaderControl';

  SUndo = 'Undo';
  SRedo = 'Redo';
  SLine = '-';
  SCut = 'Cut';
  SCopy = 'Copy';
  SPaste = 'Paste';
  SClear = 'Clear';
  SSelectAll = 'Select All';

  SBadMovieFormat = 'Unrecognized movie format';
  SMovieEmpty = 'Movie not loaded';
  SLoadingEllipsis = 'Loading...';

  SNoAppInLib = 'Fatal error: Cannot create application object in a shared object or library.';
  SDuplicateApp = 'Fatal error: Cannot create more than one TApplication instance';

implementation

end.
 
