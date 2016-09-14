unit msNullClickShape;

interface

uses
 msTool,
 msInterfaces
 ;

type
 TmsNullClickShape = class abstract(TmsTool)
 public
  class function IsNullClick: Boolean; override;
  //- �������� �� ������� ������. ������. ��� TmsSwapParents ��� TmsUpToParent
  class function Create(const aShapeClass : ImsShapeClass; const aCtx: TmsMakeShapeContext): ImsShape; override; final;
 end;//TmsNullClickShape

implementation

// TmsNullClickShape

class function TmsNullClickShape.IsNullClick: Boolean;
begin
 Result := true;
end;

class function TmsNullClickShape.Create(const aShapeClass : ImsShapeClass; const aCtx: TmsMakeShapeContext): ImsShape;
begin
 Result := nil;
 // ��� ��� �����, ������ ��� � ���������
 DoNullClick(aCtx.rDiagrammsHolder);
 // - ������������ ������� ����
end;

end.
