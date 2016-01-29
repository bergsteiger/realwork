{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{  With contributions from Mike Lischke                 }
{  Website: http://www.lischke-online.de/               }
{                                                       }
{*******************************************************}

unit Vcl.Themes;

interface

uses
  Winapi.Windows, Winapi.Messages, Winapi.UxTheme, Winapi.CommCtrl,
  System.Classes, System.SysUtils, System.Generics.Collections,
  Vcl.Graphics, Vcl.Controls, Vcl.GraphUtil;

type
  TThemedElement = (
    // Windows styles
    teButton,          // +
    teClock,           //
    teComboBox,        // +
    teDatePicker,      // new
    teEdit,            // +
    teExplorerBar,     //
    teFlyOut,          // new
    teHeader,          // +
    teLink,            // new
    teListView,        // +
    teMenu,            // +
    teMenuBand,        // new
    teMonthCal,        // new
    teNavigation,      // new
    tePage,            //
    teProgress,        // +
    teRebar,           // +
    teScrollBar,       // +
    teSpin,            //
    teStartPanel,      // +
    teStatus,          //
    teTab,             // +
    teTaskBand,        //
    teTaskBar,         // +
    teTaskDialog,      // new
    teTextStyle,       // new
    teToolBar,         // +
    teToolTip,         // +
    teTrackBar,        //
    teTrayNotify,      //
    teTreeview,        // +
    teWindow,          // +
    // VCL extensions
    teCategoryButtons,
    teCategoryPanelGroup,
    teCheckListBox,
    teControlBar,
    teDataNavButtons,
    teGrid,
    teHint,
    tePanel,
    teTabSet,
    teTextLabel
  );

  TVCLElements = teCategoryButtons..teTextLabel;

const
  CWindowsElements = [teButton..teWindow];
  CVCLElements     = [teCategoryButtons..teTextLabel];

type
  // 'Button' theme data
  TThemedButton = (
    tbButtonDontCare,
    // The root part of each element is sometimes used for special painting
    // and does not belong to a certain state.
    tbButtonRoot,
    tbPushButtonNormal, tbPushButtonHot, tbPushButtonPressed, tbPushButtonDisabled, tbPushButtonDefaulted, tbPushButtonDefaultedAnimating {Windows Vista or later},
    tbRadioButtonUncheckedNormal, tbRadioButtonUncheckedHot, tbRadioButtonUncheckedPressed, tbRadioButtonUncheckedDisabled,
    tbRadioButtonCheckedNormal, tbRadioButtonCheckedHot, tbRadioButtonCheckedPressed, tbRadioButtonCheckedDisabled,
    tbCheckBoxUncheckedNormal, tbCheckBoxUncheckedHot, tbCheckBoxUncheckedPressed, tbCheckBoxUncheckedDisabled,
    tbCheckBoxCheckedNormal, tbCheckBoxCheckedHot, tbCheckBoxCheckedPressed, tbCheckBoxCheckedDisabled,
    tbCheckBoxMixedNormal, tbCheckBoxMixedHot, tbCheckBoxMixedPressed, tbCheckBoxMixedDisabled,
    tbCheckBoxImplicitNormal, tbCheckBoxImplicitHot, tbCheckBoxImplicitPressed, tbCheckBoxImplicitDisabled, // Windows Vista or later
    tbCheckBoxExcludedNormal, tbCheckBoxExcludedHot, tbCheckBoxExcludedPressed, tbCheckBoxExcludedDisabled, // Windows Vista or later
    tbGroupBoxNormal, tbGroupBoxDisabled,
    tbUserButton,
    // Windows Vista or later
    tbCommandLinkNormal, tbCommandLinkHot, tbCommandLinkPressed, tbCommandLinkDisabled, tbCommandLinkDefaulted, tbCommandLinkDefaultedAnimating,
    tbCommandLinkGlyphNormal, tbCommandLinkGlyphHot, tbCommandLinkGlyphPressed, tbCommandLinkGlyphDisabled, tbCommandLinkGlyphDefaulted
  );

const
  tbPushButtonLast = tbPushButtonDefaultedAnimating;
  tbRadioButtonLast = tbRadioButtonCheckedDisabled;
  tbCheckBoxLast = tbCheckBoxExcludedDisabled;
  tbGroupBoxLast = tbGroupBoxDisabled;
  tbUserButtonLast = tbUserButton;
  tbCommandLinkLast = tbCommandLinkDefaultedAnimating;
  tbCommandLinkGlyphLast = tbCommandLinkGlyphDefaulted;

type
  // 'CategoryButtons' theme data
  TThemedCategoryButtons = (
    tcbCategoryButtonsDontCare,
    tcbCategoryButtonsRoot,
    tcbBackground,
    tcbCategoryNormal, tcbCategorySelected,
    tcbButtonNormal, tcbButtonHot, tcbButtonSelected,
    tcbCategoryGlyphOpened, tcbCategoryGlyphClosed,
    tcbCategoryChevronOpened, tcbCategoryChevronClosed
  );

const
  tcbCategoryLast = tcbCategorySelected;
  tcbButtonLast = tcbButtonSelected;
  tcbCategoryGlyphLast = tcbCategoryGlyphClosed;
  tcbCategoryChevronLast = tcbCategoryChevronClosed;

type
  // 'CategoryPanelGroup' theme data
  TThemedCategoryPanelGroup = (
    tcpCategoryPanelGroupDontCare,
    tcpCategoryPanelGroupRoot,
    tcpBackground,
    tcpGradientHeader,
    tcpThemedHeader,
    tcpChevronOpenedNormal, tcpChevronOpenedHot, tcpChevronOpenedPressed,
    tcpChevronClosedNormal, tcpChevronClosedHot, tcpChevronClosedPressed,
    tcpChevronClosedLeftNormal, tcpChevronClosedLeftHot, tcpChevronClosedLeftPressed,
    tcpThemedChevronOpenedNormal, tcpThemedChevronOpenedHot, tcpThemedChevronOpenedPressed,
    tcpThemedChevronClosedNormal, tcpThemedChevronClosedHot, tcpThemedChevronClosedPressed
  );

const
  tcpChevronOpenedLast = tcpChevronOpenedPressed;
  tcpChevronClosedLast = tcpChevronClosedPressed;
  tcpChevronClosedLeftLast = tcpChevronClosedLeftPressed;
  tcpThemedChevronOpenedLast = tcpThemedChevronOpenedPressed;
  tcpThemedChevronClosedLast = tcpThemedChevronClosedPressed;

type
  // 'CheckListBox' theme data
  TThemedCheckListBox = (
    tclCheckListBoxDontCare,
    tclCheckListBoxRoot,
    tclListItemNormal, tclListItemDisabled,
    tclHeaderItemNormal, tclHeaderItemDisabled
  );

const
  tclListItemLast = tclListItemDisabled;
  tclHeaderItemLast = tclHeaderItemDisabled;

type
  // 'ControlBar' theme data
  TThemedControlBar = (
    tcbControlBarDontCare,
    tcbControlBarRoot,
    tcbGradientItemFrame
  );

type
  // 'Clock' theme data
  TThemedClock = (
    tcClockDontCare,
    tcClockRoot,
    tcTimeNormal, tcTimeHot {Windows 7 or later}, tcTimePressed {Windows 7 or later}
  );

const
  tcTimeLast = tcTimePressed;
  ttbTimeNormal = tcTimeNormal deprecated 'Use tcTimeNormal';

type
  // 'ComboBox' theme data
  TThemedComboBox = (
    tcComboBoxDontCare,
    tcComboBoxRoot,
    tcDropDownButtonNormal, tcDropDownButtonHot,  tcDropDownButtonPressed,  tcDropDownButtonDisabled,
    // Windows Vista or later
    tcBackground,
    tcTransparentBackgroundNormal, tcTransparentBackgroundHot, tcTransparentBackgroundDisabled, tcTransparentBackgroundFocused,
    tcBorderNormal, tcBorderHot, tcBorderFocused,  tcBorderDisabled,
    tcReadOnlyNormal, tcReadOnlyHot, tcReadOnlyPressed, tcReadOnlyDisabled,
    tcDropDownButtonRightNormal, tcDropDownButtonRightHot, tcDropDownButtonRightPressed, tcDropDownButtonRightDisabled,
    tcDropDownButtonLeftNormal, tcDropDownButtonLeftHot, tcDropDownButtonLeftPressed, tcDropDownButtonLeftDisabled,
    tcCueBannerNormal, tcCueBannerHot, tcCueBannerPressed, tcCueBannerDisabled
  );

const
  tcDropDownButtonLast = tcDropDownButtonDisabled;
  tcBackgroundLast = tcBackground;
  tcTransparentBackgroundLast = tcTransparentBackgroundFocused;
  tcBorderLast = tcBorderDisabled;
  tcReadOnlyLast = tcReadOnlyDisabled;
  tcDropDownButtonRightLast = tcDropDownButtonRightDisabled;
  tcDropDownButtonLeftLast = tcDropDownButtonLeftDisabled;
  tcCueBannerLast = tcCueBannerDisabled;

type
  // 'DatePicker' theme data
  TThemedDatePicker = (
    tdpDatePickerDontCare,
    tdbDatePickerRoot,
    tdbDateTextNormal, tdbDateTextDisabled, tdbDateTextSelected,
    tdbDateBorderNormal, tdbDateBorderHot, tdbDateBorderFocused, tdbDateBorderDisabled,
    tdbShowCalendarButtonRightNormal, tdbShowCalendarButtonRightHot, tdbShowCalendarButtonRightPressed, tdbShowCalendarButtonRightDisabled
  );

const
  tdbDateTextLast = tdbDateTextSelected;
  tdbDateBorderLast = tdbDateBorderDisabled;
  tdbShowCalendarButtonRightLast = tdbShowCalendarButtonRightDisabled;

type
  // 'Edit' theme data
  TThemedEdit = (
    teEditDontCare,
    teEditRoot,
    teEditTextNormal, teEditTextHot, teEditTextSelected, teEditTextDisabled, teEditTextFocused, teEditTextReadOnly, teEditTextAssist,
    teEditCaret,
    // Windows Vista or later
    teBackgroundNormal, teBackgroundHot, teBackgroundDisabled, teBackgroundFocused, teBackgroundReadOnly, teBackgroundAssist,
    tePassword,
    teBackgroundWithBorderNormal, teBackgroundWithBorderHot, teBackgroundWithBorderDisabled, teBackgroundWithBorderFocused,
    teEditBorderNoScrollNormal, teEditBorderNoScrollHot, teEditBorderNoScrollFocused, teEditBorderNoScrollDisabled,
    teEditBorderHScrollNormal, teEditBorderHScrollHot, teEditBorderHScrollFocused, teEditBorderHScrollDisabled,
    teEditBorderVScrollNormal, teEditBorderVScrollHot, teEditBorderVScrollFocused, teEditBorderVScrollDisabled,
    teEditBorderHVScrollNormal, teEditBorderHVScrollHot, teEditBorderHVScrollFocused, teEditBorderHVScrollDisabled
  );

const
  teEditTextLast = teEditTextAssist;
  teEditCaretLast = teEditCaret;
  teBackgroundLast = teBackgroundAssist;
  tePasswordLast = tePassword;
  teBackgroundWithBorderLast = teBackgroundWithBorderFocused;
  teEditBorderNoScrollLast = teEditBorderNoScrollDisabled;
  teEditBorderHScrollLast = teEditBorderHScrollDisabled;
  teEditBorderVScrollLast = teEditBorderVScrollDisabled;
  teEditBorderHVScrollLast = teEditBorderHVScrollDisabled;

type
  // 'ExplorerBar' theme data
  TThemedExplorerBar = (
    tebExplorerBarDontCare,
    tebExplorerBarRoot,
    tebHeaderBackgroundNormal, tebHeaderBackgroundHot, tebHeaderBackgroundPressed,
    tebHeaderCloseNormal, tebHeaderCloseHot, tebHeaderClosePressed,
    tebHeaderPinNormal, tebHeaderPinHot, tebHeaderPinPressed,
    tebHeaderPinSelectedNormal, tebHeaderPinSelectedHot, tebHeaderPinSelectedPressed,
    tebIEBarMenuNormal, tebIEBarMenuHot, tebIEBarMenuPressed,
    tebNormalGroupBackground,
    tebNormalGroupCollapseNormal, tebNormalGroupCollapseHot, tebNormalGroupCollapsePressed,
    tebNormalGroupExpandNormal, tebNormalGroupExpandHot, tebNormalGroupExpandPressed,
    tebNormalGroupHead,
    tebSpecialGroupBackground,
    tebSpecialGroupCollapseNormal, tebSpecialGroupCollapseHot, tebSpecialGroupCollapsePressed,
    tebSpecialGroupExpandNormal, tebSpecialGroupExpandHot, tebSpecialGroupExpandPressed,
    tebSpecialGroupHead
  );

const
  tebHeaderBackgroundLast = tebHeaderBackgroundPressed;
  tebHeaderCloseLast = tebHeaderClosePressed;
  tebHeaderPinLast = tebHeaderPinPressed;
  tebHeaderPinSelectedLast = tebHeaderPinSelectedPressed;
  tebIEBarMenuLast = tebIEBarMenuPressed;
  tebNormalGroupBackgroundLast = tebNormalGroupBackground;
  tebNormalGroupCollapseLast = tebNormalGroupCollapsePressed;
  tebNormalGroupExpandLast = tebNormalGroupExpandPressed;
  tebNormalGroupHeadLast = tebNormalGroupHead;
  tebSpecialGroupBackgroundLast = tebSpecialGroupBackground;
  tebSpecialGroupCollapseLast = tebSpecialGroupCollapsePressed;
  tebSpecialGroupExpandLast = tebSpecialGroupExpandPressed;
  tebSpecialGroupHeadLast = tebSpecialGroupHead;
  tebSpecialGroupCollapseSpecial = tebSpecialGroupCollapseNormal deprecated 'Use tebSpecialGroupCollapseNormal';
  tebSpecialGroupExpandSpecial = tebSpecialGroupExpandNormal deprecated 'Use tebSpecialGroupExpandNormal';

type
  // 'FlyOut' theme data
  TThemedFlyOut = (
    tfFlyOutDontCare,
    tfFlyOutRoot,
    tfFlyOutHeader,
    tfFlyOutBodyNormal, tfFlyOutBodyEmphasized,
    tfFlyOutLabelNormal, tfFlyOutLabelSlected, tfFlyOutLabelEmphasized, tfFlyOutLabelDisabled,
    tfFlyOutLinkNormal, tfFlyOutLinkHover,
    tfFlyOutDivider,
    tfFlyOutWindow,
    tfFlyOutLinkArea,
    tfFlyOutLinkHeaderNormal, tfFlyOutLinkHeaderHover
  );

const
  tfFlyOutHeaderLast = tfFlyOutHeader;
  tfFlyOutBodyLast = tfFlyOutBodyEmphasized;
  tfFlyOutLabelLast = tfFlyOutLabelDisabled;
  tfFlyOutLinkLast = tfFlyOutLinkHover;
  tfFlyOutDividerLast = tfFlyOutDivider;
  tfFlyOutWindowLast = tfFlyOutWindow;
  tfFlyOutLinkAreaLast = tfFlyOutLinkArea;
  tfFlyOutLinkHeaderLast = tfFlyOutLinkHeaderHover;

type
  // 'Grid' theme data
  TThemedGrid = (
    tgGridDontCare,
    tgGridRoot,
    tgCellNormal, tgCellSelected, tgCellRowSelectedLeft, tgCellRowSelectedCenter, tgCellRowSelectedRight,
    tgFixedCellNormal, tgFixedCellHot, tgFixedCellPressed,
    tgGradientCellNormal, tgGradientCellSelected, tgGradientCellRowSelectedLeft,
      tgGradientCellRowSelectedCenter, tgGradientCellRowSelectedRight,
    tgGradientFixedCellNormal, tgGradientFixedCellHot, tgGradientFixedCellPressed,
    tgClassicCellNormal, tgClassicCellSelected, tgClassicCellRowSelectedLeft,
      tgClassicCellRowSelectedCenter, tgClassicCellRowSelectedRight,
    tgClassicFixedCellNormal, tgClassicFixedCellHot, tgClassicFixedCellPressed,
    tgDropDownButtonNormal, tgDropDownButtonHot, tgDropDownButtonPressed, tgDropDownButtonDisabled,
    tgEllipsisButtonNormal, tgEllipsisButtonHot, tgEllipsisButtonPressed,
    tgIndicatorArrow, tgIndicatorEdit, tgIndicatorInsert, tgIndicatorMultiDot, tgIndicatorMultiArrow
  );

const
  tgCellLast = tgCellRowSelectedRight;
  tgFixedCellLast = tgFixedCellPressed;
  tgGradientCellLast = tgGradientCellRowSelectedRight;
  tgGradientFixedCellLast = tgGradientFixedCellPressed;
  tgClassicCellLast = tgClassicCellRowSelectedRight;
  tgClassicFixedCellLast = tgClassicFixedCellPressed;
  tgDropDownButtonLast = tgDropDownButtonDisabled;
  tgEllipsisButtonLast = tgEllipsisButtonPressed;

type
  // 'Header' theme data
  TThemedHeader = (
    thHeaderDontCare,
    thHeaderRoot,
    thHeaderItemNormal, thHeaderItemHot, thHeaderItemPressed,
    thHeaderItemLeftNormal, thHeaderItemLeftHot, thHeaderItemLeftPressed,
    thHeaderItemRightNormal, thHeaderItemRightHot, thHeaderItemRightPressed,
    thHeaderSortArrowSortedUp, thHeaderSortArrowSortedDown,
    // Windows Vista or later
    thHeaderDropDownNormal, thHeaderDropDownSoftHot, thHeaderDropDownHot,
    thHeaderDropDownFilterNormal, thHeaderDropDownFilterSoftHot, thHeaderDropDownFilterHot,
    thHeaderOverflowNormal, thHeaderOverflowHot
  );

const
  thHeaderItemLast = thHeaderItemPressed;
  thHeaderItemLeftLast = thHeaderItemLeftPressed;
  thHeaderItemRightLast = thHeaderItemRightPressed;
  thHeaderSortArrowLast = thHeaderSortArrowSortedDown;
  thHeaderDropDownLast = thHeaderDropDownHot;
  thHeaderDropDownFilterLast = thHeaderDropDownFilterHot;
  thHeaderOverflowLast = thHeaderOverflowHot;

type
  // 'Hint' theme data
  TThemedHint = (
    thHintDontCare,
    thHintRoot,
    thHintNormal,
    thHintBalloon
  );

type
  // 'ListView' theme data
  TThemedListview = (
    tlListviewDontCare,
    tlListviewRoot,
    tlListItemNormal, tlListItemHot, tlListItemSelected, tlListItemDisabled, tlListItemSelectedNotFocus, tlListItemHotSelected {Windows Vista or later},
    tlListGroup,
    tlListDetail,
    tlListSortDetail,
    tlEmptyText,
    // Windows Vista or later
    tlGroupHeaderOpen, tlGroupHeaderOpenHot, tlGroupHeaderOpenSelected, tlGroupHeaderOpenSelectedHot,
    tlGroupHeaderOpenSelectedNotFocused, tlGroupHeaderOpenSelectedNotFocusedHot, tlGroupHeaderOpenMixedSelection, tlGroupHeaderOpenMixedSelectionHot,
    tlGroupHeaderClose, tlGroupHeaderCloseHot, tlGroupHeaderCloseSelected, tlGroupHeaderCloseSelectedHot, tlGroupHeaderCloseSelectedNotFocused,
    tlGroupHeaderCloseSelectedNotFocusedHot, tlGroupHeaderCloseMixedSelection, tlGroupHeaderCloseMixedSelectionHot,

    tlGroupHeaderLineOpen, tlGroupHeaderLineOpenHot, tlGroupHeaderLineOpenSelected, tlGroupHeaderLineOpenSelectedHot, tlGroupHeaderLineOpenSelectedNotFocused,
    tlGroupHeaderLineOpenSelectedNotFocusedHot, tlGroupHeaderLineOpenMixedSelection, tlGroupHeaderLineOpenMixedSelectionHot,
    tlGroupHeaderLineClose, tlGroupHeaderLineCloseHot, tlGroupHeaderLineCloseSelected, tlGroupHeaderLineCloseSelectedHot, tlGroupHeaderLineCloseSelectedNotFocused,
    tlGroupHeaderLineCloseSelectedNotFocusedHot, tlGroupHeaderLineCloseMixedSelection, tlGroupHeaderLineCloseMixedSelectionHot,

    tlExpandButtonNormal, tlExpandButtonHover, tlExpandButtonPushed,
    tlCollapseButtonNormal, tlCollapseButtonHover, tlCollapseButtonPushed,
    tlColumnDetail
  );

const
  tlListItemLast = tlListItemHotSelected;
  tlListGroupLast = tlListGroup;
  tlListDetailLast = tlListDetail;
  tlListSortDetailLast = tlListSortDetail;
  tlEmptyTextLast = tlEmptyText;
  tlGroupHeaderLast = tlGroupHeaderCloseMixedSelectionHot;
  tlGroupHeaderLineLast = tlGroupHeaderLineCloseMixedSelectionHot;
  tlExpandButtonLast = tlExpandButtonPushed;
  tlCollapseButtonLast = tlCollapseButtonPushed;
  tlColumnDetailLast = tlColumnDetail;

type
  // 'Link' theme data
  TThemedLink = (
    tlLinkDontCare,
    tlLinkRoot,
    tlLinkNormal, tlLinkLinked
  );

const
  tlLinkLast = tlLinkLinked;

type
  // 'Menu' theme data
  TThemedMenu = (
    tmMenuDontCare,
    tmMenuRoot,
    tmMenuItemNormal, tmMenuItemSelected, tmMenuItemDemoted,
    tmMenuDropDown,
    tmMenuBarItem,
    tmMenuBarDropDown,
    tmChevron,
    tmSeparator,
    // Windows Vista or later
    tmMenuBarBackgroundActive, tmMenuBarBackgroundInactive,
    tmMenuBarItemNormal, tmMenuBarItemHot, tmMenuBarItemPushed, tmMenuBarItemDisabled, tmMenuBarItemDisabledHot, tmMenuBarItemDisabledPushed,
    tmPopupBackground,
    tmPopupBorders,
    tmPopupCheckNormal, tmPopupCheckDisabled, tmPopupBulletNormal, tmPopupBulletDisabled,
    tmPopupCheckBackgroundDisabled, tmPopupCheckBackgroundNormal, tmPopupCheckBackgroundBitmap,
    tmPopupGutter,
    tmPopupItemNormal, tmPopupItemHot, tmPopupItemDisabled, tmPopupItemDisabledHot,
    tmPopupSeparator,
    tmPopupSubMenuNormal, tmPopupSubMenuDisabled,
    tmSystemCloseNormal, tmSystemCloseDisabled,
    tmSystemMaximizeNormal, tmSystemMaximizeDisabled,
    tmSystemMinimizeNormal, tmSystemMinimizeDisabled,
    tmSystemRestoreNormal, tmSystemRestoreDisabled
  );

const
  tmMenuItemTMSSchemaLast = tmMenuItemDemoted;
  tmMenuDropDownTMSSchemaLast = tmMenuDropDown;
  tmMenuBarItemTMSSchemaLast = tmMenuBarItem;
  tmMenuBarDropDownTMSSchemaLast = tmMenuBarDropDown;
  tmChevronTMSSchemaLast = tmChevron;
  tmSeparatorTMSSchemaLast = tmSeparator;
  // Windows Vista or later
  tmMenuBarBackgroundLast = tmMenuBarBackgroundInactive;
  tmMenuBarItemLast = tmMenuBarItemDisabledPushed;
  tmPopupBackgroundLast = tmPopupBackground;
  tmPopupBordersLast = tmPopupBorders;
  tmPopupCheckLast = tmPopupBulletDisabled;
  tmPopupCheckBackgroundLast = tmPopupCheckBackgroundBitmap;
  tmPopupGutterLast = tmPopupGutter;
  tmPopupItemLast = tmPopupItemDisabledHot;
  tmPopupSeparatorLast = tmPopupSeparator;
  tmPopupSubMenuLast = tmPopupSubMenuDisabled;
  tmSystemCloseLast = tmSystemCloseDisabled;
  tmSystemMaximizeLast = tmSystemMaximizeDisabled;
  tmSystemMinimizeLast = tmSystemMinimizeDisabled;
  tmSystemRestoreLast = tmSystemRestoreDisabled;

type
  // 'MenuBand' theme data
  TThemedMenuBand = (
    tmbMenuBandDontCare,
    tmbMenuBandRoot,
    tmbNewAppButtonNormal, tmbNewAppButtonHot, tmbNewAppButtonPressed, tmbNewAppButtonDisabled, tmbNewAppButtonChecked, tmbNewAppButtonNotChecked,
    tmbSeparatorNormal, tmbSeparatorHot, tmbSeparatorPressed, tmbSeparatorDisabled, tmbSeparatorChecked, tmbSeparatorNotChecked
  );

const
  tmbNewAppButtonLast = tmbNewAppButtonNotChecked;
  tmbSeparatorlast = tmbSeparatorNotChecked;

type
  // 'MonthCal' theme data
  TThemedMonthCal = (
    tmcMonthCalDontCare,
    tmcMonthCalRoot,
    tmcBackground,
    tmcBorders,
    tmcGridBackground,
    tmcColHeaderSplitter,
    tmcGridCellBackgroundSelected, tmcGridCellBackgroundHot, tmcGridCellBackgroundSelectedHot, tmcGridCellBackgroundSelectedNotFocused, tmcGridCellBackgroundToday,
    tmcGridCellHot, tmcGridCellHasState, tmcGridCellHasStateHot, tmcGridCellToday,
    tmcGridCellUpperHot, tmcGridCellUpperHasState, tmcGridCellUpperHasStateHot,
    tmcTrailingGridCellHot, tmcTrailingGridCellHasState, tmcTrailingGridCellHasStateHot, tmcTrailingGridCellToday,
    tmcTrailingGridCellUpperHot, tmcTrailingGridCellUpperHasState, tmcTrailingGridCellUpperHasStateHot,
    tmcNavNextNormal, tmcNavNextHot, tmcNavNextPressed, tmcNavNextDisabled,
    tmcNavPrevNormal, tmcNavPrevHot, tmcNavPrevPressed, tmcNavPrevDisabled
  );

const
  tmcBackgroundLast = tmcBackground;
  tmcBordersLast = tmcBorders;
  tmcGridBackgroundLast = tmcGridBackground;
  tmcColHeaderSplitterLast = tmcColHeaderSplitter;
  tmcGridCellBackgroundLast = tmcGridCellBackgroundToday;
  tmcGridCellLast = tmcGridCellToday;
  tmcGridCellUpperLast = tmcGridCellUpperHasStateHot;
  tmcTrailingGridCellLast = tmcTrailingGridCellToday;
  tmcTrailingGridCellUpperLast = tmcTrailingGridCellUpperHasStateHot;
  tmcNavNextLast = tmcNavNextDisabled;
  tmcNavPrevLast = tmcNavPrevDisabled;

type
  // 'Navigation' theme data
  TThemedNavigation = (
    tnNavigatrionDontCare,
    tnNavigatrionRoot,
    tnBackButtonNormal, tnBackButtonHot, tnBackButtonPressed, tnBackButtonDisabled,
    tnForwardButtonNormal, tnForwardButtonHot, tnForwardButtonPressed, tnForwardButtonDisabled,
    tnMenuButtonNormal, tnMenuButtonHot, tnMenuButtonPressed, tnMenuButtonDisabled
  );

const
  tnBackButtonLast = tnBackButtonDisabled;
  tnForwardButtonLast = tnForwardButtonDisabled;
  tnMenuButtonLast = tnMenuButtonDisabled;

type
  TThemedDataNavButtons = (
    tdnbDontCare,
    tdnbNavigatorRoot,
    tdnbFirstNormal, tdnbFirstHot, tdnbFirstPressed, tdnbFirstDisabled,
    tdnbPriorNormal, tdnbPriorHot, tdnbPriorPressed, tdnbPriorDisabled,
    tdnbNextNormal, tdnbNextHot, tdnbNextPressed, tdnbNextDisabled,
    tdnbLastNormal, tdnbLastHot, tdnbLastPressed, tdnbLastDisabled,
    tdnbInsertNormal, tdnbInsertHot, tdnbInsertPressed, tdnbInsertDisabled,
    tdnbDeleteNormal, tdnbDeleteHot, tdnbDeletePressed, tdnbDeleteDisabled,
    tdnbEditNormal, tdnbEditHot, tdnbEditPressed, tdnbEditDisabled,
    tdnbPostNormal, tdnbPostHot, tdnbPostPressed, tdnbPostDisabled,
    tdnbCancelNormal, tdnbCancelHot, tdnbCancelPressed, tdnbCancelDisabled,
    tdnbRefreshNormal, tdnbRefreshHot, tdnbRefreshPressed, tdnbRefreshDisabled,
    tdnbApplyUpdatesNormal, tdnbApplyUpdatesHot, tdnbApplyUpdatesPressed, tdnbApplyUpdatesDisabled,
    tdnbCancelUpdatesNormal, tdnbCancelUpdatesHot, tdnbCancelUpdatesPressed, tdnbCancelUpdatesDisabled
  );

type
  // 'Page' theme data
  TThemedPage = (
    tpPageDontCare,
    tpPageRoot,
    tpUpNormal, tpUpHot, tpUpPressed, tpUpDisabled,
    tpDownNormal, tpDownHot, tpDownPressed, tpDownDisabled,
    tpUpHorzNormal, tpUpHorzHot, tpUpHorzPressed, tpUpHorzDisabled,
    tpDownHorzNormal, tpDownHorzHot, tpDownHorzPressed, tpDownHorzDisabled
  );

type
  // 'Panel' theme data
  TThemedPanel = (
    tpPanelDontCare,
    tpPanelRoot,
    tpPanelBackground,
    tpPanelBevel,
    tpDockPanelHorzNormal, tpDockPanelHorzSelected,
    tpDockPanelVertNormal, tpDockPanelVertSelected,
    tpDockPanelPinNormal,
    tpDockPanelCloseNormal
  );

  // 'Progress' theme data
  TThemedProgress = (
    tpProgressDontCare,
    tpProgressRoot,
    tpBar,
    tpBarVert,
    tpChunk,
    tpChunkVert,
    // Windows Vista or later
    tpFill,
    tpFillVert,
    tpPulseOverlay,
    tpMoveOverlay,
    tpPulseOverlayVert,
    tpMoveOverlayVert,
    tpTransparentBarNormal, tpTransparentBarPartial,
    tpTransparentBarVertNormal, tpTransparentBarVertPartial
  );

  // 'Rebar' theme data
  TThemedRebar = (
    trRebarDontCare,
    trRebarRoot,
    trGripper,
    trGripperVert,
    trBand,
    trChevronNormal, trChevronHot, trChevronPressed,
    trChevronVertNormal, trChevronVertHot, trChevronVertPressed,
    // Windows Vista or later
    trBackground,
    trSplitterNormal, trSplitterHot, trSplitterPressed,
    trSlipperVertNormal, trSlipperVertHot, trSlipperVertPressed
  );

  // 'ScrollBar' theme data
  TThemedScrollBar = (
    tsScrollBarDontCare,
    tsScrollBarRoot,
    tsArrowBtnUpNormal, tsArrowBtnUpHot, tsArrowBtnUpPressed, tsArrowBtnUpDisabled,
    tsArrowBtnDownNormal, tsArrowBtnDownHot, tsArrowBtnDownPressed, tsArrowBtnDownDisabled,
    tsArrowBtnLeftNormal, tsArrowBtnLeftHot, tsArrowBtnLeftPressed, tsArrowBtnLeftDisabled,
    tsArrowBtnRightNormal, tsArrowBtnRightHot, tsArrowBtnRightPressed, tsArrowBtnRightDisabled,
    tsArrowBtnUpHover, tsArrowBtnDownHover, tsArrowBtnLeftHover, tsArrowBtnRightHover, // Windows Vista or later
    tsThumbBtnHorzNormal, tsThumbBtnHorzHot, tsThumbBtnHorzPressed, tsThumbBtnHorzDisabled,
    tsThumbBtnVertNormal, tsThumbBtnVertHot, tsThumbBtnVertPressed, tsThumbBtnVertDisabled,
    tsLowerTrackHorzNormal, tsLowerTrackHorzHot, tsLowerTrackHorzPressed, tsLowerTrackHorzDisabled, tsLowerTrackHorzHover {Windows Vista or later},
    tsUpperTrackHorzNormal, tsUpperTrackHorzHot, tsUpperTrackHorzPressed, tsUpperTrackHorzDisabled, tsUpperTrackHorzHover {Windows Vista or later},
    tsLowerTrackVertNormal, tsLowerTrackVertHot, tsLowerTrackVertPressed, tsLowerTrackVertDisabled, tsLowerTrackVertHover {Windows Vista or later},
    tsUpperTrackVertNormal, tsUpperTrackVertHot, tsUpperTrackVertPressed, tsUpperTrackVertDisabled, tsUpperTrackVertHover {Windows Vista or later},
    tsGripperHorzNormal, tsGripperHorzHot, tsGripperHorzPressed, tsGripperHorzDisabled, tsGripperHorzHover {Windows Vista or later},
    tsGripperVertNormal, tsGripperVertHot, tsGripperVertPressed, tsGripperVertDisabled, tsGripperVertHover {Windows Vista or later},
    tsSizeBoxRightAlign, tsSizeBoxLeftAlign,
    // Windows Vista or later
    tsSizeBoxTopRightAlign, tsSizeBoxTopLeftAlign, tsSizeBoxHalfBottomRightAlign,
    tsSizeBoxHalfBottomLeftAlign, tsSizeBoxHalfTopRightAlign, tsSizeBoxHalfTopLeftAlign
  );

  // 'Spin' theme data
  TThemedSpin = (
    tsSpinDontCare,
    tsSpinRoot,
    tsUpNormal, tsUpHot, tsUpPressed, tsUpDisabled,
    tsDownNormal, tsDownHot, tsDownPressed, tsDownDisabled,
    tsUpHorzNormal, tsUpHorzHot, tsUpHorzPressed, tsUpHorzDisabled,
    tsDownHorzNormal, tsDownHorzHot, tsDownHorzPressed, tsDownHorzDisabled
  );

  // 'StartPanel' theme data
  TThemedStartPanel = (
    tspStartPanelDontCare,
    tspStartPanelRoot,
    tspUserPane,
    tspMorePrograms,
    tspMoreProgramsArrowNormal, tspMoreProgramsArrowHot, tspMoreProgramsArrowPressed,
    tspProgList,
    tspProgListSeparator,
    tspPlacesList,
    tspPlacesListSeparator,
    tspLogOff,
    tspLogOffButtonsNormal, tspLogOffButtonsHot, tspLogOffButtonsPressed,
    tspUserPicture,
    tspPreview,
    // Windows Vista or later
    tspMoreProgramsTabNormal, tspMoreProgramsTabHot, tspMoreProgramsTabSelected, tspMoreProgramsTabDisabled, tspMoreProgramsTabFocused,
    tspNSCHost,
    tspSoftwareExplorerNormal, tspSoftwareExplorerHot, tspSoftwareExplorerSelected, tspSoftwareExplorerDisabled, tspSoftwareExplorerFocused,
    tspOpenBoxNormal, tspOpenBoxHot, tspOpenBoxSelected, tspOpenBoxDisabled, tspOpenBoxFocused,
    tspSearchView,
    tspMoreProgramsArrowBackNormal, tspMoreProgramsArrowBackHot, tspMoreProgramsArrowBackPressed,
    tspTopMatch,
    tspLogOffSplitButtonDropDown
  );

type
  // 'Status' theme data
  TThemedStatus = (
    tsStatusDontCare,
    tsStatusRoot,
    tsPane,
    tsGripperPane,
    tsGripper
  );

  // 'Tab' theme data
  TThemedTab = (
    ttTabDontCare,
    ttTabRoot,
    ttTabItemNormal, ttTabItemHot, ttTabItemSelected, ttTabItemDisabled, ttTabItemFocused,
    ttTabItemLeftEdgeNormal, ttTabItemLeftEdgeHot, ttTabItemLeftEdgeSelected, ttTabItemLeftEdgeDisabled, ttTabItemLeftEdgeFocused,
    ttTabItemRightEdgeNormal, ttTabItemRightEdgeHot, ttTabItemRightEdgeSelected, ttTabItemRightEdgeDisabled, ttTabItemRightEdgeFocused,
    ttTabItemBothEdgeNormal, ttTabItemBothEdgeHot, ttTabItemBothEdgeSelected, ttTabItemBothEdgeDisabled, ttTabItemBothEdgeFocused,
    ttTopTabItemNormal, ttTopTabItemHot, ttTopTabItemSelected, ttTopTabItemDisabled, ttTopTabItemFocused,
    ttTopTabItemLeftEdgeNormal, ttTopTabItemLeftEdgeHot, ttTopTabItemLeftEdgeSelected, ttTopTabItemLeftEdgeDisabled, ttTopTabItemLeftEdgeFocused,
    ttTopTabItemRightEdgeNormal, ttTopTabItemRightEdgeHot, ttTopTabItemRightEdgeSelected, ttTopTabItemRightEdgeDisabled, ttTopTabItemRightEdgeFocused,
    ttTopTabItemBothEdgeNormal, ttTopTabItemBothEdgeHot, ttTopTabItemBothEdgeSelected, ttTopTabItemBothEdgeDisabled, ttTopTabItemBothEdgeFocused,
    ttPane,
    ttBody,
    // Windows Vista or later
    ttAeroWizardBody
  );

  // 'TabSet' theme data
  TThemedTabSet = (
    tbsDontCare,
    tbsRoot,
    tbsBackground,
    tbsTabNormal, tbsTabSelected
  );

  // 'TaskBand' theme data
  TThemedTaskBand = (
    ttbTaskBandDontCare,
    ttbTaskBandRoot,
    ttbGroupCount,
    ttbFlashButton,
    ttpFlashButtonGroupMenu
  );

  // 'TaskBar' theme data
  TThemedTaskBar = (
    ttbTaskBarDontCare,
    ttbTaskBarRoot,
    ttbBackgroundBottom,
    ttbBackgroundRight,
    ttbBackgroundTop,
    ttbBackgroundLeft,
    ttbSizingBarBottom,
    ttbSizingBarRight,
    ttbSizingBarTop,
    ttbSizingBarLeft
  );

const
  ttTaskBarDontCare = ttbTaskBarDontCare deprecated 'Use ttbTaskBarDontCare';
  ttTaskBarRoot = ttbTaskBarDontCare deprecated 'Use ttbTaskBarDontCare';

type
  // 'TaskDialog' theme data
  TThemedTaskDialog = (
    ttdTaskDialogDontCare,
    ttdTaskDialogRoot,
    ttdPrimaryPanel,
    ttdMainInstructionPane,
    ttdMainIcon,
    ttdContentPane,
    ttdContentIcon,
    ttdExpandedContent,
    ttdCommandLinkPane,
    ttdSecondaryPanel,
    ttdControlPane,
    ttdButtonSection,
    ttdButtonWrapper,
    ttdExpandoText,
    ttdExpandoButtonNormal, ttdExpandoButtonHover, ttdExpandoButtonPressed,
    ttdExpandoButtonExpandedNormal, ttdExpandoButtonExpandedHover, ttdExpandoButtonExpandedPressed,

    ttdVerificationText,
    ttdFootnotePane,
    ttdFootnoteArea,
    ttdFootnoteSeparator,
    ttdExpandedFooterArea,
    ttdProgressBar,
    ttdImageAlignment,
    ttdRadioButtonPane
  );

const
  ttdPrimaryPanelLast = ttdPrimaryPanel;
  ttdMainInstructionPaneLast = ttdMainInstructionPane;
  ttdMainIconLast = ttdMainIcon;
  ttdContentPaneLast = ttdContentPane;
  ttdContentIconLast = ttdContentIcon;
  ttdExpandedContentLast = ttdExpandedContent;
  ttdCommandLinkPaneLast = ttdCommandLinkPane;
  ttdSecondaryPanelLast = ttdSecondaryPanel;
  ttdControlPaneLast = ttdControlPane;
  ttdButtonSectionLast = ttdButtonSection;
  ttdButtonWrapperLast = ttdButtonWrapper;
  ttdExpandoTextLast = ttdExpandoText;
  ttdExpandoButtonLast = ttdExpandoButtonExpandedPressed;
  ttdVerificationTextLast = ttdVerificationText;
  ttdFootnotePaneLast = ttdFootnotePane;
  ttdFootnoteAreaLast = ttdFootnoteArea;
  ttdFootnoteSeparatorLast = ttdFootnoteSeparator;
  ttdExpandedFooterAreaLast = ttdExpandedFooterArea;
  ttdProgressBarLast = ttdProgressBar;
  ttdImageAlignmentLast = ttdImageAlignment;
  ttdRadioButtonPaneLast = ttdRadioButtonPane;

type
  // 'TextLabel' theme data
  TThemedTextLabel = (
    ttlTextLabelDontCare,
    ttlTextLabelRoot,
    ttlTextLabelNormal, ttlTextLabelDisabled
  );

const
  ttlTextLabelLast = ttlTextLabelDisabled;

type
  // 'TextStyle' theme data
  TThemedTextStyle = (
    ttsTextStyleDontCare,
    ttsTextStyleRoot,
    ttsMainInstruction,
    ttsInstruction,
    ttsBodyTitle,
    ttsBodyText,
    ttsSecondaryText,
    ttsHyperLinkTextNormal, ttsHyperLinkTextHot, ttsHyperLinkTextPressed, ttsHyperLinkTextDisabled,
    ttsExpanded,
    ttsLabel,
    ttsControlLabelNormal, ttsControlLabelDisabled
  );

const
  ttsMainInstructionLast = ttsMainInstruction;
  ttsInstructionLast = ttsInstruction;
  ttsBodyTitleLast = ttsBodyTitle;
  ttsBodyTextLast = ttsBodyText;
  ttsSecondaryTextLast = ttsSecondaryText;
  ttsHyperLinkTextLast = ttsHyperLinkTextDisabled;
  ttsExpandedLast = ttsExpanded;
  ttsLabelLast = ttsLabel;
  ttsControlLabelLast = ttsControlLabelDisabled;

type
  // 'ToolBar' theme data
  TThemedToolBar = (
    ttbToolBarDontCare,
    ttbToolBarRoot,
    ttbButtonNormal, ttbButtonHot, ttbButtonPressed, ttbButtonDisabled, ttbButtonChecked, ttbButtonCheckedHot,
    ttbButtonNearHot, ttbButtonOtherSideHot, // Windows Vista or later
    ttbDropDownButtonNormal, ttbDropDownButtonHot, ttbDropDownButtonPressed, ttbDropDownButtonDisabled,
    ttbDropDownButtonChecked, ttbDropDownButtonCheckedHot,
    ttbDropDownButtonNearHot, ttbDropDownButtonOtherSideHot, // Windows Vista or later
    ttbSplitButtonNormal, ttbSplitButtonHot, ttbSplitButtonPressed, ttbSplitButtonDisabled, ttbSplitButtonChecked, ttbSplitButtonCheckedHot,
    ttbSplitButtonNearHot, ttbSplitButtonOtherSideHot, // Windows Vista or later
    ttbSplitButtonDropDownNormal, ttbSplitButtonDropDownHot, ttbSplitButtonDropDownPressed, ttbSplitButtonDropDownDisabled,
    ttbSplitButtonDropDownChecked, ttbSplitButtonDropDownCheckedHot,
    ttbSplitButtonDropDownNearHot, ttbSplitButtonDropDownOtherSideHot, // Windows Vista or later
    ttbSeparatorNormal, ttbSeparatorHot, ttbSeparatorPressed, ttbSeparatorDisabled,
    ttbSeparatorChecked, ttbSeparatorCheckedHot,
    ttbSeparatorNearHot, ttbSeparatorOtherSideHot, // Windows Vista or later
    ttbSeparatorVertNormal, ttbSeparatorVertHot, ttbSeparatorVertPressed, ttbSeparatorVertDisabled,
    ttbSeparatorVertChecked, ttbSeparatorVertCheckedHot,
    ttbSeparatorVertNearHot, ttbSeparatorVertOtherSideHot, // Windows Vista or later
    // Windows 7 or later
    ttbDropDownButtonGlyphNormal, ttbDropDownButtonGlyphHot, ttbDropDownButtonGlyphPressed,
    ttbDropDownButtonGlyphDisabled, ttbDropDownButtonGlyphChecked, ttbDropDownButtonGlyphCheckedHot,
    ttbDropDownButtonGlyphNearHot, ttbDropDownButtonGlyphOtherSideHot
  );

  // 'ToolTip' theme data
  TThemedToolTip = (
    tttToolTipDontCare,
    tttToolTipRoot,
    tttStandardNormal, tttStandardLink,
    tttStandardTitleNormal, tttStandardTitleLink,
    tttBaloonNormal, tttBaloonLink,
    tttBaloonTitleNormal, tttBaloonTitleLink,
    tttBaloonStemUpLeft, tttBaloonStemDownLeft,
    tttCloseNormal, tttCloseHot, tttClosePressed,
    // Windows Vista or later
    tttBalloonStemUpLeftWall, tttBalloonStemUpCentered, tttBalloonStemUpRightWall,
    tttBalloonStemDownRightWall, tttBalloonStemDownCentered, tttBalloonStemLeftWall,
    // Windows 7 or later
    tttWrenchNormal, tttWrenchHot, tttWrenchPressed
  );

  // 'TrackBar' theme data
  TThemedTrackBar = (
    ttbTrackBarDontCare,
    ttbTrackBarRoot,
    ttbTrack,
    ttbTrackVert,
    ttbThumbNormal, ttbThumbHot, ttbThumbPressed, ttbThumbFocused, ttbThumbDisabled,
    ttbThumbBottomNormal, ttbThumbBottomHot, ttbThumbBottomPressed, ttbThumbBottomFocused, ttbThumbBottomDisabled,
    ttbThumbTopNormal, ttbThumbTopHot, ttbThumbTopPressed, ttbThumbTopFocused, ttbThumbTopDisabled,
    ttbThumbVertNormal, ttbThumbVertHot, ttbThumbVertPressed, ttbThumbVertFocused, ttbThumbVertDisabled,
    ttbThumbLeftNormal, ttbThumbLeftHot, ttbThumbLeftPressed, ttbThumbLeftFocused, ttbThumbLeftDisabled,
    ttbThumbRightNormal, ttbThumbRightHot, ttbThumbRightPressed, ttbThumbRightFocused, ttbThumbRightDisabled,
    ttbThumbTics, 
    ttbThumbTicsVert
  );

  // 'TrayNotify' theme data
  TThemedTrayNotify = (
    ttnTrayNotifyDontCare,
    ttnTrayNotifyRoot,
    ttnBackground,
    ttnAnimBackground
  );

  // 'Treeview' theme data
  TThemedTreeview = (
    ttTreeviewDontCare,
    ttTreeviewRoot,
    ttItemNormal, ttItemHot, ttItemSelected, ttItemDisabled, ttItemSelectedNotFocus, ttItemHotSelected {Windows Vista or later},
    ttGlyphClosed, ttGlyphOpened,
    ttBranch,
    // Windows Vista or later
    ttHotGlyphClosed, ttHotGlyphOpen
  );

  // 'Window' theme data
  TThemedWindow = (
    twWindowDontCare,
    twWindowRoot,
    twCaptionActive, twCaptionInactive, twCaptionDisabled,
    twSmallCaptionActive, twSmallCaptionInactive, twSmallCaptionDisabled,
    twMinCaptionActive, twMinCaptionInactive, twMinCaptionDisabled,
    twSmallMinCaptionActive, twSmallMinCaptionInactive, twSmallMinCaptionDisabled,
    twMaxCaptionActive, twMaxCaptionInactive, twMaxCaptionDisabled,
    twSmallMaxCaptionActive, twSmallMaxCaptionInactive, twSmallMaxCaptionDisabled,

    twFrameLeftActive, twFrameLeftInactive,
    twFrameRightActive, twFrameRightInactive,
    twFrameBottomActive, twFrameBottomInactive,
    twSmallFrameLeftActive, twSmallFrameLeftInactive,
    twSmallFrameRightActive, twSmallFrameRightInactive,
    twSmallFrameBottomActive, twSmallFrameBottomInactive,

    twSysButtonNormal, twSysButtonHot, twSysButtonPushed, twSysButtonDisabled,
    twMDISysButtonNormal, twMDISysButtonHot, twMDISysButtonPushed, twMDISysButtonDisabled,
    twMinButtonNormal, twMinButtonHot, twMinButtonPushed, twMinButtonDisabled,
    twMDIMinButtonNormal, twMDIMinButtonHot, twMDIMinButtonPushed, twMDIMinButtonDisabled,
    twMaxButtonNormal, twMaxButtonHot, twMaxButtonPushed, twMaxButtonDisabled,
    twCloseButtonNormal, twCloseButtonHot, twCloseButtonPushed, twCloseButtonDisabled,
    twSmallCloseButtonNormal, twSmallCloseButtonHot, twSmallCloseButtonPushed, twSmallCloseButtonDisabled,
    twMDICloseButtonNormal, twMDICloseButtonHot, twMDICloseButtonPushed, twMDICloseButtonDisabled,
    twRestoreButtonNormal, twRestoreButtonHot, twRestoreButtonPushed, twRestoreButtonDisabled,
    twMDIRestoreButtonNormal, twMDIRestoreButtonHot, twMDIRestoreButtonPushed, twMDIRestoreButtonDisabled,
    twHelpButtonNormal, twHelpButtonHot, twHelpButtonPushed, twHelpButtonDisabled,
    twMDIHelpButtonNormal, twMDIHelpButtonHot, twMDIHelpButtonPushed, twMDIHelpButtonDisabled,

    twHorzScrollNormal, twHorzScrollHot, twHorzScrollPushed, twHorzScrollDisabled,
    twHorzThumbNormal, twHorzThumbHot, twHorzThumbPushed, twHorzThumbDisabled,
    twVertScrollNormal, twVertScrollHot, twVertScrollPushed, twVertScrollDisabled,
    twVertThumbNormal, twVertThumbHot, twVertThumbPushed, twVertThumbDisabled,

    twDialog,
    twCaptionSizingTemplate,
    twSmallCaptionSizingTemplate,
    twFrameLeftSizingTemplate,
    twSmallFrameLeftSizingTemplate,
    twFrameRightSizingTemplate,
    twSmallFrameRightSizingTemplate,
    twFrameBottomSizingTemplate,
    twSmallFrameBottomSizingTemplate,
    // Windows Vista or later
    twFrame
  );

  TThemeData = array[TThemedElement] of THandle;

  TElementColor = (
    ecBorderColor,
    ecFillColor,
    ecTextColor,
    ecEdgeLightColor,
    ecEdgeHighLightColor,
    ecEdgeShadowColor,
    ecEdgeDkShadowColor,
    ecEdgeFillColor,
    ecTransparentColor,
    ecGradientColor1,
    ecGradientColor2,
    ecGradientColor3,
    ecGradientColor4,
    ecGradientColor5,
    ecShadowColor,
    ecGlowColor,
    ecTextBorderColor,
    ecTextShadowColor,
    ecGlyphTextColor,
    ecGlyphTransparentColor,
    ecFillColorHint,
    ecBorderColorHint,
    ecAccentColorHint,
    ecTextColorHint,
    ecHeading1TextColor,
    ecHeading2TextColor,
    ecBodyTextColor
  );

  TElementEdge = (
    eeRaisedInner,
    eeSunkenInner,
    eeRaisedOuter,
    eeSunkenOuter,
    eeBump,
    eeEtched,
    eeRaised,
    eeSunken
  );

  TElementEdges = set of TElementEdge;

  TStyleElementEdges = record
  private
    FValue: TElementEdges;
  public
    class operator Implicit(Value: TElementEdges): TStyleElementEdges;
    class operator Implicit(Value: TStyleElementEdges): TElementEdges;
    class operator Implicit(Value: Cardinal): TStyleElementEdges;
    class operator Implicit(Value: TStyleElementEdges): Cardinal;
  end;

  TElementEdgeFlag = (
    efLeft,
    efTop,
    efRight,
    efBottom,
    efTopLeft,
    efTopRight,
    efBottomLeft,
    efBottomRight,
    efRect,
    efDiagonal,
    efDiagonalEndTopLeft,
    efDiagonalEndTopRight,
    efDiagonalEndBottomLeft,
    efDiagonalEndBottomRight,
    efMiddle,
    efSoft,
    efAdjust,
    efFlat,
    efMono
  );

  TElementEdgeFlags = set of TElementEdgeFlag;

  TStyleElementEdgeFlags = record
  private
    FValue: TElementEdgeFlags;
  public
    class operator Implicit(Value: TElementEdgeFlags): TStyleElementEdgeFlags;
    class operator Implicit(Value: TStyleElementEdgeFlags): TElementEdgeFlags;
    class operator Implicit(Value: Cardinal): TStyleElementEdgeFlags;
    class operator Implicit(Value: TStyleElementEdgeFlags): Cardinal;
  end;

  TElementMargins = Winapi.UxTheme.TMargins;
  TElementMarginsHelper = record helper for TElementMargins
  public
    class function Create(const Rect: TRect): TElementMargins; overload; static;
    class function Create(LeftWidth, TopHeight, RightWidth, BottomHeight: Integer): TElementMargins; overload; static;
  end;

  TElementMargin = (emSizing, emContent, emCaption);
  TElementSize = (esMinimum, esActual, esStretch);
  TStyleTextFlag = (stfTextColor, stfBorderColor, stfBorderSize,
    stfShadowColor, stfShadowOffset, stfGlowSize);
  TStyleTextFlags = set of TStyleTextFlag;

  TStyleTextOptions = record
    Flags: TStyleTextFlags;
    TextColor: TColor;
    BorderColor: TColor;
    BorderSize: Integer;
    ShadowColor: TColor;
    ShadowOffset: TPoint;
    GlowSize: Integer;
  end;

  PThemedElementDetails = ^TThemedElementDetails;
  TThemedElementDetails = record
    Element: TThemedElement;
    Part,
    State: Integer;
    class function Create(Element: TThemedElement; Part, State: Integer): TThemedElementDetails; static;
  end;

  TStyleColor = (scBorder, scButtonDisabled, scButtonFocused, scButtonHot,
    scButtonNormal, scButtonPressed, scCategoryButtons, scCategoryButtonsGradientBase,
    scCategoryButtonsGradientEnd, scCategoryPanelGroup, scComboBox,
    scComboBoxDisabled, scEdit, scEditDisabled, scGrid, scGenericBackground,
    scGenericGradientBase, scGenericGradientEnd, scHintGradientBase,
    scHintGradientEnd, scListBox, scListBoxDisabled, scListView, scPanel, scPanelDisabled,
    scSplitter, scToolBarGradientBase, scToolBarGradientEnd, scTreeView, scWindow);

  TStyleFont = (
    sfButtonTextDisabled, sfButtonTextFocused, sfButtonTextHot, sfButtonTextNormal, sfButtonTextPressed,
    sfCaptionTextInactive, sfCaptionTextNormal,
    sfCategoryPanelGroupHeaderHot, sfCategoryPanelGroupHeaderNormal, sfCatgeoryButtonsCategoryNormal, sfCatgeoryButtonsCategorySelected,
    sfCatgeoryButtonsHot, sfCatgeoryButtonsNormal, sfCatgeoryButtonsSelected,
    sfCheckBoxTextDisabled, sfCheckBoxTextFocused, sfCheckBoxTextHot, sfCheckBoxTextNormal, sfCheckBoxTextPressed,
    sfComboBoxItemDisabled, sfComboBoxItemFocused, sfComboBoxItemHot, sfComboBoxItemNormal, sfComboBoxItemSelected,
    sfEditBoxTextDisabled, sfEditBoxTextFocused, sfEditBoxTextHot, sfEditBoxTextNormal, sfEditBoxTextSelected,
    sfGridItemFixedHot, sfGridItemFixedNormal, sfGridItemFixedPressed, sfGridItemNormal, sfGridItemSelected,
    sfGroupBoxTextDisabled, sfGroupBoxTextNormal,
    sfHeaderSectionTextDisabled, sfHeaderSectionTextHot, sfHeaderSectionTextNormal, sfHeaderSectionTextPressed,
    sfListItemTextDisabled, sfListItemTextFocused, sfListItemTextHot, sfListItemTextNormal, sfListItemTextSelected,
    sfMenuItemTextDisabled, sfMenuItemTextHot, sfMenuItemTextNormal, sfMenuItemTextSelected,
    sfPanelTextDisabled, sfPanelTextNormal,
    sfPopupMenuItemTextDisabled, sfPopupMenuItemTextHot, sfPopupMenuItemTextNormal, sfPopupMenuItemTextSelected,
    sfRadioButtonTextDisabled, sfRadioButtonTextFocused, sfRadioButtonTextHot, sfRadioButtonTextNormal, sfRadioButtonTextPressed,
    sfSmCaptionTextInactive, sfSmCaptionTextNormal,
    sfStatusPanelTextDisabled, sfStatusPanelTextNormal,
    sfTabTextActiveDisabled, sfTabTextActiveHot, sfTabTextActiveNormal, sfTabTextInactiveDisabled, sfTabTextInactiveHot, sfTabTextInactiveNormal,
    sfTextLabelDisabled, sfTextLabelFocused, sfTextLabelHot, sfTextLabelNormal,
    sfToolItemTextDisabled, sfToolItemTextHot, sfToolItemTextNormal, sfToolItemTextSelected,
    sfTreeItemTextDisabled, sfTreeItemTextFocused, sfTreeItemTextHot, sfTreeItemTextNormal, sfTreeItemTextSelected,
    sfWindowTextDisabled, sfWindowTextNormal
  );

  PStyleInfo = ^TStyleInfo;
  TStyleInfo = record
    Name: string;
    Author: string;
    AuthorEMail: string;
    AuthorURL: string;
    Version: string;
  end;

  TCustomStyleServices = class;

  // Abstract methods that need to be implemented in custom style implementations
  TAbstractStyleServices = class
  protected
    // Implementation for TCustomStyleServices.ColorToRGB
    function DoColorToRGB(Color: TColor; Details: PThemedElementDetails): TColorRef; virtual; abstract;
    // Implementation for TCustomStyleServices.DrawEdge
    function DoDrawEdge(DC: HDC; Details: TThemedElementDetails; const R: TRect;
      Edges: TElementEdges; Flags: TElementEdgeFlags; ContentRect: PRect): Boolean; overload; virtual; abstract;
    // Implementation for TCustomStyleServices.DrawElement
    function DoDrawElement(DC: HDC; Details: TThemedElementDetails;
      const R: TRect; ClipRect: PRect): Boolean; overload; virtual; abstract;
    // Implementation for TCustomStyleServices.DrawIcon
    function DoDrawIcon(DC: HDC; Details: TThemedElementDetails;
      const R: TRect; himl: HIMAGELIST; Index: Integer): Boolean; overload; virtual; abstract;
    // Implementation for TCustomStyleServices.DrawParentBackground
    function DoDrawParentBackground(Window: HWND; Target: HDC; Details: PThemedElementDetails;
      OnlyIfTransparent: Boolean; Bounds: PRect): Boolean; overload; virtual; abstract;
    // Implementation for TCustomStyleServices.DrawText
    function DoDrawText(DC: HDC; Details: TThemedElementDetails; const S: string;
      var R: TRect; Flags: TTextFormat; Options: TStyleTextOptions): Boolean; overload; virtual; abstract;
    // Implementation for TCustomStyleServices.GetElementContentRect
    function DoGetElementContentRect(DC: HDC; Details: TThemedElementDetails;
      const BoundingRect: TRect; out ContentRect: TRect): Boolean; virtual; abstract;
    // Implementation for TCustomStyleServices.GetElementColor
    function DoGetElementColor(Details: TThemedElementDetails;
      ElementColor: TElementColor; out Color: TColor): Boolean; virtual; abstract;
    // Implementation for TCustomStyleServices.GetElementMargins
    function DoGetElementMargins(DC: HDC; Details: TThemedElementDetails; Rect: PRect;
      ElementMargin: TElementMargin; out Margins: TElementMargins): Boolean; virtual; abstract;
    // Implementation for TCustomStyleServices.GetElementRegion
    function DoGetElementRegion(DC: HDC; Details: TThemedElementDetails;
      const Rect: TRect; out Region: HRGN): Boolean; virtual; abstract;
    // Implementation for TCustomStyleServices.GetElementSize
    function DoGetElementSize(DC: HDC; Details: TThemedElementDetails; Rect: PRect;
      ElementSize: TElementSize; out Size: TSize): Boolean; virtual; abstract;
    // Implementation for TCustomStyleServices.GetStyleColor
    function DoGetStyleColor(Color: TStyleColor): TColor; virtual; abstract;
    // Implementation for TCustomStyleServices.GetStyleFontColor
    function DoGetStyleFontColor(Font: TStyleFont): TColor; virtual; abstract;
    // Implementation for TCustomStyleServices.GetSystemColor
    function DoGetSystemColor(Color: TColor): TColor; virtual; abstract;
    // Implementation for TCustomStyleServices.GetTextExtent
    function DoGetTextExtent(DC: HDC; Details: TThemedElementDetails; const Text: string;
      Flags: TTextFormat; BoundingRect: PRect; out ExtentRect: TRect): Boolean; virtual; abstract;
    // Implementation for TCustomStyleServices.HasTransparentParts
    function DoHasTransparentParts(Details: TThemedElementDetails): Boolean; virtual; abstract;
    // Implementation for TCustomStyleServices.HasFixPosition
    function DoHasElementFixedPosition(Details: TThemedElementDetails): Boolean; virtual; abstract;

    class function DoIsValidStyle(Stream: TStream; StyleInfo: PStyleInfo): Boolean; virtual; abstract;
    function GetAvailable: Boolean; virtual; abstract;
    function GetEnabled: Boolean; virtual; abstract;
    function GetName: string; virtual; abstract;
    function GetTheme(Element: TThemedElement): THandle; virtual; abstract;
    procedure UnloadThemeData; virtual; abstract;
  public
    function GetElementDetails(Detail: TThemedButton): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedCategoryButtons): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedCategoryPanelGroup): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedCheckListBox): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedClock): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedComboBox): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedControlBar): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedDataNavButtons): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedDatePicker): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedEdit): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedExplorerBar): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedFlyOut): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedGrid): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedHeader): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedHint): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedLink): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedListView): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedMenu): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedMenuBand): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedMonthCal): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedNavigation): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedPage): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedPanel): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedProgress): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedRebar): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedScrollBar): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedSpin): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedStartPanel): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedStatus): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedTab): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedTabSet): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedTaskBand): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedTaskBar): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedTaskDialog): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedTextLabel): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedTextStyle): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedToolBar): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedToolTip): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedTrackBar): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedTrayNotify): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedTreeview): TThemedElementDetails; overload; virtual; abstract;
    function GetElementDetails(Detail: TThemedWindow): TThemedElementDetails; overload; virtual; abstract;
    class function LoadFromStream(Stream: TStream): TCustomStyleServices; virtual; abstract;
    procedure PaintBorder(Control: TWinControl; EraseLRCorner: Boolean); virtual; abstract;
    procedure SaveToStream(Stream: TStream); virtual; abstract;
    procedure UpdateThemes; virtual; abstract;
  end;

  // Implements public methods and properties for custom Styles
  TCustomStyleServices = class(TAbstractStyleServices)
  public type
    TStyleFlag = (sfHandleMessages);
    TStyleFlags = set of TStyleFlag;
  private
    FOnThemeChange: TNotifyEvent;
    function GetIsSystemStyle: Boolean;
  protected
    procedure DoOnThemeChange; virtual;
    function GetFlags: TStyleFlags; virtual;
  public
    constructor Create; virtual;
    procedure ApplyThemeChange;
    // ColorToRGB
    function ColorToRGB(Color: TColor; Details: PThemedElementDetails = nil): TColorRef; overload;
    function ColorToRGB(Color: TColor; Details: TThemedElementDetails): TColorRef; overload; inline;
    // ContentRect
    function ContentRect(DC: HDC; Details: TThemedElementDetails;
      const BoundingRect: TRect): TRect; deprecated 'Use GetElementContentRect';
    // DrawEdge
    function DrawEdge(DC: HDC; Details: TThemedElementDetails; const R: TRect;
      Edges, Flags: Cardinal; ContentRect: PRect = nil): Boolean; overload; inline; deprecated 'Use DrawEdge with TElementEdges';
    function DrawEdge(DC: HDC; Details: TThemedElementDetails; const R: TRect;
      Edges: TElementEdges; Flags: TElementEdgeFlags; ContentRect: PRect = nil): Boolean; overload;
    // DrawElement
    function DrawElement(DC: HDC; Details: TThemedElementDetails;
      const R, ClipRect: TRect): Boolean; overload; inline;
    function DrawElement(DC: HDC; Details: TThemedElementDetails;
      const R: TRect; ClipRect: PRect = nil): Boolean; overload;
    // DrawIcon
    function DrawIcon(DC: HDC; Details: TThemedElementDetails; const R: TRect;
      Images: HIMAGELIST; Index: Integer): Boolean; overload;
    // DrawParentBackground
    function DrawParentBackground(Window: HWND; Target: HDC; Details: PThemedElementDetails;
      OnlyIfTransparent: Boolean; const Bounds: TRect): Boolean; overload; inline;
    function DrawParentBackground(Window: HWND; Target: HDC; const Details: TThemedElementDetails;
      OnlyIfTransparent: Boolean; Bounds: PRect = nil): Boolean; overload; inline;
    function DrawParentBackground(Window: HWND; Target: HDC; Details: PThemedElementDetails;
      OnlyIfTransparent: Boolean; Bounds: PRect = nil): Boolean; overload;
    // DrawText
    function DrawText(DC: HDC; Details: TThemedElementDetails; const S: string;
      R: TRect; Flags, Flags2: Cardinal): Boolean; overload; inline; deprecated 'Use DrawText with TTextFormat';
    function DrawText(DC: HDC; Details: TThemedElementDetails;
      const S: string; var R: TRect; Flags: TTextFormat; Color: TColor = clNone): Boolean; overload;
    function DrawText(DC: HDC; Details: TThemedElementDetails;
      const S: string; var R: TRect; Flags: TTextFormat; Options: TStyleTextOptions): Boolean; overload;
    // GetElementContentRect
    function GetElementContentRect(DC: HDC; Details: TThemedElementDetails;
      const BoundingRect: TRect; out ContentRect: TRect): Boolean; overload;
    // GetElementColor
    function GetElementColor(Details: TThemedElementDetails;
      ElementColor: TElementColor; out Color: TColor): Boolean;
    // GetElementMargins
    function GetElementMargins(DC: HDC; Details: TThemedElementDetails;
      ElementMargin: TElementMargin; out Margins: TElementMargins): Boolean; overload;
    function GetElementMargins(DC: HDC; Details: TThemedElementDetails; const Rect: TRect;
      ElementMargin: TElementMargin; out Margins: TElementMargins): Boolean; overload;
    // GetElementRegion
    function GetElementRegion(Details: TThemedElementDetails; const Rect: TRect;
      out Region: HRGN): Boolean; overload; inline;
    function GetElementRegion(DC: HDC; Details: TThemedElementDetails; const Rect: TRect;
      out Region: HRGN): Boolean; overload;
    // GetElementSize
    function GetElementSize(DC: HDC; Details: TThemedElementDetails;
      ElementSize: TElementSize; out Size: TSize): Boolean; overload;
    function GetElementSize(DC: HDC; Details: TThemedElementDetails;
      const Rect: TRect; ElementSize: TElementSize; out Size: TSize): Boolean; overload;
    // GetStyleColor
    function GetStyleColor(Color: TStyleColor): TColor;
    // GetStyleFontColor
    function GetStyleFontColor(Font: TStyleFont): TColor;
    // GetSystemColor
    function GetSystemColor(Color: TColor): TColor;
    // GetTextExtent
    function GetTextExtent(DC: HDC; Details: TThemedElementDetails; const Text: string;
      Flags: TTextFormat; out ExtentRect: TRect): Boolean; overload;
    function GetTextExtent(DC: HDC; Details: TThemedElementDetails; const Text: string;
      Flags: TTextFormat; const BoundingRect: TRect; out ExtentRect: TRect): Boolean; overload;
    // HasFixedPosition
    function HasElementFixedPosition(Details: TThemedElementDetails): Boolean;
    // HasTransparentParts
    function HasTransparentParts(Details: TThemedElementDetails): Boolean;
    // LoadFromFile
    class function LoadFromFile(const FileName: string): TCustomStyleServices; virtual;
    // PaintBorder
    procedure PaintBorder(Control: TWinControl; EraseLRCorner: Boolean); override;
    // SaveToFile
    procedure SaveToFile(const FileName: string); virtual;
    // For backwards compatibility
    function ThemesAvailable: Boolean; inline; deprecated 'Use TCustomStyleServices.Available';
    // For backwards compatibility
    function ThemesEnabled: Boolean; inline; deprecated 'Use TCustomStyleServices.Enabled';
    // Tests if the stream contains a valid style
    class function IsValidStyle(Stream: TStream): Boolean; overload;
    // Tests if the stream contains a valid style and returns style info record
    class function IsValidStyle(Stream: TStream; var StyleInfo: TStyleInfo): Boolean; overload;

    property Available: Boolean read GetAvailable;
    property Enabled: Boolean read GetEnabled;
    property Flags: TStyleFlags read GetFlags;
    property IsSystemStyle: Boolean read GetIsSystemStyle;
    property Name: string read GetName;
                                                   
    property Theme[Element: TThemedElement]: THandle read GetTheme;
    property OnThemeChange: TNotifyEvent read FOnThemeChange write FOnThemeChange;
  end;

  TCustomStyleServicesClass = class of TCustomStyleServices;

  TCustomElementServices = class;
  TCustomElementServicesClass = class of TCustomElementServices;

  // Implement Windows default "Style" based on UxTheme API's (equivalent to former TThemeServices class)
  TUxThemeStyle = class(TCustomStyleServices)
  private
    FCustomElements: array[TVCLElements] of TCustomElementServicesClass;
    FAvailable: Boolean;
    FNewComCtrls: Boolean;
    FUseThemes: Boolean;
    FThemeData: TThemeData;
  protected
    // Implementation for TCustomStyleServices.ColorToRGB
    function DoColorToRGB(Color: TColor; Details: PThemedElementDetails): TColorRef; override;
    // Implementation for TCustomStyleServices.DrawEdge
    function DoDrawEdge(DC: HDC; Details: TThemedElementDetails; const R: TRect;
      Edges: TElementEdges; Flags: TElementEdgeFlags; ContentRect: PRect): Boolean; overload; override;
    // Implementation for TCustomStyleServices.DrawElement
    function DoDrawElement(DC: HDC; Details: TThemedElementDetails;
      const R: TRect; ClipRect: PRect): Boolean; overload; override;
    // Implementation for TCustomStyleServices.DrawIcon
    function DoDrawIcon(DC: HDC; Details: TThemedElementDetails;
      const R: TRect; himl: HIMAGELIST; Index: Integer): Boolean; overload; override;
    // Implementation for TCustomStyleServices.DrawParentBackground
    function DoDrawParentBackground(Window: HWND; Target: HDC; Details: PThemedElementDetails;
      OnlyIfTransparent: Boolean; Bounds: PRect): Boolean; overload; override;
    // Implementation for TCustomStyleServices.DrawText
    function DoDrawText(DC: HDC; Details: TThemedElementDetails; const S: string;
      var R: TRect; Flags: TTextFormat; Options: TStyleTextOptions): Boolean; overload; override;
    // Implementation for TCustomStyleServices.GetElementContentRect
    function DoGetElementContentRect(DC: HDC; Details: TThemedElementDetails;
      const BoundingRect: TRect; out ContentRect: TRect): Boolean; override;
    // Implementation for TCustomStyleServices.GetElementColor
    function DoGetElementColor(Details: TThemedElementDetails;
      ElementColor: TElementColor; out Color: TColor): Boolean; override;
    // Implementation for TCustomStyleServices.GetElementMargins
    function DoGetElementMargins(DC: HDC; Details: TThemedElementDetails; Rect: PRect;
      ElementMargin: TElementMargin; out Margins: TElementMargins): Boolean; override;
    // Implementation for TCustomStyleServices.GetElementRegion
    function DoGetElementRegion(DC: HDC; Details: TThemedElementDetails;
      const Rect: TRect; out Region: HRGN): Boolean; override;
    // Implementation for TCustomStyleServices.GetElementSize
    function DoGetElementSize(DC: HDC; Details: TThemedElementDetails; Rect: PRect;
      ElementSize: TElementSize; out Size: TSize): Boolean; override;
    // Implementation for TCustomStyleServices.GetStyleColor
    function DoGetStyleColor(Color: TStyleColor): TColor; override;
    // Implementation for TCustomStyleServices.GetStyleFontColor
    function DoGetStyleFontColor(Font: TStyleFont): TColor; override;
    // Implementation for TCustomStyleServices.GetSystemColor
    function DoGetSystemColor(Color: TColor): TColor; override;
    // Implementation for TCustomStyleServices.GetTextExtent
    function DoGetTextExtent(DC: HDC; Details: TThemedElementDetails; const Text: string;
      Flags: TTextFormat; BoundingRect: PRect; out ExtentRect: TRect): Boolean; override;
    // Implementation for TCustomStyleServices.HasTransparentParts
    function DoHasTransparentParts(Details: TThemedElementDetails): Boolean; override;
    // Implementation for TCustomStyleServices.HasFixedPosition
    function DoHasElementFixedPosition(Details: TThemedElementDetails): Boolean; override;
    // Implementation for TCustomStyleServices.ValidateStyle
    class function DoIsValidStyle(Stream: TStream; StyleInfo: PStyleInfo): Boolean; override;
    function GetAvailable: Boolean; override;
    function GetEnabled: Boolean; override;
    function GetName: string; override;
    function GetTheme(Element: TThemedElement): THandle; override;
    procedure UnloadThemeData; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    function GetElementDetails(Detail: TThemedButton): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedCategoryButtons): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedCategoryPanelGroup): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedCheckListBox): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedClock): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedComboBox): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedControlBar): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedDataNavButtons): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedDatePicker): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedEdit): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedFlyOut): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedExplorerBar): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedHeader): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedHint): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedGrid): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedLink): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedListView): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedMenu): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedMenuBand): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedMonthCal): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedNavigation): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedPage): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedPanel): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedProgress): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedRebar): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedScrollBar): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedSpin): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedStartPanel): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedStatus): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedTab): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedTabSet): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedTaskBand): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedTaskBar): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedTaskDialog): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedTextLabel): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedTextStyle): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedToolBar): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedToolTip): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedTrackBar): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedTrayNotify): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedTreeview): TThemedElementDetails; override;
    function GetElementDetails(Detail: TThemedWindow): TThemedElementDetails; override;
    class function LoadFromStream(Stream: TStream): TCustomStyleServices; override;
    procedure SaveToStream(Stream: TStream); override;
    procedure UpdateThemes; override;
  end;

  TStyleHook = class;
  TStyleHookClass = class of TStyleHook;

  TCustomStyleEngine = class
  strict protected type
    TStyleHookList = TList<TStyleHookClass>;
    TStyleHookDictionary = TDictionary<TClass, TStyleHookList>;
    PStyleHookRegistrationData = ^TStyleHookRegistrationData;
    TStyleHookRegistrationData = TPair<TClass, TStyleHookClass>;
  public type
    TStyleEngineNotification = (snControlDestroyed, snStyleHookUnregistered);
  strict private
    class var FRegisteredStyleHooks: TStyleHookDictionary;
    class destructor Destroy;
  strict protected
    class property RegisteredStyleHooks: TStyleHookDictionary read FRegisteredStyleHooks;
  public
    // Called by controls to pass messages to the engine
    class function HandleMessage(Control: TWinControl; var Message: TMessage;
      DefWndProc: TWndMethod): Boolean; virtual; abstract;
    // Called to notify the engine of an event
    class procedure Notification(Operation: TStyleEngineNotification; Data: Pointer); virtual; abstract;
    // Called to register a style hook class for a VCL component
    class procedure RegisterStyleHook(ControlClass: TClass;
      StyleHookClass: TStyleHookClass); virtual;
    // Called to unregister a style hook class for a VCL component
    class procedure UnRegisterStyleHook(ControlClass: TClass;
      StyleHookClass: TStyleHookClass); virtual;
  end;

  TCustomStyleEngineClass = class of TCustomStyleEngine;

  TStyleManager = class sealed
  public type
    TStyleClassDescriptor = record
      Extension: string;
      Description: string;
      ResourceType: string;
      StyleClass: TCustomStyleServicesClass;
    end;
    TStyleServicesHandle = type Pointer;
  strict private type
    TSourceInfo = record
      Data: TStyleServicesHandle;
      StyleClass: TCustomStyleServicesClass;
    end;

  TStyleDescriptorField = (dfExtension, dfDescription, dfResourceType);
  TFormBorderStyle = (fbsCurrentStyle, fbsSystemStyle);
  strict private
    class var FActiveStyle: TCustomStyleServices;
    class var FAutoDiscoverStyleResources: Boolean;
    class var FEngine: TCustomStyleEngine;
    class var FEngineClass: TCustomStyleEngineClass;
    class var FFlags: TCustomStyleServices.TStyleFlags;
    class var FRefreshAutoDiscovery: Boolean;
    class var FRegisteredStyles: TDictionary<string, TSourceInfo>;
    class var FStyleClassDescriptors: TList<TStyleClassDescriptor>;
    class var FStyleEngines: TList<TCustomStyleEngineClass>;
    class var FStyles: TList<TCustomStyleServices>;
    class var FSystemStyle: TUxThemeStyle;
    class var FFormBorderStyle: TFormBorderStyle;
    class var FAnimationOnControls: Boolean;
    class procedure CreateStyleEngine;
    class procedure DiscoverStyleResources;
    class function DoLoadFromResource(Instance: HINST; const ResourceName: string;
      ResourceType: PChar; StyleDescriptor: TStyleClassDescriptor): TStyleServicesHandle;
    class function DoLoadFromStream(Stream: TStream; StyleInfo: TSourceInfo): TStyleServicesHandle;
    class function FindStyleDescriptor(const Name: string; Field: TStyleDescriptorField): TStyleClassDescriptor; overload;
    class function GetActiveStyle: TCustomStyleServices; static;
    class function GetIsCustomStyleActive: Boolean; static;
    class function GetEnabled: Boolean; static; inline;
    class function GetEngine: TCustomStyleEngine; static;
    class function GetStyle(const Name: string): TCustomStyleServices; static;
    class function GetStyleClassDescriptors: TArray<TStyleClassDescriptor>; static;
    class function GetStyleDescriptor(const StyleName: string): TStyleClassDescriptor; static;
    class function GetStyleNames: TArray<string>; static;
    class function GetSystemStyle: TCustomStyleServices; static;
    class procedure SetAutoDiscoverStyleResources(const Value: Boolean); static;
    class procedure SetEngineClass(const Value: TCustomStyleEngineClass); static;
    class procedure SetFormBorderStyle(const Value: TFormBorderStyle); static;
  public
    // Handles a control message by passing it to the current style engine
    class function HandleMessage(Control: TWinControl; var Message: TMessage;
      DefWndProc: TWndMethod): Boolean;
    // Reserved for internal use only - do not call directly!
    class procedure Initialize;
    // Returns True if the file is recognized as a valid style
    class function IsValidStyle(const FileName: string): Boolean; overload;
    // Returns True if the file is recognized as a valid style and returns info about the style
    class function IsValidStyle(const FileName: string; var StyleInfo: TStyleInfo): Boolean; overload;
    // Load a style from a file
    class function LoadFromFile(const FileName: string): TStyleServicesHandle;
    // Load a style from a resource
    class function LoadFromResource(Instance: HINST; const ResourceName: string): TStyleServicesHandle; overload;
    // Load a style from a resource
    class function LoadFromResource(Instance: HINST; const ResourceName: string;
      ResourceType: PChar): TStyleServicesHandle; overload;
    // Called to notify the style engine of an event
    class procedure Notification(Operation: TCustomStyleEngine.TStyleEngineNotification; Data: Pointer);
    // Register an instance of a style
    class procedure RegisterStyle(Style: TCustomStyleServices);
    // Register a style class with a file extension, description and resource type
    class procedure RegisterStyleClass(const Extension, Description: string;
      const ResourceType: string; StyleClass: TCustomStyleServicesClass); overload;
    // Register a style class with a file extension, description and resource type
    class procedure RegisterStyleClass(const Extension, Description: string;
      ResourceType: PChar; StyleClass: TCustomStyleServicesClass); overload;
    // Set the active style by name
    class procedure SetStyle(const Name: string); overload;
    // Set the active style by instance
    class procedure SetStyle(Style: TCustomStyleServices); overload;
    // Set the active style by handle
    class procedure SetStyle(Handle: TStyleServicesHandle); overload;
    // Load a style from a resource without raising an exception
    class function TryLoadFromResource(Instance: HINST; const ResourceName: string;
      ResourceType: PChar; var Handle: TStyleServicesHandle): Boolean;
    // Set the active style by name without raising an exception
    class function TrySetStyle(const Name: string; ShowErrorDialog: Boolean = True): Boolean;
    // Reserved for internal use only - do not call directly!
    class procedure UnInitialize;
    // Unregisters a style
    class procedure UnRegisterStyle(Style: TCustomStyleServices);
    // Unregister a style class
    class procedure UnRegisterStyleClass(StyleClass: TCustomStyleServicesClass);
    // Unregister a style engine
    class procedure UnRegisterStyleEngine(AEngineClass: TCustomStyleEngineClass);

    // Automatically load all styles of registered resource types
    class property AutoDiscoverStyleResources: Boolean
      read FAutoDiscoverStyleResources write SetAutoDiscoverStyleResources;
    // Returns the current style
    class property ActiveStyle: TCustomStyleServices read GetActiveStyle;
    // Return True if style engine is enabled/active
    class property Enabled: Boolean read GetEnabled;
    // Returns the current style engine
    class property Engine: TCustomStyleEngine read GetEngine;
    // Returns a class reference to the current style engine class
    class property EngineClass: TCustomStyleEngineClass read FEngineClass write SetEngineClass;
    // Returns the current style's flags
    class property Flags: TCustomStyleServices.TStyleFlags read FFlags;
    // Returns True if a custom style is the active style. Does not return
    // True if the SystemStyle is active (i.e. Windows themes)
    class property IsCustomStyleActive: Boolean read GetIsCustomStyleActive;
    // Returns the style identified by name
    class property Style[const Name: string]: TCustomStyleServices read GetStyle;
    // Returns arary of registered style class descriptors
    class property StyleClassDescriptors: TArray<TStyleClassDescriptor> read GetStyleClassDescriptors;
    // Returns the descriptor for the given style
    class property StyleDescriptor[const StyleName: string]: TStyleClassDescriptor read GetStyleDescriptor;
    // Returns array of registered style class names
    class property StyleNames: TArray<string> read GetStyleNames;
    // Returns the native sytsem style (a.k.a. Windows)
    class property SystemStyle: TCustomStyleServices read GetSystemStyle;
    class property FormBorderStyle: TFormBorderStyle read FFormBorderStyle write SetFormBorderStyle default fbsCurrentStyle;
    class property AnimationOnControls: Boolean read FAnimationOnControls write FAnimationOnControls default False;
  end;

  TCustomElementServices = class
  public
    class function DrawEdge(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const R: TRect; Edges: TElementEdges; Flags: TElementEdgeFlags; ContentRect: PRect): Boolean; virtual;
    class function DrawElement(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const R: TRect; ClipRect: PRect): Boolean; virtual;
    class function DrawIcon(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const R: TRect; himl: HIMAGELIST; Index: Integer): Boolean; virtual;
    class function DrawText(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const S: string; var R: TRect; Flags: TTextFormat; Options: TStyleTextOptions): Boolean; virtual;
    class function GetElementContentRect(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const BoundingRect: TRect; out ContentRect: TRect): Boolean; virtual;
    class function GetElementColor(Style: TCustomStyleServices; Part, State: Integer;
      ElementColor: TElementColor; out Color: TColor): Boolean; virtual;
    class function GetElementMargins(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      Rect: PRect; Margin: TElementMargin; out ElementMargins: TElementMargins): Boolean; virtual;
    class function GetElementRegion(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const Rect: TRect; out Region: HRGN): Boolean; virtual;
    class function GetElementSize(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      Rect: PRect; ElementSize: TElementSize; out Size: TSize): Boolean; virtual;
    class function GetTextExtent(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const Text: string; Flags: TTextFormat; BoundingRect: PRect; out ExtentRect: TRect): Boolean; virtual;
    class function HasTransparentParts(Style: TCustomStyleServices; Part, State: Integer): Boolean; virtual;
  end;

  // Implements specifics for teCategoryButtons elements
  TUxThemeCategoryButtonElements = class(TCustomElementServices)
  public
    class function DrawElement(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const R: TRect; ClipRect: PRect): Boolean; override;
    class function GetElementColor(Style: TCustomStyleServices; Part, State: Integer;
      ElementColor: TElementColor; out Color: TColor): Boolean; override;
  end;

  // Implements specifics for teCategoryPanelGroup elements
  TUxThemeCategoryPanelGroupElements = class(TCustomElementServices)
  public
    class function DrawElement(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const R: TRect; ClipRect: PRect): Boolean; override;
    class function DrawText(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const S: string; var R: TRect; Flags: TTextFormat; Options: TStyleTextOptions): Boolean; override;
    class function GetElementColor(Style: TCustomStyleServices; Part, State: Integer;
      ElementColor: TElementColor; out Color: TColor): Boolean; override;
    class function GetElementSize(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      Rect: PRect; ElementSize: TElementSize; out Size: TSize): Boolean; override;
  end;

  // Implements specifics for teCheckListBox elements
  TUxThemeCheckListBoxElements = class(TCustomElementServices)
  public
    class function GetElementColor(Style: TCustomStyleServices; Part, State: Integer;
      ElementColor: TElementColor; out Color: TColor): Boolean; override;
  end;

  // Implements specifics for teControlBar elements
  TUxThemeControlBarElements = class(TCustomElementServices)
  public
    class function GetElementColor(Style: TCustomStyleServices; Part, State: Integer;
      ElementColor: TElementColor; out Color: TColor): Boolean; override;
  end;

  // Implements specifics for teGrid elements
  TUxThemeGridElements = class(TCustomElementServices)
  public
    class function DrawElement(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const R: TRect; ClipRect: PRect): Boolean; override;
    class function DrawText(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const S: string; var R: TRect; Flags: TTextFormat; Options: TStyleTextOptions): Boolean; override;
    class function GetElementColor(Style: TCustomStyleServices; Part, State: Integer;
      ElementColor: TElementColor; out Color: TColor): Boolean; override;
  end;

  // Implements specifics for teHint elements
  TUxThemeHintElements = class(TCustomElementServices)
  public
    class function GetElementColor(Style: TCustomStyleServices; Part, State: Integer;
      ElementColor: TElementColor; out Color: TColor): Boolean; override;
  end;

  // Implements specifics for tePanel elements
  TUxThemePanelElements = class(TCustomElementServices)
  public
    class function DrawText(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const S: string; var R: TRect; Flags: TTextFormat; Options: TStyleTextOptions): Boolean; override;
    class function GetElementColor(Style: TCustomStyleServices; Part, State: Integer;
      ElementColor: TElementColor; out Color: TColor): Boolean; override;
  end;

  // Implements specifics for teTabSet elements
  TUxThemeTabSetElements = class(TCustomElementServices)
  public
    class function GetElementColor(Style: TCustomStyleServices; Part, State: Integer;
      ElementColor: TElementColor; out Color: TColor): Boolean; override;
  end;

  // Implements specifics for teTextLabel elements
  TUxThemeTextLabelElements = class(TCustomElementServices)
  public
    class function DrawText(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const S: string; var R: TRect; Flags: TTextFormat; Options: TStyleTextOptions): Boolean; override;
    class function GetElementContentRect(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const BoundingRect: TRect; out ContentRect: TRect): Boolean; override;
    class function GetElementColor(Style: TCustomStyleServices; Part, State: Integer;
      ElementColor: TElementColor; out Color: TColor): Boolean; override;
    class function GetTextExtent(Style: TCustomStyleServices; DC: HDC; Part, State: Integer;
      const Text: string; Flags: TTextFormat; BoundingRect: PRect; out ExtentRect: TRect): Boolean; override;
  end;

  TStyleHook = class
  strict private
    FBrush: TBrush;
    FControl: TWinControl;
    FCallDefaultProc: Boolean;
    FDoubleBuffered: Boolean;
    FFocused: Boolean;
    FFocusUpdate: Boolean;
    FFontColor: TColor;
    FHandled: Boolean;
    FNeedsDefaultPaint: Boolean;
    FOverrideEraseBkgnd: Boolean;
    FOverridePaint: Boolean;
    FOverridePaintNC: Boolean;
    FPaintOnEraseBkgnd: Boolean;
    FText: string;
    function GetHandle: HWND;
    function GetText: string;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure WMPaint(var Message: TMessage); message WM_PAINT;
    procedure WMNCPaint(var Message: TMessage); message WM_NCPAINT;
    procedure WMEraseBkgnd(var Message: TMessage); message WM_ERASEBKGND;
    procedure WMSetFocus(var Message: TMessage); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TMessage); message WM_KILLFOCUS;
    procedure WMSetText(var Message: TMessage); message WM_SETTEXT;
    procedure WMEnable(var Message: TMessage); message WM_ENABLE;
  strict protected
    procedure CallDefaultProc(var Msg: TMessage);
    function AcceptMessage(var Message: TMessage): Boolean; virtual;
    function GetStringPropValue(const PropName: string): string;
    function HasBorder: Boolean; virtual;
    function HasClientEdge: Boolean; virtual;
    function InternalPaint(DC: HDC): Boolean; virtual;
    procedure Paint(Canvas: TCanvas); virtual;
    procedure PaintBackground(Canvas: TCanvas); virtual;
    procedure PaintNC(Canvas: TCanvas); virtual;
    procedure SetRedraw(Value: Boolean);
    procedure WndProc(var Message: TMessage); virtual;
    property Brush: TBrush read FBrush;
    property DoubleBuffered: Boolean read FDoubleBuffered write FDoubleBuffered;
    property Focused: Boolean read FFocused write FFocused;
    property FocusUpdate: Boolean read FFocusUpdate write FFocusUpdate;
    property FontColor: TColor read FFontColor write FFontColor;
    property Handle: HWND read GetHandle;
    property Handled: Boolean read FHandled write FHandled;
    property NeedsDefaultPaint: Boolean read FNeedsDefaultPaint write FNeedsDefaultPaint;
    property OverridePaint: Boolean read FOverridePaint write FOverridePaint;
    property OverridePaintNC: Boolean read FOverridePaintNC write FOverridePaintNC;
    property OverrideEraseBkgnd: Boolean read FOverrideEraseBkgnd write FOverrideEraseBkgnd;
    property PaintOnEraseBkgnd: Boolean read FPaintOnEraseBkgnd write FPaintOnEraseBkgnd;
    property Text: string read GetText;
  public
    constructor Create(AControl: TWinControl); virtual;
    destructor Destroy; override;
                                                                                                               
    procedure DrawControlText(Canvas: TCanvas; Details: TThemedElementDetails;
      const S: string; var R: TRect; Flags: Cardinal);
    function HandleMessage(var Message: TMessage): Boolean; virtual;
    procedure Invalidate; virtual;
    procedure InvalidateNC; virtual;
    property Control: TWinControl read FControl;
  end;

  TMouseTrackControlStyleHook = class(TStyleHook)
  public type
    TMousePosition = (mpNone, mpLeft, mpRight, mpTop, mpBottom);
  strict private
    FHotTrackTimer: TComponent; { TTimer }
    FMouseInControl: Boolean;
    FMouseInNCArea: Boolean;
    procedure WMMouseMove(var Message: TWMMouse); message WM_MOUSEMOVE;
    procedure WMNCMouseMove(var Message: TWMMouse); message WM_NCMOUSEMOVE;
  strict protected
    procedure DoHotTrackTimer(Sender: TObject); virtual;
    function IsMouseInControl: Boolean;
    procedure MouseEnter; virtual;
    procedure MouseLeave; virtual;
    function IsChildHandle(AHandle: HWnd): Boolean; virtual;
    procedure StartHotTrackTimer;
    procedure StopHotTrackTimer;
    procedure WndProc(var Message: TMessage); override;
    property MouseInControl: Boolean read FMouseInControl write FMouseInControl;
    property MouseInNCArea: Boolean read FMouseInNCArea write FMouseInNCArea;
  public
    constructor Create(AControl: TWinControl); override;
    destructor Destroy; override;
  end;

  // For backwards compatibility
  TThemeServices = TUxThemeStyle deprecated 'Use TUxThemeStyle';
  TThemeServicesClass = TCustomStyleServicesClass deprecated 'Use TCustomStyleServicesClass';

  TThemeServicesClassHelper = record
    class operator Implicit(AValue: TCustomStyleServicesClass): TThemeServicesClassHelper;
    class operator Implicit(AValue: TThemeServicesClassHelper): TCustomStyleServicesClass;
  end;

