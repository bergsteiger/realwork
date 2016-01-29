unit l3ControlsTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3ControlsTypes.pas"
// �����: 27.05.2005 16:42
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi Low Level::L3::l3ControlsTypes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  Classes
  {$If not defined(NoVCL)}
  ,
  ImgList
  {$IfEnd} //not NoVCL
  
  ;

type
 TvtViewOption = (
  {* ��������� �����������. }
   voShowInterRowSpace
 , voShowIcons
 , voShowExpandable
 , voShowRoot
 , voShowLines
 , voShowOpenChip
 , voVariableItemHeight
 , voWithoutImages // ImageList �� ������������, � �� ��������� ��������� �� �������.
 , voShowItemEdgeLine
 , voShowSelectAsArrow
 , voDoNotShowFocusRect
 , voFullLineSelect
 );//TvtViewOption

 TvtViewOptions = set of TvtViewOption;

 Tl3GetItemImage = function (Sender: TObject;
  Index: Integer;
  var aImages: TCustomImageList): Integer of object;

 Tl3ActionElementMode = (
   l3_amDoubleClick
 , l3_amSingleClick
 , l3_amSecondSingleClick
 );//Tl3ActionElementMode

 TvlViewOption = voShowInterRowSpace..voShowInterRowSpace;

 TvlViewOptions = set of TvlViewOption;

const
  { Item Hit Type }
 ihtNone = 0;
 ihtText = 1;
 ihtIcon = 2;
 ihtPickIcon = 3;
 ihtOpenChip = 4;
 ihtFooter = 5;

type
 TvlOption = (
   vlMouseTrack
 , vlTooltips
 );//TvlOption

 TvlOptions = set of TvlOption;

implementation

end.