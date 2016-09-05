unit nscTreeViewWithAdapterDragDrop;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Components\nscTreeViewWithAdapterDragDrop.pas"
// ���������: "GuiControl"
// ������� ������: "TnscTreeViewWithAdapterDragDrop" MUID: (52DE57DF007B)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 {$If Defined(Nemesis)}
 , nscTreeView
 {$IfEnd} // Defined(Nemesis)
 , vtOutlinerWithDragDrop
;

type
 TnscTreeViewWithAdapterDragDrop = class({$If Defined(Nemesis)}
 TnscTreeView
 {$IfEnd} // Defined(Nemesis)
 )
  protected
   function DataObjectClass: RvtNodeDataObject; override;
 end;//TnscTreeViewWithAdapterDragDrop

implementation

uses
 l3ImplUses
 , nsEntitiesTreeDataObject
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *52DE57DF007Bimpl_uses*
 //#UC END# *52DE57DF007Bimpl_uses*
;

{$If Defined(Nemesis)}
function TnscTreeViewWithAdapterDragDrop.DataObjectClass: RvtNodeDataObject;
//#UC START# *52DD106403D3_52DE57DF007B_var*
//#UC END# *52DD106403D3_52DE57DF007B_var*
begin
//#UC START# *52DD106403D3_52DE57DF007B_impl*
{$ifdef Nemesis}
 {$If Declared(TnsEntitiesTreeDataObject)}
 Result := TnsEntitiesTreeDataObject;
 {$else}
 Result := inherited DataObjectClass;
 {$IfEnd}
{$else}
 Result := inherited DataObjectClass;
{$endif}
//#UC END# *52DD106403D3_52DE57DF007B_impl*
end;//TnscTreeViewWithAdapterDragDrop.DataObjectClass

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
 {* ����������� TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Nemesis)

end.
