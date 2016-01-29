unit nevTable;

interface

uses
 l3IntfUses
 , nevParaList
 , nevTools
 , l3Variant
 , nevBase
;

type
 TnevTable = class(TnevParaList, InevTable)
  function Make(aTag: Tl3Variant): InevTable;
  procedure AddRow(aColCount: Integer;
   aColumnWidth: Integer;
   aFramed: Boolean);
   {* ��������� � ������� ������ � ��������� ���������� ������ aColumnWidth. 
         ���� aFramed ���������, �� ��� ������ ������ ����������� �����. }
 end;//TnevTable
 
implementation

uses
 l3ImplUses
 , k2Base
 , evdFrame_Const
 , k2Tags
 , k2Const
;

end.
