unit l3IEBitmapContainer;

interface

uses
 l3IntfUses
 , l3GraphicContainer
;

type
 Tl3IEBitmapContainer = class(Tl3PrimGraphicContainer)
  {* объект - контейнер для картинки (TBitmap) }
 end;//Tl3IEBitmapContainer
 
implementation

uses
 l3ImplUses
 , l3IEBitmapContainerStack
;

end.
