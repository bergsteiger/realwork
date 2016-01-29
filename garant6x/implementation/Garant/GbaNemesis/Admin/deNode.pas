unit deNode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Admin"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Admin/deNode.pas"
// Начат: 07.09.2009 19:23
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Администратор::Admin::Admin::Admin::TdeNode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin)}
uses
  DynamicTreeUnit,
  AdminInterfaces,
  l3ProtoObject
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
type
 TdeNode = class(Tl3ProtoObject, IdeNode)
 private
 // private fields
   f_Node : INodeBase;
 protected
 // realized methods
   function pm_GetNode: INodeBase;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aNode: INodeBase); reintroduce;
   class function Make(const aNode: INodeBase): IdeNode; reintroduce;
 end;//TdeNode
{$IfEnd} //Admin

implementation

{$If defined(Admin)}

// start class TdeNode

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
end;

function TdeNode.pm_GetNode: INodeBase;
//#UC START# *4AA523050019_492472AC0033get_var*
//#UC END# *4AA523050019_492472AC0033get_var*
begin
//#UC START# *4AA523050019_492472AC0033get_impl*
 Result := f_Node;
//#UC END# *4AA523050019_492472AC0033get_impl*
end;//TdeNode.pm_GetNode

procedure TdeNode.Cleanup;
//#UC START# *479731C50290_492472AC0033_var*
//#UC END# *479731C50290_492472AC0033_var*
begin
//#UC START# *479731C50290_492472AC0033_impl*
 f_Node := nil;
 inherited;
//#UC END# *479731C50290_492472AC0033_impl*
end;//TdeNode.Cleanup

{$IfEnd} //Admin

end.