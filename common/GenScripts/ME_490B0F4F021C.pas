unit nsMainMenuNode;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Common\nsMainMenuNode.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsNewCachableNode
 , MainMenuDomainInterfaces
 , l3_String
 , l3Tree_TLB
 , l3Interfaces
 , DynamicTreeUnit
;

type
 TnsMainMenuNode = class(TnsNewCachableNode, InsMainMenuNode)
  private
   f_Caption: Tl3_String;
   f_NodeType: Integer;
  protected
   function pm_GetNodeType: Integer;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function GetAsPCharLen: Tl3WString; override;
  public
   constructor Create(aType: Integer;
    const aCaption: Il3CString;
    const aNode: INodeBase); reintroduce;
   class function Make(aType: Integer;
    const aCaption: Il3CString;
    const aNode: INodeBase = nil): Il3Node; reintroduce;
 end;//TnsMainMenuNode
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3String
 , SysUtils
 , l3Base
;

constructor TnsMainMenuNode.Create(aType: Integer;
 const aCaption: Il3CString;
 const aNode: INodeBase);
//#UC START# *4ADF05C401AD_490B0F4F021C_var*
//#UC END# *4ADF05C401AD_490B0F4F021C_var*
begin
//#UC START# *4ADF05C401AD_490B0F4F021C_impl*
 inherited Create(aNode);
 if not l3IsNil(aCaption) then
  l3Set(f_Caption, aCaption);
 f_NodeType := aType;
//#UC END# *4ADF05C401AD_490B0F4F021C_impl*
end;//TnsMainMenuNode.Create

class function TnsMainMenuNode.Make(aType: Integer;
 const aCaption: Il3CString;
 const aNode: INodeBase = nil): Il3Node;
var
 l_Inst : TnsMainMenuNode;
begin
 l_Inst := Create(aType, aCaption, aNode);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsMainMenuNode.Make

function TnsMainMenuNode.pm_GetNodeType: Integer;
//#UC START# *49904B470294_490B0F4F021Cget_var*
//#UC END# *49904B470294_490B0F4F021Cget_var*
begin
//#UC START# *49904B470294_490B0F4F021Cget_impl*
 Result := f_NodeType;
//#UC END# *49904B470294_490B0F4F021Cget_impl*
end;//TnsMainMenuNode.pm_GetNodeType

procedure TnsMainMenuNode.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_490B0F4F021C_var*
//#UC END# *479731C50290_490B0F4F021C_var*
begin
//#UC START# *479731C50290_490B0F4F021C_impl*
 FreeAndNil(f_Caption);
 inherited;
//#UC END# *479731C50290_490B0F4F021C_impl*
end;//TnsMainMenuNode.Cleanup

function TnsMainMenuNode.GetAsPCharLen: Tl3WString;
//#UC START# *47A869BB02DE_490B0F4F021C_var*
//#UC END# *47A869BB02DE_490B0F4F021C_var*
begin
//#UC START# *47A869BB02DE_490B0F4F021C_impl*
 if (f_Caption <> nil) then
  Result := f_Caption.AsPCharLen
 else
  Result := inherited GetAsPCharLen;
//#UC END# *47A869BB02DE_490B0F4F021C_impl*
end;//TnsMainMenuNode.GetAsPCharLen
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
