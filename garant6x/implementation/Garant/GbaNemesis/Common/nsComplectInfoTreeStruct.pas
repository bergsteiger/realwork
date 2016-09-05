unit nsComplectInfoTreeStruct;
 {* Дерево информации о комплекте }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Common\nsComplectInfoTreeStruct.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsComplectInfoTreeStruct" MUID: (468368FC017F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsDataResetTreeStruct
 , l3TreeInterfaces
 , DynamicTreeUnit
 , nsINodeWrapBase
;

type
 TnsComplectInfoTreeStruct = class(TnsDataResetTreeStruct)
  {* Дерево информации о комплекте }
  private
   class function GetComplectInfoTree: INodeBase;
    {* Получает корневую ноду с адаптера }
  protected
   function ReAqurieUnfilteredRoot: INodeBase; override;
   function RootNodeClass: RnsINodeWrap; override;
    {* определяет класс обертки для Root }
  public
   constructor Create; reintroduce;
   class function Make: Il3SimpleTree; reintroduce;
    {* Создаёт экземляр дерева }
 end;//TnsComplectInfoTreeStruct
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , DataAdapter
 , ComplectUnit
 , nsTypes
 , nsComplectInfoRootNode
 //#UC START# *468368FC017Fimpl_uses*
 //#UC END# *468368FC017Fimpl_uses*
;

constructor TnsComplectInfoTreeStruct.Create;
//#UC START# *490872B30390_468368FC017F_var*
//#UC END# *490872B30390_468368FC017F_var*
begin
//#UC START# *490872B30390_468368FC017F_impl*
 inherited Create(GetComplectInfoTree, False);
//#UC END# *490872B30390_468368FC017F_impl*
end;//TnsComplectInfoTreeStruct.Create

class function TnsComplectInfoTreeStruct.Make: Il3SimpleTree;
 {* Создаёт экземляр дерева }
var
 l_Inst : TnsComplectInfoTreeStruct;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsComplectInfoTreeStruct.Make

class function TnsComplectInfoTreeStruct.GetComplectInfoTree: INodeBase;
 {* Получает корневую ноду с адаптера }
//#UC START# *490872E30161_468368FC017F_var*
var
 lCI   : IComplectInfo;
//#UC END# *490872E30161_468368FC017F_var*
begin
//#UC START# *490872E30161_468368FC017F_impl*
 lCI := DefDataAdapter.NativeAdapter.MakeComplectInfo;
 try
  lCI.GetInfo(Result);
 finally
  lCI := nil;
 end;
//#UC END# *490872E30161_468368FC017F_impl*
end;//TnsComplectInfoTreeStruct.GetComplectInfoTree

function TnsComplectInfoTreeStruct.ReAqurieUnfilteredRoot: INodeBase;
//#UC START# *48FF64F60078_468368FC017F_var*
//#UC END# *48FF64F60078_468368FC017F_var*
begin
//#UC START# *48FF64F60078_468368FC017F_impl*
 case BeenReseted of
  rtsRoot :
   Result := GetComplectInfoTree;
  else
   Result := inherited ReAqurieUnfilteredRoot;
 end
//#UC END# *48FF64F60078_468368FC017F_impl*
end;//TnsComplectInfoTreeStruct.ReAqurieUnfilteredRoot

function TnsComplectInfoTreeStruct.RootNodeClass: RnsINodeWrap;
 {* определяет класс обертки для Root }
//#UC START# *48FEE3640227_468368FC017F_var*
//#UC END# *48FEE3640227_468368FC017F_var*
begin
//#UC START# *48FEE3640227_468368FC017F_impl*
 Result := TnsComplectInfoRootNode;
//#UC END# *48FEE3640227_468368FC017F_impl*
end;//TnsComplectInfoTreeStruct.RootNodeClass
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
