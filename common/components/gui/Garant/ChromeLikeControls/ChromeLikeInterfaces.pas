unit ChromeLikeInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ChromeLikeControls"
// ������: "w:/common/components/gui/Garant/ChromeLikeControls/ChromeLikeInterfaces.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::ChromeLikeControls::ChromeLikeInterfaces
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  Types
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  ImgList
  {$IfEnd} //not NoVCL
  
  ;

type
 TChromeLikeTabSetParams = record
   rCloseButtonImages : TCustomImageList;
   rTabImages : TCustomImageList;
   rCloseButtonImageIndex : TImageIndex;
   rCloseButtonHotImageIndex : TImageIndex;
 end;//TChromeLikeTabSetParams

  TChromeLikeCaptionMenuKind = (
   {* ��� �����-���� � ������������ �������� }
    cl_cmkSystem // ���������� ��������� ����
  , cl_cmkCustom // ���������� ���� ����
  , cl_cmkNone // �� ���������� �������� ����
  );//TChromeLikeCaptionMenuKind

 IChromeLikeCaptionControl = interface(IUnknown)
   ['{A051CA0C-AA42-42C4-B5BE-0A024F9C99BC}']
   function GetMenuKindAtPoint(const aPoint: TPoint): TChromeLikeCaptionMenuKind;
   procedure ShowContextMenu(const aPoint: TPoint);
   function pm_GetVCLWinControl: TWinControl;
   property VCLWinControl: TWinControl
     read pm_GetVCLWinControl;
 end;//IChromeLikeCaptionControl


function TChromeLikeTabSetParams_C(aTabImages: TCustomImageList;
     aCloseButtonImages: TCustomImageList;
     aCloseButtonImageIndex: TImageIndex;
     aCloseButtonHotImageIndex: TImageIndex): TChromeLikeTabSetParams;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}

function TChromeLikeTabSetParams_C(aTabImages: TCustomImageList;
       aCloseButtonImages: TCustomImageList;
       aCloseButtonImageIndex: TImageIndex;
       aCloseButtonHotImageIndex: TImageIndex): TChromeLikeTabSetParams;
//#UC START# *5518DC3B0065_551552FA002B_var*
//#UC END# *5518DC3B0065_551552FA002B_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *5518DC3B0065_551552FA002B_impl*
 with Result do
 begin
  rCloseButtonImages := aCloseButtonImages;
  rTabImages := aTabImages;
  rCloseButtonImageIndex := aCloseButtonImageIndex;
  rCloseButtonHotImageIndex := aCloseButtonHotImageIndex;
 end;
//#UC END# *5518DC3B0065_551552FA002B_impl*
end;//TChromeLikeTabSetParams.C

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

end.