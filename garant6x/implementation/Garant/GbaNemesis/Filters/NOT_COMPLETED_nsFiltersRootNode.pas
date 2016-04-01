unit NOT_COMPLETED_nsFiltersRootNode;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Filters\NOT_COMPLETED_nsFiltersRootNode.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsFiltersRootNode" MUID: (5061DE4402FD)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3NodesModelPart
 , nsFiltersInterfaces
 , l3TreeInterfaces
;

type
 TnsFiltersRootNode = class(Tl3PlaceNode, InsFilterRootNode)
  private
   f_FiltersType: TnsFiltersType;
  protected
   function Get_FiltersType: TnsFiltersType;
   function GetIsSame(const aNode: Il3SimpleNode): Boolean; override;
  public
   constructor Create(aFiltersType: TnsFiltersType); reintroduce;
   class function Make(aFiltersType: TnsFiltersType): InsFilterRootNode; reintroduce;
 end;//TnsFiltersRootNode
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
;

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
end;//TnsFiltersRootNode.Make

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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
