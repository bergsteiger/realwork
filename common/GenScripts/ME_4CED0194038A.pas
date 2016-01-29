unit Para2Point.imp;

interface

uses
 l3IntfUses
 , nevTools
 , l3Units
 , evCustomEditorWindow
;

type
 _Para2Point_ = class
  {* ��������� ����� Tl3Point �� ���� ���������. }
  function GetInnerPara(const aView: InevInputView;
   const aDocument: InevPara): InevPara;
   {* ���������� ��������, ������������ �������� ����� �������������� ����� ��� ��������� }
  function GetPoint(const aMap: InevMap): Tl3Point;
   {* ���������� �����, �� ������� ����� ������������������. }
  function TranslatePara2Point(aText: TevCustomEditorWindow): Tl3Point;
   {* ������ ��������� ����� �� ���� ���������. }
 end;//_Para2Point_
 
implementation

uses
 l3ImplUses
;

end.