function StyleServices: TCustomStyleServices; inline;
function ThemeServices: TCustomStyleServices; inline; deprecated 'Use StyleServices';
function ThemeControl(AControl: TControl): Boolean;
function UnthemedDesigner(AControl: TControl): Boolean;

procedure DrawStyleEdge(DC: HDC; var Rect: TRect; Edges: TElementEdges; Flags: TElementEdgeFlags); overload;
procedure DrawStyleEdge(Canvas: TCanvas; var Rect: TRect; Edges: TElementEdges; Flags: TElementEdgeFlags); overload;

procedure DrawStyleFocusRect(DC: HDC; const Rect: TRect);

procedure DrawGlassText(ADC: HDC; const AText: string; var ATextRect: TRect;
  ATextFlags: Cardinal; const AGlowSize: Integer; const AFontColor: TColor); overload;
procedure DrawGlassText(ADC: HDC; const AText: string; var ATextRect: TRect;
  ATextFlags: Cardinal; const AGlowSize: Integer; const AFontColor: TColor;
  ADetail: TThemedElementDetails); overload;

var
  // For backwards compatibility
  ThemeServicesClass: TThemeServicesClassHelper deprecated 'Use TStyleManager.SetStyle';

type
  EStyleEngineException = class(Exception);
  ECustomStyleException = class(Exception);
  EDuplicateStyleException = class(ECustomStyleException);

                           
