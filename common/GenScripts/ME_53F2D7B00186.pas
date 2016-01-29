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
  {* ��� �����-���� � ������������ �������� }
  cl_cmkSystem
   {* ���������� ��������� ���� }
  , cl_cmkCustom
   {* ���������� ���� ���� }
  , cl_cmkNone
   {* �� ���������� �������� ���� }
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
