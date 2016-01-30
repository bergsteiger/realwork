unit nevHAFPainterView;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevHAFPainterView.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , nevVirtualDrawView
 , nevTools
 , nevObjectHolder
 , nevBase
;

type
 TnevHAFPainterView = class(TnevVirtualDrawView)
  private
   f_DocView: InevView;
   f_Holder: TnevObjectHolder;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aText: InevObjectList;
    const aCanvas: InevCanvas); reintroduce;
   class function Make(const aText: InevObjectList;
    const aCanvas: InevCanvas): InevView; reintroduce;
 end;//TnevHAFPainterView

implementation

uses
 l3ImplUses
 , nevBaseDetachedView
 , SysUtils
;

constructor TnevHAFPainterView.Create(const aText: InevObjectList;
 const aCanvas: InevCanvas);
//#UC START# *4CB5BF260122_481DB3AA03CD_var*
//#UC END# *4CB5BF260122_481DB3AA03CD_var*
begin
//#UC START# *4CB5BF260122_481DB3AA03CD_impl*
 f_Holder := TnevObjectHolder.Create(aText);
 f_DocView := TnevBaseDetachedView.Make(aText, aCanvas);
 inherited Create(aText.Obj[0], f_DocView.RootFormatInfo, aCanvas, f_DocView.Metrics);
//#UC END# *4CB5BF260122_481DB3AA03CD_impl*
end;//TnevHAFPainterView.Create

class function TnevHAFPainterView.Make(const aText: InevObjectList;
 const aCanvas: InevCanvas): InevView;
var
 l_Inst : TnevHAFPainterView;
begin
 l_Inst := Create(aText, aCanvas);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnevHAFPainterView.Make

procedure TnevHAFPainterView.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_481DB3AA03CD_var*
//#UC END# *479731C50290_481DB3AA03CD_var*
begin
//#UC START# *479731C50290_481DB3AA03CD_impl*
 f_DocView := nil;
 FreeAndNil(f_Holder);
 inherited;
//#UC END# *479731C50290_481DB3AA03CD_impl*
end;//TnevHAFPainterView.Cleanup

end.
