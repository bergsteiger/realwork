unit gtViewerTypes;

interface

type

  TgtStdZoomType = (sztActualSize, sztFitPage, sztFitWidth, sztCustom);
//  TgtRotationAngle = (ra0, raCW90, raCW180, raCW270, raACW90, raACW180, raACW270);
  TPageIndex = 1..MaxInt;
  TResDPI = 1..32767;

  TgtViewerMouseActivity = (vmaButtonDown, vmaButtonUp, vmaMoving, vmaSelecting{,
    vmaEnteringPage, vmaLeavingPage});

  TgtSelectionType = (stPoint, stRect);

  // Page display layout for viewer
  // plSingle = 1 page in view at a time.
  // plContinuous = Pages continuously displyed in view, one below the other
  TgtPageLayout = (plSingle, plContinuous);

  // Mode by which number of columns of pages is determined for viewer
  // pcCustom = use value specified in ColumnsCustomCount
  // pcMaxFit = automatically determine count. As many as will fit based on
  // current zoom value
  TgtPageColumns = (pcCustom, pcMaxFit);

  // Viewer page display resolution
  // rsUseCustom = Use value specified in ResDPICustom
  // rsUseSystem = Use system desktop display resolution
  TgtResDPISource = (rsUseCustom, rsUseSystem);

const
  cDEFAULT_BORDER_WIDTH = 6;
  cZOOM_RANGE_MIN = 0.25;
  cZOOM_RANGE_MAX = 3200.0;
  cPAGE_CACHE_COUNT = 2;
  // Half of total, as value is used to cache pages before current page and
  // beyond last visible
  cZOOM_STD_VALUES: array[0..13] of Single =
    (1, 5, 10, 25, 50, 75, 100, 150, 200, 400, 800, 1600, 2400, 3200);
  cDEFAULT_RES_DPI = 110;   // in pixels per inch

resourcestring
  sScrollToolTipText = 'Page: ';
  sRegionSelectorLabelPrefix = 'Region ';

implementation

end.
