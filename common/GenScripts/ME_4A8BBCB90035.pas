unit evDocumentPartGeneratorPrim;

interface

uses
 l3IntfUses
 , evHighLevelDocumentGenerator
 , evGeneratorsInterfaces
 , nevBase
;

type
 TevDocumentPartGeneratorPrim = class(TevHighLevelDocumentGenerator, IevJoinGenerator)
  procedure AtEndChanged;
  function NeedJoin: Boolean;
   {* �������� ������������ ���� �� ���������� ��������� ��� ������� }
  function AtEnd: Boolean;
  function NeedSkipSubDocuments: Boolean;
  function LoadFlags: TevLoadFlags;
   {* ����� �������� }
 end;//TevDocumentPartGeneratorPrim
 
implementation

uses
 l3ImplUses
;

end.