const
  WM_MDICHILDMOVE = WM_USER + 300;
  WM_MDICHILDCLOSE = WM_USER + 301;


implementation

uses
  System.Types, System.UITypes, System.IOUtils, System.TypInfo, Vcl.Forms, Vcl.Consts,
  Vcl.ExtCtrls, Vcl.Dialogs;

const
  Copyright: string = 'Theme manager '#$00A9' 2001-2006 Mike Lischke';

  ThemeDataNames: array[TThemedElement] of PChar = (
    // Windows elements
    'button',             // teButton
    'clock',              // teClock
    'combobox',           // teComboBox
    'datepicker',         // teDatePicker
    'edit',               // teEdit
    'explorerbar',        // teExplorerBar
    'flyout',             // teFlyOut
    'header',             // teHeader
    'link',               // teLink
    'listview',           // teListView
    'menu',               // teMenu
    'menuband',           // teMenuBand
    'monthcal',           // teMonthCal
    'navigation',         // teNavigation
    'page',               // tePage
    'progress',           // teProgress
    'rebar',              // teRebar
    'scrollbar',          // teScrollBar
    'spin',               // teSpin
    'startpanel',         // teStartPanel
    'status',             // teStatus
    'tab',                // teTab
    'taskband',           // teTaskBand
    'taskbar',            // teTaskBar
    'taskdialog',         // teTaskDialog
    'textstyle',          // teTextStyle
    'toolbar',            // teToolBar
    'tooltip',            // teToolTip
    'trackbar',           // teTrackBar
    'traynotify',         // teTrayNotify
    'treeview',           // teTreeview
    'window',             // teWindow
    // VCL extensions
    'categorybuttons',    // teCategoryButtons
    'categorypanelgroup', // teCategoryPanelGroup
    'checklistbox',       // teCheckListBox
    'controlbar',         // teControlBar
    'datanavbuttons',     // teDataNavButtons
    'grid',               // teGrid
    'hint',               // teHint
    'panel',              // tePanel
    'tabset',             // teTabSet
    'textlabel'           // teTextLabel
  );

var
  RM_UnthemedDesigner: DWORD;

function UnthemedDesigner(AControl: TControl): Boolean;
begin
  Result := False;
  if (AControl = nil) or not (csDesigning in AControl.ComponentState) then exit;
  if RM_UnthemedDesigner = 0 then
    RM_UnthemedDesigner := RegisterWindowMessage('BDSUnthemedDesigner');  { do not localize }
  Result := AControl.Perform(RM_UnthemedDesigner, 100, 0) = 100;
end;

function StyleServices: TCustomStyleServices;
begin
  Result := TStyleManager.ActiveStyle;
end;

function ThemeServices: TCustomStyleServices;
begin
  Result := TStyleManager.ActiveStyle;
end;

/// <summary>
/// ThemeControl is for use at design time to determine if a TControl should be themed.
/// This function is generally for use with Graphic controls like TSpeedButton or
/// TBitBtn to allow them to determine if they should render themed.
/// </summary>
/// <param name="AControl">The control to be themed</param>
/// <returns>Returns true if themes are enabled and we're at runtime or if
///          themes are enabled, the control is in design mode and it's owner is
///          an unthemed designer.
/// </returns>
function ThemeControl(AControl: TControl): Boolean;
begin
  Result := False;
  if AControl = nil then exit;
  Result := (not (csDesigning in AControl.ComponentState) and StyleServices.Enabled) or
            ((csDesigning in AControl.ComponentState) and (AControl.Parent <> nil) and
             (StyleServices.Enabled and not UnthemedDesigner(AControl.Parent)));
