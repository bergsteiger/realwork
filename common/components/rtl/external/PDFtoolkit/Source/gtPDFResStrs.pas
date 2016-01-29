{ ********************************************************************* }
{                                                                       }
{                       Gnostice PDFtoolkit v3.0                        }
{                       Copyright (c) 2002-2009                         }
{          Gnostice Information Technologies Private Limited            }
{                       http://www.gnostice.com                         }
{                                                                       }
{ ********************************************************************* }
{$I gtDefines.Inc}
unit gtPDFResStrs;

interface

uses
  gtPDFConsts;

resourcestring

  SInvalidPageNumber = 'Invalid page number (%d)';
  SInvalidPageRange = 'Invalid page range (%s)';
  SInsertingPages = 'Inserting Pages...';
  SNPagesDeleted = '%d pages deleted';
  SMergingFile = 'Merging File: %s';
  SAppendingPages = 'Appending Pages...';
  SNDocumentsMerged = '%d documents merged successfully';
  SExtractingPages = 'Extracting Pages...';
  SSavingFile = 'Saving File %s';
  SSaveComplete = 'Save Complete';
  SFieldNameError = 'Field (%s) does not exist';
  // Resource Strings for Setup dialog
  SPageLayoutSinglePage = 'Single Page';
  SPageLayoutOneColoumn = 'One Column';
  SPageLayoutTwoColoumnLeft = 'Two Column Left';
  SPageLayoutTwoColoumnRight = 'Two Column Right';
  SPageLayoutTwoPageLeft = 'Two Page Left';
  SPageLayoutTwoPageRight = 'Two Page Right';

  SPageModeUseNone = 'Use None';
  SPageModeUseOutlines = 'Use Outlines';
  SPageModeUseThumbs = 'Use Thumbs';
  SPageModeFullScreen = 'Full Screen';
  SPageModeUseAttachments = 'Use Attachments';
  SPageModeUseOptionalContent = 'Use Optional Content';

  SSplitHorizontalInward = 'Split Horizontal Inward';
  SSplitHorizontalOutward = 'Split Horizontal Outward';
  SSplitVerticalInward = 'Split Vertical Inward';
  SSplitVerticalOutward = 'Split Vertical Outward';
  SBlindsHorizontal = 'Blinds Horizontal';
  SBlindsVertical = 'Blinds Vertical';
  SBoxInward = 'Box Inward';
  SBoxOutward = 'Box Outward';
  SWipeLeftToRight = 'Wipe Left To Right';
  SWipeBottomToTop = 'Wipe Bottom To Top';
  SWipeRightToLeft = 'Wipe Right To Left';
  SWipeTopToBottom = 'Wipe Top To Bottom';
  SDissolve = 'Dissolve';
  SGlitterLeftToRight = 'Glitter Left To Right';
  SGlitterTopToBottom = 'Glitter Top To Bottom';
  SGlitterTopLeftToBottomRight = 'Glitter Top-Left To Bottom-Right';
  SNone = 'None';

  SCompressionLevelFastest = 'Fastest';
  SCompressionLevelNormal = 'Normal';
  SCompressionLevelMaximum = 'Maximum';

  SCompressionTypeFlate = 'Flate';
  SCompressionTypeRunlength = 'Runlength';

  SHideToolbars = 'Hide Toolbars';
  SHideMenuBar = 'Hide Menu Bar';
  SHideWindowUI = 'Hide Window UI';
  SFitWindow = 'Fit Window';
  SCenterWindow = 'Center Window';
  SDisplayDocumentTitle = 'Display Document Title';

  SPrint = 'Print';
  SModify = 'Modify';
  SCopy = 'Copy';
  SAnnotation = 'Annotation';
  SFormFill = 'Form Fill';
  SAccessibility = 'Accessebility';
  SDocumentAssembly = 'Document Assembly';
  SHighResolutionPrinting = 'High Resolution Printing';
  SFontNotFoundForEmbedding = 'Font Not Found For Embedding';
  SCCITTFaxDecodeImageFormat = 'CCITTFaxDecodeImageFormat Not Supported';

  Sel40Bit = '40 Bit';
  Sel128Bit = '128 Bit';
  SPasswordMissMatch = 'The %s Passwords do not match.' + CRLF + 'Please re-enter.';
  SOnlyOwner = 'Only the owner can change the encryption settings';

  SPDFSettingsDlg = 'Document Settings and Preferences';
  SbtnOK = 'OK';
  SbtnCancel = 'Cancel';
  StsDocInfo = 'General';
  SchkOpenAfterSave = 'Open After Save';
  SgbDocInfo = 'Document Information';
  SlblCreator = 'Creator:';
  SlblProducer = 'Producer: ';
  SlblPDFVer = 'PDF Version:';
  SlblNoOfPages = 'No. of Pages:';
  SlblTitle = 'Title:';
  SlblDocSubject = 'Subject:';
  SlblAuthor = 'Author:';
  SlblKeywords = 'Keywords:';
  StsSecurity = 'Security';
  SgbUserPermissions = 'User Permissions';
  SchkEnableEncryption = 'Encrypt Document ';
  StsView = 'View';
  SlblPageLayout = 'Page Layout';
  SlblPageMode = 'Page Mode';
  SgbPresentationMode = 'Presentation Mode';
  SlblPageTransitionEffect = 'Page Transition Effect:';
  SlblSecs = 'Secs';
  SlblPageTransitionDur = 'Page Transition Duration:';
  SgbPresentationPageRange = 'Presentation Page range';
  SlblPageExample = 'Enter page numbers and/or page ranges separated by commas. For example, 1,3,5-12';
  SrbAllPages = 'All Pages';
  SrbPages = 'Pages:';
  SgbViewerPreferences = 'Viewer Preferences';
  StsEmailDoc = 'Email';
  SchkEmailAfterSave = 'Email After Save';
  SlblHost = 'Host:';
  SlblUserID = 'UserID:';
  SlblPassword = 'Password:';
  SlblTo = 'To:';
  SlblCC = 'CC:';
  SlblBCC = 'BCC:';
  SlblFrom = 'From:';
  SlblMessage = 'Message:';
  SlblSubject = 'Subject:';
  StsCompress = 'Compress';
  SlblCompType = 'Compression Type';
  SlblCompLevel = 'Compression Level';
  SchkCompressDoc = 'Compress Document';
  SlblOwnerPswd = 'Owner Password:';
  SlblConfirmOwnerPswd = 'Confirm Owner Password:';
  SlblUserPswd = 'User Password:';
  SlblConfirmUserPswd = 'Confirm User Password:';
implementation

end.
