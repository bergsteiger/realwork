unit afwMeasureCanvas;
 {* Канва для измерений и вычисления позиции курсора. }

// Модуль: "w:\common\components\gui\Garant\AFW\implementation\Visual\afwMeasureCanvas.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TafwMeasureCanvas" MUID: (47414D0C018A)

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
 l3IntfUses
 , l3VirtualCanvas
 , afwInterfaces
 , l3InternalInterfaces
 , l3Interfaces
;

type
 TafwMeasureCanvas = class(Tl3VirtualCanvas)
  {* Канва для измерений и вычисления позиции курсора. }
  private
   f_Caret: IafwCaret;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function GetCaret: Il3Caret; override;
   procedure ClearFields; override;
  public
   constructor Create(const anExtent: TafwPoint;
    const aCaret: IafwCaret); reintroduce;
   class function Make(const anExtent: TafwPoint;
    const aCaret: IafwCaret): Il3Canvas; reintroduce;
 end;//TafwMeasureCanvas

implementation

uses
 l3ImplUses
;

constructor TafwMeasureCanvas.Create(const anExtent: TafwPoint;
 const aCaret: IafwCaret);
//#UC START# *4CC69AD60087_47414D0C018A_var*
//#UC END# *4CC69AD60087_47414D0C018A_var*
begin
//#UC START# *4CC69AD60087_47414D0C018A_impl*
 with anExtent do
  inherited Create(Tl3_Point_C(X, Y + Y div 4));
 f_Caret := aCaret;
 ShowCursor := (f_Caret <> nil);
//#UC END# *4CC69AD60087_47414D0C018A_impl*
end;//TafwMeasureCanvas.Create

class function TafwMeasureCanvas.Make(const anExtent: TafwPoint;
 const aCaret: IafwCaret): Il3Canvas;
var
 l_Inst : TafwMeasureCanvas;
begin
 l_Inst := Create(anExtent, aCaret);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TafwMeasureCanvas.Make

procedure TafwMeasureCanvas.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_47414D0C018A_var*
//#UC END# *479731C50290_47414D0C018A_var*
begin
//#UC START# *479731C50290_47414D0C018A_impl*
 f_Caret := nil;
 inherited;
//#UC END# *479731C50290_47414D0C018A_impl*
end;//TafwMeasureCanvas.Cleanup

function TafwMeasureCanvas.GetCaret: Il3Caret;
//#UC START# *56B49F030225_47414D0C018A_var*
//#UC END# *56B49F030225_47414D0C018A_var*
begin
//#UC START# *56B49F030225_47414D0C018A_impl*
 Result := f_Caret;
//#UC END# *56B49F030225_47414D0C018A_impl*
end;//TafwMeasureCanvas.GetCaret

procedure TafwMeasureCanvas.ClearFields;
begin
 f_Caret := nil;
 inherited;
end;//TafwMeasureCanvas.ClearFields

end.
