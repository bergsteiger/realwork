unit ChromeLikeTabSetRes;

interface

uses
  SysUtils, Classes, vgComponent, vgCustomResources, vg_scene, ChromeLikeTabSetTypes,
  ImgList, vtPngImgList;

type
  TChromeLikeTabSetResources = class(TDataModule)
    vgResources: TvgResources;
    CloseButtonImages: TvtNonFixedPngImageList;
  private
    function pm_GetCloseButtonImage(
      aState: TChromeLikeTabSetElementState): TImageIndex;
  public
    property CloseButtonImage[aState: TChromeLikeTabSetElementState]: TImageIndex
      read pm_GetCloseButtonImage;
  end;

const
 cChromeLikeTabStyleName = 'ChromeLikeTabItemStyle';
 cChromeLikeTabCloseButtonStyleName = 'ChromeLikeTabCloseButtonStyle';
 cChromeLikeTabCloseButtonLayoutName = 'TabCloseButtonLayout';
 // - название ресурса layout'a, в котором лежит кнопка закрытия вкладки
 cChromeLikeTabTextObjectResourceName      = 'text';
 // - название ресурса объекта текста на вкладке
 cChromeLikeTabCenterRectResourceName = 'Background';//'TabItemCenterRect';
 // - название ресурса центрального прямоугольника вкладки
 cChromeLikeTabRightPathResourceName = 'RightEdgePart';//'TabItemRightPath';
 // - название ресурса объекта TvgPath правого края вкладки
 cChromeLikeTabLeftPathResourceName = 'LeftEdgePart';//'TabItemLeftPath';
 // - название ресурса объекта TvgPath левого края вкладки
 cChromeLikeTabTopLineResourceName = 'TopEdgeLine';
 // - название ресурса объекта TvgLine верхней границы вкладки
 cChromeLikeTabBottomLineResourceName = 'BottomEdgeLine';
 // - название ресурса объекта TvgLine нижней границы вкладки
 cChromeLikeTabCloseButtonInactiveBitmap = 'TabCloseButtonInactiveBitmap';
 // - картинка для неактивного креста закрытия вкладки
 cChromeLikeTabCloseButtonActiveBitmap = 'TabCloseButtonActiveBitmap';
 // - картинка для активного креста закрытия вкладки
 cChromeLikeTabIconImageName = 'TabIconImage';
 // - название ресурса иконки таба

 cCloseButtonImages: array[TChromeLikeTabSetElementState] of TImageIndex = (0, -1, 1);
 // - картинки для крестика закрытия вкладки
 
 function ChromeLikeTabSetResources: TChromeLikeTabSetResources;

implementation
uses
 l3Base
 ;

{$R *.dfm}

var
  StdChromeLikeTabSetRes: TChromeLikeTabSetResources = nil;

procedure Fini;
begin
 FreeAndNil(StdChromeLikeTabSetRes);
end;

function ChromeLikeTabSetResources: TChromeLikeTabSetResources;
begin
 Assert(not l3SystemDown);
 if (StdChromeLikeTabSetRes = nil) then
 begin
  StdChromeLikeTabSetRes := TChromeLikeTabSetResources.Create(nil);
  l3System.AddExitProc(Fini);
 end;//StdChromeLikeTabSetRes = nil
 Result := StdChromeLikeTabSetRes;
end;

{ TChromeLikeTabSetResources }

function TChromeLikeTabSetResources.pm_GetCloseButtonImage(
  aState: TChromeLikeTabSetElementState): TImageIndex;
begin
 Result := cCloseButtonImages[aState];
end;

end.
