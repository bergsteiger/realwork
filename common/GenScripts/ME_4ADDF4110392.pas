unit nsPrimAdapterNode;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsPrimAdapterNode.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , nsPrimNode
 , BaseTreeSupportUnit
 , l3IID
 , l3TreeInterfaces
;

type
 TnsPrimAdapterNode = {abstract} class(TnsPrimNode)
  private
   f_AdapterNode: INode;
    {* Поле для свойства AdapterNode }
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
   procedure ClearFields; override;
   function GetIsSame(const aNode: Il3SimpleNode): Boolean; override;
   function GetLevelForParent(const aNode: Il3SimpleNode): Integer; override;
  public
   constructor Create(const aNode: INode;
    aNumInParent: Integer); reintroduce;
  protected
   property AdapterNode: INode
    read f_AdapterNode
    write f_AdapterNode;
 end;//TnsPrimAdapterNode

implementation

uses
 l3ImplUses
 , SysUtils
 , l3InterfacesMisc
;

constructor TnsPrimAdapterNode.Create(const aNode: INode;
 aNumInParent: Integer);
//#UC START# *4AE02DE00365_4ADDF4110392_var*
//#UC END# *4AE02DE00365_4ADDF4110392_var*
begin
//#UC START# *4AE02DE00365_4ADDF4110392_impl*
 inherited Create(aNumInParent);
 AdapterNode := aNode;
//#UC END# *4AE02DE00365_4ADDF4110392_impl*
end;//TnsPrimAdapterNode.Create

procedure TnsPrimAdapterNode.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4ADDF4110392_var*
//#UC END# *479731C50290_4ADDF4110392_var*
begin
//#UC START# *479731C50290_4ADDF4110392_impl*
 AdapterNode := nil;
 inherited;
//#UC END# *479731C50290_4ADDF4110392_impl*
end;//TnsPrimAdapterNode.Cleanup

function TnsPrimAdapterNode.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_4ADDF4110392_var*
var
 l_AdapterNode : INode;
//#UC END# *4A60B23E00C3_4ADDF4110392_var*
begin
//#UC START# *4A60B23E00C3_4ADDF4110392_impl*
 if IID.EQ(INode) then
 begin
  l_AdapterNode := AdapterNode;
  if (l_AdapterNode = nil) then
   Result.SetNOINTERFACE
  else
  begin
   Result.SetOk;
   INode(Obj) := l_AdapterNode;
  end;//l_AdapterNode = nil
 end//IID.EQ(INode)
 else
 begin
  Result := inherited COMQueryInterface(IID, Obj);
  if Result.fail then
  begin
   l_AdapterNode := AdapterNode;
   if (l_AdapterNode = nil) then
    Result.SetNOINTERFACE
   else
    Result := Tl3HResult_C(l_AdapterNode.QueryInterface(IID.IID, Obj));
  end;//l3IFail(Result)
 end;//IID.EQ(INode)
//#UC END# *4A60B23E00C3_4ADDF4110392_impl*
end;//TnsPrimAdapterNode.COMQueryInterface

procedure TnsPrimAdapterNode.ClearFields;
begin
 AdapterNode := nil;
 inherited;
end;//TnsPrimAdapterNode.ClearFields

function TnsPrimAdapterNode.GetIsSame(const aNode: Il3SimpleNode): Boolean;
//#UC START# *54C78D9201B9_4ADDF4110392_var*
var
 l_MyAdapterNode : INode;
 l_AdapterNode   : INode;
//#UC END# *54C78D9201B9_4ADDF4110392_var*
begin
//#UC START# *54C78D9201B9_4ADDF4110392_impl*
 Result := inherited GetIsSame(aNode);
 if not Result then
 begin
  l_MyAdapterNode := AdapterNode;
  if (l_MyAdapterNode <> nil) AND
     Supports(aNode, INode, l_AdapterNode) then
   try
    Result := l3IEQ(l_MyAdapterNode, l_AdapterNode);
    if not Result then
     Result := l_MyAdapterNode.IsSameNode(l_AdapterNode);
   finally
    l_AdapterNode := nil;
   end;//try..finally
 end;//not Result
//#UC END# *54C78D9201B9_4ADDF4110392_impl*
end;//TnsPrimAdapterNode.GetIsSame

function TnsPrimAdapterNode.GetLevelForParent(const aNode: Il3SimpleNode): Integer;
//#UC START# *54C78EA30198_4ADDF4110392_var*
var
 l_Parent : INode;
 l_Node   : INode;
//#UC END# *54C78EA30198_4ADDF4110392_var*
begin
//#UC START# *54C78EA30198_4ADDF4110392_impl*
 l_Node := AdapterNode;
 if (l_Node <> nil) and Supports(aNode, INode, l_Parent) then
 begin
  try
   Result := l_Node.GetLevel - l_Parent.GetLevel;
  finally
   l_Parent := nil;
  end;//try..finally
 end//l_Node <> nil..
 else
  Result := 0
//#UC END# *54C78EA30198_4ADDF4110392_impl*
end;//TnsPrimAdapterNode.GetLevelForParent

end.
