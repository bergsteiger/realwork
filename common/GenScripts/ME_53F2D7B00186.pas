unit ChromeLikeInterfaces;

interface

uses
 l3IntfUses
 , ImgList
 , Controls
 , Types
;

type
 TChromeLikeTabSetParams = record
 end;//TChromeLikeTabSetParams
 
 TChromeLikeCaptionMenuKind = (
  {* Тип попап-меню в заголовочном контроле }
  cl_cmkSystem
   {* Показывать системное меню }
  , cl_cmkCustom
   {* Показывать свое меню }
  , cl_cmkNone
   {* Не показывать никакого меню }
 );//TChromeLikeCaptionMenuKind
 
 IChromeLikeCaptionControl = interface
  function GetMenuKindAtPoint(const aPoint: TPoint): TChromeLikeCaptionMenuKind;
  procedure ShowContextMenu(const aPoint: TPoint);
 end;//IChromeLikeCaptionControl
 
implementation

uses
 l3ImplUses
;

end.
