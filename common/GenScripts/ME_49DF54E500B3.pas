unit nevDiff.imp;

interface

uses
 l3IntfUses
 , nevTools
 , nevBase
;

type
 _nevDiff_ = class
  function DoDiff(const aView: InevView;
   const aPoint: InevBasePoint;
   aMap: TnevFormatInfoPrim): Integer;
  function DoPartiallyVisible(const aView: InevView;
   const aPoint: InevBasePoint;
   aMap: TnevFormatInfoPrim): Boolean;
  function Diff(const aView: InevView;
   const aPoint: InevBasePoint;
   aMap: TnevFormatInfoPrim): Integer;
   {* сравнивает курсор с "якорем" по вертикали. }
  function PartiallyVisible(const aView: InevView;
   const aPoint: InevBasePoint;
   const aMap: TnevFormatInfoPrim): Boolean;
   {* Определяет может ли точка "частично видимой" относительно другой точки (aPoint). Сделано для определения видимости начальной ячейки относительно якоря. }
 end;//_nevDiff_
 
implementation

uses
 l3ImplUses
;

end.
