unit nscTreeViewForNewsLine;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Tree/nscTreeViewForNewsLine.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Tree::TnscTreeViewForNewsLine
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  nscTreeViewWithAdapterDragDrop,
  l3TreeInterfaces,
  vtOutliner
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 TnscTreeViewForNewsLine = class(TnscTreeViewWithAdapterDragDrop)
 protected
 // overridden protected methods
   procedure SetTreeStructFromHistory(const aTreeStruct: Il3SimpleTree;
      const aData: TvtOutlinerHystoryData); override;
 end;//TnscTreeViewForNewsLine
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}

// start class TnscTreeViewForNewsLine

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

{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация TnscTreeViewForNewsLine
 TtfwClassRef.Register(TnscTreeViewForNewsLine);
{$IfEnd} //not Admin AND not NoScripts

end.