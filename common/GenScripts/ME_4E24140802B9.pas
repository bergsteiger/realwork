unit nevNodeView;

// Модуль: "w:\common\components\gui\Garant\Everest\nevNodeView.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , nevBaseDetachedView
 , nevObjectHolder
 , nevTools
;

type
 TnevNodeView = class(TnevBaseDetachedView)
  private
   f_Holder: TnevObjectHolder;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function GetNeedTotalRecalc: Boolean; override;
  public
   constructor Create(const aNode: InevObject;
    const aCanvas: InevCanvas); reintroduce;
   class function Make(const aNode: InevObject;
    const aCanvas: InevCanvas): InevView;
 end;//TnevNodeView

implementation

uses
 l3ImplUses
 , l3Base
;

constructor TnevNodeView.Create(const aNode: InevObject;
 const aCanvas: InevCanvas);
//#UC START# *4E241455003A_4E24140802B9_var*
//#UC END# *4E241455003A_4E24140802B9_var*
begin
//#UC START# *4E241455003A_4E24140802B9_impl*
 f_Holder := TnevObjectHolder.Create(aNode);
 inherited Create(aNode, aCanvas);
//#UC END# *4E241455003A_4E24140802B9_impl*
end;//TnevNodeView.Create

class function TnevNodeView.Make(const aNode: InevObject;
 const aCanvas: InevCanvas): InevView;
//#UC START# *4E241480025C_4E24140802B9_var*
var
 l_View : TnevNodeView;
//#UC END# *4E241480025C_4E24140802B9_var*
begin
//#UC START# *4E241480025C_4E24140802B9_impl*
 l_View := Create(aNode, aCanvas);
 try
  Result := l_View;
 finally
  l3Free(l_View);
 end;//try..finally
//#UC END# *4E241480025C_4E24140802B9_impl*
end;//TnevNodeView.Make

procedure TnevNodeView.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4E24140802B9_var*
//#UC END# *479731C50290_4E24140802B9_var*
begin
//#UC START# *479731C50290_4E24140802B9_impl*
 l3Free(f_Holder);
 inherited;
//#UC END# *479731C50290_4E24140802B9_impl*
end;//TnevNodeView.Cleanup

function TnevNodeView.GetNeedTotalRecalc: Boolean;
//#UC START# *565F0492012D_4E24140802B9_var*
//#UC END# *565F0492012D_4E24140802B9_var*
begin
//#UC START# *565F0492012D_4E24140802B9_impl*
 Result := true; 
//#UC END# *565F0492012D_4E24140802B9_impl*
end;//TnevNodeView.GetNeedTotalRecalc

end.
