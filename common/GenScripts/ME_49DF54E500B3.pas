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
   {* ���������� ������ � "������" �� ���������. }
  function PartiallyVisible(const aView: InevView;
   const aPoint: InevBasePoint;
   const aMap: TnevFormatInfoPrim): Boolean;
   {* ���������� ����� �� ����� "�������� �������" ������������ ������ ����� (aPoint). ������� ��� ����������� ��������� ��������� ������ ������������ �����. }
 end;//_nevDiff_
 
implementation

uses
 l3ImplUses
;

end.
