unit evUsialParagraph;

interface

uses
 l3IntfUses
 , k2ProcessorTagTool
 , evEditorInterfaces
 , l3Variant
 , k2Interfaces
;

type
 TevUsialParagraph = class(Tk2ProcessorTagTool, IedParagraph)
  {* ���������� IedParagraph ��� �������� ��������� }
  function Make(aTag: Tl3Variant;
   const aProcessor: Ik2Processor): IedParagraph;
  function Frame: IedFrame;
   {* ����� ������ ������� }
 end;//TevUsialParagraph
 
implementation

uses
 l3ImplUses
 , evParaFrame
;

end.
