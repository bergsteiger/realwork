unit ddDocument;

interface

uses
 l3IntfUses
 , k2CustomFileGenerator
 , k2Interfaces
 , l3_Base
;

type
 TddDocumentGenerator = class(Tk2CustomFileGenerator)
  procedure DoStartBlock;
  procedure DoCloseBlock;
  procedure Apply2Sub(AtomIndex: LongInt;
   const Value: Tk2Variant);
  procedure DoStartDocument;
  function NeedWritePara: Boolean;
   {* ����� "������" ��� Writer'�. ������ ��� �� ������ �������� � ����������� �� �����. }
  function BlockIndent: Integer;
   {* ����� "������" ��� Writer'�. ������ ��� ��������� ���������. }
  function IgnoreLeftIndent: Boolean;
  procedure CheckFilterPara(aFromFilter: Boolean);
 end;//TddDocumentGenerator
 
 TddDocument = class(Tl3_Base)
 end;//TddDocument
 
implementation

uses
 l3ImplUses
 , evdAllParaEliminator
;

end.
