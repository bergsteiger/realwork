unit msScrollShape;

interface

uses
 msScrollShapePrim,
 msInterfaces,
 System.Types
 ;

type
 TmsScrollShape = class abstract(TmsScrollShapePrim)
 public
  class function DoNullClick(const aHolder: ImsDiagrammsHolder): Boolean; override; final;
 protected
  class function ScrollDelta : TPointF; virtual;
  class function ArrowShape: ImsShape; virtual; abstract;
 public
  class function ButtonShape: ImsShape; override; final;
 end;//TmsScrollShape

implementation

uses
 msShapesGroup,
 msRectangle
 ;

// TmsScrollShape

class function TmsScrollShape.DoNullClick(const aHolder: ImsDiagrammsHolder): Boolean;
begin
 Result := true;
 aHolder.Scroll(ScrollDelta * 5);
end;

class function TmsScrollShape.ScrollDelta: TPointF;
begin
 Result := TPointF.Create(0, 0);
 // - ���� ��� Assert - ���� ���������������� Result
 //   ����� �� ���� ������ Warning'�� ��� ����������
 Assert(False, '����������� � ��������');
end;

class function TmsScrollShape.ButtonShape: ImsShape;
begin
 Result := TmsShapesGroup.Create([TmsRectangle.Create, ArrowShape]);
end;

end.
