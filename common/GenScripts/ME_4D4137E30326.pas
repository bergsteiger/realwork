unit SelectOperation.imp;

interface

uses
 l3IntfUses
 , evCustomEditorWindow
;

type
 _SelectOperation_ = class
  {* ��������� ��������� ���������, ��������� � �.�. }
  procedure SelectPara(aText: TevCustomEditorWindow);
   {* �������� �������� ������� }
  procedure SelectDocument(aText: TevCustomEditorWindow);
   {* �������� �������� ������� }
 end;//_SelectOperation_
 
implementation

uses
 l3ImplUses
 , evTypes
;

end.
