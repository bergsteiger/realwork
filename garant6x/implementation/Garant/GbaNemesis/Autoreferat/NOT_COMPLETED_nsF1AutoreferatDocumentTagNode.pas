unit NOT_COMPLETED_nsF1AutoreferatDocumentTagNode;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Autoreferat\NOT_COMPLETED_nsF1AutoreferatDocumentTagNode.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsF1AutoreferatDocumentTagNode" MUID: (4D6E58B300D2)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsF1DocumentTagNode
 , k2Base
 , l3Variant
;

type
 TnsF1AutoreferatDocumentTagNode = class(TnsF1DocumentTagNode)
  protected
   function DoGetSubAtom(aProp: Tk2Prop;
    out Data: Tl3Variant): Boolean; override;
   function NodeChildrenCount: Integer; override;
 end;//TnsF1AutoreferatDocumentTagNode
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , k2Tags
 , F1TagDataProviderInterface
;

function TnsF1AutoreferatDocumentTagNode.DoGetSubAtom(aProp: Tk2Prop;
 out Data: Tl3Variant): Boolean;
//#UC START# *4C6D1D450332_4D6E58B300D2_var*
//#UC END# *4C6D1D450332_4D6E58B300D2_var*
begin
//#UC START# *4C6D1D450332_4D6E58B300D2_impl*
 Case aProp.TagIndex of
  k2_tiFixedWidth,
  k2_tiOrientation,
  k2_tiCollapsed:
   Result := BaseGetSubAtom(aProp, Data);
  else
   Result := inherited DoGetSubAtom(aProp, Data);
 end;//Case aProp.TagIndex
//#UC END# *4C6D1D450332_4D6E58B300D2_impl*
end;//TnsF1AutoreferatDocumentTagNode.DoGetSubAtom

function TnsF1AutoreferatDocumentTagNode.NodeChildrenCount: Integer;
//#UC START# *4CED5CEF011A_4D6E58B300D2_var*
//#UC END# *4CED5CEF011A_4D6E58B300D2_var*
begin
//#UC START# *4CED5CEF011A_4D6E58B300D2_impl*
 if TagDataProvider.IsProviderGot then
  Result := inherited NodeChildrenCount
 else
  Result := IntA[k2_tiAllChildrenCount]; 
//#UC END# *4CED5CEF011A_4D6E58B300D2_impl*
end;//TnsF1AutoreferatDocumentTagNode.NodeChildrenCount
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
