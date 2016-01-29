{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.RibbonConsts;

interface

resourcestring
  // Ribbon constants
  SPageCaptionExists = 'A page with the caption "%s" already exists';
  SInvalidRibbonPageParent = 'A Ribbon Pages parent must be TCustomRibbon';
  SRecentDocuments = 'Recent Documents';
  SDuplicateRibbonComponentsNotAllowed = 'Only one Ribbon control on a Form is allowed';
  SRibbonTabIndexInvalid = 'Specified TabIndex is invalid';
  SRibbonControlInvalidParent = 'A %s can only be placed on a Ribbon Group with an ActionManager assigned';
  SInvalidRibbonGroupParent = 'Ribbon Group must have a Ribbon Page as its parent';
  SInvalidRibbonPageChild = 'Only Ribbon Groups can be inserted into a Ribbon Page';

  // Quick Access Toolbar
  SAddToQuickAccessToolbar = 'Add to Quick Access Toolbar';
  SRemoveFromQuickAccessToolbar = 'Remove from Quick Access Toolbar';
  SCustomizeQuickAccessToolbar = 'Customize Quick Access Toolbar...';
  SMoreControls = 'More controls';
  SMoreCommands = 'More Commands...';
  SMinimizeTheRibbon = 'Minimize the Ribbon';
  SQuickAccessToolbarGlyphRequired = 'Cannot place an item on the Quick Access Toolbar that does not have a glyph';
  SQATShowAboveTheRibbon = 'Show Above the Ribbon';
  SQATShowBelowTheRibbon = 'Show Below the Ribbon';
  SShowQuickAccessToolbarAbove = 'Show Quick Access Toolbar Above the Ribbon';
  SShowQuickAccessToolbarBelow = 'Show Quick Access Toolbar Below the Ribbon';

  // ScreenTips constants
  SCommandIsDisabled = 'This command is disabled.';
  SUseTheGlyphProperty = 'Use the glyph property to set an image';
  SInvalidScreenTipItemAssign = 'Cannot assign a non-ScreenTipItem to a ScreenTipItem';
  SDefaultFooterText = 'Press F1 for more help.';
  SGenerateScreenTipsError = 'Unable to generate Screen Tips because there are no linked Action Lists.';

implementation

end.
