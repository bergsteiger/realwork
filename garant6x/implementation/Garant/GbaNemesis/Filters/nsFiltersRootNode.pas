unit nsFiltersRootNode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Filters"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Filters/nsFiltersRootNode.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Filters::Impl::TnsFiltersRootNode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsFiltersInterfaces,
  l3NodesModelPart,
  l3TreeInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsFiltersRootNode = class(Tl3PlaceNode, InsFilterRootNode)
 private
 // private fields
   f_FiltersType : TnsFiltersType;
 protected
 // realized methods
   function Get_FiltersType: TnsFiltersType;
 protected
 // overridden protected methods
   function GetIsSame(const aNode: Il3SimpleNode): Boolean; override;
 public
 // public methods
   constructor Create(aFiltersType: TnsFiltersType); reintroduce;
   class function Make(aFiltersType: TnsFiltersType): InsFilterRootNode; reintroduce;
     {* Сигнатура фабрики TnsFiltersRootNode.Make }
 end;//TnsFiltersRootNode
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsFiltersRootNode

constructor TnsFiltersRootNode.Create(aFiltersType: TnsFiltersType);
//#UC START# *5061DE910095_5061DE4402FD_var*
//#UC END# *5061DE910095_5061DE4402FD_var*
begin
//#UC START# *5061DE910095_5061DE4402FD_impl*
 inherited Create;
 f_FiltersType := aFiltersType;
//#UC END# *5061DE910095_5061DE4402FD_impl*
end;//TnsFiltersRootNode.Create

class function TnsFiltersRootNode.Make(aFiltersType: TnsFiltersType): InsFilterRootNode;
var
 l_Inst : TnsFiltersRootNode;
begin
 l_Inst := Create(aFiltersType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TnsFiltersRootNode.Get_FiltersType: TnsFiltersType;
//#UC START# *5061DE2D0275_5061DE4402FDget_var*
//#UC END# *5061DE2D0275_5061DE4402FDget_var*
begin
//#UC START# *5061DE2D0275_5061DE4402FDget_impl*
 Result := f_FiltersType;
//#UC END# *5061DE2D0275_5061DE4402FDget_impl*
end;//TnsFiltersRootNode.Get_FiltersType

function TnsFiltersRootNode.GetIsSame(const aNode: Il3SimpleNode): Boolean;
//#UC START# *54C78D9201B9_5061DE4402FD_var*
var
 l_FilterRootNode: InsFilterRootNode;
//#UC END# *54C78D9201B9_5061DE4402FD_var*
begin
//#UC START# *54C78D9201B9_5061DE4402FD_impl*
 Result := False;
 if Supports(aNode, InsFilterRootNode, l_FilterRootNode) then
  Result := l_FilterRootNode.FiltersType = f_FiltersType; 
//#UC END# *54C78D9201B9_5061DE4402FD_impl*
end;//TnsFiltersRootNode.GetIsSame

{$IfEnd} //not Admin AND not Monitorings

end.