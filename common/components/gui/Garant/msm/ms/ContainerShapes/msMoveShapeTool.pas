unit msMoveShapeTool;

interface

uses
 System.Types,
 msInterfaces,
 msShapeTool
 ;

type
 TmsMoveShapeTool = class abstract(TmsShapeTool)
 protected
  procedure ProcessClickInDiagramm; override; final;
  function Delta: TPointF; virtual; abstract;
 end;//TmsMoveShapeTool

 RmsMoveShapeTool = class of TmsMoveShapeTool;

implementation

// TmsMoveShapeTool

procedure TmsMoveShapeTool.ProcessClickInDiagramm;
begin
 ShapeToDeal.MoveBy(TmsMoveContext.Create(ShapeToDeal.StartPoint, Delta, nil));
 // ��� ���� ��������:
 //  https://bitbucket.org/ingword/mindstream/issue/143/tmsline
end;

end.
