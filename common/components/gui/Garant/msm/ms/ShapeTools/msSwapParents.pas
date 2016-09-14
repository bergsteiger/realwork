unit msSwapParents;

interface

uses
 msInterfaces,
 msTool,
 msNullClickShape,
 System.Types
 ;

type
 TmsSwapParents = class(TmsNullClickShape)
  // - ��������� ����� ������ �������� �������
 public
  class function ButtonShape: ImsShape; override;
  class function DoNullClick(const aHolder: ImsDiagrammsHolder): Boolean; override;
 end;//TmsSwapParents

implementation

uses
 msLeftArrow,
 msRightArrow,
 msLineWithArrow,
 msShapesGroup,
 msSwapParentsIcon
 ;

class function TmsSwapParents.DoNullClick(const aHolder: ImsDiagrammsHolder): Boolean;
begin
 Result := true;
 aHolder.SwapParents;
end;

class function TmsSwapParents.ButtonShape: ImsShape;
begin
 Result := TmsSwapParentsIcon.Create;
end;

end.
