unit nsNewCachableNode;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsNewCachableNode.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , l3NodesModelPart
 , DynamicTreeUnit
 , l3Tree_TLB
 , l3Interfaces
 , l3IID
 , l3TreeInterfaces
;

type
 TnsNewCachableNode = class(Tl3PlaceNode)
  private
   f_AdapterNode: INodeBase;
    {* Поле для свойства AdapterNode }
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function GetAsPCharLen: Tl3WString; override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
   procedure ClearFields; override;
   function DoGetLevel: Integer; override;
   function GetIsSame(const aNode: Il3SimpleNode): Boolean; override;
  public
   constructor Create(const aNode: INodeBase); reintroduce;
   class function Make(const aNode: INodeBase): Il3Node; reintroduce;
  protected
   property AdapterNode: INodeBase
    read f_AdapterNode;
 end;//TnsNewCachableNode

implementation

uses
 l3ImplUses
 , nsTypes
 , IOUnit
 , SysUtils
 , l3InterfacesMisc
;

constructor TnsNewCachableNode.Create(const aNode: INodeBase);
//#UC START# *4AE058130153_490AF9B0039B_var*
//#UC END# *4AE058130153_490AF9B0039B_var*
begin
//#UC START# *4AE058130153_490AF9B0039B_impl*
 inherited Create;
 f_AdapterNode := aNode;
//#UC END# *4AE058130153_490AF9B0039B_impl*
end;//TnsNewCachableNode.Create

class function TnsNewCachableNode.Make(const aNode: INodeBase): Il3Node;
var
 l_Inst : TnsNewCachableNode;
begin
 l_Inst := Create(aNode);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsNewCachableNode.Make

procedure TnsNewCachableNode.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_490AF9B0039B_var*
//#UC END# *479731C50290_490AF9B0039B_var*
begin
//#UC START# *479731C50290_490AF9B0039B_impl*
 f_AdapterNode := nil;
 inherited;
//#UC END# *479731C50290_490AF9B0039B_impl*
end;//TnsNewCachableNode.Cleanup

function TnsNewCachableNode.GetAsPCharLen: Tl3WString;
//#UC START# *47A869BB02DE_490AF9B0039B_var*
var
 l_Str: IString;
//#UC END# *47A869BB02DE_490AF9B0039B_var*
begin
//#UC START# *47A869BB02DE_490AF9B0039B_impl*
 if (f_AdapterNode <> nil) then
  f_AdapterNode.GetCaption(l_Str)
 else
  l_Str := nil;
 Result := nsWStr(l_Str);
//#UC END# *47A869BB02DE_490AF9B0039B_impl*
end;//TnsNewCachableNode.GetAsPCharLen

function TnsNewCachableNode.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_490AF9B0039B_var*
//#UC END# *4A60B23E00C3_490AF9B0039B_var*
begin
//#UC START# *4A60B23E00C3_490AF9B0039B_impl*
 Result := inherited COMQueryInterface(IID, Obj);
 if Result.Fail then
 begin
  if (f_AdapterNode = nil) then
   Result.SetNOINTERFACE
  else
   Result := Tl3HResult_C(f_AdapterNode.QueryInterface(IID.IID, Obj));
 end;//l3IFail(Result)
//#UC END# *4A60B23E00C3_490AF9B0039B_impl*
end;//TnsNewCachableNode.COMQueryInterface

procedure TnsNewCachableNode.ClearFields;
begin
 f_AdapterNode := nil;
 inherited;
end;//TnsNewCachableNode.ClearFields

function TnsNewCachableNode.DoGetLevel: Integer;
//#UC START# *54C78D4603D6_490AF9B0039B_var*
//#UC END# *54C78D4603D6_490AF9B0039B_var*
begin
//#UC START# *54C78D4603D6_490AF9B0039B_impl*
 if (f_AdapterNode = nil) then
  Result := 0
 else
  Result := f_AdapterNode.GetLevel; 
//#UC END# *54C78D4603D6_490AF9B0039B_impl*
end;//TnsNewCachableNode.DoGetLevel

function TnsNewCachableNode.GetIsSame(const aNode: Il3SimpleNode): Boolean;
//#UC START# *54C78D9201B9_490AF9B0039B_var*
var
 l_AdapterNode: INodeBase;
//#UC END# *54C78D9201B9_490AF9B0039B_var*
begin
//#UC START# *54C78D9201B9_490AF9B0039B_impl*
 Result := l3IEQ(Self, aNode);
 if not Result then 
 begin
  if Supports(aNode, INodeBase, l_AdapterNode) then
   try
    Result := l_AdapterNode.IsSameNode(f_AdapterNode);
   finally
    l_AdapterNode := nil;
   end;//try..finally
 end;//not Result
//#UC END# *54C78D9201B9_490AF9B0039B_impl*
end;//TnsNewCachableNode.GetIsSame

end.
