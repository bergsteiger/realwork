{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FmxDsnConst;

{$SCOPEDENUMS ON}

interface

resourcestring
  SCreateNewFloatAnimation = 'Create New TFloatAnimation';
  SCreateNewFloatKeyAnimation = 'Create New TFloatKeyAnimation';
  SCreateNewGradientAnimation = 'Create New TGradientAnimation';
  SCreateNewRectAnimation = 'Create New TRectAnimation';
  SCreateNewBitmapAnimation = 'Create New TBitmapAnimation';
  SCreateNewBitmapListAnimation = 'Create New TBitmapListAnimation';
  SCreateNewColorAnimation = 'Create New TColorAnimation';
  SCreateNewColorKeyAnimation = 'Create New TColorKeyAnimation';

  SEditItemCaption = 'Edit...';
  
  SItemsEditor = 'Items Editor...';
  SNewItem = 'Add Item';
  SNewLastItem = 'Add %s';
  SDeleteItem = 'Delete %s';
  SUnnamedTab = 'Unnamed %1:s %0:d';
  SNextTab = 'Next Tab';
  SPrevTab = 'Previous Tab';
  SCustomColors= 'Custom colors';

  SAnimations = 'Animations';
  SColors = 'Colors';
  SEffects = 'Effects';
  SShapes = 'Shapes';
  SViewports = 'Viewports';
  SShapes3D = '3D Shapes';
  SScene3D = '3D Scene';
  SLayers3D = '3D Layers';
  SDialogs = 'Dialogs';
  SLayouts = 'Layouts';
  SItems = 'Items';
  SGridsColumns = 'Grids';
  SMaterials = 'Materials';
  SInternet = 'Internet';
  SStyles = 'Styles';
  SGestures = 'Gestures';
 
  SNoSelectedControl = 'No control selected';
  SCustomGestures  = 'Custom Gestures...';
  SUnableToFindComponent = 'Unable to locate form/component, ''%s''';

  SThreeFloatsException = 'Float values must be entered in sets of three.';
  STwoFloatsException = 'Float values must be entered in sets of two.';
  SIntegersSetException = 'Integer values must be entered in sets of one.';

  SRemoveInfo = 'Clear information used only at design time?';

  SUnnamed = '<Unnamed>';
  SMediaLibraryCategory = 'Media Library';
  SPhoneCategory = 'Phone Dialer';
  SService = 'Services';

  SBitmapBrushWindowsOnly = 'Bitmap brush is only supported in OS Windows (GDI+ and D2D)';

  SMultiViewMode = 'Mode (%s)';
  SMultiViewPlatformBehavior = 'Platform Behavior';
  SMultiViewPanel = 'Docked Panel';
  SMultiViewlDropDown = 'Popover';
  SMultiViewDrawer = 'Drawer';
  SMultiViewNavigationPane = 'Navigation Pane';
  SMultiViewCustom = 'Custom';

  SLinkScale = 'Scale %nx';
  SAvailableScales = 'The source "%s" contains bitmaps with scales: %s' + sLineBreak +
    'The bitmap is shown for scale %s' + sLineBreak +
    'The coordinates are given for the scale %s';
  SNoScales = 'The source "%s" does not contain bitmaps';
  SNoSource = 'There is no source "%s"';
  SBitmapQueryScale = 'The image has a physical size %s. Do you want to use scale %s?';

  SMultiViewShow = 'Show';
  SMultiViewHide = 'Hide';

  SItemPurpose = 'Item';
  SHeaderPurpose = 'Header';
  SFooterPurpose = 'Footer';
  SPrototypeText = '%s %s';
  SPrototypeButtonText = 'Button';

  SDeleteAppearanceObject = 'Delete object';
  SToggleEditMode = 'Toggle EditMode';
  SToggleDesignMode = 'Toggle DesignMode';
  SAddNewAppearanceObject = 'Add new...';

type
  TAppearanceObject = (Text = 0, Image, Accessory, TextButton, GlyphButton);

const
  SSize = '%d ' + Chr(215) + ' %d';  // do not localize
  SBitmapSize = '(Bitmap %s)';  // do not localize

  SDynAppearanceObjectText = 'TTextObjectAppearance';  // do not localize
  SDynAppearanceObjectImage = 'TImageObjectAppearance'; // do not localize
  SDynAppearanceObjectAccessory = 'TAccessoryObjectAppearance'; // do not localize
  SDynAppearanceObjectTextButton = 'TTextButtonObjectAppearance'; // do not localize
  SDynAppearanceObjectGlyphButton = 'TGlyphButtonObjectAppearance'; // do not localize

  SNameFormatText = 'Text%d';
  SNameFormatImage = 'Image%d';
  SNameFormatAccessory = 'Accessory%d';
  SNameFormatTextButton = 'TextButton%d';
  SNameFormatGlyphButton = 'GlyphButton%d';

  ObjectAppearanceClass: array[TAppearanceObject] of string = (SDynAppearanceObjectText, SDynAppearanceObjectImage,
    SDynAppearanceObjectAccessory, SDynAppearanceObjectTextButton, SDynAppearanceObjectGlyphButton);
  ObjectAppearanceFormat: array[TAppearanceObject] of string = (SNameFormatText, SNameFormatImage, SNameFormatAccessory,
    SNameFormatTextButton, SNameFormatGlyphButton);

implementation

end.
