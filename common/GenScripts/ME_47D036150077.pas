unit l3ControlsTypes;

interface

uses
 l3IntfUses
 , ImgList
;

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
 
 // TvlViewOption
 
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
