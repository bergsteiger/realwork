unit vtImageListWrapper;

{$I vtDefine.inc }

interface

uses
 ImgList,

 l3ImageList
 ;

type
 TvtImageList = class(Tl3ImageList)
 protected
  function DoGetBigSize: Boolean;
   override;
    {-}
  procedure DoSetBigSize(aValue: Boolean);
   override;
    {-}
 public
  constructor Create(aList: TCustomImageList);
   override;
 end;

 TvtProxyImageList = class(Tl3ImageList)
 protected
  function DoGetBigSize: Boolean;
   override;
    {-}
  procedure DoSetBigSize(aValue: Boolean);
   override;
    {-}
 public
  constructor Create(aList: TCustomImageList);
   override;
 end;

implementation

uses
 vtPngImgList,
 vtInterfaces
 ;

{ TvtImageList }

const
 g_Sizes: array [Boolean] of TvtPILSize = (ps16x16, ps32x32);

constructor TvtImageList.Create(aList: TCustomImageList);
begin
 Assert(aList is TvtPngImageList);
 inherited Create(aList);
end;

function TvtImageList.DoGetBigSize: Boolean;
begin
 Result := TvtPngImageList(Hack).CurSize = ps32x32
end;

procedure TvtImageList.DoSetBigSize(aValue: Boolean);
begin
 TvtPngImageList(Hack).CurSize := g_Sizes[aValue];
end;

{ TvtProxyImageList }

constructor TvtProxyImageList.Create(aList: TCustomImageList);
begin
 Assert(aList is TvtFixedSizeProxyPngImageList);
 inherited Create(aList);
end;

function TvtProxyImageList.DoGetBigSize: Boolean;
begin
 Result := TvtFixedSizeProxyPngImageList(Hack).FixedSize = ps32x32
end;

procedure TvtProxyImageList.DoSetBigSize(aValue: Boolean);
begin
 TvtFixedSizeProxyPngImageList(Hack).FixedSize := g_Sizes[aValue];
end;

end.

