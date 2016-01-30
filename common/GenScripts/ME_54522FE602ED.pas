unit nscTreeViewForNewsLine;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Tree\nscTreeViewForNewsLine.pas"
// Стереотип: "GuiControl"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , nscTreeViewWithAdapterDragDrop
 , l3TreeInterfaces
 , vtOutliner
;

type
 TnscTreeViewForNewsLine = class(TnscTreeViewWithAdapterDragDrop)
  protected
   procedure SetTreeStructFromHistory(const aTreeStruct: Il3SimpleTree;
    const aData: TvtOutlinerHystoryData); override;
 end;//TnscTreeViewForNewsLine
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TnscTreeViewForNewsLine.SetTreeStructFromHistory(const aTreeStruct: Il3SimpleTree;
 const aData: TvtOutlinerHystoryData);
//#UC START# *51629D8E02C8_54522FE602ED_var*
//#UC END# *51629D8E02C8_54522FE602ED_var*
begin
//#UC START# *51629D8E02C8_54522FE602ED_impl*
 if Assigned(TreeStruct) then
  inherited SetTreeStructFromHistory(TreeStruct, aData)
 else
  inherited SetTreeStructFromHistory(aTreeStruct, aData);
//#UC END# *51629D8E02C8_54522FE602ED_impl*
end;//TnscTreeViewForNewsLine.SetTreeStructFromHistory

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscTreeViewForNewsLine);
 {* Регистрация TnscTreeViewForNewsLine }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
