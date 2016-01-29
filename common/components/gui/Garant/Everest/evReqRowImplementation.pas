unit evReqRowImplementation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evReqRowImplementation.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParaUtils::TevReqRowImplementation
//
// Специализированная обработка добавления строк в КЗ.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(k2ForEditor)}
uses
  evTableImplementation,
  nevBase,
  nevTools
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}
type
 TevReqRowImplementation = {final} class(TevTableImplementation)
  {* Специализированная обработка добавления строк в КЗ. }
 protected
 // overridden protected methods
   procedure DoCloneSegments(const aOldRow: Tl3Variant;
     const aNewRow: Tl3Variant;
     const anOp: InevOp); override;
   function GetClearMode4Clone: TevClearMode; override;
 end;//TevReqRowImplementation
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}
uses
  k2Tags
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}

// start class TevReqRowImplementation

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

{$IfEnd} //k2ForEditor

end.