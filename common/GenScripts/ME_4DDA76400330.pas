unit k2SortTagsList;

interface

uses
 l3IntfUses
 , k2SortTagsListPrim
;

type
 Tk2SortTagsList = class(Tk2SortTagsListPrim)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
 end;//Tk2SortTagsList
 
implementation

uses
 l3ImplUses
;

end.
