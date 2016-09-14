unit msPaletteShapeCreator;

interface

uses
 msCompletedShapeCreator,
 msInterfaces
 ;

type
 TmsPaletteShapeCreator = class(TmsCompletedShapeCreator)
 // ��������� TmsShape. ��� �������!!
 protected
  function CreateShape(const aContext: TmsMakeShapeContext): ImsShape; override;
 public
  class function ButtonSize: Integer;
 end;//TmsPaletteShapeCreator

implementation

uses
 msPaletteShape
 ;

// TmsPaletteShapeCreator

type
 TmsPaletteShapeFriend = class(TmsPaletteShape)
 end;//TmsPaletteShapeFriend

 RmsPaletteShapeFriend = class of TmsPaletteShapeFriend;

function TmsPaletteShapeCreator.CreateShape(const aContext: TmsMakeShapeContext): ImsShape;
begin
 if ShapeClass.IsNullClick then
  Result := RmsPaletteShapeFriend(TmsPaletteShape).Create(ShapeClass, aContext)
 else
 if ShapeClass.IsTool then
  Result := RmsPaletteShapeFriend(TmsPaletteShape).Create(ShapeClass, aContext)
 else
  Result := inherited CreateShape(aContext);
end;

class function TmsPaletteShapeCreator.ButtonSize: Integer;
begin
 Result := 40;
end;

end.
