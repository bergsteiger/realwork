unit evdDocumentBufferedFilter;

interface

uses
 l3IntfUses
 , evdBufferedFilter
 , k2TagGen
;

type
 TevdDocumentBufferedFilter = class(TevdChildBufferedFilter)
  {* ������ ��� ���������� ��������� �������. �� ��������� ������ ����������� �������� � ����� � ����������� ��� ����� ������. }
  procedure Create;
  function SetTo(var theGenerator: Tk2TagGenerator): Pointer; overload;
 end;//TevdDocumentBufferedFilter
 
implementation

uses
 l3ImplUses
 , Document_Const
 , l3Base
;

end.
