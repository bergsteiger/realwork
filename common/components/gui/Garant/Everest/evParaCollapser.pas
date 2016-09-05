unit evParaCollapser;

// Модуль: "w:\common\components\gui\Garant\Everest\evParaCollapser.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevParaCollapser" MUID: (4E1D776103C6)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , evDecorHotSpot
 , nevTools
 , evDecorHyperlink
;

type
 TevParaCollapser = class(TevDecorHotSpot)
  protected
   function DoCollapse(const aView: InevControlView): Boolean; virtual;
   function DoLButtonUp(const aView: InevControlView;
    const Keys: TevMouseState): Boolean; override;
   function DoLButtonDoubleClick(const aView: InevControlView;
    const Keys: TevMouseState;
    var Effect: TevMouseEffect): Boolean; override;
   function DoLButtonDown(const aView: InevControlView;
    const Keys: TevMouseState;
    var Effect: TevMouseEffect): Boolean; override;
   function DoMButtonUp(const aView: InevControlView;
    const Keys: TevMouseState): Boolean; override;
   function GetDecorHyperlinkClass: RevDecorHyperlink; override;
 end;//TevParaCollapser
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
 , nevBase
 , evCollapserHyperlink
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , k2Tags
 //#UC START# *4E1D776103C6impl_uses*
 //#UC END# *4E1D776103C6impl_uses*
;

function TevParaCollapser.DoCollapse(const aView: InevControlView): Boolean;
//#UC START# *4E1D87640086_4E1D776103C6_var*
var
 l_C  : Boolean;
 l_Op : InevOp;
 l_S  : Integer;
 l_P  : InevPara;
//#UC END# *4E1D87640086_4E1D776103C6_var*
begin
//#UC START# *4E1D87640086_4E1D776103C6_impl*
 Result := true;
 l_S := f_Para.AsObject.IntA[k2_tiStyle];
 l_C := not aView.IsObjectCollapsed[f_Para];
 l_P := f_Para;
 l_Op := aView.Processor.StartOp;
 try
  while (l_P <> nil) AND l_P.AsObject.IsValid AND
        (l_P.AsObject.IntA[k2_tiStyle] = l_S) do
  begin
   aView.IsObjectCollapsed[l_P] := l_C;
   l_P := evNextOverallPara(l_P);
  end;//while (l_P <> nil)..
 finally
  l_Op := nil;
 end;//try..finally
 f_Para.Invalidate([nev_spExtent]);
//#UC END# *4E1D87640086_4E1D776103C6_impl*
end;//TevParaCollapser.DoCollapse

function TevParaCollapser.DoLButtonUp(const aView: InevControlView;
 const Keys: TevMouseState): Boolean;
//#UC START# *4E1D7BDF01C4_4E1D776103C6_var*
//#UC END# *4E1D7BDF01C4_4E1D776103C6_var*
begin
//#UC START# *4E1D7BDF01C4_4E1D776103C6_impl*
 Result := DoCollapse(aView);
 if not Result then
  Result := inherited DoLButtonUp(aView, Keys);
//#UC END# *4E1D7BDF01C4_4E1D776103C6_impl*
end;//TevParaCollapser.DoLButtonUp

function TevParaCollapser.DoLButtonDoubleClick(const aView: InevControlView;
 const Keys: TevMouseState;
 var Effect: TevMouseEffect): Boolean;
//#UC START# *4E1D7C16028B_4E1D776103C6_var*
//#UC END# *4E1D7C16028B_4E1D776103C6_var*
begin
//#UC START# *4E1D7C16028B_4E1D776103C6_impl*
 Result := true;
 Effect.rNeedAsyncLoop := false;
(* Result := DoCollapse(aView);
 if not Result then
  Result := inherited DoLButtonDoubleClick(aView, Keys, Effect);*)
//#UC END# *4E1D7C16028B_4E1D776103C6_impl*
end;//TevParaCollapser.DoLButtonDoubleClick

function TevParaCollapser.DoLButtonDown(const aView: InevControlView;
 const Keys: TevMouseState;
 var Effect: TevMouseEffect): Boolean;
//#UC START# *4E1DC2FF02BB_4E1D776103C6_var*
//#UC END# *4E1DC2FF02BB_4E1D776103C6_var*
begin
//#UC START# *4E1DC2FF02BB_4E1D776103C6_impl*
 Result := true;
 Effect.rNeedAsyncLoop := false;
//#UC END# *4E1DC2FF02BB_4E1D776103C6_impl*
end;//TevParaCollapser.DoLButtonDown

function TevParaCollapser.DoMButtonUp(const aView: InevControlView;
 const Keys: TevMouseState): Boolean;
//#UC START# *548B10B4010F_4E1D776103C6_var*
//#UC END# *548B10B4010F_4E1D776103C6_var*
begin
//#UC START# *548B10B4010F_4E1D776103C6_impl*
 Result := DoCollapse(aView);
 if not Result then
  Result := inherited DoMButtonUp(aView, Keys);
//#UC END# *548B10B4010F_4E1D776103C6_impl*
end;//TevParaCollapser.DoMButtonUp

function TevParaCollapser.GetDecorHyperlinkClass: RevDecorHyperlink;
//#UC START# *55F6D02B0013_4E1D776103C6_var*
//#UC END# *55F6D02B0013_4E1D776103C6_var*
begin
//#UC START# *55F6D02B0013_4E1D776103C6_impl*
 Result := TevCollapserHyperlink;
//#UC END# *55F6D02B0013_4E1D776103C6_impl*
end;//TevParaCollapser.GetDecorHyperlinkClass
{$IfEnd} // Defined(evNeedHotSpot)

end.
