unit eeDocumentPartGenerator;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\eeDocumentPartGenerator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TeeDocumentPartGenerator" MUID: (4D93589403E2)

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , evDocumentPartGenerator
 , nevTools
;

type
 TeeDocumentPartGenerator = class(TevDocumentPartGenerator)
  protected
   procedure SetInsertionPoint(const aPoint: InevBasePoint;
    aPID: Integer); override;
 end;//TeeDocumentPartGenerator
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , evOp
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , CommentPara_Const
;

procedure TeeDocumentPartGenerator.SetInsertionPoint(const aPoint: InevBasePoint;
 aPID: Integer);
//#UC START# *4D9359AA01A2_4D93589403E2_var*
//#UC END# *4D9359AA01A2_4D93589403E2_var*
begin
//#UC START# *4D9359AA01A2_4D93589403E2_impl*
 inherited;
 while true do
 begin
  if evInPara(aPoint.MostInner.Obj^.AsObject, k2_typCommentPara) then
   break;
  if not aPoint.Move(View, ev_ocPrevParaBottomRight, Context) then
   break; 
 end;//while true
//#UC END# *4D9359AA01A2_4D93589403E2_impl*
end;//TeeDocumentPartGenerator.SetInsertionPoint
{$IfEnd} // Defined(Nemesis)

end.
