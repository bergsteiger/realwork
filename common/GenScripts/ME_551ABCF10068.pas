unit vg_services;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3GetComponentFromPointHelper
 , Types
 , Classes
 , Controls
 , l3FormatObjectInfoHelper
 , l3RTTI
 , l3IterateComponentParents
 , l3GetCaptureHelper
 , l3GetComponentBoundsHelper
;

type
 TvgGetComponentFromPointImpl = class(Tl3ProtoObject, Il3GetComponentFromPointHelper)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  procedure GetComponent(const aPoint: TPoint;
   out aComponent: TComponent;
   out aBindedControl: TControl);
   {* aBindedControl - если найденный компонент - контрол, то равен этому контролу, если нет, то его родитель }
 end;//TvgGetComponentFromPointImpl
 
 TvgFormatObjectInfoImpl = class(Tl3ProtoObject, Il3FormatObjectInfoHelper)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function Format(anObject: TObject;
   aShortInfo: Boolean;
   anObjectPropFound: TRTTIInfoObjectPropertyFoundCallBack): AnsiString;
 end;//TvgFormatObjectInfoImpl
 
 TvgIterateComponentsImpl = class(Tl3ProtoObject, Il3IterateComponentParents)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  procedure IterateF;
 end;//TvgIterateComponentsImpl
 
 TvgGetCaptureImpl = class(Tl3ProtoObject, Il3GetCaptureHelper)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function GetCapture: TComponent;
 end;//TvgGetCaptureImpl
 
 TvgGetComponentBoundsImpl = class(Tl3ProtoObject, Il3GetComponentBoundsHelper)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function GetBounds(aComponent: TComponent): TRect;
 end;//TvgGetComponentBoundsImpl
 
implementation

uses
 l3ImplUses
 , vg_scene
 , vg_controls
 , vgVisualObject
 , l3HugeMessageDlgWithWikiHelper
 , SysUtils
 , vgObject
 , Windows
;

end.
