unit evDocumentContainerWithProcessor;

interface

uses
 l3IntfUses
 , nevDocumentContainer
 , evOpProc
 , nevBase
 , nevTools
 , l3IID
;

type
 TevDocumentContainerWithProcessor = class(TnevDocumentContainer)
  {* ��������� ��������� � ����������� ��������. }
  procedure MakeProcessor(out theProcessor: TevCustomUndoProcessor);
 end;//TevDocumentContainerWithProcessor
 
implementation

uses
 l3ImplUses
 , l3Base
 , evDefaultContext
;

end.
