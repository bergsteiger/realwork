unit vgVisualObject;

interface

uses
 l3IntfUses
 , vgObject
 , Classes
 , vgObjectList
 , vgTypes
 , vgBounds
 , vgPosition
;

type
 TvgVisualObject = class(TvgObject)
 end;//TvgVisualObject
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
 , VGSceneWordsPack
;

end.
