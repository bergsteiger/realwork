unit nevNodeView;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/nevNodeView.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::PaintedNode::TnevNodeView
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  nevTools,
  nevBaseDetachedView,
  nevObjectHolder
  ;

type
 TnevNodeView = class(TnevBaseDetachedView)
 private
 // private fields
   f_Holder : TnevObjectHolder;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   function GetNeedTotalRecalc: Boolean; override;
 public
 // public methods
   constructor Create(const aNode: InevObject;
    const aCanvas: InevCanvas); reintroduce;
   class function Make(const aNode: InevObject;
    const aCanvas: InevCanvas): InevView;
 end;//TnevNodeView

implementation

uses
  l3Base
  ;

// start class TnevNodeView

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