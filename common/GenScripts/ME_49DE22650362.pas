unit evParaCursor;

interface

uses
 l3IntfUses
 , evCursor
 , nevTools
 , l3Interfaces
 , evMarker
 , l3Variant
 , nevBase
 , l3Core
;

type
 TevParaCursor = class(TevCursor, IevMarkersSource)
  {* ������� ����� ��� ���������� ������� ��������� }
  procedure AddMarker(const aView: InevView;
   const aList: IevMarkersList;
   aType: Integer;
   aStyle: TevParaMarkerStyle;
   const aHint: Il3CString;
   aMarkerClass: RevMarker);
  procedure DoGetMarkers(const aView: InevView;
   const aList: IevMarkersList);
  procedure GetMarkers(const aView: InevView;
   const aList: IevMarkersList);
   {* �������� ������� �� ��������� � aList. }
 end;//TevParaCursor
 
implementation

uses
 l3ImplUses
 , evExcept
 , evOp
 , nevInterfaces
 , k2Base
 , SysUtils
 , k2Tags
;

end.
