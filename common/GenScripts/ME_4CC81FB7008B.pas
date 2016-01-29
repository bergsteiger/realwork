unit RegionableControl.imp;

interface

uses
 l3IntfUses
 , l3Region
 , Messages
;

type
 _RegionableControl_ = class(Ml3Unknown, MWinControl)
  {* Контрол с поддержкой регионов }
  procedure UpdateRegion;
  procedure ClearRegion;
  procedure TuneRegion(aRegion: Tl3Region);
  procedure CMVisibleChanged(var Message: TMessage);
 end;//_RegionableControl_
 
implementation

uses
 l3ImplUses
 , SysUtils
 , Themes
 , Windows
;

end.