end;

{ DrawStyleEdge }

procedure DrawStyleEdge(DC: HDC; var Rect: TRect; Edges: TElementEdges; Flags: TElementEdgeFlags);
var
  Canvas: TCanvas;
begin
  Canvas := TCanvas.Create;
  try
    Canvas.Handle := DC;
    DrawStyleEdge(Canvas, Rect, Edges, Flags);
  finally
    Canvas.Handle := 0;
    Canvas.Free;
  end;
end;

procedure DrawStyleEdge(Canvas: TCanvas; var Rect: TRect; Edges: TElementEdges; Flags: TElementEdgeFlags);
var
  LRect: TRect;
  Points: TList<TPoint>;
  HighlightColor, ShadowColor: TColor;

  procedure DrawRect(TopLeftHighlight, BottomRightHighlight: Boolean);
  var
    TopRight, BottomLeft: TPoint;
  begin
    with Canvas do
    begin
      TopRight.X := LRect.Right;
      TopRight.Y := LRect.Top;
      BottomLeft.X := LRect.Left;
      BottomLeft.Y := LRect.Bottom;

      if TopLeftHighlight then
        Pen.Color := HighlightColor
      else
        Pen.Color := ShadowColor;

      if efLeft in Flags then
        Points.AddRange([BottomLeft, LRect.TopLeft]);
      if efTop in Flags then
        Points.AddRange([LRect.TopLeft, TopRight]);

      PolyLine(Points.ToArray);
      Points.Clear;

      if BottomRightHighlight then
        Pen.Color := HighlightColor
      else
        Pen.Color := ShadowColor;

      Dec(BottomLeft.X);
      if efRight in Flags then
        Points.AddRange([TopRight, LRect.BottomRight]);
      if efBottom in Flags then
        Points.AddRange([LRect.BottomRight, BottomLeft]);

      PolyLine(Points.ToArray);
      Points.Clear;
    end;
  end;

var
  Adjustments: TRect;
  Style: TCustomStyleServices;
begin
  LRect := Rect;
  Adjustments := TRect.Empty;
  Style := StyleServices;

  if efRect in Flags then
    Flags := Flags + [efTop, efLeft, efBottom, efRight]
  else
  begin
    if efTopLeft in Flags then Flags := Flags + [efTop, efLeft];
    if efTopRight in Flags then Flags := Flags + [efTop, efRight];
    if efBottomLeft in Flags then Flags := Flags + [efBottom, efLeft];
    if efBottomRight in Flags then Flags := Flags + [efBottom, efRight];
  end;

  if eeBump in Edges then Edges := [eeRaisedOuter, eeSunkenInner];
  if eeEtched in Edges then Edges := [eeSunkenOuter, eeRaisedInner];
  if eeRaised in Edges then Edges := [eeRaisedOuter, eeRaisedInner];
  if eeSunken in Edges then Edges := [eeSunkenOuter, eeSunkenInner];

  Points := TList<TPoint>.Create;
  try
    Canvas.Pen.Width := 1;
    Dec(LRect.Bottom);
    Dec(LRect.Right);

    if (eeRaisedOuter in Edges) then
    begin
      ShadowColor := Style.GetSystemColor(cl3DDkShadow);
      HighlightColor := Style.GetSystemColor(cl3DLight);
    end
    else
    begin
      ShadowColor := Style.GetSystemColor(clBtnShadow);
      HighlightColor := Style.GetSystemColor(clBtnHighlight);
    end;

    // Draw outer frame
    if (eeRaisedOuter in Edges) or (eeSunkenOuter in Edges) then
    begin
      DrawRect(eeRaisedOuter in Edges, eeSunkenOuter in Edges);
      if efAdjust in Flags then
      begin
        if efLeft in Flags then Inc(Adjustments.Left);
        if efRight in Flags then Inc(Adjustments.Right);
        if efTop in Flags then Inc(Adjustments.Top);
        if efBottom in Flags then Inc(Adjustments.Bottom);
      end;
      InflateRect(LRect, -1, -1);
    end;

    // Draw inner frame
    if (eeRaisedInner in Edges) or (eeSunkenInner in Edges) then
    begin
      if (eeRaisedOuter in Edges) and (eeRaisedInner in Edges) then
      begin
        ShadowColor := Style.GetSystemColor(clBtnShadow);
        HighlightColor := Style.GetSystemColor(clBtnHighlight);
      end;

      DrawRect(eeRaisedInner in Edges, eeSunkenInner in Edges);
      if efAdjust in Flags then
      begin
        if efLeft in Flags then Inc(Adjustments.Left);
        if efRight in Flags then Inc(Adjustments.Right);
        if efTop in Flags then Inc(Adjustments.Top);
        if efBottom in Flags then Inc(Adjustments.Bottom);
      end;
      InflateRect(LRect, -1, -1);
    end;

    Inc(LRect.Bottom);
    Inc(LRect.Right);
  finally
    Points.Free;
  end;

  if efAdjust in Flags then
  begin
    Inc(Rect.Left, Adjustments.Left);
    Inc(Rect.Top, Adjustments.Top);
    Dec(Rect.Right, Adjustments.Right);
    Dec(Rect.Bottom, Adjustments.Bottom);
  end;
end;

{ DrawStyleFocusRect }

procedure DrawStyleFocusRect(DC: HDC; const Rect: TRect);

  function AdjustPixel(PixelColor, TargetColor: TColorRef): TColorRef; inline;
  begin
    if PixelColor = TargetColor then
      Result := not TargetColor
    else
      Result := TargetColor;
  end;

var
  I: Integer;
  LColor1, LColor2: TColor;
begin
  LColor1 := GetHighlightColor(ColorToRGB(StyleServices.GetSystemColor(clHighlight)));
  LColor2 := GetShadowColor(ColorToRGB(StyleServices.GetSystemColor(clHighlight)));

  I := Rect.Left + 1;
  while I < Rect.Right - 1 do
  begin
    SetPixel(DC, I, Rect.Top, AdjustPixel(GetPixel(DC, I, Rect.Top), LColor1));
    SetPixel(DC, I + 1, Rect.Top, AdjustPixel(GetPixel(DC, I, Rect.Top), LColor2));
    Inc(I, 2);
  end;

  I := Rect.Left + 1;
  while I < Rect.Right - 1 do
  begin
    SetPixel(DC, I, Rect.Bottom - 1, AdjustPixel(GetPixel(DC, I, Rect.Bottom - 1), LColor1));
    SetPixel(DC, I + 1, Rect.Bottom - 1, AdjustPixel(GetPixel(DC, I + 1, Rect.Bottom - 1), LColor2));
    Inc(I, 2);
  end;

  I := Rect.Top + 1;
  while I < Rect.Bottom - 1 do
  begin
    SetPixel(DC, Rect.Left, I, AdjustPixel(GetPixel(DC, Rect.Left, I), LColor1));
    SetPixel(DC, Rect.Left, I + 1, AdjustPixel(GetPixel(DC, Rect.Left, I + 1), LColor2));
    Inc(I, 2);
  end;

  I := Rect.Top + 1;
  while I < Rect.Bottom - 1 do
  begin
    SetPixel(DC, Rect.Right - 1, I, AdjustPixel(GetPixel(DC, Rect.Right - 1, I), LColor1));
    SetPixel(DC, Rect.Right - 1, I + 1, AdjustPixel(GetPixel(DC, Rect.Right - 1, I + 1), LColor2));
    Inc(I, 2);
  end;
end;

{ DrawGlassText }

procedure DrawGlassText(ADC: HDC; const AText: string; var ATextRect: TRect;
  ATextFlags: Cardinal; const AGlowSize: Integer; const AFontColor: TColor); overload;
var
  LDetail: TThemedElementDetails;
begin
  LDetail := TStyleManager.SystemStyle.GetElementDetails(teEditTextNormal);
  DrawGlassText(ADC, AText, ATextRect, ATextFlags, AGlowSize, AFontColor, LDetail);
end;

procedure DrawGlassText(ADC: HDC; const AText: string; var ATextRect: TRect;
  ATextFlags: Cardinal; const AGlowSize: Integer; const AFontColor: TColor;
  ADetail: TThemedElementDetails); overload;
var
  Options: TDTTOpts;
begin
  // DrawThemeTextEx requires Windows Vista or later
  if TOSVersion.Check(6) then
  begin
    FillChar(Options, SizeOf(Options), 0);
    Options.dwSize := SizeOf(Options);
    Options.dwFlags := DTT_TEXTCOLOR or DTT_COMPOSITED;
    if AGlowSize > 0 then
      Options.dwFlags := Options.dwFlags or DTT_GLOWSIZE;
    if ATextFlags and DT_CALCRECT = DT_CALCRECT then
      Options.dwFlags := Options.dwFlags or DTT_CALCRECT;
    Options.crText := ColorToRGB(AFontColor);
    Options.iGlowSize := AGlowSize;
    DrawThemeTextEx(TStyleManager.SystemStyle.Theme[ADetail.Element], ADC,
      ADetail.Part, ADetail.State, AText, Length(AText), ATextFlags, ATextRect, Options);
  end
  else
    DrawThemeText(TStyleManager.SystemStyle.Theme[ADetail.Element], ADC,
      ADetail.Part, ADetail.State, PChar(AText), Length(AText), ATextFlags, 0, ATextRect);
end;


{ TCustomStyleServices }

constructor TCustomStyleServices.Create;
begin
  inherited;
end;

procedure TCustomStyleServices.ApplyThemeChange;
begin
  UpdateThemes;
  DoOnThemeChange;
end;

function TCustomStyleServices.ColorToRGB(Color: TColor; Details: PThemedElementDetails = nil): TColorRef;
begin
  Result := DoColorToRGB(Color, Details);
end;

function TCustomStyleServices.ColorToRGB(Color: TColor; Details: TThemedElementDetails): TColorRef;
begin
  Result := ColorToRGB(Color, @Details);
end;

function TCustomStyleServices.ContentRect(DC: HDC; Details: TThemedElementDetails;
  const BoundingRect: TRect): TRect;
begin
  GetElementContentRect(DC, Details, BoundingRect, Result);
end;

procedure TCustomStyleServices.DoOnThemeChange;
begin
  if Assigned(FOnThemeChange) then
    FOnThemeChange(Self);
end;

function TCustomStyleServices.DrawEdge(DC: HDC; Details: TThemedElementDetails;
  const R: TRect; Edges, Flags: Cardinal; ContentRect: PRect = nil): Boolean;
begin
  Result := DrawEdge(DC, Details, R, TElementEdges(TStyleElementEdges(Edges)),
    TStyleElementEdgeFlags(Flags), ContentRect);
end;

function TCustomStyleServices.DrawEdge(DC: HDC; Details: TThemedElementDetails;
  const R: TRect; Edges: TElementEdges; Flags: TElementEdgeFlags; ContentRect: PRect = nil): Boolean;
begin
  Result := DoDrawEdge(DC, Details, R, Edges, Flags, ContentRect);
end;

function TCustomStyleServices.DrawElement(DC: HDC; Details: TThemedElementDetails;
  const R, ClipRect: TRect): Boolean;
begin
  Result := DrawElement(DC, Details, R, @ClipRect);
end;

function TCustomStyleServices.DrawElement(DC: HDC; Details: TThemedElementDetails;
  const R: TRect; ClipRect: PRect = nil): Boolean;
begin
  Result := DoDrawElement(DC, Details, R, ClipRect);
end;

function TCustomStyleServices.DrawIcon(DC: HDC; Details: TThemedElementDetails;
  const R: TRect; Images: HIMAGELIST; Index: Integer): Boolean;
begin
  Result := DoDrawIcon(DC, Details, R, Images, Index);
end;

function TCustomStyleServices.DrawParentBackground(Window: HWND; Target: HDC;
  Details: PThemedElementDetails; OnlyIfTransparent: Boolean; const Bounds: TRect): Boolean;
begin
  Result := DrawParentBackground(Window, Target, Details, OnlyIfTransparent, @Bounds);
end;

function TCustomStyleServices.DrawParentBackground(Window: HWND; Target: HDC;
  Details: PThemedElementDetails; OnlyIfTransparent: Boolean; Bounds: PRect): Boolean;
begin
  Result := DoDrawParentBackground(Window, Target, Details, OnlyIfTransparent, Bounds);
end;

function TCustomStyleServices.DrawParentBackground(Window: HWND; Target: HDC;
  const Details: TThemedElementDetails; OnlyIfTransparent: Boolean; Bounds: PRect): Boolean;
begin
  Result := DrawParentBackground(Window, Target, @Details, OnlyIfTransparent, Bounds);
end;

function TCustomStyleServices.DrawText(DC: HDC; Details: TThemedElementDetails;
  const S: string; R: TRect; Flags, Flags2: Cardinal): Boolean;
begin
  Result := DrawText(DC, Details, S, R, TTextFormatFlags(Flags));
end;

function TCustomStyleServices.DrawText(DC: HDC; Details: TThemedElementDetails;
  const S: string; var R: TRect; Flags: TTextFormat; Color: TColor = clNone): Boolean;
var
  LColor: TColor;
  LOptions: TStyleTextOptions;
begin
  if (Color = clNone) and GetElementColor(Details, ecTextColor, LColor) then
    Color := LColor;
  if Color <> clNone then
  begin
    LOptions.Flags := [stfTextColor];
    LOptions.TextColor := Color;
  end
  else
    LOptions.Flags := [];
  Result := DoDrawText(DC, Details, S, R, Flags, LOptions);
end;

function TCustomStyleServices.DrawText(DC: HDC; Details: TThemedElementDetails;
  const S: string; var R: TRect; Flags: TTextFormat; Options: TStyleTextOptions): Boolean;
begin
  Result := DoDrawText(DC, Details, S, R, Flags, Options);
end;

function TCustomStyleServices.GetElementColor(Details: TThemedElementDetails;
  ElementColor: TElementColor; out Color: TColor): Boolean;
begin
  Result := DoGetElementColor(Details, ElementColor, Color);
end;

function TCustomStyleServices.GetElementContentRect(DC: HDC; Details: TThemedElementDetails;
  const BoundingRect: TRect; out ContentRect: TRect): Boolean;
begin
  Result := DoGetElementContentRect(DC, Details, BoundingRect, ContentRect);
end;

function TCustomStyleServices.GetElementMargins(DC: HDC; Details: TThemedElementDetails;
  ElementMargin: TElementMargin; out Margins: TElementMargins): Boolean;
begin
  Result := DoGetElementMargins(DC, Details, nil, ElementMargin, Margins);
end;

function TCustomStyleServices.GetElementMargins(DC: HDC; Details: TThemedElementDetails;
  const Rect: TRect; ElementMargin: TElementMargin; out Margins: TElementMargins): Boolean;
begin
  Result := DoGetElementMargins(DC, Details, @Rect, ElementMargin, Margins);
end;

function TCustomStyleServices.GetElementRegion(Details: TThemedElementDetails;
  const Rect: TRect; out Region: HRGN): Boolean;
begin
  Result := GetElementRegion(0, Details, Rect, Region);
end;

function TCustomStyleServices.GetElementRegion(DC: HDC; Details: TThemedElementDetails;
  const Rect: TRect; out Region: HRGN): Boolean;
begin
  Result := DoGetElementRegion(DC, Details, Rect, Region);
end;

function TCustomStyleServices.GetElementSize(DC: HDC; Details: TThemedElementDetails;
  ElementSize: TElementSize; out Size: TSize): Boolean;
begin
  Result := DoGetElementSize(DC, Details, nil, ElementSize, Size);
end;

function TCustomStyleServices.GetElementSize(DC: HDC; Details: TThemedElementDetails;
  const Rect: TRect; ElementSize: TElementSize; out Size: TSize): Boolean;
begin
  Result := DoGetElementSize(DC, Details, @Rect, ElementSize, Size);
end;

function TCustomStyleServices.GetIsSystemStyle: Boolean;
begin
  Result := TStyleManager.SystemStyle = Self;
end;

function TCustomStyleServices.GetStyleColor(Color: TStyleColor): TColor;
begin
  Result := DoGetStyleColor(Color);
end;

function TCustomStyleServices.GetStyleFontColor(Font: TStyleFont): TColor;
begin
  Result := DoGetStyleFontColor(Font);
end;

function TCustomStyleServices.GetSystemColor(Color: TColor): TColor;
begin
  Result := DoGetSystemColor(Color);
end;

function TCustomStyleServices.GetTextExtent(DC: HDC; Details: TThemedElementDetails;
  const Text: string; Flags: TTextFormat; out ExtentRect: TRect): Boolean;
begin
  Result := DoGetTextExtent(DC, Details, Text, Flags, nil, ExtentRect);
end;

function TCustomStyleServices.GetTextExtent(DC: HDC; Details: TThemedElementDetails;
  const Text: string; Flags: TTextFormat; const BoundingRect: TRect; out ExtentRect: TRect): Boolean;
begin
  Result := DoGetTextExtent(DC, Details, Text, Flags, @BoundingRect, ExtentRect);
end;

function TCustomStyleServices.GetFlags: TStyleFlags;
begin
  Result := [];
end;

function TCustomStyleServices.HasTransparentParts(Details: TThemedElementDetails): Boolean;
begin
  Result := DoHasTransparentParts(Details);
end;

function TCustomStyleServices.HasElementFixedPosition(Details: TThemedElementDetails): Boolean;
begin
  Result := DoHasElementFixedPosition(Details);
end;

class function TCustomStyleServices.LoadFromFile(const FileName: string): TCustomStyleServices;
var
  LStream: TStream;
begin
  LStream := TFileStream.Create(FileName, fmOpenRead);
  try
    Result := LoadFromStream(LStream);
  finally
    LStream.Free;
  end;
end;

procedure TCustomStyleServices.PaintBorder(Control: TWinControl; EraseLRCorner: Boolean);
var
  EmptyRect,
  DrawRect: TRect;
  DC: HDC;
  H, W: Integer;
  AStyle,
  ExStyle: Integer;
  Details: TThemedElementDetails;
begin
  with Control do
  begin
    ExStyle := GetWindowLong(Handle, GWL_EXSTYLE);
    if (ExStyle and WS_EX_CLIENTEDGE) <> 0 then
    begin
      GetWindowRect(Handle, DrawRect);
      OffsetRect(DrawRect, -DrawRect.Left, -DrawRect.Top);
      DC := GetWindowDC(Handle);
      try
        EmptyRect := DrawRect;
        if EraseLRCorner then
        begin
          AStyle := GetWindowLong(Handle, GWL_STYLE);
          if ((AStyle and WS_HSCROLL) <> 0) and ((AStyle and WS_VSCROLL) <> 0) then
          begin
            W := GetSystemMetrics(SM_CXVSCROLL);
            H := GetSystemMetrics(SM_CYHSCROLL);
            InflateRect(EmptyRect, -2, -2);
            with EmptyRect do
              if UseRightToLeftScrollBar then
                EmptyRect := Rect(Left, Bottom - H, Left + W, Bottom)
              else
                EmptyRect := Rect(Right - W, Bottom - H, Right, Bottom);
            FillRect(DC, EmptyRect, GetSysColorBrush(COLOR_BTNFACE));
          end;
        end;
        with DrawRect do
          ExcludeClipRect(DC, Left + 2, Top + 2, Right - 2, Bottom - 2);
        Details := GetElementDetails(teEditTextNormal);
        DrawElement(DC, Details, DrawRect);
      finally
        ReleaseDC(Handle, DC);
      end;
    end;
  end;
end;

procedure TCustomStyleServices.SaveToFile(const FileName: string);
var
  LStream: TStream;
begin
  LStream := TFileStream.Create(FileName, fmOpenWrite);
  try
    SaveToStream(LStream);
  finally
    LStream.Free;
  end;
end;

function TCustomStyleServices.ThemesAvailable: Boolean;
begin
  Result := Available;
end;

function TCustomStyleServices.ThemesEnabled: Boolean;
begin
  Result := Enabled;
end;

class function TCustomStyleServices.IsValidStyle(Stream: TStream): Boolean;
begin
  Result := DoIsValidStyle(Stream, nil);
end;

class function TCustomStyleServices.IsValidStyle(Stream: TStream; var StyleInfo: TStyleInfo): Boolean;
begin
  Result := DoIsValidStyle(Stream, @StyleInfo);
end;

{ TUxThemeStyle }

constructor TUxThemeStyle.Create;
const
  ComCtlVersionIE6 = $00060000;
begin
  inherited Create;

  FCustomElements[teCategoryButtons] := TUxThemeCategoryButtonElements;
  FCustomElements[teCategoryPanelGroup] := TUxThemeCategoryPanelGroupElements;
  FCustomElements[teCheckListBox] := TUxThemeCheckListBoxElements;
  FCustomElements[teControlBar] := TUxThemeControlBarElements;
  FCustomElements[teGrid] := TUxThemeGridElements;
  FCustomElements[teHint] := TUxThemeHintElements;
  FCustomElements[tePanel] := TUxThemePanelElements;
  FCustomElements[teTabSet] := TUxThemeTabSetElements;
  FCustomElements[teTextLabel] := TUxThemeTextLabelElements;

  FAvailable := InitThemeLibrary;
  if FAvailable then
  begin
    FNewComCtrls := GetFileVersion(comctl32) >= ComCtlVersionIE6;
    UpdateThemes;
  end;
end;

destructor TUxThemeStyle.Destroy;
begin
  UnloadThemeData;
  if not IsLibrary then
    FreeThemeLibrary;
end;

function TUxThemeStyle.DoColorToRGB(Color: TColor;
  Details: PThemedElementDetails): TColorRef;
begin
  if (Color and $80000000 = 0) or (Details = nil) then
    Result := TColorRef(Color)
  else
    Result := GetThemeSysColor(Theme[Details.Element], Color and not $80000000);
end;

function TUxThemeStyle.DoDrawEdge(DC: HDC; Details: TThemedElementDetails;
  const R: TRect; Edges: TElementEdges; Flags: TElementEdgeFlags; ContentRect: PRect): Boolean;
begin
  if Details.Element in CVCLElements then
    Result := FCustomElements[Details.Element].DrawEdge(Self, DC, Details.Part,
      Details.State, R, Edges, Flags, ContentRect)
  else
    Result := DrawThemeEdge(Theme[Details.Element], DC, Details.Part,
      Details.State, R, TStyleElementEdges(Edges), TStyleElementEdgeFlags(Flags), ContentRect) = S_OK;
end;

function TUxThemeStyle.DoDrawElement(DC: HDC; Details: TThemedElementDetails;
  const R: TRect; ClipRect: PRect): Boolean;
begin
  if Details.Element in CVCLElements then
    Result := FCustomElements[Details.Element].DrawElement(Self, DC,
      Details.Part, Details.State, R, ClipRect)
  else
    Result := DrawThemeBackground(Theme[Details.Element], DC, Details.Part,
      Details.State, R, ClipRect) = S_OK;
end;

function TUxThemeStyle.DoDrawIcon(DC: HDC; Details: TThemedElementDetails;
  const R: TRect; himl: HIMAGELIST; Index: Integer): Boolean;
begin
  if Details.Element in CVCLElements then
    Result := FCustomElements[Details.Element].DrawIcon(Self, DC,
      Details.Part, Details.State, R, himl, Index)
  else
    Result := DrawThemeIcon(Theme[Details.Element], DC, Details.Part,
      Details.State, R, himl, Index) = S_OK;
end;

function TUxThemeStyle.DoDrawParentBackground(Window: HWND; Target: HDC;
  Details: PThemedElementDetails; OnlyIfTransparent: Boolean; Bounds: PRect): Boolean;
begin
  if OnlyIfTransparent and Assigned(Details) then
    Result := DoHasTransparentParts(Details^)
  else
    Result := True;

  if Result then
    Result := DrawThemeParentBackground(Window, Target, Bounds) = S_OK;
end;

function TUxThemeStyle.DoDrawText(DC: HDC; Details: TThemedElementDetails;
  const S: string; var R: TRect; Flags: TTextFormat; Options: TStyleTextOptions): Boolean;
const
  COptions: array[TStyleTextFlag] of Cardinal = (DTT_TEXTCOLOR, DTT_BORDERCOLOR,
    DTT_BORDERSIZE, DTT_SHADOWCOLOR, DTT_SHADOWOFFSET, DTT_GLOWSIZE);
var
  LFlags: Cardinal;
  LOptions: TDTTOpts;
  LTextOption: TStyleTextFlag;
  LColorRef: TColorRef;
begin
  if Details.Element in CVCLElements then
    Result := FCustomElements[Details.Element].DrawText(Self, DC,
      Details.Part, Details.State, S, R, Flags, Options)
  else
  begin
    LFlags := TTextFormatFlags(Flags);

    // Vista or later, use DrawThemeTextEx
    if TOSVersion.Check(6) then
    begin
      FillChar(LOptions, SizeOf(LOptions), 0);
      LOptions.dwSize := SizeOf(LOptions);
      for LTextOption := Low(TStyleTextFlag) to High(TStyleTextFlag) do
        if (LTextOption in Options.Flags) then
          LOptions.dwFlags := LOptions.dwFlags or COptions[LTextOption];
      LOptions.crText := Vcl.Graphics.ColorToRGB(Options.TextColor);
      LOptions.crBorder := Vcl.Graphics.ColorToRGB(Options.BorderColor);
      LOptions.iBorderSize := Options.BorderSize;
      LOptions.crShadow := Vcl.Graphics.ColorToRGB(Options.ShadowColor);
      LOptions.ptShadowOffset := Options.ShadowOffset;
      LOptions.iGlowSize := Options.GlowSize;
      if (tfComposited in Flags) then
        LOptions.dwFlags := LOptions.dwFlags or DTT_COMPOSITED;
      if (tfCalcRect in Flags) then
        LOptions.dwFlags := LOptions.dwFlags or DTT_CALCRECT;

      Result := DrawThemeTextEx(Theme[Details.Element], DC, Details.Part, Details.State,
        PChar(S), Length(S), LFlags, @R, LOptions) = S_OK;
    end
    else
    begin
      // Windows XP doesn't allow changing the text color, use DrawText if needed
      if (stfTextColor in Options.Flags) then
      begin
        LColorRef := SetTextColor(DC, Vcl.Graphics.ColorToRGB(Options.TextColor));
        try
          Winapi.Windows.DrawText(DC, PChar(S), Length(S), R, LFlags);
        finally
          SetTextColor(DC, LColorRef);
        end;
        Result := True;
      end
      else
        // If text color is default for part/state, use DrawThemeText
        Result := DrawThemeText(Theme[Details.Element], DC, Details.Part, Details.State,
          PChar(S), Length(S), LFlags, 0, R) = S_OK;
    end;
  end;
end;

function TUxThemeStyle.DoGetElementContentRect(DC: HDC; Details: TThemedElementDetails;
  const BoundingRect: TRect; out ContentRect: TRect): Boolean;
begin
  if Details.Element in CVCLElements then
    Result := FCustomElements[Details.Element].GetElementContentRect(Self, DC,
      Details.Part, Details.State, BoundingRect, ContentRect)
  else
    Result := GetThemeBackgroundContentRect(Theme[Details.Element], DC, Details.Part,
      Details.State, BoundingRect, @ContentRect) = S_OK;
end;

function TUxThemeStyle.DoGetElementColor(Details: TThemedElementDetails;
  ElementColor: TElementColor; out Color: TColor): Boolean;
begin
  if Details.Element in CVCLElements then
    Result := FCustomElements[Details.Element].GetElementColor(Self, Details.Part,
      Details.State, ElementColor, Color)
  else
    Result := GetThemeColor(Theme[Details.Element], Details.Part, Details.State,
      Integer(ElementColor) + TMT_BORDERCOLOR, TColorRef(Color)) = S_OK;
end;

function TUxThemeStyle.DoGetElementMargins(DC: HDC; Details: TThemedElementDetails;
  Rect: PRect; ElementMargin: TElementMargin; out Margins: TElementMargins): Boolean;
const
  CMargins: array[TElementMargin] of Integer = (TMT_SIZINGMARGINS, TMT_CONTENTMARGINS, TMT_CAPTIONMARGINS);
begin
  if Details.Element in CVCLElements then
    Result := FCustomElements[Details.Element].GetElementMargins(Self, DC,
      Details.Part, Details.State, Rect, ElementMargin, Margins)
  else
    Result := GetThemeMargins(Theme[Details.Element], DC, Details.Part, Details.State,
      CMargins[ElementMargin], Rect, Margins) = S_OK;
end;

function TUxThemeStyle.DoGetElementRegion(DC: HDC; Details: TThemedElementDetails;
  const Rect: TRect; out Region: HRGN): Boolean;
begin
  if Details.Element in CVCLElements then
    Result := FCustomElements[Details.Element].GetElementRegion(Self,
      DC, Details.Part, Details.State, Rect, Region)
  else
    Result := GetThemeBackgroundRegion(Theme[Details.Element], DC, Details.Part,
      Details.State, Rect, Region) = S_OK;
end;

function TUxThemeStyle.DoGetElementSize(DC: HDC; Details: TThemedElementDetails;
 Rect: PRect; ElementSize: TElementSize; out Size: TSize): Boolean;
const
  CSizes: array[TElementSize] of TThemeSize = (TS_MIN, TS_TRUE, TS_DRAW);
begin
  if Details.Element in CVCLElements then
    Result := FCustomElements[Details.Element].GetElementSize(Self,
      DC, Details.Part, Details.State, Rect, ElementSize, Size)
  else
    Result := GetThemePartSize(Theme[Details.Element], DC, Details.Part, Details.State,
      Rect, CSizes[ElementSize], Size) = S_OK;
end;

function TUxThemeStyle.DoGetStyleColor(Color: TStyleColor): TColor;
begin
  case Color of
    scBorder: Result := clWindowFrame;
    scButtonDisabled: Result := clBtnFace;
    scButtonFocused: Result := clBtnFace;
    scButtonHot: Result := clBtnFace;
    scButtonNormal: Result := clBtnFace;
    scButtonPressed: Result := clBtnFace;
    scCategoryButtons: Result := clBtnFace;
    scCategoryButtonsGradientBase: Result := $C0C0C0;
    scCategoryButtonsGradientEnd: Result := $F0F0F0;
    scCategoryPanelGroup: Result := clMedGray;
    scComboBox: Result := clWindow;
    scComboBoxDisabled: Result := clWindow;
    scEdit: Result := clWindow;
    scEditDisabled: Result := clWindow;
    scGrid: Result := clWindow;
    scGenericBackground: Result := clBtnFace;
    scGenericGradientEnd: Result := $C0C0C0;
    scGenericGradientBase: Result := $F0F0F0;
    scHintGradientBase: Result := clInfoBk;
    scHintGradientEnd: Result := clInfoBk;
    scListBox: Result := clWindow;
    scListBoxDisabled: Result := clWindow;
    scListView: Result := clWindow;
    scPanel: Result := clBtnFace;
    scPanelDisabled: Result := clBtnFace;
    scSplitter: Result := clWhite;
    scToolBarGradientBase: Result := $C0C0C0;
    scToolBarGradientEnd: Result := $F0F0F0;
    scTreeView: Result := clWindow;
    scWindow: Result := clBtnFace;
  else
    Result := clNone;
  end;
end;

function TUxThemeStyle.DoGetStyleFontColor(Font: TStyleFont): TColor;

  function GetColor(Details: TThemedElementDetails; Default: TColor): TColor;
  begin
    if not GetElementColor(Details, ecTextColor, Result) then
      Result := Default;
  end;

