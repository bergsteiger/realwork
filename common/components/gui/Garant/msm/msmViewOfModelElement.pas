unit msmViewOfModelElement;

// Модуль: "w:\common\components\gui\Garant\msm\msmViewOfModelElement.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmViewOfModelElement" MUID: (57E3BD5101AF)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3CProtoObject
 , msmElementViews
;

type
 TmsmViewOfModelElement = class(Tl3CProtoObject)
  private
   f_Element: TmsmModelElementView;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(const anElement: TmsmModelElementView); reintroduce;
  protected
   property Element: TmsmModelElementView
    read f_Element;
 end;//TmsmViewOfModelElement

implementation

uses
 l3ImplUses
 //#UC START# *57E3BD5101AFimpl_uses*
 //#UC END# *57E3BD5101AFimpl_uses*
;

constructor TmsmViewOfModelElement.Create(const anElement: TmsmModelElementView);
//#UC START# *57E3BD8F0102_57E3BD5101AF_var*
//#UC END# *57E3BD8F0102_57E3BD5101AF_var*
begin
//#UC START# *57E3BD8F0102_57E3BD5101AF_impl*
 //Assert(anElement.rElement <> nil);
 f_Element := anElement;
 inherited Create;
//#UC END# *57E3BD8F0102_57E3BD5101AF_impl*
end;//TmsmViewOfModelElement.Create

procedure TmsmViewOfModelElement.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57E3BD5101AF_var*
//#UC END# *479731C50290_57E3BD5101AF_var*
begin
//#UC START# *479731C50290_57E3BD5101AF_impl*
 Finalize(f_Element);
 inherited;
//#UC END# *479731C50290_57E3BD5101AF_impl*
end;//TmsmViewOfModelElement.Cleanup

procedure TmsmViewOfModelElement.ClearFields;
begin
 Finalize(f_Element);
 inherited;
end;//TmsmViewOfModelElement.ClearFields

end.
