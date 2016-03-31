unit deNode;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Admin\deNode.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdeNode" MUID: (492472AC0033)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , l3ProtoObject
 , AdminInterfaces
 , DynamicTreeUnit
;

type
 TdeNode = class(Tl3ProtoObject, IdeNode)
  private
   f_Node: INodeBase;
  protected
   function pm_GetNode: INodeBase;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aNode: INodeBase); reintroduce;
   class function Make(const aNode: INodeBase): IdeNode; reintroduce;
 end;//TdeNode
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
;

constructor TdeNode.Create(const aNode: INodeBase);
//#UC START# *4AA523C701F4_492472AC0033_var*
//#UC END# *4AA523C701F4_492472AC0033_var*
begin
//#UC START# *4AA523C701F4_492472AC0033_impl*
 inherited Create;
 f_Node := aNode;
//#UC END# *4AA523C701F4_492472AC0033_impl*
end;//TdeNode.Create

class function TdeNode.Make(const aNode: INodeBase): IdeNode;
var
 l_Inst : TdeNode;
begin
 l_Inst := Create(aNode);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TdeNode.Make

function TdeNode.pm_GetNode: INodeBase;
//#UC START# *4AA523050019_492472AC0033get_var*
//#UC END# *4AA523050019_492472AC0033get_var*
begin
//#UC START# *4AA523050019_492472AC0033get_impl*
 Result := f_Node;
//#UC END# *4AA523050019_492472AC0033get_impl*
end;//TdeNode.pm_GetNode

procedure TdeNode.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_492472AC0033_var*
//#UC END# *479731C50290_492472AC0033_var*
begin
//#UC START# *479731C50290_492472AC0033_impl*
 f_Node := nil;
 inherited;
//#UC END# *479731C50290_492472AC0033_impl*
end;//TdeNode.Cleanup
{$IfEnd} // Defined(Admin)

end.
