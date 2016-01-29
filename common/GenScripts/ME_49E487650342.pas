unit evdLeafParaFilter;

interface

uses
 l3IntfUses
 , k2TagFilter
 , k2Base
 , l3Variant
;

type
 TevdLeafParaFilter = class(Tk2TagFilter)
  {* �����, ����������� "���������" ������. ��������� ����������
 �������� ������� TevdLeafParaFilter.ParaTypeForFiltering
(���� ����� ����������� ���� ���) � TevdLeafParaFilter.NeedWritePara
(���� ����� ����������� ��������� ����� ��� �������
���������� �������� � �������� �������). ������
���������������� ������ ����������� � ������ TevdLeafParaFilter.DoWritePara,
���������� �������, ����� ������� ��������� � ����������
������ }
  function ParaTypeForFiltering: Tk2Type;
   {* �������, ������������ ��� �������, ��� ������� ����� ����������� ���������� }
  function NeedWritePara(aLeaf: Tl3Variant): Boolean;
   {* ���������� ����� �� ����������� ���������� ����� }
  procedure DoWritePara(aLeaf: Tl3Variant);
   {* ������ ����������� ������ � ���������. ��������� ������� ��������� � ���������� ������ }
 end;//TevdLeafParaFilter
 
implementation

uses
 l3ImplUses
;

end.