begin
  case Font of
    sfButtonTextDisabled: Result := GetColor(GetElementDetails(tbPushButtonDisabled), clGrayText);
    sfButtonTextFocused: Result := GetColor(GetElementDetails(tbPushButtonHot), clBtnText);
    sfButtonTextHot: Result := GetColor(GetElementDetails(tbPushButtonHot), clBtntext);
    sfButtonTextNormal: Result := GetColor(GetElementDetails(tbPushButtonNormal), clBtnText);
    sfButtonTextPressed: Result := GetColor(GetElementDetails(tbPushButtonPressed), clBtnText);
    sfCaptionTextInactive: Result := GetColor(GetElementDetails(twCaptionInactive), clInactiveCaptionText);
    sfCaptionTextNormal: Result := GetColor(GetElementDetails(twCaptionActive), clCaptionText);
    sfCategoryPanelGroupHeaderHot: Result := clWindowText;
    sfCategoryPanelGroupHeaderNormal: Result := clWindowText;
    sfCatgeoryButtonsCategoryNormal: Result := clWindowText;
    sfCatgeoryButtonsCategorySelected: Result := clWindowText;
    sfCatgeoryButtonsHot: Result := clWindowText;
    sfCatgeoryButtonsNormal: Result := clWindowText;
    sfCatgeoryButtonsSelected: Result := clWindowText;
    sfCheckBoxTextDisabled: Result := GetColor(GetElementDetails(tbCheckBoxUncheckedDisabled), clWindowText);
    sfCheckBoxTextFocused: Result := GetColor(GetElementDetails(tbCheckBoxUncheckedHot), clWindowText);
    sfCheckBoxTextHot: Result := GetColor(GetElementDetails(tbCheckBoxUncheckedHot), clWindowText);
    sfCheckBoxTextNormal: Result := GetColor(GetElementDetails(tbCheckBoxUncheckedNormal), clWindowText);
    sfCheckBoxTextPressed: Result := GetColor(GetElementDetails(tbCheckBoxUncheckedPressed), clWindowText);
    sfComboBoxItemDisabled,
    sfEditBoxTextDisabled: Result := GetColor(GetElementDetails(teEditTextDisabled), clGrayText);
    sfComboBoxItemFocused,
    sfEditBoxTextFocused: Result := GetColor(GetElementDetails(teEditTextFocused), clWindowText);
    sfComboBoxItemHot,
    sfEditBoxTextHot: Result := GetColor(GetElementDetails(teEditTextHot), clWindowText);
    sfComboBoxItemNormal,
    sfEditBoxTextNormal: Result := GetColor(GetElementDetails(teEditTextNormal), clWindowText);
    sfComboBoxItemSelected,
    sfEditBoxTextSelected: Result := GetColor(GetElementDetails(teEditTextSelected), clWindowText);
    sfGridItemFixedHot: Result := clWindowText;
    sfGridItemFixedNormal: Result := clWindowText;
    sfGridItemFixedPressed: Result := clWindowText;
    sfGridItemNormal: Result := clWindowText;
    sfGridItemSelected: Result := clWindowText;
    sfGroupBoxTextDisabled: Result := GetColor(GetElementDetails(tbGroupBoxDisabled), clWindowText);
    sfGroupBoxTextNormal: Result := GetColor(GetElementDetails(tbGroupBoxNormal), clWindowText);
    sfHeaderSectionTextDisabled: Result := GetColor(GetElementDetails(thHeaderItemNormal), clWindowText);
    sfHeaderSectionTextHot: Result := GetColor(GetElementDetails(thHeaderItemHot), clWindowText);
    sfHeaderSectionTextNormal: Result := GetColor(GetElementDetails(thHeaderItemNormal), clWindowText);
    sfHeaderSectionTextPressed: Result := GetColor(GetElementDetails(thHeaderItemPressed), clWindowText);
    sfListItemTextDisabled: Result := GetColor(GetElementDetails(tlListItemDisabled), clGrayText);
    sfListItemTextFocused: Result := GetColor(GetElementDetails(tlListItemHot), clWindowText);
    sfListItemTextHot: Result := GetColor(GetElementDetails(tlListItemHot), clWindowText);
    sfListItemTextNormal: Result := GetColor(GetElementDetails(tlListItemNormal), clWindowText);
    sfListItemTextSelected: Result := GetColor(GetElementDetails(tlListItemSelected), clWindowText);
    sfMenuItemTextDisabled: Result := GetColor(GetElementDetails(tmMenuBarItemDisabled), clGrayText);
    sfMenuItemTextHot: Result := GetColor(GetElementDetails(tmMenuBarItemHot), clWindowText);
    sfMenuItemTextNormal: Result := GetColor(GetElementDetails(tmMenuBarItemNormal), clWindowText);
    sfMenuItemTextSelected: Result := GetColor(GetElementDetails(tmMenuBarItemPushed), clWindowText);
    sfPanelTextDisabled: Result := clWindowText;
    sfPanelTextNormal: Result := clWindowText;
    sfPopupMenuItemTextDisabled: Result := GetColor(GetElementDetails(tmPopupItemDisabled), clGrayText);
    sfPopupMenuItemTextHot: Result := GetColor(GetElementDetails(tmPopupItemHot), clWindowText);
    sfPopupMenuItemTextNormal: Result := GetColor(GetElementDetails(tmPopupItemNormal), clWindowText);
    sfPopupMenuItemTextSelected: Result := GetColor(GetElementDetails(tmPopupItemHot), clWindowText);
    sfRadioButtonTextDisabled: Result := GetColor(GetElementDetails(tbRadioButtonUncheckedDisabled), clGrayText);
    sfRadioButtonTextFocused: Result := GetColor(GetElementDetails(tbRadioButtonUncheckedHot), clWindowText);
    sfRadioButtonTextHot: Result := GetColor(GetElementDetails(tbRadioButtonUncheckedHot), clWindowText);
    sfRadioButtonTextNormal: Result := GetColor(GetElementDetails(tbRadioButtonUncheckedNormal), clWindowText);
    sfRadioButtonTextPressed: Result := GetColor(GetElementDetails(tbRadioButtonUncheckedPressed), clWindowText);
    sfSmCaptionTextInactive: Result := GetColor(GetElementDetails(twSmallCaptionInactive), clInactiveCaption);
    sfSmCaptionTextNormal: Result := GetColor(GetElementDetails(twSmallCaptionActive), clActiveCaption);
    sfStatusPanelTextDisabled: Result := clWindowText;
    sfStatusPanelTextNormal: Result := clWindowText;
    sfTabTextInactiveDisabled,
    sfTabTextActiveDisabled: Result := GetColor(GetElementDetails(ttTabItemDisabled), clWindowText);
    sfTabTextInactiveHot,
    sfTabTextActiveHot: Result := GetColor(GetElementDetails(ttTabItemHot), clWindowText);
    sfTabTextInactiveNormal,
    sfTabTextActiveNormal: Result := GetColor(GetElementDetails(ttTabItemNormal), clWindowText);
    sfTextLabelDisabled: Result := clGrayText;
    sfTextLabelFocused: Result := clWindowText;
    sfTextLabelHot: Result := clWindowText;
    sfTextLabelNormal: Result := clWindowText;
    sfToolItemTextDisabled: Result := GetColor(GetElementDetails(ttbButtonDisabled), clGrayText);
    sfToolItemTextHot: Result := GetColor(GetElementDetails(ttbButtonHot), clWindowText);
    sfToolItemTextNormal: Result := GetColor(GetElementDetails(ttbButtonNormal), clWindowText);
    sfToolItemTextSelected: Result := GetColor(GetElementDetails(ttbButtonPressed), clWindowText);
    sfTreeItemTextDisabled: Result := GetColor(GetElementDetails(ttItemDisabled), clGrayText);
    sfTreeItemTextFocused: Result := GetColor(GetElementDetails(ttItemSelected), clWindowText);
    sfTreeItemTextHot: Result := GetColor(GetElementDetails(ttItemHot), clWindowText);
    sfTreeItemTextNormal: Result := GetColor(GetElementDetails(ttItemNormal), clWindowText);
    sfTreeItemTextSelected: Result := GetColor(GetElementDetails(ttItemSelected), clWindowText);
    sfWindowTextDisabled: Result := clGrayText;
    sfWindowTextNormal: Result := clWindowText;
  else
    Result := clNone;
  end;
end;

function TUxThemeStyle.DoGetSystemColor(Color: TColor): TColor;
begin
  Result := Color;
end;

function TUxThemeStyle.DoGetTextExtent(DC: HDC; Details: TThemedElementDetails;
  const Text: string; Flags: TTextFormat; BoundingRect: PRect; out ExtentRect: TRect): Boolean;
begin
  if Details.Element in CVCLElements then
    Result := FCustomElements[Details.Element].GetTextExtent(Self,
      DC, Details.Part, Details.State, Text, Flags, BoundingRect, ExtentRect)
  else
    Result := GetThemeTextExtent(Theme[Details.Element], DC, Details.Part,
      Details.State, PChar(Text), Length(Text), TTextFormatFlags(Flags), BoundingRect, ExtentRect) = S_OK;
end;

function TUxThemeStyle.DoHasTransparentParts(Details: TThemedElementDetails): Boolean;
begin
  if Details.Element in CVCLElements then
    Result := FCustomElements[Details.Element].HasTransparentParts(Self,
      Details.Part, Details.State)
  else
    Result := IsThemeBackgroundPartiallyTransparent(Theme[Details.Element], Details.Part, Details.State);
end;

function TUxThemeStyle.DoHasElementFixedPosition(Details: TThemedElementDetails): Boolean;
begin
  Result := False;
end;

class function TUxThemeStyle.DoIsValidStyle(Stream: TStream; StyleInfo: PStyleInfo): Boolean;
begin
  Result := True;
  if StyleInfo <> nil then
  begin
    StyleInfo.Name := 'Windows';
    StyleInfo.Author := '';
    StyleInfo.AuthorEMail := '';
    StyleInfo.AuthorURL := '';
    StyleInfo.Version := '';
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedListView): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teListView;
  with Result do
  begin
    case Detail of
      tlListItemNormal..tlListItemLast:
        begin
          Part := LVP_LISTITEM;
          Base := Ord(tlListItemNormal);
        end;
      tlListGroup..tlListGroupLast:
        begin
          Part := LVP_LISTGROUP;
          Base := Ord(tlListGroup);
        end;
      tlListDetail..tlListDetailLast:
        begin
          Part := LVP_LISTDETAIL;
          Base := Ord(tlListDetail);
        end;
      tlListSortDetail..tlListSortDetailLast:
        begin
          Part := LVP_LISTSORTEDDETAIL;
          Base := Ord(tlListSortDetail);
        end;
      tlEmptyText..tlEmptyTextLast:
        begin
          Part := LVP_EMPTYTEXT;
          Base := Ord(tlEmptyText);
        end;
      // Windows Vista or later
      tlGroupHeaderOpen..tlGroupHeaderLast:
        begin
          Part := LVP_GROUPHEADER;
          Base := Ord(tlGroupHeaderOpen);
        end;
      tlGroupHeaderLineOpen..tlGroupHeaderLineLast:
        begin
          Part := LVP_GROUPHEADERLINE;
          Base := Ord(tlGroupHeaderLineOpen);
        end;
      tlExpandButtonNormal..tlExpandButtonLast:
        begin
          Part := LVP_EXPANDBUTTON;
          Base := Ord(tlExpandButtonNormal);
        end;
      tlCollapseButtonNormal..tlCollapseButtonLast:
        begin
          Part := LVP_COLLAPSEBUTTON;
          Base := Ord(tlCollapseButtonNormal);
        end;
      tlColumnDetail..tlColumnDetailLast:
        begin
          Part := LVP_COLUMNDETAIL;
          Base := Ord(tlColumnDetail);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedLink): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teLink;
  with Result do
  begin
    case Detail of
      tlLinkNormal..tlLinkLast:
        begin
          Part := LP_HYPERLINK;
          Base := Ord(tlLinkNormal);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;


function TUxThemeStyle.GetElementDetails(Detail: TThemedHeader): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teHeader;
  with Result do
  begin
    case Detail of
      thHeaderItemNormal..thHeaderItemLast:
        begin
          Part := HP_HEADERITEM;
          Base := Ord(thHeaderItemNormal);
        end;
      thHeaderItemLeftNormal..thHeaderItemLeftLast:
        begin
          Part := HP_HEADERITEMLEFT;
          Base := Ord(thHeaderItemLeftNormal);
        end;
      thHeaderItemRightNormal..thHeaderItemRightLast:
        begin
          Part := HP_HEADERITEMRIGHT;
          Base := Ord(thHeaderItemRightNormal);
        end;
      thHeaderSortArrowSortedUp..thHeaderSortArrowLast:
        begin
          Part := HP_HEADERSORTARROW;
          Base := Ord(thHeaderSortArrowSortedUp);
        end;
      // Windows Vista or later
      thHeaderDropDownNormal..thHeaderDropDownLast:
        begin
          Part := HP_HEADERDROPDOWN;
          Base := Ord(thHeaderDropDownNormal);
        end;
      thHeaderDropDownFilterNormal..thHeaderDropDownFilterLast:
        begin
          Part := HP_HEADERDROPDOWNFILTER;
          Base := Ord(thHeaderDropDownFilterNormal);
        end;
      thHeaderOverflowNormal..thHeaderOverflowLast:
        begin
          Part := HP_HEADEROVERFLOW;
          Base := Ord(thHeaderOverflowNormal);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedMenu): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teMenu;
  with Result do
  begin
    case Detail of
      tmMenuItemNormal..tmMenuItemTMSSchemaLast:
        begin
          Part := MENU_MENUITEM_TMSCHEMA;
          Base := Ord(tmMenuItemNormal);
        end;
      tmMenuDropDown..tmMenuDropDownTMSSchemaLast:
        begin
          Part := MENU_MENUDROPDOWN_TMSCHEMA;
          Base := Ord(tmMenuDropDown);
        end;
      tmMenuBarItem..tmMenuBarItemTMSSchemaLast:
        begin
          Part := MENU_MENUBARITEM_TMSCHEMA;
          Base := Ord(tmMenuBarItem);
        end;
      tmMenuBarDropDown..tmMenuBarDropDownTMSSchemaLast:
        begin
          Part := MENU_MENUBARDROPDOWN_TMSCHEMA;
          Base := Ord(tmMenuBarDropDown);
        end;
      tmChevron..tmChevronTMSSchemaLast:
        begin
          Part := MENU_CHEVRON_TMSCHEMA;
          Base := Ord(tmChevron);
        end;
      tmSeparator..tmSeparatorTMSSchemaLast:
        begin
          Part := MENU_SEPARATOR_TMSCHEMA;
          Base := Ord(tmSeparator);
        end;
      // Windows Vista or later
      tmMenuBarBackgroundActive..tmMenuBarBackgroundLast:
        begin
          Part := MENU_BARBACKGROUND;
          Base := Ord(tmMenuBarBackgroundActive);
        end;
      tmMenuBarItemNormal..tmMenuBarItemLast:
        begin
          Part := MENU_BARITEM;
          Base := Ord(tmMenuBarItemNormal);
        end;
      tmPopupBackground..tmPopupBackgroundLast:
        begin
          Part := MENU_POPUPBACKGROUND;
          Base := Ord(tmPopupBackground);
        end;
      tmPopupBorders..tmPopupBordersLast:
        begin
          Part := MENU_POPUPBORDERS;
          Base := Ord(tmPopupBorders);
        end;
      tmPopupCheckNormal..tmPopupCheckLast:
        begin
          Part := MENU_POPUPCHECK;
          Base := Ord(tmPopupCheckNormal);
        end;
      tmPopupCheckBackgroundDisabled..tmPopupCheckBackgroundLast:
        begin
          Part := MENU_POPUPCHECKBACKGROUND;
          Base := Ord(tmPopupCheckBackgroundDisabled);
        end;
      tmPopupGutter..tmPopupGutterLast:
        begin
          Part := MENU_POPUPGUTTER;
          Base := Ord(tmPopupGutter);
        end;
      tmPopupItemNormal..tmPopupItemLast:
        begin
          Part := MENU_POPUPITEM;
          Base := Ord(tmPopupItemNormal);
        end;
      tmPopupSeparator..tmPopupSeparatorLast:
        begin
          Part := MENU_POPUPSEPARATOR;
          Base := Ord(tmPopupSeparator);
        end;
      tmPopupSubMenuNormal..tmPopupSubMenuLast:
        begin
          Part := MENU_POPUPSUBMENU;
          Base := Ord(tmPopupSubMenuNormal);
        end;
      tmSystemCloseNormal, tmSystemCloseLast:
        begin
          Part := MENU_SYSTEMCLOSE;
          Base := Ord(tmSystemCloseNormal);
        end;
      tmSystemMaximizeNormal, tmSystemMaximizeLast:
        begin
          Part := MENU_SYSTEMMAXIMIZE;
          Base := Ord(tmSystemMaximizeNormal);
        end;
      tmSystemMinimizeNormal, tmSystemMinimizeLast:
        begin
          Part := MENU_SYSTEMMINIMIZE;
          Base := Ord(tmSystemMinimizeNormal);
        end;
      tmSystemRestoreNormal, tmSystemRestoreLast:
        begin
          Part := MENU_SYSTEMRESTORE;
          Base := Ord(tmSystemRestoreNormal);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedMenuBand): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teMenuBand;
  with Result do
  begin
    case Detail of
      tmbNewAppButtonNormal..tmbNewAppButtonLast:
        begin
          Part := MDP_NEWAPPBUTTON;
          Base := Ord(tmbNewAppButtonNormal);
        end;
      tmbSeparatorNormal..tmbSeparatorLast:
        begin
          Part := MDP_SEPERATOR;
          Base := Ord(tmbSeparatorNormal);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedMonthCal): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teMonthCal;
  with Result do
  begin
    case Detail of
      tmcBackground..tmcBackgroundLast:
        begin
          Part := MC_BACKGROUND;
          Base := Ord(tmcBackground);
        end;
      tmcBorders..tmcBordersLast:
        begin
          Part := MC_BORDERS;
          Base := Ord(tmcBorders);
        end;
      tmcGridBackground..tmcGridBackgroundLast:
        begin
          Part := MC_GRIDBACKGROUND;
          Base := Ord(tmcGridBackground);
        end;
      tmcColHeaderSplitter..tmcColHeaderSplitterLast:
        begin
          Part := MC_COLHEADERSPLITTER;
          Base := Ord(tmcColHeaderSplitter);
        end;
      tmcGridCellBackgroundSelected..tmcGridCellBackgroundLast:
        begin
          Part := MC_GRIDCELLBACKGROUND;
          Base := Ord(tmcGridCellBackgroundSelected);
        end;
      tmcGridCellHot..tmcGridCellLast:
        begin
          Part := MC_GRIDCELL;
          Base := Ord(tmcGridCellHot);
        end;
      tmcGridCellUpperHot..tmcGridCellUpperLast:
        begin
          Part := MC_GRIDCELLUPPER;
          Base := Ord(tmcGridCellUpperHot);
        end;
      tmcTrailingGridCellHot..tmcTrailingGridCellLast:
        begin
          Part := MC_TRAILINGGRIDCELL;
          Base := Ord(tmcTrailingGridCellHot);
        end;
      tmcTrailingGridCellUpperHot..tmcTrailingGridCellUpperLast:
        begin
          Part := MC_TRAILINGGRIDCELLUPPER;
          Base := Ord(tmcTrailingGridCellUpperHot);
        end;
      tmcNavNextNormal..tmcNavNextLast:
        begin
          Part := MC_NAVNEXT;
          Base := Ord(tmcNavNextNormal);
        end;
      tmcNavPrevNormal..tmcNavPrevLast:
        begin
          Part := MC_NAVPREV;
          Base := Ord(tmcNavPrevNormal);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedNavigation): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teNavigation;
  with Result do
  begin
    case Detail of
      tnBackButtonNormal..tnBackButtonLast:
        begin
          Part := NAV_BACKBUTTON;
          Base := Ord(tnBackButtonNormal);
        end;
      tnForwardButtonNormal..tnForwardButtonLast:
        begin
          Part := NAV_FORWARDBUTTON;
          Base := Ord(tnForwardButtonNormal);
        end;
      tnMenuButtonNormal..tnMenuButtonLast:
        begin
          Part := NAV_MENUBUTTON;
          Base := Ord(tnMenuButtonNormal);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedProgress): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teProgress;
  with Result do
  begin
    case Detail of
      tpBar:
        begin
          Part := PP_BAR;
          Base := Ord(tpBar);
        end;
      tpBarVert:
        begin
          Part := PP_BARVERT;
          Base := Ord(tpBarVert);
        end;
      tpChunk:
        begin
          Part := PP_CHUNK;
          Base := Ord(tpChunk);
        end;
      tpChunkVert:
        begin
          Part := PP_CHUNKVERT;
          Base := Ord(tpChunkVert);
        end;
      // Windows Vista or later
      tpFill:
        begin
          Part := PP_FILL;
          Base := Ord(tpFill);
        end;
      tpFillVert:
        begin
          Part := PP_FILLVERT;
          Base := Ord(tpFillVert);
        end;
      tpPulseOverlay:
        begin
          Part := PP_PULSEOVERLAY;
          Base := Ord(tpPulseOverlay);
        end;
      tpMoveOverlay:
        begin
          Part := PP_MOVEOVERLAY;
          Base := Ord(tpMoveOverlay);
        end;
      tpPulseOverlayVert:
        begin
          Part := PP_PULSEOVERLAYVERT;
          Base := Ord(tpPulseOverlayVert);
        end;
      tpMoveOverlayVert:
        begin
          Part := PP_MOVEOVERLAYVERT;
          Base := Ord(tpMoveOverlayVert);
        end;
      tpTransparentBarNormal..tpTransparentBarPartial:
        begin
          Part := PP_TRANSPARENTBAR;
          Base := Ord(tpTransparentBarNormal);
        end;
      tpTransparentBarVertNormal..tpTransparentBarVertPartial:
        begin
          Part := PP_TRANSPARENTBARVERT;
          Base := Ord(tpTransparentBarVertNormal);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedPage): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := tePage;
  with Result do
  begin
    case Detail of
      tpUpNormal..tpUpDisabled:
        begin
          Part := PGRP_UP;
          Base := Ord(tpUpNormal);
        end;
      tpDownNormal..tpDownDisabled:
        begin
          Part := PGRP_DOWN;
          Base := Ord(tpDownNormal);
        end;
      tpUpHorzNormal..tpUpHorzDisabled:
        begin
          Part := PGRP_UPHORZ;
          Base := Ord(tpUpHorzNormal);
        end;
      tpDownHorzNormal..tpDownHorzDisabled:
        begin
          Part := PGRP_DOWNHORZ;
          Base := Ord(tpDownHorzNormal);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedClock): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teClock;
  with Result do
  begin
    case Detail of
      tcTimeNormal..tcTimePressed:
        begin
          Part := CLP_TIME;
          Base := Ord(tcTimeNormal);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedButton): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teButton;
  with Result do
  begin
    case Detail of
      tbPushButtonNormal..tbPushButtonLast:
        begin
          Part := BP_PUSHBUTTON;
          Base := Ord(tbPushButtonNormal);
        end;
      tbRadioButtonUncheckedNormal..tbRadioButtonLast:
        begin
          Part := BP_RADIOBUTTON;
          Base := Ord(tbRadioButtonUncheckedNormal);
        end;
      tbCheckBoxUncheckedNormal..tbCheckBoxLast:
        begin
          Part := BP_CHECKBOX;
          Base := Ord(tbCheckBoxUncheckedNormal);
        end;
      tbGroupBoxNormal..tbGroupBoxLast:
        begin
          Part := BP_GROUPBOX;
          Base := Ord(tbGroupBoxNormal);
        end;
      tbUserButton..tbUserButtonLast:
        begin
          Part := BP_USERBUTTON;
          Base := Ord(tbUserButton);
        end;
      // Windows Vista or later
      tbCommandLinkNormal..tbCommandLinkLast:
        begin
          Part := BP_COMMANDLINK;
          Base := Ord(tbCommandLinkNormal);
        end;
      tbCommandLinkGlyphNormal..tbCommandLinkGlyphLast:
        begin
          Part := BP_COMMANDLINKGLYPH;
          Base := Ord(tbCommandLinkGlyphNormal);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedComboBox): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teComboBox;
  with Result do
  begin
    case Detail of
      tcDropDownButtonNormal..tcDropDownButtonLast:
        begin
          Part := CP_DROPDOWNBUTTON;
          Base := Ord(tcDropDownButtonNormal);
        end;
      // Windows Vista or later
      tcBackground..tcBackgroundLast:
        begin
          Part := CP_BACKGROUND;
          Base := Ord(tcBackground);
        end;
      tcTransparentBackgroundNormal..tcTransparentBackgroundLast:
        begin
          Part := CP_TRANSPARENTBACKGROUND;
          Base := Ord(tcTransparentBackgroundNormal);
        end;
      tcBorderNormal..tcBorderLast:
        begin
          Part := CP_BORDER;
          Base := Ord(tcBorderNormal);
        end;
      tcReadOnlyNormal..tcReadOnlyLast:
        begin
          Part := CP_READONLY;
          Base := Ord(tcReadOnlyNormal);
        end;
      tcDropDownButtonRightNormal..tcDropDownButtonRightLast:
        begin
          Part := CP_DROPDOWNBUTTONRIGHT;
          Base := Ord(tcDropDownButtonRightNormal);
        end;
      tcDropDownButtonLeftNormal..tcDropDownButtonLeftLast:
        begin
          Part := CP_DROPDOWNBUTTONLEFT;
          Base := Ord(tcDropDownButtonLeftNormal);
        end;
      tcCueBannerNormal..tcCueBannerLast:
        begin
          Part := CP_CUEBANNER;
          Base := Ord(tcCueBannerNormal);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedDataNavButtons): TThemedElementDetails;
