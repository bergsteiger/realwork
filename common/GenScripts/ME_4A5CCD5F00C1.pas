unit nevViewBounds.imp;

interface

uses
 l3IntfUses
 , nevTools
 , nevBase
;

type
 _nevViewBounds_ = class
  {* ������� ������������� ������� }
  function GetViewBounds(const aView: InevView;
   const aMap: InevMap): TnevRect;
  function ViewBounds(const aView: InevView;
   const aMap: InevMap): TnevRect;
   {* �������������� ����� "�������������". ��� ��������� ���������� ���������� �� ����� �������. ���� ����������� �������� �������������, �� ���������� ����� ������������ }
 end;//_nevViewBounds_
 
implementation

uses
 l3ImplUses
;

end.
