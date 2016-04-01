unit evReqRowImplementation;
 {* Специализированная обработка добавления строк в КЗ. }

// Модуль: "w:\common\components\gui\Garant\Everest\evReqRowImplementation.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevReqRowImplementation" MUID: (56123C590233)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , evTableImplementation
 , nevBase
 , nevTools
;

type
 TevReqRowImplementation = {final} class(TevTableImplementation)
  {* Специализированная обработка добавления строк в КЗ. }
  protected
   procedure DoCloneSegments(const aOldRow: Tl3Variant;
    const aNewRow: Tl3Variant;
    const anOp: InevOp); override;
   function GetClearMode4Clone: TevClearMode; override;
 end;//TevReqRowImplementation
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , k2Tags
;

procedure TevReqRowImplementation.DoCloneSegments(const aOldRow: Tl3Variant;
 const aNewRow: Tl3Variant;
 const anOp: InevOp);
//#UC START# *5612461701A2_56123C590233_var*
const
 cnLabelCellID = 0;
var
 l_Leaf        : Tl3Variant;
 l_Layer       : Tl3Variant;
 l_OldSegments : Tl3Variant;
 l_NewSegments : Tl3Variant;
 l_NewHyperlink: Tl3Variant;
 l_SegmentChild: Tl3Variant;
//#UC END# *5612461701A2_56123C590233_var*
begin
//#UC START# *5612461701A2_56123C590233_impl*
 l_Leaf := aOldRow.Child[cnLabelCellID];
 if (l_Leaf.IsValid) and (l_Leaf.ChildrenCount > 0) then
 begin
  l_Leaf := l_Leaf.Child[0];
  l_OldSegments := aOldRow.Child[0].Child[0].Attr[k2_tiSegments];
  if l_OldSegments.IsValid then
  begin
   l_Layer := l_OldSegments.Child[0];
   if (l_Layer.IsValid) and (l_Layer.ChildrenCount > 0) then
   begin
    l_SegmentChild := l_Layer.CloneTag.AsObject;
    l_NewHyperlink := l_Layer.Child[0].CloneTag.AsObject;
    l_NewSegments := aNewRow.Child[0].Child[0].Attr[k2_tiSegments];
    Assert(l_NewSegments.IsValid);
    l_NewSegments.AddChild(l_SegmentChild, anOp);
    l_SegmentChild.AddChild(l_NewHyperlink, anOp);
   end; // if l_Layer.IsValid then
  end; // if l_OldSegments.IsValid then
 end; // if l_Leaf.IsValid then
//#UC END# *5612461701A2_56123C590233_impl*
end;//TevReqRowImplementation.DoCloneSegments

function TevReqRowImplementation.GetClearMode4Clone: TevClearMode;
//#UC START# *5612464E01AC_56123C590233_var*
//#UC END# *5612464E01AC_56123C590233_var*
begin
//#UC START# *5612464E01AC_56123C590233_impl*
 Result := ev_cmLeaveSegments;
//#UC END# *5612464E01AC_56123C590233_impl*
end;//TevReqRowImplementation.GetClearMode4Clone
{$IfEnd} // Defined(k2ForEditor)

end.