begin
  Result.Element := teDataNavButtons;
  Result.Part := 0;
  Result.State := Ord(Detail);
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedDatePicker): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teDatePicker;
  with Result do
  begin
    case Detail of
      tdbDateTextNormal..tdbDateTextLast:
        begin
          Part := DP_DATETEXT;
          Base := Ord(tdbDateTextNormal);
        end;
      tdbDateBorderNormal..tdbDateBorderLast:
        begin
          Part := DP_DATEBORDER;
          Base := Ord(tdbDateBorderNormal);
        end;
      tdbShowCalendarButtonRightNormal..tdbShowCalendarButtonRightLast:
        begin
          Part := DP_SHOWCALENDARBUTTONRIGHT;
          Base := Ord(tdbShowCalendarButtonRightNormal);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedExplorerBar): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teExplorerBar;
  with Result do
  begin
    case Detail of
      tebHeaderBackgroundNormal..tebHeaderBackgroundLast:
        begin
          Part := EBP_HEADERBACKGROUND;
          Base := Ord(tebHeaderBackgroundNormal);
        end;
      tebHeaderCloseNormal..tebHeaderCloseLast:
        begin
          Part := EBP_HEADERCLOSE;
          Base := Ord(tebHeaderCloseNormal);
        end;
      tebHeaderPinNormal..tebHeaderPinSelectedLast:
        begin
          Part := EBP_HEADERPIN;
          Base := Ord(tebHeaderPinSelectedNormal);
        end;
      tebIEBarMenuNormal..tebIEBarMenuLast:
        begin
          Part := EBP_IEBARMENU;
          Base := Ord(tebIEBarMenuNormal);
        end;
      tebNormalGroupBackground..tebNormalGroupBackgroundLast:
        begin
          Part := EBP_NORMALGROUPBACKGROUND;
          Base := Ord(tebNormalGroupBackground);
        end;
      tebNormalGroupCollapseNormal..tebNormalGroupCollapseLast:
        begin
          Part := EBP_NORMALGROUPCOLLAPSE;
          Base := Ord(tebNormalGroupCollapseNormal);
        end;
      tebNormalGroupExpandNormal..tebNormalGroupExpandLast:
        begin
          Part := EBP_NORMALGROUPEXPAND;
          Base := Ord(tebNormalGroupExpandNormal);
        end;
      tebNormalGroupHead..tebNormalGroupHeadLast:
        begin
          Part := EBP_NORMALGROUPHEAD;
          Base := Ord(tebNormalGroupHead);
        end;
      tebSpecialGroupBackground..tebSpecialGroupBackgroundLast:
        begin
          Part := EBP_SPECIALGROUPBACKGROUND;
          Base := Ord(tebSpecialGroupBackground);
        end;
      tebSpecialGroupCollapseNormal..tebSpecialGroupCollapseLast:
        begin
          Part := EBP_SPECIALGROUPCOLLAPSE;
          Base := Ord(tebSpecialGroupCollapseNormal);
        end;
      tebSpecialGroupExpandNormal..tebSpecialGroupExpandLast:
        begin
          Part := EBP_SPECIALGROUPEXPAND;
          Base := Ord(tebSpecialGroupExpandNormal);
        end;
      tebSpecialGroupHead..tebSpecialGroupHeadLast:
        begin
          Part := EBP_SPECIALGROUPHEAD;
          Base := Ord(tebSpecialGroupHead);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedEdit): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teEdit;
  with Result do
  begin
    case Detail of
      teEditTextNormal..teEditTextLast:
        begin
          Part := EP_EDITTEXT;
          Base := Ord(teEditTextNormal);
        end;
      teEditCaret..teEditCaretLast:
        begin
          Part := EP_CARET;
          Base := Ord(teEditCaret);
        end;
      // Windows Vista or later
      teBackgroundNormal..teBackgroundLast:
        begin
          Part := EP_BACKGROUND;
          Base := Ord(teBackgroundNormal);
        end;
      tePassword..tePasswordLast:
        begin
          Part := EP_PASSWORD;
          Base := Ord(tePassword);
        end;
      teBackgroundWithBorderNormal..teBackgroundWithBorderLast:
        begin
          Part := EP_BACKGROUNDWITHBORDER;
          Base := Ord(teBackgroundWithBorderNormal);
        end;
      teEditBorderNoScrollNormal..teEditBorderNoScrollLast:
        begin
          Part := EP_EDITBORDER_NOSCROLL;
          Base := Ord(teEditBorderNoScrollNormal);
        end;
      teEditBorderHScrollNormal..teEditBorderHScrollLast:
        begin
          Part := EP_EDITBORDER_HSCROLL;
          Base := Ord(teEditBorderHScrollNormal);
        end;
      teEditBorderVScrollNormal..teEditBorderVScrollLast:
        begin
          Part := EP_EDITBORDER_VSCROLL;
          Base := Ord(teEditBorderVScrollNormal);
        end;
      teEditBorderHVScrollNormal..teEditBorderHVScrollLast:
        begin
          Part := EP_EDITBORDER_HVSCROLL;
          Base := Ord(teEditBorderHVScrollNormal);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedFlyOut): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teFlyOut;
  with Result do
  begin
    case Detail of
      tfFlyOutHeader..tfFlyOutHeaderLast:
        begin
          Part := FLYOUT_HEADER;
          Base := Ord(tfFlyOutHeader);
        end;
      tfFlyOutBodyNormal..tfFlyOutBodyLast:
        begin
          Part := FLYOUT_BODY;
          Base := Ord(tfFlyOutBodyNormal);
        end;
      tfFlyOutLabelNormal..tfFlyOutLabelLast:
        begin
          Part := FLYOUT_LABEL;
          Base := Ord(tfFlyOutLabelNormal);
        end;
      tfFlyOutLinkNormal..tfFlyOutLinkLast:
        begin
          Part := FLYOUT_LINK;
          Base := Ord(tfFlyOutLinkNormal);
        end;
      tfFlyOutDivider..tfFlyOutDividerLast:
        begin
          Part := FLYOUT_DIVIDER;
          Base := Ord(tfFlyOutDivider);
        end;
      tfFlyOutWindow..tfFlyOutWindowLast:
        begin
          Part := FLYOUT_WINDOW;
          Base := Ord(tfFlyOutWindow);
        end;
      tfFlyOutLinkArea..tfFlyOutLinkAreaLast:
        begin
          Part := FLYOUT_LINKAREA;
          Base := Ord(tfFlyOutLinkArea);
        end;
      tfFlyOutLinkHeaderNormal..tfFlyOutLinkHeaderLast:
        begin
          Part := FLYOUT_LINKHEADER;
          Base := Ord(tfFlyOutLinkHeaderNormal);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedRebar): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teRebar;
  with Result do
  begin
    case Detail of
      trGripper:
        begin
          Part := RP_GRIPPER;
          Base := Ord(trGripper);
        end;
      trGripperVert:
        begin
          Part := RP_GRIPPERVERT;
          Base := Ord(trGripperVert);
        end;
      trBand:
        begin
          Part := RP_BAND;
          Base := Ord(trBand);
        end;
      trChevronNormal..trChevronPressed:
        begin
          Part := RP_CHEVRON;
          Base := Ord(trChevronNormal);
        end;
      trChevronVertNormal..trChevronVertPressed:
        begin
          Part := RP_CHEVRONVERT;
          Base := Ord(trChevronVertNormal);
        end;
      // Windows Vista or later
      trBackground:
        begin
          Part := RP_BACKGROUND;
          Base := Ord(trBackground);
        end;
      trSplitterNormal..trSplitterPressed:
        begin
          Part := RP_SPLITTER;
          Base := Ord(trSplitterNormal);
        end;
      trSlipperVertNormal..trSlipperVertPressed:
        begin
          Part := RP_SPLITTERVERT;
          Base := Ord(trSlipperVertNormal);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedTrackBar): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teTrackBar;
  with Result do
  begin
    case Detail of
      ttbTrack:
        begin
          Part := TKP_TRACK;
          Base := Ord(ttbTrack);
        end;
      ttbTrackVert:
        begin
          Part := TKP_TRACKVERT;
          Base := Ord(ttbTrackVert);
        end;
      ttbThumbNormal..ttbThumbDisabled:
        begin
          Part := TKP_THUMB;
          Base := Ord(ttbThumbNormal);
        end;
      ttbThumbBottomNormal..ttbThumbBottomDisabled:
        begin
          Part := TKP_THUMBBOTTOM;
          Base := Ord(ttbThumbBottomNormal);
        end;
      ttbThumbTopNormal..ttbThumbTopDisabled:
        begin
          Part := TKP_THUMBTOP;
          Base := Ord(ttbThumbTopNormal);
        end;
      ttbThumbVertNormal..ttbThumbVertDisabled:
        begin
          Part := TKP_THUMBVERT;
          Base := Ord(ttbThumbVertNormal);
        end;
      ttbThumbLeftNormal..ttbThumbLeftDisabled:
        begin
          Part := TKP_THUMBLEFT;
          Base := Ord(ttbThumbLeftNormal);
        end;
      ttbThumbRightNormal..ttbThumbRightDisabled:
        begin
          Part := TKP_THUMBRIGHT;
          Base := Ord(ttbThumbRightNormal);
        end;
      ttbThumbTics:
        begin
          Part := TKP_TICS;
          Base := Ord(ttbThumbTics);
        end;
      ttbThumbTicsVert:
        begin
          Part := TKP_TICSVERT;
          Base := Ord(ttbThumbTicsVert);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedToolTip): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teToolTip;
  with Result do
  begin
    case Detail of
      tttStandardNormal..tttStandardLink:
        begin
          Part := TTP_STANDARD;
          Base := Ord(tttStandardNormal);
        end;
      tttStandardTitleNormal..tttStandardTitleLink:
        begin
          Part := TTP_STANDARDTITLE;
          Base := Ord(tttStandardTitleNormal);
        end;
      tttBaloonNormal..tttBaloonLink:
        begin
          Part := TTP_BALLOON;
          Base := Ord(tttBaloonNormal);
        end;
      tttBaloonTitleNormal..tttBaloonTitleLink:
        begin
          Part := TTP_BALLOONTITLE;
          Base := Ord(tttBaloonTitleNormal);
        end;
      tttBaloonStemUpLeft:
        begin
          Part := TTP_BALLOONSTEM;
          Base := TTBSS_POINTINGUPLEFTWALL;
        end;
      tttBaloonStemDownLeft:
        begin
          Part := TTP_BALLOONSTEM;
          Base := TTBSS_POINTINGDOWNLEFTWALL;
        end;
      tttCloseNormal..tttClosePressed:
        begin
          Part := TTP_CLOSE;
          Base := Ord(tttCloseNormal);
        end;
      // Windows Vista or later
      tttBalloonStemUpLeftWall..tttBalloonStemLeftWall:
        begin
          Part := TTP_BALLOONSTEM;
          Base := Ord(tttBalloonStemUpLeftWall);
        end;
      // Windows 7 or later
      tttWrenchNormal..tttWrenchPressed:
        begin
          Part := TTP_WRENCH;
          Base := Ord(tttWrenchNormal);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedToolBar): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teToolBar;
  with Result do
  begin
    case Detail of
      ttbButtonNormal..ttbButtonOtherSideHot:
        begin
          Part := TP_BUTTON;
          Base := Ord(ttbButtonNormal);
        end;
      ttbDropDownButtonNormal..ttbDropDownButtonOtherSideHot:
        begin
          Part := TP_DROPDOWNBUTTON;
          Base := Ord(ttbDropDownButtonNormal);
        end;
      ttbSplitButtonNormal..ttbSplitButtonOtherSideHot:
        begin
          Part := TP_SPLITBUTTON;
          Base := Ord(ttbSplitButtonNormal);
        end;
      ttbSplitButtonDropDownNormal..ttbSplitButtonDropDownOtherSideHot:
        begin
          Part := TP_SPLITBUTTONDROPDOWN;
          Base := Ord(ttbSplitButtonDropDownNormal);
        end;
      ttbSeparatorNormal..ttbSeparatorOtherSideHot:
        begin
          Part := TP_SEPARATOR;
          Base := Ord(ttbSeparatorNormal);
        end;
      ttbSeparatorVertNormal..ttbSeparatorVertOtherSideHot:
        begin
          Part := TP_SEPARATORVERT;
          Base := Ord(ttbSeparatorVertNormal);
        end;
      ttbDropDownButtonGlyphNormal..ttbDropDownButtonGlyphOtherSideHot:
        begin
          Part := TP_DROPDOWNBUTTONGLYPH;
          Base := Ord(ttbDropDownButtonGlyphNormal);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedWindow): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teWindow;
  with Result do
  begin
    case Detail of
      twCaptionActive..twCaptionDisabled:
        begin
          Part := WP_CAPTION;
          Base := Ord(twCaptionActive);
        end;
      twSmallCaptionActive..twSmallCaptionDisabled:
        begin
          Part := WP_SMALLCAPTION;
          Base := Ord(twSmallCaptionActive);
        end;
      twMinCaptionActive..twMinCaptionDisabled:
        begin
          Part := WP_MINCAPTION;
          Base := Ord(twMinCaptionActive);
        end;
      twSmallMinCaptionActive..twSmallMinCaptionDisabled:
        begin
          Part := WP_SMALLMINCAPTION;
          Base := Ord(twSmallMinCaptionActive);
        end;
      twMaxCaptionActive..twMaxCaptionDisabled:
        begin
          Part := WP_MAXCAPTION;
          Base := Ord(twMaxCaptionActive);
        end;
      twSmallMaxCaptionActive..twSmallMaxCaptionDisabled:
        begin
          Part := WP_SMALLMAXCAPTION;
          Base := Ord(twSmallMaxCaptionActive);
        end;
      twFrameLeftActive..twFrameLeftInactive:
        begin
          Part := WP_FRAMELEFT;
          Base := Ord(twFrameLeftActive);
        end;
      twFrameRightActive..twFrameRightInactive:
        begin
          Part := WP_FRAMERIGHT;
          Base := Ord(twFrameRightActive);
        end;
      twFrameBottomActive..twFrameBottomInactive:
        begin
          Part := WP_FRAMEBOTTOM;
          Base := Ord(twFrameBottomActive);
        end;
      twSmallFrameLeftActive..twSmallFrameLeftInactive:
        begin
          Part := WP_SMALLFRAMELEFT;
          Base := Ord(twSmallFrameLeftActive);
        end;
      twSmallFrameRightActive..twSmallFrameRightInactive:
        begin
          Part := WP_SMALLFRAMERIGHT;
          Base := Ord(twSmallFrameRightActive);
        end;
      twSmallFrameBottomActive..twSmallFrameBottomInactive:
        begin
          Part := WP_SMALLFRAMEBOTTOM;
          Base := Ord(twSmallFrameBottomActive);
        end;
      twSysButtonNormal..twSysButtonDisabled:
        begin
          Part := WP_SYSBUTTON;
          Base := Ord(twSysButtonNormal);
        end;
      twMDISysButtonNormal..twMDISysButtonDisabled:
        begin
          Part := WP_MDISYSBUTTON;
          Base := Ord(twMDISysButtonNormal);
        end;
      twMinButtonNormal..twMinButtonDisabled:
        begin
          Part := WP_MINBUTTON;
          Base := Ord(twMinButtonNormal);
        end;
      twMDIMinButtonNormal..twMDIMinButtonDisabled:
        begin
          Part := WP_MDIMINBUTTON;
          Base := Ord(twMDIMinButtonNormal);
        end;
      twMaxButtonNormal..twMaxButtonDisabled:
        begin
          Part := WP_MAXBUTTON;
          Base := Ord(twMaxButtonNormal);
        end;
      twCloseButtonNormal..twCloseButtonDisabled:
        begin
          Part := WP_CLOSEBUTTON;
          Base := Ord(twCloseButtonNormal);
        end;
      twSmallCloseButtonNormal..twSmallCloseButtonDisabled:
        begin
          Part := WP_SMALLCLOSEBUTTON;
          Base := Ord(twSmallCloseButtonNormal);
        end;
      twMDICloseButtonNormal..twMDICloseButtonDisabled:
        begin
          Part := WP_MDICLOSEBUTTON;
          Base := Ord(twMDICloseButtonNormal);
        end;
      twRestoreButtonNormal..twRestoreButtonDisabled:
        begin
          Part := WP_RESTOREBUTTON;
          Base := Ord(twRestoreButtonNormal);
        end;
      twMDIRestoreButtonNormal..twMDIRestoreButtonDisabled:
        begin
          Part := WP_MDIRESTOREBUTTON;
          Base := Ord(twMDIRestoreButtonNormal);
        end;
      twHelpButtonNormal..twHelpButtonDisabled:
        begin
          Part := WP_HELPBUTTON;
          Base := Ord(twHelpButtonNormal);
        end;
      twMDIHelpButtonNormal..twMDIHelpButtonDisabled:
        begin
          Part := WP_MDIHELPBUTTON;
          Base := Ord(twMDIHelpButtonNormal);
        end;
      twHorzScrollNormal..twHorzScrollDisabled:
        begin
          Part := WP_HORZSCROLL;
          Base := Ord(twHorzScrollNormal);
        end;
      twHorzThumbNormal..twHorzThumbDisabled:
        begin
          Part := WP_HORZTHUMB;
          Base := Ord(twHorzThumbNormal);
        end;
      twVertScrollNormal..twVertScrollDisabled:
        begin
          Part := WP_VERTSCROLL;
          Base := Ord(twVertScrollNormal);
        end;
      twVertThumbNormal..twVertThumbDisabled:
        begin
          Part := WP_VERTTHUMB;
          Base := Ord(twVertThumbNormal);
        end;
      twDialog:
        begin
          Part := WP_DIALOG;
          Base := Ord(twDialog);
        end;
      twCaptionSizingTemplate:
        begin
          Part := WP_CAPTIONSIZINGTEMPLATE;
          Base := Ord(twCaptionSizingTemplate);
        end;
      twSmallCaptionSizingTemplate:
        begin
          Part := WP_SMALLCAPTIONSIZINGTEMPLATE;
          Base := Ord(twSmallCaptionSizingTemplate);
        end;
      twFrameLeftSizingTemplate:
        begin
          Part := WP_FRAMELEFTSIZINGTEMPLATE;
          Base := Ord(twFrameLeftSizingTemplate);
        end;
      twSmallFrameLeftSizingTemplate:
        begin
          Part := WP_SMALLFRAMELEFTSIZINGTEMPLATE;
          Base := Ord(twSmallFrameLeftSizingTemplate);
        end;
      twFrameRightSizingTemplate:
        begin
          Part := WP_FRAMERIGHTSIZINGTEMPLATE;
          Base := Ord(twFrameRightSizingTemplate);
        end;
      twSmallFrameRightSizingTemplate:
        begin
          Part := WP_SMALLFRAMERIGHTSIZINGTEMPLATE;
          Base := Ord(twSmallFrameRightSizingTemplate);
        end;
      twFrameBottomSizingTemplate:
        begin
          Part := WP_FRAMEBOTTOMSIZINGTEMPLATE;
          Base := Ord(twFrameBottomSizingTemplate);
        end;
      twSmallFrameBottomSizingTemplate:
        begin
          Part := WP_SMALLFRAMEBOTTOMSIZINGTEMPLATE;
          Base := Ord(twSmallFrameBottomSizingTemplate);
        end;
      // Windows Vista or later
      twFrame:
        begin
          Part := WP_FRAME;
          Base := Ord(twFrame);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedHint): TThemedElementDetails;
begin
  Result.Element := teHint;
  Result.Part := 0;
  Result.State := Ord(Detail);
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedControlBar): TThemedElementDetails;
begin
  Result.Element := teControlBar;
  Result.Part := 0;
  Result.State := Ord(Detail);
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedTabSet): TThemedElementDetails;
begin
  Result.Element := teTabSet;
  Result.Part := 0;
  Result.State := Ord(Detail);
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedPanel): TThemedElementDetails;
begin
  Result.Element := tePanel;
  Result.Part := 0;
  Result.State := Ord(Detail);
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedCategoryButtons): TThemedElementDetails;
begin
  Result.Element := teCategoryButtons;
  Result.Part := 0;
  Result.State := Ord(Detail);
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedCategoryPanelGroup): TThemedElementDetails;
begin
  Result.Element := teCategoryPanelGroup;
  Result.Part := 0;
  Result.State := Ord(Detail);
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedCheckListBox): TThemedElementDetails;
begin
  Result.Element := teCheckListBox;
  Result.Part := 0;
  Result.State := Ord(Detail);
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedGrid): TThemedElementDetails;
begin
  Result.Element := teGrid;
  Result.Part := 0;
  Result.State := Ord(Detail);
end;

function TUxThemeStyle.GetName: string;
begin
  Result := 'Windows';
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedTreeview): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teTreeView;
  with Result do
  begin
    case Detail of
      ttItemNormal..ttItemHotSelected:
        begin
          Part := TVP_TREEITEM;
          Base := Ord(ttItemNormal);
        end;
      ttGlyphClosed..ttGlyphOpened:
        begin
          Part := TVP_GLYPH;
          Base := Ord(ttGlyphClosed);
        end;
      ttBranch:
        begin
          Part := TVP_BRANCH;
          Base := Ord(ttBranch);
        end;
      // Windows Vista or later
      ttHotGlyphClosed..ttHotGlyphOpen:
        begin
          Part := TVP_HOTGLYPH;
          Base := Ord(ttHotGlyphClosed);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedTrayNotify): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teTrayNotify;
  with Result do
  begin
    case Detail of
      ttnBackground:
        begin
          Part := TNP_BACKGROUND;
          Base := Ord(ttnBackground);
        end;
      ttnAnimBackground:
        begin
          Part := TNP_ANIMBACKGROUND;
          Base := Ord(ttnAnimBackground);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedTaskBar): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teTaskBar;
  with Result do
  begin
    case Detail of
      ttbBackgroundBottom:
        begin
          Part := TBP_BACKGROUNDBOTTOM;
          Base := Ord(ttbBackgroundBottom);
        end;
      ttbBackgroundRight:
        begin
          Part := TBP_BACKGROUNDRIGHT;
          Base := Ord(ttbBackgroundRight);
        end;
      ttbBackgroundTop:
        begin
          Part := TBP_BACKGROUNDTOP;
          Base := Ord(ttbBackgroundTop);
        end;
      ttbBackgroundLeft:
        begin
          Part := TBP_BACKGROUNDLEFT;
          Base := Ord(ttbBackgroundLeft);
        end;
      ttbSizingBarBottom:
        begin
          Part := TBP_SIZINGBARBOTTOM;
          Base := Ord(ttbSizingBarBottom);
        end;
      ttbSizingBarRight:
        begin
          Part := TBP_SIZINGBARRIGHT;
          Base := Ord(ttbSizingBarRight);
        end;
      ttbSizingBarTop:
        begin
          Part := TBP_SIZINGBARTOP;
          Base := Ord(ttbSizingBarTop);
        end;
      ttbSizingBarLeft:
        begin
          Part := TBP_SIZINGBARLEFT;
          Base := Ord(ttbSizingBarLeft);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedStartPanel): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teStartPanel;
  with Result do
  begin
    case Detail of
      tspUserPane:
        begin
          Part := SPP_USERPANE;
          Base := Ord(tspUserPane);
        end;
      tspMorePrograms:
        begin
          Part := SPP_MOREPROGRAMS;
          Base := Ord(tspMorePrograms);
        end;
      tspMoreProgramsArrowNormal..tspMoreProgramsArrowPressed:
        begin
          Part := SPP_MOREPROGRAMSARROW;
          Base := Ord(tspMoreProgramsArrowNormal);
        end;
      tspProgList:
        begin
          Part := SPP_PROGLIST;
          Base := Ord(tspProgList);
        end;
      tspProgListSeparator:
        begin
          Part := SPP_PROGLISTSEPARATOR;
          Base := Ord(tspProgListSeparator);
        end;
      tspPlacesList:
        begin
          Part := SPP_PLACESLIST;
          Base := Ord(tspPlacesList);
        end;
      tspPlacesListSeparator:
        begin
          Part := SPP_PLACESLISTSEPARATOR;
          Base := Ord(tspPlacesListSeparator);
        end;
      tspLogOff:
        begin
          Part := SPP_LOGOFF;
          Base := Ord(tspLogOff);
        end;
      tspLogOffButtonsNormal..tspLogOffButtonsPressed:
        begin
          Part := SPP_LOGOFFBUTTONS;
          Base := Ord(tspLogOffButtonsNormal);
        end;
      tspUserPicture:
        begin
          Part := SPP_USERPICTURE;
          Base := Ord(tspUserPicture);
        end;
      tspPreview:
        begin
          Part := SPP_PREVIEW;
          Base := Ord(tspPreview);
        end;
      // Windows Vista or later
      tspMoreProgramsTabNormal..tspMoreProgramsTabFocused:
        begin
          Part := SPP_MOREPROGRAMSTAB;
          Base := Ord(tspMoreProgramsTabNormal);
        end;
      tspNSCHost:
        begin
          Part := SPP_NSCHOST;
          Base := Ord(tspNSCHost);
        end;
      tspSoftwareExplorerNormal..tspSoftwareExplorerFocused:
        begin
          Part := SPP_SOFTWAREEXPLORER;
          Base := Ord(tspSoftwareExplorerNormal);
        end;
      tspOpenBoxNormal..tspOpenBoxFocused:
        begin
          Part := SPP_OPENBOX;
          Base := Ord(tspOpenBoxNormal);
        end;
      tspSearchView:
        begin
          Part := SPP_SEARCHVIEW;
          Base := Ord(tspSearchView);
        end;
      tspMoreProgramsArrowBackNormal..tspMoreProgramsArrowBackPressed:
        begin
          Part := SPP_MOREPROGRAMSARROWBACK;
          Base := Ord(tspMoreProgramsArrowBackNormal);
        end;
      tspTopMatch:
        begin
          Part := SPP_TOPMATCH;
          Base := Ord(tspTopMatch);
        end;
      tspLogOffSplitButtonDropDown:
        begin
          Part := SPP_LOGOFFSPLITBUTTONDROPDOWN;
          Base := Ord(tspLogOffSplitButtonDropDown);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedSpin): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teSpin;
  with Result do
  begin
    case Detail of
      tsUpNormal..tsUpDisabled:
        begin
          Part := SPNP_UP;
          Base := Ord(tsUpNormal);
        end;
      tsDownNormal..tsDownDisabled:
        begin
          Part := SPNP_DOWN;
          Base := Ord(tsDownNormal);
        end;
      tsUpHorzNormal..tsUpHorzDisabled:
        begin
          Part := SPNP_UPHORZ;
          Base := Ord(tsUpHorzNormal);
        end;
      tsDownHorzNormal..tsDownHorzDisabled:
        begin
          Part := SPNP_DOWNHORZ;
          Base := Ord(tsDownHorzNormal);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedScrollBar): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teScrollBar;
  with Result do
  begin
    case Detail of
      tsArrowBtnUpNormal..tsArrowBtnRightHover:
        begin
          Part := SBP_ARROWBTN;
          Base := Ord(tsArrowBtnUpNormal);
        end;
      tsThumbBtnHorzNormal..tsThumbBtnHorzDisabled:
        begin
          Part := SBP_THUMBBTNHORZ;
          Base := Ord(tsThumbBtnHorzNormal);
        end;
      tsThumbBtnVertNormal..tsThumbBtnVertDisabled:
        begin
          Part := SBP_THUMBBTNVERT;
          Base := Ord(tsThumbBtnVertNormal);
        end;
      tsLowerTrackHorzNormal..tsLowerTrackHorzHover:
        begin
          Part := SBP_LOWERTRACKHORZ;
          Base := Ord(tsLowerTrackHorzNormal);
        end;
      tsUpperTrackHorzNormal..tsUpperTrackHorzHover:
        begin
          Part := SBP_UPPERTRACKHORZ;
          Base := Ord(tsUpperTrackHorzNormal);
        end;
      tsLowerTrackVertNormal..tsLowerTrackVertHover:
        begin
          Part := SBP_LOWERTRACKVERT;
          Base := Ord(tsLowerTrackVertNormal);
        end;
      tsUpperTrackVertNormal..tsUpperTrackVertHover:
        begin
          Part := SBP_UPPERTRACKVERT;
          Base := Ord(tsUpperTrackVertNormal);
        end;
      tsGripperHorzNormal..tsGripperHorzHover:
        begin
          Part := SBP_GRIPPERHORZ;
          Base := Ord(tsGripperHorzNormal);
        end;
      tsGripperVertNormal..tsGripperVertHover:
        begin
          Part := SBP_GRIPPERVERT;
          Base := Ord(tsGripperVertNormal);
        end;
      tsSizeBoxRightAlign..tsSizeBoxHalfTopLeftAlign:
        begin
          Part := SBP_SIZEBOX;
          Base := Ord(tsSizeBoxRightAlign);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedTaskBand): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teTaskBand;
  with Result do
  begin
    case Detail of
      ttbGroupCount:
        begin
          Part := TDP_GROUPCOUNT;
          Base := Ord(ttbGroupCount);
        end;
      ttbFlashButton:
        begin
          Part := TDP_FLASHBUTTON;
          Base := Ord(ttbFlashButton);
        end;
      ttpFlashButtonGroupMenu:
        begin
          Part := TDP_FLASHBUTTONGROUPMENU;
          Base := Ord(ttpFlashButtonGroupMenu);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedTaskDialog): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teTaskDialog;
  with Result do
  begin
    case Detail of
      ttdPrimaryPanel..ttdPrimaryPanelLast:
        begin
          Part := TDLG_PRIMARYPANEL;
          Base := Ord(ttdPrimaryPanel);
        end;
      ttdMainInstructionPane..ttdMainInstructionPaneLast:
        begin
          Part := TDLG_MAININSTRUCTIONPANE;
          Base := Ord(ttdMainInstructionPane);
        end;
      ttdMainIcon..ttdMainIconLast:
        begin
          Part := TDLG_MAINICON;
          Base := Ord(ttdMainIcon);
        end;
      ttdContentPane..ttdContentPaneLast:
        begin
          Part := TDLG_CONTENTPANE;
          Base := Ord(ttdContentPane);
        end;
      ttdContentIcon..ttdContentIconLast:
        begin
          Part := TDLG_CONTENTICON;
          Base := Ord(ttdContentIcon);
        end;
      ttdExpandedContent..ttdExpandedContentLast:
        begin
          Part := TDLG_EXPANDEDCONTENT;
          Base := Ord(ttdExpandedContent);
        end;
      ttdCommandLinkPane..ttdCommandLinkPaneLast:
        begin
          Part := TDLG_COMMANDLINKPANE;
          Base := Ord(ttdCommandLinkPane);
        end;
      ttdSecondaryPanel..ttdSecondaryPanelLast:
        begin
          Part := TDLG_SECONDARYPANEL;
          Base := Ord(ttdSecondaryPanel);
        end;
      ttdControlPane..ttdControlPaneLast:
        begin
          Part := TDLG_CONTROLPANE;
          Base := Ord(ttdControlPane);
        end;
      ttdButtonSection..ttdButtonSectionLast:
        begin
          Part := TDLG_BUTTONSECTION;
          Base := Ord(ttdButtonSection);
        end;
      ttdButtonWrapper..ttdButtonWrapperLast:
        begin
          Part := TDLG_BUTTONWRAPPER;
          Base := Ord(ttdButtonWrapper);
        end;
      ttdExpandoText..ttdExpandoTextLast:
        begin
          Part := TDLG_EXPANDOTEXT;
          Base := Ord(ttdExpandoText);
        end;
      ttdExpandoButtonNormal..ttdExpandoButtonLast:
        begin
          Part := TDLG_EXPANDOBUTTON;
          Base := Ord(ttdExpandoButtonNormal);
        end;
      ttdVerificationText..ttdVerificationTextLast:
        begin
          Part := TDLG_VERIFICATIONTEXT;
          Base := Ord(ttdVerificationText);
        end;
      ttdFootnotePane..ttdFootnotePaneLast:
        begin
          Part := TDLG_FOOTNOTEPANE;
          Base := Ord(ttdFootnotePane);
        end;
      ttdFootnoteArea..ttdFootnoteAreaLast:
        begin
          Part := TDLG_FOOTNOTEAREA;
          Base := Ord(ttdFootnoteArea);
        end;
      ttdFootnoteSeparator..ttdFootnoteSeparatorLast:
        begin
          Part := TDLG_FOOTNOTESEPARATOR;
          Base := Ord(ttdFootnoteSeparator);
        end;
      ttdExpandedFooterArea..ttdExpandedFooterAreaLast:
        begin
          Part := TDLG_EXPANDEDFOOTERAREA;
          Base := Ord(ttdExpandedFooterArea);
        end;
      ttdProgressBar..ttdProgressBarLast:
        begin
          Part := TDLG_PROGRESSBAR;
          Base := Ord(ttdProgressBar);
        end;
      ttdImageAlignment..ttdImageAlignmentLast:
        begin
          Part := TDLG_IMAGEALIGNMENT;
          Base := Ord(ttdImageAlignment);
        end;
      ttdRadioButtonPane..ttdRadioButtonPaneLast:
        begin
          Part := TDLG_RADIOBUTTONPANE;
          Base := Ord(ttdRadioButtonPane);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedTab): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teTab;
  with Result do
  begin
    case Detail of
      ttTabItemNormal..ttTabItemFocused:
        begin
          Part := TABP_TABITEM;
          Base := Ord(ttTabItemNormal);
        end;
      ttTabItemLeftEdgeNormal..ttTabItemLeftEdgeFocused:
        begin
          Part := TABP_TABITEMLEFTEDGE;
          Base := Ord(ttTabItemLeftEdgeNormal);
        end;
      ttTabItemRightEdgeNormal..ttTabItemRightEdgeFocused:
        begin
          Part := TABP_TABITEMRIGHTEDGE;
          Base := Ord(ttTabItemRightEdgeNormal);
        end;
      ttTabItemBothEdgeNormal..ttTabItemBothEdgeFocused:
        begin
          Part := TABP_TABITEMBOTHEDGE;
          Base := Ord(ttTabItemBothEdgeNormal);
        end;
      ttTopTabItemNormal..ttTopTabItemFocused:
        begin
          Part := TABP_TOPTABITEM;
          Base := Ord(ttTopTabItemNormal);
        end;
      ttTopTabItemLeftEdgeNormal..ttTopTabItemLeftEdgeFocused:
        begin
          Part := TABP_TOPTABITEMLEFTEDGE;
          Base := Ord(ttTopTabItemLeftEdgeNormal);
        end;
      ttTopTabItemRightEdgeNormal..ttTopTabItemRightEdgeFocused:
        begin
          Part := TABP_TOPTABITEMRIGHTEDGE;
          Base := Ord(ttTopTabItemRightEdgeNormal);
        end;
      ttTopTabItemBothEdgeNormal..ttTopTabItemBothEdgeFocused:
        begin
          Part := TABP_TOPTABITEMBOTHEDGE;
          Base := Ord(ttTopTabItemBothEdgeNormal);
        end;
      ttPane:
        begin
          Part := TABP_PANE;
          Base := Ord(ttPane);
        end;
      ttBody:
        begin
          Part := TABP_BODY;
          Base := Ord(ttBody);
        end;
      ttAeroWizardBody:
        begin
          Part := TABP_AEROWIZARDBODY;
          Base := Ord(ttAeroWizardBody);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedTextStyle): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teTextStyle;
  with Result do
  begin
    case Detail of
      ttsMainInstruction..ttsMainInstructionLast:
        begin
          Part := TEXT_MAININSTRUCTION;
          Base := Ord(ttsMainInstruction);
        end;
      ttsInstruction..ttsInstructionLast:
        begin
          Part := TEXT_INSTRUCTION;
          Base := Ord(ttsInstruction);
        end;
      ttsBodyTitle..ttsBodyTitleLast:
        begin
          Part := TEXT_BODYTITLE;
          Base := Ord(ttsBodyTitle);
        end;
      ttsBodyText..ttsBodyTextLast:
        begin
          Part := TEXT_BODYTEXT;
          Base := Ord(ttsBodyText);
        end;
      ttsSecondaryText..ttsSecondaryTextLast:
        begin
          Part := TEXT_SECONDARYTEXT;
          Base := Ord(ttsSecondaryText);
        end;
      ttsHyperLinkTextNormal..ttsHyperLinkTextLast:
        begin
          Part := TEXT_HYPERLINKTEXT;
          Base := Ord(ttsHyperLinkTextNormal);
        end;
      ttsExpanded..ttsExpandedLast:
        begin
          Part := TEXT_EXPANDED;
          Base := Ord(ttsExpanded);
        end;
      ttsLabel..ttsLabelLast:
        begin
          Part := TEXT_LABEL;
          Base := Ord(ttsLabel);
        end;
      ttsControlLabelNormal..ttsControlLabelLast:
        begin
          Part := TEXT_CONTROLLABEL;
          Base := Ord(ttsControlLabelNormal);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedTextLabel): TThemedElementDetails;
begin
  Result.Element := teTextLabel;
  Result.Part := 0;
  Result.State := Ord(Detail);
end;

function TUxThemeStyle.GetElementDetails(Detail: TThemedStatus): TThemedElementDetails;
var
  Base: Integer;
begin
  Result.Element := teStatus;
  with Result do
  begin
    case Detail of
      tsPane:
        begin
          Part := SP_PANE;
          Base := Ord(tsPane);
        end;
      tsGripperPane:
        begin
          Part := SP_GRIPPERPANE;
          Base := Ord(tsGripperPane);
        end;
      tsGripper:
        begin
          Part := SP_GRIPPER;
          Base := Ord(tsGripper);
        end;
    else
      Part := 0;
      Base := 0;
    end;
    State := Ord(Detail) - Base + 1;
  end;
end;

function TUxThemeStyle.GetTheme(Element: TThemedElement): HTHEME;
begin
  if Element in CWindowsElements then
  begin
    if FUseThemes and (FThemeData[Element] = 0) then
      FThemeData[Element] := OpenThemeData(0, ThemeDataNames[Element]);
  end;
  Result := FThemeData[Element];
end;

function TUxThemeStyle.GetAvailable: Boolean;
begin
  Result := FAvailable;
end;

function TUxThemeStyle.GetEnabled: Boolean;
begin
  Result := FAvailable and FUseThemes and FNewComCtrls;
end;

class function TUxThemeStyle.LoadFromStream(Stream: TStream): TCustomStyleServices;
begin
  raise ECustomStyleException.Create(SStyleFeatureNotSupported);
end;

procedure TUxThemeStyle.SaveToStream(Stream: TStream);
begin
  raise ECustomStyleException.Create(SStyleFeatureNotSupported);
end;

procedure TUxThemeStyle.UnloadThemeData;
var
  Entry: TThemedElement;
begin
  for Entry := Low(TThemeData) to High(TThemeData) do
    if FThemeData[Entry] <> 0 then
    begin
      CloseThemeData(FThemeData[Entry]);
      FThemeData[Entry] := 0;
    end;
end;

procedure TUxThemeStyle.UpdateThemes;
begin
  if FUseThemes then
    UnloadThemeData;
  FUseThemes := UseThemes;
end;

{ TStyleManager }

class procedure TStyleManager.CreateStyleEngine;
var
  LEngine: TCustomStyleEngine;
begin
  if FEngineClass <> nil then
  begin
    LEngine := FEngineClass.Create;
    if InterlockedCompareExchangePointer(Pointer(FEngine), LEngine, nil) <> nil then
      LEngine.Free;
  end;
end;

type
  PEnumResourceInfo = ^TEnumResourceInfo;
  TEnumResourceInfo = record
    Instance: HINST;
    Descriptors: TList<TStyleManager.TStyleClassDescriptor>;
    Errors: TStrings;
  end;

function EnumResourceNamesProc(Module: HMODULE; lpszType, lpszName: PChar; Data: LPARAM): BOOL; stdcall;
var
  LHandle: TStyleManager.TStyleServicesHandle;
begin
  Result := True;
  if not TStyleManager.TryLoadFromResource(PEnumResourceInfo(Data)^.Instance, lpszName, lpszType, LHandle) then
    PEnumResourceInfo(Data)^.Errors.Add(lpszName);
end;

function EnumModulesProc(Instance: NativeInt; Data: Pointer): Boolean;
var
  LItem: TStyleManager.TStyleClassDescriptor;
begin
  Result := True;
  PEnumResourceInfo(Data)^.Instance := Instance;
  for LItem in PEnumResourceInfo(Data)^.Descriptors do
    EnumResourceNames(Instance, PChar(LItem.ResourceType), @EnumResourceNamesProc, LPARAM(Data));
end;

class procedure TStyleManager.DiscoverStyleResources;
var
  LInfo: TEnumResourceInfo;
begin
  LInfo.Errors := TStringList.Create;
  try
    LInfo.Descriptors := FStyleClassDescriptors;
    EnumModules(EnumModulesProc, @LInfo);
    if LInfo.Errors.Count > 1 then
      raise ECustomStyleException.CreateResFmt(@SStyleLoadErrors, [LInfo.Errors.CommaText])
    else if LInfo.Errors.Count > 0 then
      raise ECustomStyleException.CreateResFmt(@SStyleLoadError, [LInfo.Errors[0]])
  finally
    FRefreshAutoDiscovery := False;
    LInfo.Errors.Free;
  end;
