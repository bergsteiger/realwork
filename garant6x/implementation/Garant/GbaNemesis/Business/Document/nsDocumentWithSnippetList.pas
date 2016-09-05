unit nsDocumentWithSnippetList;

// ћодуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\nsDocumentWithSnippetList.pas"
// —тереотип: "SimpleClass"
// Ёлемент модели: "TnsDocumentWithSnippetList" MUID: (5645E9550108)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , bsListTreeStruct
 , nsINodeWrapBase
;

type
 TnsDocumentWithSnippetList = class(TbsListTreeStruct)
  protected
   function RootNodeClass: RnsINodeWrap; override;
    {* определ€ет класс обертки дл€ Root }
 end;//TnsDocumentWithSnippetList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsDocumentWithSnippetNode
 //#UC START# *5645E9550108impl_uses*
 //#UC END# *5645E9550108impl_uses*
;

function TnsDocumentWithSnippetList.RootNodeClass: RnsINodeWrap;
 {* определ€ет класс обертки дл€ Root }
//#UC START# *48FEE3640227_5645E9550108_var*
//#UC END# *48FEE3640227_5645E9550108_var*
begin
//#UC START# *48FEE3640227_5645E9550108_impl*
 Result := TnsDocumentWithSnippetNode;
//#UC END# *48FEE3640227_5645E9550108_impl*
end;//TnsDocumentWithSnippetList.RootNodeClass
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
