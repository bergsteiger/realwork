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
   {* ��������� ������ ��������� ���������� ��� ��� }
  procedure GetComponent(const aPoint: TPoint;
   out aComponent: TComponent;
   out aBindedControl: TControl);
   {* aBindedControl - ���� ��������� ��������� - �������, �� ����� ����� ��������, ���� ���, �� ��� �������� }
 end;//TvgGetComponentFromPointImpl
 
 TvgFormatObjectInfoImpl = class(Tl3ProtoObject, Il3FormatObjectInfoHelper)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  function Format(anObject: TObject;
   aShortInfo: Boolean;
   anObjectPropFound: TRTTIInfoObjectPropertyFoundCallBack): AnsiString;
 end;//TvgFormatObjectInfoImpl
 
 TvgIterateComponentsImpl = class(Tl3ProtoObject, Il3IterateComponentParents)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  procedure IterateF;
 end;//TvgIterateComponentsImpl
 
 TvgGetCaptureImpl = class(Tl3ProtoObject, Il3GetCaptureHelper)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  function GetCapture: TComponent;
 end;//TvgGetCaptureImpl
 
 TvgGetComponentBoundsImpl = class(Tl3ProtoObject, Il3GetComponentBoundsHelper)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
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
