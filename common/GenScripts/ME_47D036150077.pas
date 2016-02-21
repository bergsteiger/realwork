unit l3ControlsTypes;

// Модуль: "w:\common\components\rtl\Garant\L3\l3ControlsTypes.pas"
// Стереотип: "Interfaces"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
;

const
 {* Item Hit Type }
 ihtNone = 0;
 ihtText = 1;
 ihtIcon = 2;
 ihtPickIcon = 3;
 ihtOpenChip = 4;
 ihtFooter = 5;

type
 TvtViewOption = (
  {* настройки отображения. }
  voShowInterRowSpace
  , voShowIcons
  , voShowExpandable
  , voShowRoot
  , voShowLines
  , voShowOpenChip
  , voVariableItemHeight
  , voWithoutImages
   {* ImageList не используется, и не создается фиктивный из ресурса. }
  , voShowItemEdgeLine
  , voShowSelectAsArrow
  , voDoNotShowFocusRect
  , voFullLineSelect
 );//TvtViewOption

 TvtViewOptions = set of TvtViewOption;

 Tl3GetItemImage = function(Sender: TObject;
  Index: Integer;
  var aImages: TCustomImageList): Integer of object;
  {* Event to get Index of Bitmap in ImageIndex. }

 Tl3ActionElementMode = (
  l3_amDoubleClick
  , l3_amSingleClick
  , l3_amSecondSingleClick
 );//Tl3ActionElementMode

 TvlViewOption = voShowInterRowSpace .. voShowInterRowSpace;

 TvlViewOptions = set of TvlViewOption;

 TvlOption = (
  vlMouseTrack
  , vlTooltips
 );//TvlOption

 TvlOptions = set of TvlOption;

implementation

uses
 l3ImplUses
;

end.