end;

class function TStyleManager.DoLoadFromResource(Instance: HINST; const ResourceName: string;
  ResourceType: PChar; StyleDescriptor: TStyleClassDescriptor): TStyleServicesHandle;
var
  LInfo: TSourceInfo;
  LStream: TResourceStream;
begin
  Result := nil;
  if StyleDescriptor.StyleClass <> nil then
  begin
    LInfo.StyleClass := StyleDescriptor.StyleClass;
    LStream := TResourceStream.Create(Instance, ResourceName, ResourceType);
    try
      Result := DoLoadFromStream(LStream, LInfo);
    finally
      LStream.Free;
    end;
  end;
end;

class function TStyleManager.DoLoadFromStream(Stream: TStream; StyleInfo: TSourceInfo): TStyleServicesHandle;
var
  LInfo: TStyleInfo;
  LStream: TMemoryStream;
begin
  LStream := TMemoryStream.Create;
  try
    LStream.CopyFrom(Stream, Stream.Size);
    LStream.Position := 0;
    if StyleInfo.StyleClass.IsValidStyle(LStream, LInfo) then
    begin
                                                    
      if not FRegisteredStyles.ContainsKey(LInfo.Name) then
      begin
        LStream.Position := 0;
        StyleInfo.Data := LStream;
        FRegisteredStyles.Add(LInfo.Name, StyleInfo);
        Result := TStyleServicesHandle(LStream);
      end
      else
        raise EDuplicateStyleException.CreateResFmt(@SStyleRegisterError, [LInfo.Name]);
    end
    else
      raise ECustomStyleException.CreateRes(@SStyleFormatError);
  except
    StyleInfo.Data := nil;
    LStream.Free;
    raise;
  end
end;

class function TStyleManager.FindStyleDescriptor(const Name: string; Field: TStyleDescriptorField): TStyleClassDescriptor;
var
  LResult: Boolean;
  LDescriptor: TStyleClassDescriptor;
begin
  FillChar(Result, SizeOf(Result), 0);
  for LDescriptor in FStyleClassDescriptors do
  begin
    case Field of
      dfExtension: LResult := SameText(Name, LDescriptor.Extension, loUserLocale);
      dfDescription: LResult := SameText(Name, LDescriptor.Description, loUserLocale);
      dfResourceType: LResult := SameText(Name, LDescriptor.ResourceType, loUserLocale);
    else
      LResult := False;
    end;
    if LResult then
      Result := LDescriptor;
  end;
end;

class function TStyleManager.GetEnabled: Boolean;
begin
  // Call ActiveStyle property getter to force initialization
  Result := ActiveStyle.Enabled;
end;

class function TStyleManager.GetEngine: TCustomStyleEngine;
begin
  if FEngine = nil then
    CreateStyleEngine;
  Result := FEngine;
end;

class function TStyleManager.GetSystemStyle: TCustomStyleServices;
begin
  if FSystemStyle = nil then
  begin
    FSystemStyle := TUxThemeStyle.Create;
    RegisterStyle(FSystemStyle);
  end;
  Result := FSystemStyle;
end;

class function TStyleManager.GetStyleClassDescriptors: TArray<TStyleClassDescriptor>;
begin
  if FAutoDiscoverStyleResources and FRefreshAutoDiscovery then
    DiscoverStyleResources;
  Result := FStyleClassDescriptors.ToArray;
end;

class function TStyleManager.GetStyleDescriptor(const StyleName: string): TStyleClassDescriptor;
var
  LDescriptor: TStyleClassDescriptor;
  LItem: TPair<string, TSourceInfo>;
begin
  if FAutoDiscoverStyleResources and FRefreshAutoDiscovery then
    DiscoverStyleResources;

  for LItem in FRegisteredStyles do
    if SameText(StyleName, LItem.Key, loUserLocale) then
      for LDescriptor in FStyleClassDescriptors do
        if LDescriptor.StyleClass = LItem.Value.StyleClass then
          Exit(LDescriptor);

  raise ECustomStyleException.CreateResFmt(@SStyleNotFound, [StyleName]);
end;

class function TStyleManager.GetStyleNames: TArray<string>;
var
  I: Integer;
  LItem: TPair<string, TSourceInfo>;
begin
  if FAutoDiscoverStyleResources and FRefreshAutoDiscovery then
    DiscoverStyleResources;
  SetLength(Result, FRegisteredStyles.Count + 1);
  Result[0] := FSystemStyle.Name;
  I := 1;
  for LItem in FRegisteredStyles do
  begin
    Result[I] := LItem.Key;
    Inc(I);
  end;
end;

class function TStyleManager.GetStyle(const Name: string): TCustomStyleServices;
var
  LStyle: TCustomStyleServices;
  LItem: TPair<string, TSourceInfo>;
begin
  Result := nil;
  if FAutoDiscoverStyleResources and FRefreshAutoDiscovery then
    DiscoverStyleResources;

  for LStyle in FStyles do
    if SameText(Name, LStyle.Name, loUserLocale) then
      Exit(LStyle);

  for LItem in FRegisteredStyles do
    if SameText(Name, LItem.Key, loUserLocale) then
      if LItem.Value.Data <> nil then
      begin
        Result := LItem.Value.StyleClass.LoadFromStream(LItem.Value.Data);
        if FStyles.IndexOf(Result) = -1 then
          FStyles.Add(Result);
        Break;
      end;
end;

class function TStyleManager.GetActiveStyle: TCustomStyleServices;
begin
  if FActiveStyle = nil then
    // Call SystemStyle property getter to force initialization
    FActiveStyle := SystemStyle;
  Result := FActiveStyle;
end;

class function TStyleManager.GetIsCustomStyleActive: Boolean;
begin
  // Call ActiveStyle property getter to force initialization
  Result := ActiveStyle.Enabled and (FActiveStyle <> FSystemStyle);
end;

class function TStyleManager.HandleMessage(Control: TWinControl; var Message: TMessage;
  DefWndProc: TWndMethod): Boolean;
begin
  Result := False;
  if (sfHandleMessages in FFlags) then
  begin
    if FEngine = nil then
    begin
      CreateStyleEngine;
      if Engine <> nil then
        Result := FEngine.HandleMessage(Control, Message, DefWndProc);
    end
    else
      Result := FEngine.HandleMessage(Control, Message, DefWndProc);
  end;
end;

class procedure TStyleManager.Initialize;
begin
  FFlags := [];
  FAutoDiscoverStyleResources := True;
  FRefreshAutoDiscovery := False;
  if FRegisteredStyles = nil then
    FRegisteredStyles := TDictionary<string, TSourceInfo>.Create;
  if FStyleClassDescriptors = nil then
    FStyleClassDescriptors := TList<TStyleClassDescriptor>.Create;
  if FStyles = nil then
    FStyles := TList<TCustomStyleServices>.Create;
  if FStyleEngines = nil then
    FStyleEngines := TList<TCustomStyleEngineClass>.Create;
end;

class function TStyleManager.IsValidStyle(const FileName: string): Boolean;
var
  Temp: TStyleInfo;
begin
  Result := IsValidStyle(FileName, Temp);
end;

class function TStyleManager.IsValidStyle(const FileName: string; var StyleInfo: TStyleInfo): Boolean;
var
  LStream: TStream;
  LDescriptor: TStyleClassDescriptor;
begin
  Result := False;
  LStream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
  try
    for LDescriptor in FStyleClassDescriptors do
    begin
      Result := LDescriptor.StyleClass.IsValidStyle(LStream, StyleInfo);
      if Result then
        Break;
      LStream.Position := 0;
    end;
  finally
    LStream.Free;
  end;
end;

class function TStyleManager.LoadFromFile(const FileName: string): TStyleServicesHandle;
var
  LStream: TStream;
  LInfo: TSourceInfo;
  LStyleServicesClass: TCustomStyleServicesClass;
begin
  LStyleServicesClass := FindStyleDescriptor(ExtractFileExt(FileName), dfExtension).StyleClass;
  if LStyleServicesClass <> nil then
  begin
    LInfo.StyleClass := LStyleServicesClass;
    LStream := TFileStream.Create(FileName, fmOpenRead);
    try
      Result := DoLoadFromStream(LStream, LInfo);
    finally
      LStream.Free;
    end;
  end
  else
    raise ECustomStyleException.CreateResFmt(@SStyleLoadError, [FileName]);
end;

class function TStyleManager.LoadFromResource(Instance: HINST;
  const ResourceName: string; ResourceType: PChar): TStyleServicesHandle;
var
  LResType: string;
begin
  if Is_IntResource(ResourceType) then
    LResType := string('#' + IntToStr(ULONG_PTR(ResourceType)))
  else
    LResType := ResourceType;

  Result := DoLoadFromResource(Instance, ResourceName, ResourceType,
     FindStyleDescriptor(LResType, dfResourceType));
end;

class function TStyleManager.LoadFromResource(Instance: HINST; const ResourceName: string): TStyleServicesHandle;
var
  LResType: PChar;
  LItem: TStyleClassDescriptor;
  LDescriptor: TStyleClassDescriptor;
begin
  for LItem in FStyleClassDescriptors do
  begin
    LDescriptor := FindStyleDescriptor(LItem.ResourceType, dfResourceType);
    if LDescriptor.StyleClass <> nil then
    begin
      if (Length(LDescriptor.ResourceType) >= 2) and (LDescriptor.ResourceType[1] = '#') then
        LResType := MakeIntResource(StrToInt(Copy(LDescriptor.ResourceType, 2, Length(LDescriptor.ResourceType) - 1)))
      else
        LResType := PChar(LDescriptor.ResourceType);

      Exit(DoLoadFromResource(Instance, ResourceName, LResType, LDescriptor));
    end;
  end;

  raise ECustomStyleException.CreateResFmt(@SStyleLoadError, [ResourceName]);
end;

class procedure TStyleManager.Notification(Operation: TCustomStyleEngine.TStyleEngineNotification;
  Data: Pointer);
begin
  if FEngine <> nil then
    FEngine.Notification(Operation, Data);
end;

class procedure TStyleManager.RegisterStyle(Style: TCustomStyleServices);
begin
  if FStyles.IndexOf(Style) = -1 then
    FStyles.Add(Style)
  else
    raise EDuplicateStyleException.CreateResFmt(@SStyleRegisterError, [Style.Name]);
end;

class procedure TStyleManager.RegisterStyleClass(const Extension, Description: string;
  ResourceType: PChar; StyleClass: TCustomStyleServicesClass);
begin
  if Is_IntResource(ResourceType) then
    RegisterStyleClass(Extension, Description, string('#' + IntToStr(ULONG_PTR(ResourceType))), StyleClass)
  else
    RegisterStyleClass(Extension, Description, string(ResourceType), StyleClass);
end;

class procedure TStyleManager.RegisterStyleClass(const Extension, Description: string;
  const ResourceType: string; StyleClass: TCustomStyleServicesClass);
var
  LDescriptor: TStyleClassDescriptor;
begin
  for LDescriptor in FStyleClassDescriptors do
    if SameText(Extension, LDescriptor.Extension, loUserLocale) then
      raise ECustomStyleException.CreateResFmt(@SStyleClassRegisterError, [StyleClass.ClassName]);

  LDescriptor.Extension := Extension;
  LDescriptor.Description := Description;
  LDescriptor.ResourceType := ResourceType;
  LDescriptor.StyleClass := StyleClass;
  FStyleClassDescriptors.Add(LDescriptor);
  FRefreshAutoDiscovery := True;
end;

class procedure TStyleManager.SetAutoDiscoverStyleResources(const Value: Boolean);
begin
  if Value <> FAutoDiscoverStyleResources then
  begin
    FAutoDiscoverStyleResources := Value;
    if FAutoDiscoverStyleResources then
      FRefreshAutoDiscovery := True;
  end;
end;

class procedure TStyleManager.SetEngineClass(const Value: TCustomStyleEngineClass);
begin
  if Value <> FEngineClass then
  begin
    FEngineClass := Value;
    if FEngineClass <> nil then
      FStyleEngines.Insert(0, FEngineClass);
    if FEngine <> nil then
      FreeAndNil(FEngine);
  end;
end;

class procedure TStyleManager.SetStyle(Style: TCustomStyleServices);
var
  I: Integer;
begin
  // Call ActiveStyle property getter to force initialization
  if (Style <> ActiveStyle) then
  begin
    if Style = nil then
      // Call SystemStyle property getter to force initialization
      Style := SystemStyle
    else if FStyles.IndexOf(Style) = -1 then
      FStyles.Add(Style);
    FActiveStyle := Style;
    FFlags := FActiveStyle.Flags;

    for I := 0 to Screen.FormCount - 1 do
      if Screen.Forms[I].HandleAllocated then
        if IsWindowVisible(Screen.Forms[I].Handle) then
          PostMessage(Screen.Forms[I].Handle, CM_CUSTOMSTYLECHANGED, 0, 0)
        else
          SendMessage(Screen.Forms[I].Handle, CM_CUSTOMSTYLECHANGED, 0, 0);
  end;
end;

class procedure TStyleManager.SetStyle(const Name: string);
begin
  if not TrySetStyle(Name, False) then
    raise ECustomStyleException.CreateResFmt(@SStyleNotFound, [Name]);
end;

class procedure TStyleManager.SetStyle(Handle: TStyleServicesHandle);
var
  LItem: TPair<string, TSourceInfo>;
begin
  for LItem in FRegisteredStyles do
    if LItem.Value.Data = Handle then
    begin
      SetStyle(LItem.Value.StyleClass.LoadFromStream(Handle));
      Exit;
    end;
  raise ECustomStyleException.CreateRes(@SStyleInvalidHandle);
end;

class procedure TStyleManager.SetFormBorderStyle(const Value: TFormBorderStyle);
var
  I: Integer;
begin
  if FFormBorderStyle <> Value then
  begin
    FFormBorderStyle := Value;
    if IsCustomStyleActive then
    begin
      for I := 0 to Screen.FormCount - 1 do
      if Screen.Forms[I].HandleAllocated then
        if IsWindowVisible(Screen.Forms[I].Handle) then
          PostMessage(Screen.Forms[I].Handle, CM_CUSTOMSTYLECHANGED, 0, 0)
        else
          SendMessage(Screen.Forms[I].Handle, CM_CUSTOMSTYLECHANGED, 0, 0);
    end;
  end;
end;

class function TStyleManager.TryLoadFromResource(Instance: HINST;
  const ResourceName: string; ResourceType: PChar; var Handle: TStyleServicesHandle): Boolean;
begin
  Result := True;
  try
    Handle := DoLoadFromResource(Instance, ResourceName, REsourceType,
       FindStyleDescriptor(ResourceType, dfResourceType));
  except
    Result := False;
  end;
end;

class function TStyleManager.TrySetStyle(const Name: string; ShowErrorDialog: Boolean = True): Boolean;
var
  LInfo: TSourceInfo;
  LStyle: TCustomStyleServices;
  LItem: TPair<string, TSourceInfo>;
begin
  if FAutoDiscoverStyleResources and FRefreshAutoDiscovery then
    DiscoverStyleResources;

  for LStyle in FStyles do
    if SameText(Name, LStyle.Name, loUserLocale) then
    begin
      SetStyle(LStyle);
      Exit(True);
    end;

  for LItem in FRegisteredStyles do
    if SameText(Name, LItem.Key, loUserLocale) then
    begin
      LInfo := LItem.Value;
      if LInfo.Data <> nil then
      begin
        SetStyle(LInfo.StyleClass.LoadFromStream(LInfo.Data));
        Exit(True);
      end;
    end;

  Result := False;
  if ShowErrorDialog then
    MessageDlg(Format(LoadResString(@SStyleNotFound), [Name]), mtError, [mbClose], 0);
end;

class procedure TStyleManager.UnRegisterStyleEngine(AEngineClass: TCustomStyleEngineClass);
var
  Index: Integer;
begin
  Index := FStyleEngines.IndexOf(AEngineClass);
  if Index <> -1 then
  begin
    FStyleEngines.Delete(Index);
    if FEngineClass = AEngineClass then
    begin
      if FStyleEngines.Count > 0 then
        SetEngineClass(FStyleEngines[0])
      else
        SetEngineClass(nil);
    end;
  end;
end;

class procedure TStyleManager.UnInitialize;
var
  LStyle: TCustomStyleServices;
  LItem: TPair<string, TSourceInfo>;
begin
  FFlags := [];
  FActiveStyle := nil;
  FSystemStyle := nil;
  for LItem in FRegisteredStyles do
    if LItem.Value.Data <> nil then
      TMemoryStream(LItem.Value.Data).Free;
  FreeAndNil(FRegisteredStyles);
  FreeAndNil(FStyleClassDescriptors);
  for LStyle in FStyles do
    LStyle.Free;
  FreeAndNil(FStyleEngines);
  FreeAndNil(FStyles);
  FreeAndNil(FEngine);
end;

class procedure TStyleManager.UnRegisterStyle(Style: TCustomStyleServices);
begin
  if assigned(Style) then
  begin
    if Style = FSystemStyle then
      raise EDuplicateStyleException.CreateRes(@SStyleUnregisterError);
    if FStyles.IndexOf(Style) = -1 then
      raise EDuplicateStyleException.CreateResFmt(@SStyleNotRegistered, [Style.Name])
    else
    begin
      FStyles.Remove(Style);
      if FActiveStyle = Style then
        SetStyle(FSystemStyle);
    end;
  end
  else
    raise EStyleEngineException.CreateRes(@SStyleNotRegisteredNoName);
end;

class procedure TStyleManager.UnRegisterStyleClass(StyleClass: TCustomStyleServicesClass);
var
  I: Integer;
begin
  for I := 0 to FStyleClassDescriptors.Count - 1 do
    if StyleClass = FStyleClassDescriptors[I].StyleClass then
    begin
      FStyleClassDescriptors.Delete(I);
      if FActiveStyle is StyleClass then
        SetStyle(FSystemStyle);
      Exit;
    end;
  raise ECustomStyleException.CreateResFmt(@SStyleClassNotFound, [StyleClass.ClassName]);
end;

{ TCustomElementServices }

class function TCustomElementServices.DrawEdge(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const R: TRect; Edges: TElementEdges;
  Flags: TElementEdgeFlags; ContentRect: PRect): Boolean;
begin
  Result := False;
end;

class function TCustomElementServices.DrawElement(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const R: TRect; ClipRect: PRect): Boolean;
begin
  Result := False;
end;

class function TCustomElementServices.DrawIcon(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const R: TRect; himl: HIMAGELIST;
  Index: Integer): Boolean;
begin
  Result := False;
end;

class function TCustomElementServices.DrawText(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const S: string; var R: TRect;
  Flags: TTextFormat; Options: TStyleTextOptions): Boolean;
begin
  Result := False;
end;

class function TCustomElementServices.GetElementColor(Style: TCustomStyleServices;
  Part, State: Integer; ElementColor: TElementColor; out Color: TColor): Boolean;
begin
  Result := False;
end;

class function TCustomElementServices.GetElementContentRect(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const BoundingRect: TRect; out ContentRect: TRect): Boolean;
begin
  Result := False;
end;

class function TCustomElementServices.GetElementMargins(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; Rect: PRect; Margin: TElementMargin;
  out ElementMargins: TElementMargins): Boolean;
begin
  Result := False;
end;

class function TCustomElementServices.GetElementRegion(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const Rect: TRect; out Region: HRGN): Boolean;
begin
  Result := False;
end;

class function TCustomElementServices.GetElementSize(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; Rect: PRect; ElementSize: TElementSize;
  out Size: TSize): Boolean;
begin
  Result := False;
end;

class function TCustomElementServices.GetTextExtent(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const Text: string; Flags: TTextFormat;
  BoundingRect: PRect; out ExtentRect: TRect): Boolean;
begin
  Result := False;
end;

class function TCustomElementServices.HasTransparentParts(Style: TCustomStyleServices;
  Part, State: Integer): Boolean;
begin
  Result := False;
end;

{ TPlatformGridServices }

class function TUxThemeGridElements.DrawElement(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const R: TRect; ClipRect: PRect): Boolean;
var
  LRect: TRect;
  LDetails: TTHemedElementDetails;
begin
  case TThemedGrid(State) of
    tgCellSelected..tgCellRowSelectedRight:
      begin
        case TThemedGrid(State) of
          tgCellSelected:
            LRect := R;
          tgCellRowSelectedLeft:
            LRect := TRect.Create(R.Left, R.Top, R.Right, R.Bottom);
          tgCellRowSelectedCenter:
            LRect := TRect.Create(R.Left, R.Top, R.Right, R.Bottom);
          tgCellRowSelectedRight:
            LRect := TRect.Create(R.Left, R.Top, R.Right, R.Bottom);
        end;
        Result := Style.DrawElement(DC, Style.GetElementDetails(tmPopupItemHot), LRect, ClipRect);
      end;

    tgFixedCellNormal..tgFixedCellPressed:
      begin
        case TThemedGrid(State) of
          tgFixedCellNormal: LDetails := Style.GetElementDetails(thHeaderItemNormal);
          tgFixedCellHot: LDetails := Style.GetElementDetails(thHeaderItemHot);
          tgFixedCellPressed: LDetails := Style.GetElementDetails(thHeaderItemPressed);
        end;
        LRect := R;
        if TOSVersion.Check(6) then
          InflateRect(LRect, 1, 1);
        Result := Style.DrawElement(DC, LDetails, R, ClipRect);
      end;

    tgDropDownButtonNormal..tgDropDownButtonDisabled:
      begin
        case TThemedGrid(State) of
          tgDropDownButtonNormal: LDetails := Style.GetElementDetails(tcDropDownButtonNormal);
          tgDropDownButtonHot: LDetails := Style.GetElementDetails(tcDropDownButtonHot);
          tgDropDownButtonPressed: LDetails := Style.GetElementDetails(tcDropDownButtonPressed);
          tgDropDownButtonDisabled: LDetails := Style.GetElementDetails(tcDropDownButtonDisabled);
        end;
        Result := Style.DrawElement(DC, LDetails, R, ClipRect);
      end;

    tgEllipsisButtonNormal..tgEllipsisButtonPressed:
      begin
        case TThemedGrid(State) of
          tgEllipsisButtonNormal: LDetails := Style.GetElementDetails(tbPushButtonNormal);
          tgEllipsisButtonPressed: LDetails := Style.GetElementDetails(tbPushButtonPressed);
          tgEllipsisButtonHot: LDetails := Style.GetElementDetails(tbPushButtonHot);
        else
          Exit(False);
        end;
        Result := Style.DrawElement(DC, LDetails, R, ClipRect);
      end
  else
    Result := False;
  end;
end;

class function TUxThemeGridElements.DrawText(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const S: string; var R: TRect;
  Flags: TTextFormat; Options: TStyleTextOptions): Boolean;
begin
  case TThemedGrid(State) of
    tgClassicCellNormal,
    tgCellNormal,
    tgGradientCellNormal,
    tgClassicCellSelected,
    tgCellSelected,
    tgGradientCellSelected,
    tgClassicFixedCellNormal,
    tgFixedCellNormal,
    tgGradientFixedCellNormal,
    tgClassicFixedCellHot,
    tgFixedCellHot,
    tgGradientFixedCellHot,
    tgClassicFixedCellPressed,
    tgFixedCellPressed,
    tgGradientFixedCellPressed:
      Result := Style.DrawText(DC, Style.GetElementDetails(thHeaderItemNormal), S, R, Flags, Options);
  else
    Result := False;
  end;
end;

class function TUxThemeGridElements.GetElementColor(Style: TCustomStyleServices;
  Part, State: Integer; ElementColor: TElementColor; out Color: TColor): Boolean;
begin
  Result := True;

  case TThemedGrid(State) of
    // Themed style
    tgCellNormal:
      case ElementColor of
        ecBorderColor:
          if TOSVersion.Check(6) then
            Color := $F0F0F0
          else
            Color := $D8E9EC;
        ecFillColor:
          Result := Style.GetElementColor(Style.GetElementDetails(tlListItemNormal), ecFillColor, Color);
        ecTextColor:
          Color := clNone;
      else
        Result := False;
      end;
    tgCellSelected..tgCellRowSelectedRight:
      case ElementColor of
        ecTextColor:
          Result := Style.GetElementColor(Style.GetElementDetails(tmPopupItemHot), ecTextColor, Color);
      else
        Result := False;
      end;
    tgFixedCellNormal:
      case ElementColor of
        ecBorderColor:
          if TOSVersion.Check(6) then
            Result := Style.GetElementColor(Style.GetElementDetails(thHeaderItemNormal), ecEdgeFillColor, Color)
          else
            Color := $B8C7CB;
        ecFillColor:
          Result := Style.GetElementColor(Style.GetElementDetails(tlListItemNormal), ecFillColor, Color);
        ecTextColor:
          Color := clNone;
      else
        Result := False;
      end;
    tgFixedCellHot..tgFixedCellPressed:
      if ElementColor = ecTextColor then
        Color := clNone
      else
        Result := False;

    // Gradient style
    tgGradientCellNormal:
      case ElementColor of
        ecBorderColor:
          Color := clNone;
        ecFillColor:
          Color := clNone;
        ecTextColor:
          Color := clNone;
      else
        Result := False;
      end;
    tgGradientCellSelected..tgGradientCellRowSelectedRight:
      case ElementColor of
        ecTextColor:
          Color := clNone;
        ecGradientColor1:
          Color := clNone;
        ecGradientColor2:
          Color := clNone;
      else
        Result := False;
      end;
    tgGradientFixedCellNormal:
      case ElementColor of
        ecBorderColor:
          Color := clNone;
        ecGradientColor1:
          Color := clNone;
        ecGradientColor2:
          Color := clNone;
        ecTextColor:
          Color := clNone;
      else
        Result := False;
      end;
    tgGradientFixedCellHot:
      case ElementColor of
        ecBorderColor:
          Color := clNone;
        ecGradientColor1:
          Color := clNone;
        ecGradientColor2:
          Color := clNone;
        ecTextColor:
          Color := clNone;
      else
        Result := False;
      end;
    tgGradientFixedCellPressed:
      case ElementColor of
        ecBorderColor:
          Color := clNone;
        ecGradientColor1:
          Color := clNone;
        ecGradientColor2:
          Color := clNone;
        ecTextColor:
          Color := clNone;
      else
        Result := False;
      end;

    // Classic style
    tgClassicCellNormal:
      case ElementColor of
        ecBorderColor:
          Color := clNone;
        ecFillColor:
          Color := clNone;
        ecTextColor:
          Color := clNone;
      else
        Result := False;
      end;
    tgClassicCellSelected..tgClassicCellRowSelectedRight:
      case ElementColor of
        ecFillColor:
          Color := clNone;
        ecTextColor:
          Color := clNone;
      else
        Result := False;
      end;
    tgClassicFixedCellNormal:
      case ElementColor of
        ecBorderColor:
          Color := clNone;
        ecFillColor:
          Color := clNone;
        ecTextColor:
          Color := clNone;
      else
        Result := False;
      end;
    tgClassicFixedCellHot..tgClassicFixedCellPressed:
      case ElementColor of
        ecFillColor:
          Color := clNone;
        ecTextColor:
          Color := clNone;
      else
        Result := False;
      end
  else
    Result := False;
  end;
end;

{ TPlatformLabelPaintServices }

class function TUxThemeTextLabelElements.DrawText(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const S: string; var R: TRect;
  Flags: TTextFormat; Options: TStyleTextOptions): Boolean;
var
  LRect: TRect;
  LFlags: Cardinal;
  LOptions: TDTTOpts;
  LColor, LSaveColor: TColor;
  LDetails: TThemedElementDetails;
begin
  if (State = Ord(ttlTextLabelNormal)) or (tfCalcRect in Flags) then
    Result := Style.DrawText(DC, Style.GetElementDetails(teEditTextNormal), S, R, Flags, Options)
  else
  begin
    if TOSVersion.Check(6) then
    begin
      FillChar(LOptions, SizeOf(LOptions), 0);
      LOptions.dwSize := SizeOf(LOptions);

      LOptions.dwFlags := LOptions.dwFlags or DTT_TEXTCOLOR or DTT_SHADOWCOLOR or
        DTT_SHADOWTYPE or DTT_SHADOWOFFSET;
      if GetElementColor(Style, Part, State, ecShadowColor, LColor) and (LColor <> clNone) then
        LOptions.crText := LColor
      else
        LOptions.crText := TColorRef(ColorToRGB(clBtnShadow));

      if GetElementColor(Style, Part, State, ecTextColor, LColor) and (LColor <> clNone) then
        LOptions.crShadow := LColor
      else
        LOptions.crShadow := ColorToRGB(clBtnHighlight);
      LOptions.ptShadowOffset := TPoint.Create(1, 1);
      LOptions.iTextShadowType := TST_SINGLE;

      if (tfComposited in Flags) then
        LOptions.dwFlags := LOptions.dwFlags or DTT_COMPOSITED;
      if (tfCalcRect in Flags) then
        LOptions.dwFlags := LOptions.dwFlags or DTT_CALCRECT;

      LDetails := TStyleManager.SystemStyle.GetElementDetails(teEditTextDisabled);
      Result := DrawThemeTextEx(TStyleManager.SystemStyle.Theme[LDetails.Element], DC, LDetails.Part,
        LDetails.State, PChar(S), Length(S), TTextFormatFlags(Flags), @R, LOptions) = S_OK;
    end
    else
    begin
      LRect := R;
      LFlags := TTextFormatFlags(Flags);
      OffsetRect(LRect, 1, 1);
      if not GetElementColor(Style, Part, State, ecTextColor, LColor) or (LColor = clNone) then
        LColor := ColorToRGB(clBtnHighlight);
      LSaveColor := SetTextColor(DC, LColor);
      try
        Winapi.Windows.DrawText(DC, PChar(S), Length(S), LRect, LFlags);
        OffsetRect(LRect, -1, -1);
        if not GetElementColor(Style, Part, State, ecShadowColor, LColor) or (LColor = clNone) then
          LColor := ColorToRGB(clBtnShadow);
        SetTextColor(DC, LColor);
        Winapi.Windows.DrawText(DC, PChar(S), Length(S), LRect, LFlags);
      finally
        SetTextColor(DC, LSaveColor);
      end;
      Result := True;
    end;
  end;
end;

class function TUxThemeTextLabelElements.GetElementColor(Style: TCustomStyleServices;
  Part, State: Integer; ElementColor: TElementColor; out Color: TColor): Boolean;
begin
  Result := True;
  case TThemedTextLabel(State) of
    ttlTextLabelNormal:
      Result := False; // Do not override Font.Color
    ttlTextLabelDisabled:
      case ElementColor of
        ecTextColor:
          Color := ColorToRGB(clBtnHighlight);
        ecShadowColor:
          Color := ColorToRGB(clBtnShadow);
      else
        Result := False;
      end;
  else
    Result := False;
  end;
end;

class function TUxThemeTextLabelElements.GetElementContentRect(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const BoundingRect: TRect; out ContentRect: TRect): Boolean;
begin
  ContentRect := BoundingRect;
  Result := True;
end;

class function TUxThemeTextLabelElements.GetTextExtent(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const Text: string; Flags: TTextFormat;
  BoundingRect: PRect; out ExtentRect: TRect): Boolean;
begin
  if BoundingRect <> nil then
    ExtentRect := BoundingRect^
  else
    ExtentRect := TRect.Empty;
  Result := Style.DrawText(DC, Style.GetElementDetails(TThemedTextLabel(State)),
    Text, ExtentRect, Flags + [tfCalcRect]);
end;

{ TPlatformCategoryButtonsServices }

class function TUxThemeCategoryButtonElements.DrawElement(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const R: TRect; ClipRect: PRect): Boolean;
begin
  case TThemedCategoryButtons(State) of
    tcbCategoryGlyphOpened:
      Result := Style.DrawElement(DC, Style.GetElementDetails(ttGlyphOpened), R, ClipRect);
    tcbCategoryGlyphClosed:
      Result := Style.DrawElement(DC, Style.GetElementDetails(ttGlyphClosed), R, ClipRect);
  else
    Result := False;
  end;
end;

class function TUxThemeCategoryButtonElements.GetElementColor(Style: TCustomStyleServices;
  Part, State: Integer; ElementColor: TElementColor; out Color: TColor): Boolean;
