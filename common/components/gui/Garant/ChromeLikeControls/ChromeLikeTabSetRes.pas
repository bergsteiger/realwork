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
 // - �������� ������� layout'a, � ������� ����� ������ �������� �������
 cChromeLikeTabTextObjectResourceName      = 'text';
 // - �������� ������� ������� ������ �� �������
 cChromeLikeTabCenterRectResourceName = 'Background';//'TabItemCenterRect';
 // - �������� ������� ������������ �������������� �������
 cChromeLikeTabRightPathResourceName = 'RightEdgePart';//'TabItemRightPath';
 // - �������� ������� ������� TvgPath ������� ���� �������
 cChromeLikeTabLeftPathResourceName = 'LeftEdgePart';//'TabItemLeftPath';
 // - �������� ������� ������� TvgPath ������ ���� �������
 cChromeLikeTabTopLineResourceName = 'TopEdgeLine';
 // - �������� ������� ������� TvgLine ������� ������� �������
 cChromeLikeTabBottomLineResourceName = 'BottomEdgeLine';
 // - �������� ������� ������� TvgLine ������ ������� �������
 cChromeLikeTabCloseButtonInactiveBitmap = 'TabCloseButtonInactiveBitmap';
 // - �������� ��� ����������� ������ �������� �������
 cChromeLikeTabCloseButtonActiveBitmap = 'TabCloseButtonActiveBitmap';
 // - �������� ��� ��������� ������ �������� �������
 cChromeLikeTabIconImageName = 'TabIconImage';
 // - �������� ������� ������ ����

 cCloseButtonImages: array[TChromeLikeTabSetElementState] of TImageIndex = (0, -1, 1);
 // - �������� ��� �������� �������� �������
 
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
