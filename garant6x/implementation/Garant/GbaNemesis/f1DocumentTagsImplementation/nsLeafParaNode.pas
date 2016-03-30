unit nsLeafParaNode;
 {* Листьевой параграф }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsLeafParaNode.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsLeafParaNode" MUID: (467FCDA10044)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , nsParentedTagNode
 , k2Base
 , l3Variant
;

type
 TnsLeafParaNode = class(TnsParentedTagNode)
  {* Листьевой параграф }
  protected
   procedure BuildSubs(aProp: Tk2Prop);
   procedure DoIterateProperties(Action: Ml3TagHolder_IterateProperties_Action;
    All: Boolean); override;
   function DoGetSubAtom(aProp: Tk2Prop;
    out Data: Tl3Variant): Boolean; override;
   procedure DoDoLoad; override;
 end;//TnsLeafParaNode

implementation

uses
 l3ImplUses
 , k2Tags
 , ObjectSegment_Const
 , f1AtomChecker
 , F1TagDataProviderInterface
;

procedure TnsLeafParaNode.BuildSubs(aProp: Tk2Prop);
//#UC START# *4C722F3D02EE_467FCDA10044_var*
//#UC END# *4C722F3D02EE_467FCDA10044_var*
begin
//#UC START# *4C722F3D02EE_467FCDA10044_impl*
 if not (ns_nsSubsBuilt in f_State) then
 begin
  Include(f_State, ns_nsSubsBuilt);
  TagDataProvider.BuildSubs(aProp, Tf1AtomChecker.Make(Self));
 end;//not (ns_nsSubsBuilt in f_State)
//#UC END# *4C722F3D02EE_467FCDA10044_impl*
end;//TnsLeafParaNode.BuildSubs

procedure TnsLeafParaNode.DoIterateProperties(Action: Ml3TagHolder_IterateProperties_Action;
 All: Boolean);
//#UC START# *49A545D501F6_467FCDA10044_var*

  function lp_IterateLayer(aLayer: Tl3Variant; anIndex: Integer): Boolean;

   function lp_IterateSegment(aSegment: Tl3Variant; anIndex: Integer): Boolean;
   var
    l_Object: Tl3Variant;
   begin
    if aSegment.IsKindOf(k2_typObjectSegment) then
    begin
     l_Object := aSegment.Child[0];
     l_Object.Attr[k2_tiData];
    end; // if aSegment.IsKindOf(k2_typObjectSegment) then
    Result := True;
   end;

  begin//UpdateSegment
   aLayer.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@lp_IterateSegment));
   Result := True;
  end;//UpdateSegment

//#UC END# *49A545D501F6_467FCDA10044_var*
begin
//#UC START# *49A545D501F6_467FCDA10044_impl*
 if not All then
 begin
  Attr[k2_tiSubs];
  Attr[k2_tiFrame];
  Attr[k2_tiText];
  Attr[k2_tiData];
  Attr[k2_tiSegments].IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@lp_IterateLayer));
 end;//not All
 inherited;
//#UC END# *49A545D501F6_467FCDA10044_impl*
end;//TnsLeafParaNode.DoIterateProperties

function TnsLeafParaNode.DoGetSubAtom(aProp: Tk2Prop;
 out Data: Tl3Variant): Boolean;
//#UC START# *4C6D1D450332_467FCDA10044_var*
//#UC END# *4C6D1D450332_467FCDA10044_var*
begin
//#UC START# *4C6D1D450332_467FCDA10044_impl*
 Case aProp.TagIndex of
  k2_tiSubs :
  begin
   ParseStyle;
   BuildSubs(aProp);
   Result := BaseGetSubAtom(aProp, Data);
  end;//k2_tiSubs
  k2_tiFrame :
  begin
   ParseStyle;
   Result := BaseGetSubAtom(aProp, Data);
  end;//k2_tiFrame
  else
   Result := inherited DoGetSubAtom(aProp, Data);
 end;//Case aProp.TagIndex
//#UC END# *4C6D1D450332_467FCDA10044_impl*
end;//TnsLeafParaNode.DoGetSubAtom

procedure TnsLeafParaNode.DoDoLoad;
//#UC START# *4CEFA0BA0233_467FCDA10044_var*
//#UC END# *4CEFA0BA0233_467FCDA10044_var*
begin
//#UC START# *4CEFA0BA0233_467FCDA10044_impl*
 ParseStyle;
 inherited;
//#UC END# *4CEFA0BA0233_467FCDA10044_impl*
end;//TnsLeafParaNode.DoDoLoad

end.