begin
  Result := True;

  case TThemedCategoryButtons(State) of
    tcbBackground:
      case ElementColor of
        ecFillColor: Color := clNone;
      else
        Result := False;
      end;

    tcbCategoryNormal:
      case ElementColor of
        ecGradientColor1: Color := clNone;
        ecGradientColor2: Color := clNone;
        ecTextColor: Color := clNone;
      else
        Result := False;
      end;
    tcbCategorySelected:
      case ElementColor of
        ecGradientColor1: Color := clNone;
        ecGradientColor2: Color := clNone;
        ecTextColor: Color := clNone;
      else
        Result := False;
      end;

    tcbButtonNormal:
      case ElementColor of
        ecTextColor: Color := clNone;
        ecBorderColor: Color := clNone;
      else
        Result := False;
      end;
    tcbButtonHot:
      case ElementColor of
        ecTextColor: Color := clNone;
        ecBorderColor: Color := clNone;
      else
        Result := False;
      end;
    tcbButtonSelected:
      case ElementColor of
        ecTextColor: Color := clNone;
        ecBorderColor: Color := clNone;
      else
        Result := False;
      end;

    tcbCategoryChevronOpened:
      case ElementColor of
        ecFillColor: Color := clNone;
      else
        Result := False;
      end;
    tcbCategoryChevronClosed:
      case ElementColor of
        ecFillColor: Color := clNone;
      else
        Result := False;
      end;
  else
    Result := False;
  end;
end;

{ TUxThemeCategoryPanelGroupElements }

class function TUxThemeCategoryPanelGroupElements.DrawElement(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const R: TRect; ClipRect: PRect): Boolean;
begin
  case TThemedCategoryPanelGroup(State) of
    tcpThemedHeader:
      Result := Style.DrawElement(DC, Style.GetElementDetails(tebNormalGroupHead), R, ClipRect);
    tcpThemedChevronOpenedNormal:
      Result := Style.DrawElement(DC, Style.GetElementDetails(tebNormalGroupCollapseNormal), R, ClipRect);
    tcpThemedChevronOpenedHot:
      Result := Style.DrawElement(DC, Style.GetElementDetails(tebNormalGroupCollapseHot), R, ClipRect);
    tcpThemedChevronOpenedPressed:
      Result := Style.DrawElement(DC, Style.GetElementDetails(tebNormalGroupCollapsePressed), R, ClipRect);
    tcpThemedChevronClosedNormal:
      Result := Style.DrawElement(DC, Style.GetElementDetails(tebNormalGroupExpandNormal), R, ClipRect);
    tcpThemedChevronClosedHot:
      Result := Style.DrawElement(DC, Style.GetElementDetails(tebNormalGroupExpandHot), R, ClipRect);
    tcpThemedChevronClosedPressed:
      Result := Style.DrawElement(DC, Style.GetElementDetails(tebNormalGroupExpandPressed), R, ClipRect);
  else
    Result := False;
  end;
end;

class function TUxThemeCategoryPanelGroupElements.DrawText(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const S: string; var R: TRect;
  Flags: TTextFormat; Options: TStyleTextOptions): Boolean;
begin
  Result := True;
  case TThemedCategoryPanelGroup(State) of
    tcpGradientHeader:
      Winapi.Windows.DrawText(DC, S, Length(S), R, TTextFormatFlags(Flags));
    tcpThemedHeader:
      Result := Style.DrawText(DC, Style.GetElementDetails(tebNormalGroupHead), S, R, Flags, Options);
  else
    Result := False;
  end;
end;

class function TUxThemeCategoryPanelGroupElements.GetElementColor(Style: TCustomStyleServices;
  Part, State: Integer; ElementColor: TElementColor; out Color: TColor): Boolean;
begin
  Result := True;
  case TThemedCategoryPanelGroup(State) of
    tcpBackground:
      case ElementColor of
        ecFillColor: Color := clNone;
      else
        Result := False;
      end;
    tcpGradientHeader:
      case ElementColor of
        ecGradientColor1: Color := clNone;
        ecGradientColor2: Color := clNone;
      else
        Result := False;
      end;
    tcpChevronOpenedNormal..tcpChevronOpenedPressed:
      if ElementColor = ecFillColor then
        Color := clNone
      else
        Result := False;
    tcpChevronClosedNormal..tcpChevronClosedPressed:
      if ElementColor = ecFillColor then
        Color := clNone
      else
        Result := False;
  else
    Result := False;
  end;
end;

class function TUxThemeCategoryPanelGroupElements.GetElementSize(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; Rect: PRect; ElementSize: TElementSize; out Size: TSize): Boolean;
var
  LPart: TThemedExplorerBar;
begin
  Result := True;
  LPart := tebExplorerBarDontCare;

  case TThemedCategoryPanelGroup(State) of
    tcpChevronOpenedNormal..tcpChevronClosedLeftPressed:
      begin
        if ElementSize = esActual then
          Size := TSize.Create(16, 16)
        else
          Result := False;
        Exit;
      end;
    tcpThemedChevronOpenedNormal:
      LPart := tebHeaderPinNormal;
    tcpThemedChevronOpenedHot:
      LPart := tebHeaderPinHot;
    tcpThemedChevronOpenedPressed:
      LPart := tebHeaderPinPressed;
    tcpThemedChevronClosedNormal:
      LPart := tebNormalGroupExpandNormal;
    tcpThemedChevronClosedHot:
      LPart := tebNormalGroupExpandHot;
    tcpThemedChevronClosedPressed:
      LPart := tebNormalGroupExpandPressed;
  else
    Result := False;
  end;

  if Result then
    if ElementSize = esActual then
    begin
      if Rect <> nil then
        Result := Style.GetElementSize(DC, Style.GetElementDetails(LPart), Rect^, ElementSize, Size)
      else
        Result := Style.GetElementSize(DC, Style.GetElementDetails(LPart), ElementSize, Size);
    end
    else
      Result := False;
end;

{ TUxThemePanelElements }

class function TUxThemePanelElements.DrawText(Style: TCustomStyleServices;
  DC: HDC; Part, State: Integer; const S: string; var R: TRect;
  Flags: TTextFormat; Options: TStyleTextOptions): Boolean;
begin
  Result := Style.DrawText(DC, Style.GetElementDetails(teEditTextNormal), S, R, Flags, Options);
end;

class function TUxThemePanelElements.GetElementColor(Style: TCustomStyleServices; Part,
  State: Integer; ElementColor: TElementColor; out Color: TColor): Boolean;
begin
  Result := True;
  case TThemedPanel(State) of
    tpPanelBackground:
      case ElementColor of
        ecFillColor:
          Color := clNone;
        ecTextColor:
          Color := clNone;
      else
        Result := False;
      end;
    tpPanelBevel:
      case ElementColor of
        ecEdgeHighLightColor: Color := clNone;
        ecEdgeShadowColor: Color := clNone;
      else
        Result := False;
      end;
    tpDockPanelHorzNormal, tpDockPanelHorzSelected,
    tpDockPanelVertNormal, tpDockPanelVertSelected:
      case ElementColor of
        ecBorderColor:
          Color := clNone;
        ecFillColor:
          Color := clNone;
        ecTextColor:
          Color := clNone;
      else
        Result := False;
      end;
    tpDockPanelPinNormal, tpDockPanelCloseNormal:
      case ElementColor of
        ecEdgeFillColor:
          Color := clNone;
        ecEdgeShadowColor:
          Color := clNone;
        ecEdgeHighLightColor:
          Color := clNone;
        ecEdgeDkShadowColor:
          Color := clNone;
        ecFillColor:
          Color := clNone;
      else
        Result := False;
      end;
  else
    Result := False;
  end;
end;

{ TUxThemeCheckListBoxElements }

class function TUxThemeCheckListBoxElements.GetElementColor(Style: TCustomStyleServices;
  Part, State: Integer; ElementColor: TElementColor; out Color: TColor): Boolean;
begin
  Result := True;
  case TThemedCheckListBox(State) of
    tclListItemNormal:
      case ElementColor of
        ecTextColor: Color := clNone;
      else
        Result := False;
      end;
    tclListItemDisabled:
      case ElementColor of
        ecTextColor: Color := clNone;
      else
        Result := False;
      end;
    tclHeaderItemNormal:
      case ElementColor of
        ecFillColor: Color := clNone;
        ecTextColor: Color := clNone;
      else
        Result := False;
      end;
    tclHeaderItemDisabled:
      case ElementColor of
        ecFillColor: Color := clNone;
        ecTextColor: Color := clNone;
      else
        Result := False;
      end;
  else
    Result := False;
  end;
end;

{ TStyleElementEdges }

class operator TStyleElementEdges.Implicit(Value: TStyleElementEdges): TElementEdges;
begin
  Result := Value.FValue;
end;

class operator TStyleElementEdges.Implicit(Value: TElementEdges): TStyleElementEdges;
begin
  Result.FValue := Value;
end;

class operator TStyleElementEdges.Implicit(Value: TStyleElementEdges): Cardinal;
const
  CFlags: array[TElementEdge] of Cardinal = (
    BDR_RAISEDINNER, BDR_SUNKENINNER, BDR_RAISEDOUTER, BDR_SUNKENOUTER,
    EDGE_BUMP, EDGE_ETCHED, EDGE_RAISED, EDGE_SUNKEN);
var
  LElementEdge: TElementEdge;
begin
  Result := 0;
  for LElementEdge := Low(TElementEdge) to High(TElementEdge) do
    if (LElementEdge in Value.FValue) then
      Result := Result or CFlags[LElementEdge];
end;

class operator TStyleElementEdges.Implicit(Value: Cardinal): TStyleElementEdges;
begin
  Result.FValue := [];
  if (Value and BDR_RAISEDOUTER) = BDR_RAISEDOUTER then
    Include(Result.FValue, eeRaisedOuter);
  if (Value and BDR_SUNKENOUTER) = BDR_SUNKENOUTER then
    Include(Result.FValue, eeSunkenOuter);
  if (Value and BDR_RAISEDINNER) = BDR_RAISEDINNER then
    Include(Result.FValue, eeRaisedInner);
  if (Value and BDR_SUNKENINNER) = BDR_SUNKENINNER then
    Include(Result.FValue, eeSunkenInner);
  if (Value and EDGE_RAISED) = EDGE_RAISED then
    Include(Result.FValue, eeRaised);
  if (Value and EDGE_SUNKEN) = EDGE_SUNKEN then
    Include(Result.FValue, eeSunken);
  if (Value and EDGE_ETCHED) = EDGE_ETCHED then
    Include(Result.FValue, eeEtched);
  if (Value and EDGE_BUMP) = EDGE_BUMP then
    Include(Result.FValue, eeBump);
end;

{ TStyleElementEdgeFlags }

class operator TStyleElementEdgeFlags.Implicit(Value: TStyleElementEdgeFlags): TElementEdgeFlags;
begin
  Result := Value.FValue;
end;

class operator TStyleElementEdgeFlags.Implicit(Value: TElementEdgeFlags): TStyleElementEdgeFlags;
begin
  Result.FValue := Value;
end;

class operator TStyleElementEdgeFlags.Implicit(Value: TStyleElementEdgeFlags): Cardinal;
const
  CFlags: array[TElementEdgeFlag] of Cardinal = (
    BF_LEFT, BF_TOP, BF_RIGHT, BF_BOTTOM, BF_TOPLEFT, BF_TOPRIGHT,
    BF_BOTTOMLEFT, BF_BOTTOMRIGHT, BF_RECT, BF_DIAGONAL, BF_DIAGONAL_ENDTOPRIGHT,
    BF_DIAGONAL_ENDTOPLEFT, BF_DIAGONAL_ENDBOTTOMLEFT, BF_DIAGONAL_ENDBOTTOMRIGHT,
    BF_MIDDLE, BF_SOFT, BF_ADJUST, BF_FLAT, BF_MONO);
var
  LElementEdgeFlag: TElementEdgeFlag;
begin
  Result := 0;
  for LElementEdgeFlag := Low(TElementEdgeFlag) to High(TElementEdgeFlag) do
    if (LElementEdgeFlag in Value.FValue) then
      Result := Result or CFlags[LElementEdgeFlag];
end;

class operator TStyleElementEdgeFlags.Implicit(Value: Cardinal): TStyleElementEdgeFlags;
begin
  Result.FValue := [];
  if (Value and BF_LEFT) = BF_LEFT then
    Include(Result.FValue, efLeft);
  if (Value and BF_TOP) = BF_TOP then
    Include(Result.FValue, efTop);
  if (Value and BF_RIGHT) = BF_RIGHT then
    Include(Result.FValue, efRight);
  if (Value and BF_BOTTOM) = BF_BOTTOM then
    Include(Result.FValue, efBottom);
  if (Value and BF_TOPLEFT) = BF_TOPLEFT then
    Include(Result.FValue, efTopLeft);
  if (Value and BF_TOPRIGHT) = BF_TOPRIGHT then
    Include(Result.FValue, efTopRight);
  if (Value and BF_BOTTOMLEFT) = BF_BOTTOMLEFT then
    Include(Result.FValue, efBottomLeft);
  if (Value and BF_BOTTOMRIGHT) = BF_BOTTOMRIGHT then
    Include(Result.FValue, efBottomRight);
  if (Value and BF_RECT) = BF_RECT then
    Include(Result.FValue, efRect);
  if (Value and BF_DIAGONAL) = BF_DIAGONAL then
    Include(Result.FValue, efDiagonal);
  if (Value and BF_DIAGONAL_ENDTOPRIGHT) = BF_DIAGONAL_ENDTOPRIGHT then
    Include(Result.FValue, efDiagonalEndTopLeft);
  if (Value and BF_DIAGONAL_ENDTOPLEFT) = BF_DIAGONAL_ENDTOPLEFT then
    Include(Result.FValue, efDiagonalEndTopRight);
  if (Value and BF_DIAGONAL_ENDBOTTOMLEFT) = BF_DIAGONAL_ENDBOTTOMLEFT then
    Include(Result.FValue, efDiagonalEndBottomLeft);
  if (Value and BF_DIAGONAL_ENDBOTTOMRIGHT) = BF_DIAGONAL_ENDBOTTOMRIGHT then
    Include(Result.FValue, efDiagonalEndBottomRight);
  if (Value and BF_MIDDLE) = BF_MIDDLE then
    Include(Result.FValue, efMiddle);
  if (Value and BF_SOFT) = BF_SOFT then
    Include(Result.FValue, efSoft);
  if (Value and BF_ADJUST) = BF_ADJUST then
    Include(Result.FValue, efAdjust);
  if (Value and BF_FLAT) = BF_FLAT then
    Include(Result.FValue, efFlat);
  if (Value and BF_MONO) = BF_MONO then
    Include(Result.FValue, efMono);
end;

{ TUxThemeTabSetElements }

class function TUxThemeTabSetElements.GetElementColor(Style: TCustomStyleServices;
  Part, State: Integer; ElementColor: TElementColor; out Color: TColor): Boolean;
begin
  Result := True;
  case TThemedTabSet(State) of
    tbsBackground:
      case ElementColor of
        ecFillColor: Color := clNone;
      else
        Result := False;
      end;
    tbsTabNormal:
      case ElementColor of
        ecFillColor: Color := clNone;
        ecEdgeFillColor: Color := clNone;
        ecEdgeShadowColor: Color := clNone;
        ecEdgeDkShadowColor: Color := clNone;
        ecTextColor: Color := clNone;
      else
        Result := False;
      end;
    tbsTabSelected:
      case ElementColor of
        ecFillColor: Color := clNone;
        ecEdgeFillColor: Color := clNone;
        ecEdgeShadowColor: Color := clNone;
        ecEdgeDkShadowColor: Color := clNone;
        ecEdgeHighLightColor: Color := clNone;
        ecTextColor: Color := clNone;
      else
        Result := False;
      end;
  else
    Result := False;
  end;
end;

{ TUxThemeControlBarElements }

class function TUxThemeControlBarElements.GetElementColor(Style: TCustomStyleServices;
  Part, State: Integer; ElementColor: TElementColor; out Color: TColor): Boolean;
begin
  Result := True;
  case TThemedControlBar(State) of
    tcbGradientItemFrame:
      case ElementColor of
        ecGradientColor1: Color := clNone;
        ecGradientColor2: Color := clNone;
      else
        Result := False;
      end;
  else
    Result := False;
  end;
end;

{ TUxThemeHintElements }

class function TUxThemeHintElements.GetElementColor(Style: TCustomStyleServices;
  Part, State: Integer; ElementColor: TElementColor; out Color: TColor): Boolean;
begin
  Result := True;
  case TThemedHint(State) of
    thHintNormal:
      case ElementColor of
        ecGradientColor1: Color := clNone;
        ecGradientColor2: Color := clNone;
        ecTextColor: Color := clNone;
      else
        Result := False;
      end;
    thHintBalloon:
      case ElementColor of
        ecBorderColor: Color := clNone;
        ecGradientColor1: Color := clNone;
        ecGradientColor2: Color := clNone;
        ecTextColor: Color := clNone;
      else
        Result := False;
      end;
  else
    Result := False;
  end;
end;


{ TElementMarginsHelper }

class function TElementMarginsHelper.Create(const Rect: TRect): TElementMargins;
begin
  Result.cxLeftWidth := Rect.Left;
  Result.cyTopHeight := Rect.Top;
  Result.cxRightWidth := Rect.Right;
  Result.cyBottomHeight := Rect.Bottom;
end;

class function TElementMarginsHelper.Create(LeftWidth, TopHeight, RightWidth,
  BottomHeight: Integer): TElementMargins;
begin
  Result.cxLeftWidth := LeftWidth;
  Result.cyTopHeight := TopHeight;
  Result.cxRightWidth := RightWidth;
  Result.cyBottomHeight := BottomHeight;
end;

{ TControlHook }

type
  TWinControlClass = class(TWinControl);

constructor TStyleHook.Create(AControl: TWinControl);
begin
  FControl := AControl;
  FCallDefaultProc := False;
  FOverridePaint := False;
  FOverrideEraseBkgnd := False;
  FOverridePaintNC := False;
  FDoubleBuffered := False;
  FNeedsDefaultPaint := False;
  FPaintOnEraseBkgnd := False;
  FHandled := False;
  FFocusUpdate := False;
  FBrush := TBrush.Create;
  FBrush.Color := StyleServices.GetStyleColor(scWindow);
  FFontColor := StyleServices.GetSystemColor(clWindowText);
end;

destructor TStyleHook.Destroy;
begin
  FBrush.Free;
  inherited Destroy;
end;

procedure TStyleHook.CallDefaultProc(var Msg: TMessage);
begin
  if FCallDefaultProc then
    FControl.WindowProc(Msg)
  else
  begin
    FCallDefaultProc := True;
    FControl.WindowProc(Msg);
    FCallDefaultProc := False;
  end;
end;

procedure TStyleHook.DrawControlText(Canvas: TCanvas; Details: TThemedElementDetails;
  const S: string; var R: TRect; Flags: Cardinal);
var
  ThemeTextColor: TColor;
  TextFormat: TTextFormatFlags;
begin
  Canvas.Font := TWinControlClass(Control).Font;
  TextFormat := TTextFormatFlags(Flags);
  if StyleServices.GetElementColor(Details, ecTextColor, ThemeTextColor) then
  begin
    if not Control.Enabled or (seFont in Control.StyleElements) then
      Canvas.Font.Color := ThemeTextColor;
    StyleServices.DrawText(Canvas.Handle, Details, S, R, TextFormat, Canvas.Font.Color);
  end
  else
  begin
    Canvas.Refresh;
    StyleServices.DrawText(Canvas.Handle, Details, S, R, TextFormat);
  end;
end;

function TStyleHook.AcceptMessage(var Message: TMessage): Boolean;
begin
  Result := True;

  if not (seBorder in Control.StyleElements) then
  begin
    case Message.Msg of
      WM_NCCREATE..WM_NCMBUTTONDBLCLK:
        Result := False;
    end;
  end;

  if not (seClient in Control.StyleElements) then
  begin
    case Message.Msg of
      WM_ERASEBKGND, WM_PAINT,
      WM_CTLCOLORMSGBOX..WM_CTLCOLORSTATIC,
      CN_CTLCOLORMSGBOX..CN_CTLCOLORSTATIC,
      TVM_SETBKCOLOR, LVM_SETBKCOLOR:
        Result := False;
    end;
  end;
end;

function TStyleHook.HandleMessage(var Message: TMessage): Boolean;
begin
  Result := False;

  if not AcceptMessage(Message) then Exit;

  if FCallDefaultProc then
  begin
    if not FNeedsDefaultPaint then
      case Message.Msg of
        WM_PAINT, WM_ERASEBKGND, WM_NCPAINT,
        WM_CTLCOLORMSGBOX..WM_CTLCOLORSTATIC,
        CN_CTLCOLORMSGBOX..CN_CTLCOLORSTATIC: ; // Allow message to be passed to WndProc
      else
        Exit;
      end
    else
      Exit;
  end;
  Handled := False;
  if StyleServices.Available then
    WndProc(Message);
  Result := Handled;
end;

function TStyleHook.GetStringPropValue(const PropName: string): string;
var
  PropInfo: PPropInfo;
begin
  Result := '';
  if Control = nil then Exit;
  if (PropName = 'Caption') and (Control <> nil) then // do not localize
    Result := TWinControlClass(Control).Caption;
  PropInfo := GetPropInfo(Control.ClassInfo, PropName);
  if PropInfo <> nil then
    Result := GetStrProp(Control, PropInfo);
end;

function TStyleHook.GetText: string;
var
  Buffer: array [0..255] of Char;
begin
  if (Handle <> 0) then
    SetString(Result, Buffer, GetWindowText(Handle, Buffer, Length(Buffer)))
  else
    Result := GetStringPropValue('Caption'); // do not localize
  FText := Result;
end;

procedure TStyleHook.SetRedraw(Value: Boolean);
begin
  if Control.Visible and Control.HandleAllocated then
    SendMessage(Control.Handle, WM_SETREDRAW, LPARAM(Value), 0);
end;

function TStyleHook.GetHandle: HWND;
begin
  if FControl.HandleAllocated then
    Result := FControl.Handle
  else
    Result := 0;
end;

function TStyleHook.HasBorder: Boolean;
begin
  Result := (GetWindowLong(Handle, GWL_STYLE) and WS_BORDER = WS_BORDER) or
    (GetWindowLong(Handle, GWL_EXSTYLE) and WS_EX_CLIENTEDGE = WS_EX_CLIENTEDGE);
end;

function TStyleHook.HasClientEdge: Boolean;
begin
  Result := GetWindowLong(Handle, GWL_EXSTYLE) and WS_EX_CLIENTEDGE = WS_EX_CLIENTEDGE;
end;

procedure TStyleHook.InvalidateNC;
begin
  if Control.HandleAllocated then
    SendMessage(Handle, WM_NCPAINT, 0, 0);
end;

procedure TStyleHook.Invalidate;
begin
  if Control.HandleAllocated then
  begin
    if FOverridePaintNC then
      InvalidateNC;
    InvalidateRect(Handle, nil, False);
  end;
end;

function TStyleHook.InternalPaint(DC: HDC): Boolean;
begin
  Result := False;
end;

procedure TStyleHook.Paint(Canvas: TCanvas);
begin
end;

procedure TStyleHook.PaintBackground(Canvas: TCanvas);
begin
  Canvas.Brush.Color := FBrush.Color;
  Canvas.FillRect(Control.ClientRect);
end;

procedure TStyleHook.PaintNC(Canvas: TCanvas);
begin
end;

procedure TStyleHook.WMPaint(var Message: TMessage);
var
  DC: HDC;
  Buffer: TBitmap;
  Canvas: TCanvas;
  PS: TPaintStruct;
begin
  if FOverridePaint then
  begin
    DC := HDC(Message.WParam);
    Canvas := TCanvas.Create;
    try
      if DC <> 0 then
        Canvas.Handle := DC
      else
        Canvas.Handle := BeginPaint(Control.Handle, PS);
      if not InternalPaint(Canvas.Handle) then
        if FDoubleBuffered and (DC = 0) then
        begin
          Buffer := TBitmap.Create;
          try
            Buffer.SetSize(Control.Width, Control.Height);
            PaintBackground(Buffer.Canvas);
            Paint(Buffer.Canvas);
            // paint other controls
            if Control is TWinControl then
              TWinControlClass(Control).PaintControls(Buffer.Canvas.Handle, nil);
            Canvas.Draw(0, 0, Buffer);
          finally
            Buffer.Free;
          end;
        end
       else
         begin
           Paint(Canvas);
           // paint other controls
           if Control is TWinControl then
              TWinControlClass(Control).PaintControls(Canvas.Handle, nil);
         end;
      if DC = 0 then
        EndPaint(Control.Handle, PS);
    finally
      Canvas.Handle := 0;
      Canvas.Free;
    end;
    Handled := True;
  end;
end;

procedure TStyleHook.WMNCPaint(var Message: TMessage);
var
  Canvas: TCanvas;
begin
  if FOverridePaintNC then
  begin
    Canvas := TCanvas.Create;
    try
      Canvas.Handle := GetWindowDC(Control.Handle);
      PaintNC(Canvas);
    finally
      ReleaseDC(Handle, Canvas.Handle);
      Canvas.Handle := 0;
      Canvas.Free;
    end;
    Handled := True;
  end;
end;

procedure TStyleHook.WMEraseBkgnd(var Message: TMessage);
var
  DC: HDC;
  Canvas: TCanvas;
  SaveIndex: Integer;
begin
  if FOverrideEraseBkgnd then
  begin
    if not FDoubleBuffered then
    begin
      DC := HDC(Message.WParam);
      SaveIndex := SaveDC(DC);
      Canvas := TCanvas.Create;
      try
        Canvas.Handle := DC;
        PaintBackground(Canvas);
        if FPaintOnEraseBkgnd then
          Paint(Canvas);
      finally
        Canvas.Handle := 0;
        Canvas.Free;
        RestoreDC(DC, SaveIndex);
      end;
    end;
    Handled := True;
    Message.Result := 1;
  end;
end;

procedure TStyleHook.WMSetFocus(var Message: TMessage);
begin
  FFocused := True;
  if FFocusUpdate then
    Invalidate;
end;

procedure TStyleHook.WMKillFocus(var Message: TMessage);
begin
  FFocused := False;
  if FFocusUpdate then
    Invalidate;
end;

procedure TStyleHook.CMEnabledChanged(var Message: TMessage);
begin
  CallDefaultProc(Message);
  Invalidate;
  Handled := True;
end;

procedure TStyleHook.CMTextChanged(var Message: TMessage);
begin
  CallDefaultProc(Message);
  Invalidate;
  Handled := True;
end;

procedure TStyleHook.WMSetText(var Message: TMessage);
begin
  CallDefaultProc(Message);
  Invalidate;
  Handled := True;
end;

procedure TStyleHook.WMEnable(var Message: TMessage);
begin
  CallDefaultProc(Message);
  Invalidate;
  Handled := True;
end;

procedure TStyleHook.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_CTLCOLORMSGBOX..WM_CTLCOLORSTATIC:
      with Message do
        Result := SendMessage(LParam, CN_BASE + Msg, WParam, LParam);
    CN_CTLCOLORMSGBOX..CN_CTLCOLORSTATIC:
      begin
        SetTextColor(Message.WParam, ColorToRGB(FFontColor));
        SetBkColor(Message.WParam, ColorToRGB(FBrush.Color));
        Message.Result := LRESULT(FBrush.Handle);
        Handled := True;
      end;
  end;
  Dispatch(Message);
end;

{ TMouseTrackControlHook }

constructor TMouseTrackControlStyleHook.Create(AControl: TWinControl);
begin
  inherited;
  FMouseInControl := False;
  FMouseInNCArea := False;
  Focused := False;
  FHotTrackTimer := nil;
end;

destructor TMouseTrackControlStyleHook.Destroy;
begin
  if FHotTrackTimer <> nil then
    StopHotTrackTimer;
  inherited;
end;

function TMouseTrackControlStyleHook.IsChildHandle(AHandle: HWnd): Boolean;
begin
  Result := False;
end;

function TMouseTrackControlStyleHook.IsMouseInControl: Boolean;
var
  P: TPoint;
begin
  GetCursorPos(P);
  Result := WindowFromPoint(P) = Handle;
  FMouseInControl := Result;
end;

procedure TMouseTrackControlStyleHook.StartHotTrackTimer;
begin
  if FHotTrackTimer <> nil then
    StopHotTrackTimer;
  FHotTrackTimer := TTimer.Create(nil);
  TTimer(FHotTrackTimer).Interval := 100;
  TTimer(FHotTrackTimer).OnTimer := DoHotTrackTimer;
  TTimer(FHotTrackTimer).Enabled := True;
end;

procedure TMouseTrackControlStyleHook.StopHotTrackTimer;
begin
  if FHotTrackTimer <> nil then
  begin
    TTimer(FHotTrackTimer).Enabled := False;
    FreeAndNil(FHotTrackTimer);
  end;
end;

procedure TMouseTrackControlStyleHook.DoHotTrackTimer;
var
  P: TPoint;
  FWindowHandle: HWnd;
begin
  GetCursorPos(P);
  FWindowHandle := WindowFromPoint(P);
  if (FWindowHandle <> Handle) and not IsChildHandle(FWindowHandle) then
  begin
    StopHotTrackTimer;
    FMouseInControl := False;
    MouseLeave;
  end;
end;

procedure TMouseTrackControlStyleHook.WMMouseMove(var Message: TWMMouse);
begin
  inherited;
  if not FMouseInControl and not FMouseInNCArea then
  begin
    FMouseInControl := True;
    StartHotTrackTimer;
    MouseEnter;
  end
  else if FMouseInNCArea and FMouseInControl then
  begin
    StopHotTrackTimer;
    FMouseInControl := False;
    MouseLeave;
  end;
end;

procedure TMouseTrackControlStyleHook.WMNCMouseMove(var Message: TWMMouse);
begin
  inherited;
  if not FMouseInControl then
  begin
    FMouseInControl := True;
    StartHotTrackTimer;
    MouseEnter;
  end;
end;

procedure TMouseTrackControlStyleHook.MouseEnter;
begin
end;

procedure TMouseTrackControlStyleHook.MouseLeave;
begin
end;

procedure TMouseTrackControlStyleHook.WndProc(var Message: TMessage);
begin
  // Reserved for potential updates
  inherited;
end;


{ TCustomStyleEngine }

class destructor TCustomStyleEngine.Destroy;
var
  LItem: TPair<TClass, TStyleHookList>;
begin
  for LItem in FRegisteredStyleHooks do
    LItem.Value.Free;
  FreeAndNil(FRegisteredStyleHooks);
end;

class procedure TCustomStyleEngine.RegisterStyleHook(ControlClass: TClass;
  StyleHookClass: TStyleHookClass);
var
  List: TStyleHookList;
begin
  if FRegisteredStyleHooks = nil then
    FRegisteredStyleHooks := TStyleHookDictionary.Create;

  if not FRegisteredStyleHooks.ContainsKey(ControlClass) then
  begin
    List := TStyleHookList.Create;
    List.Add(StyleHookClass);
    FRegisteredStyleHooks.Add(ControlClass, List);
  end
  else
  begin
    List := FRegisteredStyleHooks[ControlClass];
    if List.IndexOf(StyleHookClass) = -1 then
      List.Add(StyleHookClass)
    else
      raise EStyleEngineException.CreateResFmt(@SStyleHookClassRegistered,
        [StyleHookClass.ClassName, ControlClass.ClassName]);
  end;
end;

class procedure TCustomStyleEngine.UnRegisterStyleHook(ControlClass: TClass;
  StyleHookClass: TStyleHookClass);
var
  List: TStyleHookList;
  Pair: TPair<TClass, TStyleHookClass>;
  LEngine: TCustomStyleEngine;
begin
  if (ControlClass = nil) then
    raise EStyleEngineException.CreateResFmt(@SStyleInvalidParameter, ['ControlClass']); // do not localize

  if (StyleHookClass = nil) then
    raise EStyleEngineException.CreateResFmt(@SStyleInvalidParameter, ['StyleHookClass']); // do not localize

  if (FRegisteredStyleHooks <> nil) and
     FRegisteredStyleHooks.ContainsKey(ControlClass) then
  begin
    List := FRegisteredStyleHooks[ControlClass];
    if List.IndexOf(StyleHookClass) <> -1 then
    begin
      List.Remove(StyleHookClass);
      Pair := TPair<TClass, TStyleHookClass>.Create(ControlClass, StyleHookClass);
      LEngine := TStyleManager.Engine;
      if LEngine <> nil then
        LEngine.Notification(snStyleHookUnregistered, @Pair);
    end
    else
      raise EStyleEngineException.CreateResFmt(@SStyleHookClassNotRegistered,
        [StyleHookClass.ClassName, ControlClass.ClassName]);
  end;
end;

{ TThemedElementDetails }

class function TThemedElementDetails.Create(Element: TThemedElement;
  Part, State: Integer): TThemedElementDetails;
begin
  Result.Element := Element;
  Result.Part := Part;
  Result.State := State;
end;

{ TThemeServicesClassHelper }

class operator TThemeServicesClassHelper.Implicit(AValue: TCustomStyleServicesClass): TThemeServicesClassHelper;
begin
  TStyleManager.SetStyle(AValue.Create);
end;

class operator TThemeServicesClassHelper.Implicit(AValue: TThemeServicesClassHelper): TCustomStyleServicesClass;
begin
  Result := TCustomStyleServicesClass(TStyleManager.ActiveStyle.ClassType);
end;

end.
