unit nsDocumentPreviewWithoutBlockNames;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\nsDocumentPreviewWithoutBlockNames.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsDocumentPreviewWithoutBlockNames" MUID: (54DC54FD024B)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , nsDocumentPreview
;

type
 TnsDocumentPreviewWithoutBlockNames = class(TnsDocumentPreview)
  protected
   function NeedAddBlockNames: Boolean; override;
    {* Нужно ли добавлять имена блоков }
 end;//TnsDocumentPreviewWithoutBlockNames
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 //#UC START# *54DC54FD024Bimpl_uses*
 //#UC END# *54DC54FD024Bimpl_uses*
;

function TnsDocumentPreviewWithoutBlockNames.NeedAddBlockNames: Boolean;
 {* Нужно ли добавлять имена блоков }
//#UC START# *4A2E97A4021B_54DC54FD024B_var*
//#UC END# *4A2E97A4021B_54DC54FD024B_var*
begin
//#UC START# *4A2E97A4021B_54DC54FD024B_impl*
 Result := False;
//#UC END# *4A2E97A4021B_54DC54FD024B_impl*
end;//TnsDocumentPreviewWithoutBlockNames.NeedAddBlockNames
{$IfEnd} // NOT Defined(Admin)

end.
