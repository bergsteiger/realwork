unit Common_Rubricator_Controls;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common_Rubricator_Controls.pas"
// ���������: "VCMControls"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3TreeInterfaces
 , DynamicTreeUnit
 , MainMenuUnit
 , l3CProtoObject
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 // Rubricator

 IRubricator_SetListRoot_Params = interface
  {* ��������� ��� �������� Rubricator.SetListRoot }
  ['{08AEB6DA-F51C-4D30-871E-FF19E1935A99}']
  function Get_Node: Il3SimpleNode;
  function Get_RootToKeep: INodeBase;
  function Get_MenuSectionItemToKeep: ISectionItem;
  property Node: Il3SimpleNode
   read Get_Node;
  property RootToKeep: INodeBase
   read Get_RootToKeep;
  property MenuSectionItemToKeep: ISectionItem
   read Get_MenuSectionItemToKeep;
 end;//IRubricator_SetListRoot_Params

 Op_Rubricator_SetListRoot = class
  {* ����� ��� ������ �������� Rubricator.SetListRoot }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem): Boolean; overload;
    {* ����� �������� Rubricator.SetListRoot � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem): Boolean; overload;
    {* ����� �������� Rubricator.SetListRoot � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem): Boolean; overload;
    {* ����� �������� Rubricator.SetListRoot � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem): Boolean; overload;
    {* ����� �������� Rubricator.SetListRoot � ���������� }
 end;//Op_Rubricator_SetListRoot

 IRubricator_InitListRoot_Params = interface
  {* ��������� ��� �������� Rubricator.InitListRoot }
  ['{A4493419-E50F-4EFC-9B58-CA180C218275}']
  function Get_Node: Il3SimpleNode;
  function Get_RootToKeep: INodeBase;
  function Get_MenuSectionItemToKeep: ISectionItem;
  property Node: Il3SimpleNode
   read Get_Node;
  property RootToKeep: INodeBase
   read Get_RootToKeep;
  property MenuSectionItemToKeep: ISectionItem
   read Get_MenuSectionItemToKeep;
 end;//IRubricator_InitListRoot_Params

 Op_Rubricator_InitListRoot = class
  {* ����� ��� ������ �������� Rubricator.InitListRoot }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem): Boolean; overload;
    {* ����� �������� Rubricator.InitListRoot � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem): Boolean; overload;
    {* ����� �������� Rubricator.InitListRoot � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem): Boolean; overload;
    {* ����� �������� Rubricator.InitListRoot � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem): Boolean; overload;
    {* ����� �������� Rubricator.InitListRoot � ���������� }
 end;//Op_Rubricator_InitListRoot

 Op_Rubricator_Synchronize = class
  {* ����� ��� ������ �������� Rubricator.Synchronize }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� Rubricator.Synchronize � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� Rubricator.Synchronize � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� Rubricator.Synchronize � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� Rubricator.Synchronize � ���������� }
 end;//Op_Rubricator_Synchronize

 IRubricator_GetRoot_Params = interface
  {* ��������� ��� �������� Rubricator.GetRoot }
  ['{E6D245F3-C0B0-41E0-AAD9-9913FA991580}']
  function Get_ResultValue: Il3SimpleNode;
  procedure Set_ResultValue(const aValue: Il3SimpleNode);
  property ResultValue: Il3SimpleNode
   read Get_ResultValue
   write Set_ResultValue;
 end;//IRubricator_GetRoot_Params

 Op_Rubricator_GetRoot = class
  {* ����� ��� ������ �������� Rubricator.GetRoot }
  public
   class function Call(const aTarget: IvcmEntity): Il3SimpleNode; overload;
    {* ����� �������� Rubricator.GetRoot � �������� }
   class function Call(const aTarget: IvcmAggregate): Il3SimpleNode; overload;
    {* ����� �������� Rubricator.GetRoot � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Il3SimpleNode; overload;
    {* ����� �������� Rubricator.GetRoot � ����� }
   class function Call(const aTarget: IvcmContainer): Il3SimpleNode; overload;
    {* ����� �������� Rubricator.GetRoot � ���������� }
 end;//Op_Rubricator_GetRoot
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 TRubricator_SetListRoot_Params = class(Tl3CProtoObject, IRubricator_SetListRoot_Params)
  {* ���������� IRubricator_SetListRoot_Params }
  private
   f_Node: Il3SimpleNode;
   f_RootToKeep: INodeBase;
   f_MenuSectionItemToKeep: ISectionItem;
  protected
   function Get_MenuSectionItemToKeep: ISectionItem;
   function Get_RootToKeep: INodeBase;
   function Get_Node: Il3SimpleNode;
   procedure ClearFields; override;
  public
   constructor Create(const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem); reintroduce;
    {* ����������� TRubricator_SetListRoot_Params }
   class function Make(const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem): IRubricator_SetListRoot_Params; reintroduce;
    {* ������� TRubricator_SetListRoot_Params }
 end;//TRubricator_SetListRoot_Params

 TRubricator_InitListRoot_Params = class(Tl3CProtoObject, IRubricator_InitListRoot_Params)
  {* ���������� IRubricator_InitListRoot_Params }
  private
   f_Node: Il3SimpleNode;
   f_RootToKeep: INodeBase;
   f_MenuSectionItemToKeep: ISectionItem;
  protected
   function Get_RootToKeep: INodeBase;
   function Get_MenuSectionItemToKeep: ISectionItem;
   function Get_Node: Il3SimpleNode;
   procedure ClearFields; override;
  public
   constructor Create(const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem); reintroduce;
    {* ����������� TRubricator_InitListRoot_Params }
   class function Make(const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem): IRubricator_InitListRoot_Params; reintroduce;
    {* ������� TRubricator_InitListRoot_Params }
 end;//TRubricator_InitListRoot_Params

 TRubricator_GetRoot_Params = class(Tl3CProtoObject, IRubricator_GetRoot_Params)
  {* ���������� IRubricator_GetRoot_Params }
  private
   f_ResultValue: Il3SimpleNode;
  protected
   function Get_ResultValue: Il3SimpleNode;
   procedure Set_ResultValue(const aValue: Il3SimpleNode);
   procedure ClearFields; override;
  public
   constructor Create; reintroduce;
    {* ����������� TRubricator_GetRoot_Params }
   class function Make: IRubricator_GetRoot_Params; reintroduce;
    {* ������� TRubricator_GetRoot_Params }
 end;//TRubricator_GetRoot_Params

constructor TRubricator_SetListRoot_Params.Create(const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem);
 {* ����������� TRubricator_SetListRoot_Params }
//#UC START# *FE5ABE7677C2_A7ACC8300BF9_var*
//#UC END# *FE5ABE7677C2_A7ACC8300BF9_var*
begin
//#UC START# *FE5ABE7677C2_A7ACC8300BF9_impl*
 !!! Needs to be implemented !!!
//#UC END# *FE5ABE7677C2_A7ACC8300BF9_impl*
end;//TRubricator_SetListRoot_Params.Create

class function TRubricator_SetListRoot_Params.Make(const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem): IRubricator_SetListRoot_Params;
 {* ������� TRubricator_SetListRoot_Params }
var
 l_Inst : TRubricator_SetListRoot_Params;
begin
 l_Inst := Create(aNode, aRootToKeep, aMenuSectionItemToKeep);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TRubricator_SetListRoot_Params.Make

function TRubricator_SetListRoot_Params.Get_MenuSectionItemToKeep: ISectionItem;
//#UC START# *7642365480E3_A7ACC8300BF9get_var*
//#UC END# *7642365480E3_A7ACC8300BF9get_var*
begin
//#UC START# *7642365480E3_A7ACC8300BF9get_impl*
 !!! Needs to be implemented !!!
//#UC END# *7642365480E3_A7ACC8300BF9get_impl*
end;//TRubricator_SetListRoot_Params.Get_MenuSectionItemToKeep

function TRubricator_SetListRoot_Params.Get_RootToKeep: INodeBase;
//#UC START# *BDF6495DCDAE_A7ACC8300BF9get_var*
//#UC END# *BDF6495DCDAE_A7ACC8300BF9get_var*
begin
//#UC START# *BDF6495DCDAE_A7ACC8300BF9get_impl*
 !!! Needs to be implemented !!!
//#UC END# *BDF6495DCDAE_A7ACC8300BF9get_impl*
end;//TRubricator_SetListRoot_Params.Get_RootToKeep

function TRubricator_SetListRoot_Params.Get_Node: Il3SimpleNode;
//#UC START# *FF658FE3F542_A7ACC8300BF9get_var*
//#UC END# *FF658FE3F542_A7ACC8300BF9get_var*
begin
//#UC START# *FF658FE3F542_A7ACC8300BF9get_impl*
 !!! Needs to be implemented !!!
//#UC END# *FF658FE3F542_A7ACC8300BF9get_impl*
end;//TRubricator_SetListRoot_Params.Get_Node

procedure TRubricator_SetListRoot_Params.ClearFields;
begin
 f_Node := nil;
 f_RootToKeep := nil;
 f_MenuSectionItemToKeep := nil;
 inherited;
end;//TRubricator_SetListRoot_Params.ClearFields

class function Op_Rubricator_SetListRoot.Call(const aTarget: IvcmEntity;
 const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem): Boolean;
 {* ����� �������� Rubricator.SetListRoot � �������� }
//#UC START# *48AC881B1007_3266791D2583_var*
//#UC END# *48AC881B1007_3266791D2583_var*
begin
//#UC START# *48AC881B1007_3266791D2583_impl*
 !!! Needs to be implemented !!!
//#UC END# *48AC881B1007_3266791D2583_impl*
end;//Op_Rubricator_SetListRoot.Call

class function Op_Rubricator_SetListRoot.Call(const aTarget: IvcmAggregate;
 const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem): Boolean;
 {* ����� �������� Rubricator.SetListRoot � ��������� }
//#UC START# *78EC48099A57_3266791D2583_var*
//#UC END# *78EC48099A57_3266791D2583_var*
begin
//#UC START# *78EC48099A57_3266791D2583_impl*
 !!! Needs to be implemented !!!
//#UC END# *78EC48099A57_3266791D2583_impl*
end;//Op_Rubricator_SetListRoot.Call

class function Op_Rubricator_SetListRoot.Call(const aTarget: IvcmEntityForm;
 const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem): Boolean;
 {* ����� �������� Rubricator.SetListRoot � ����� }
//#UC START# *C75C9E1570AD_3266791D2583_var*
//#UC END# *C75C9E1570AD_3266791D2583_var*
begin
//#UC START# *C75C9E1570AD_3266791D2583_impl*
 !!! Needs to be implemented !!!
//#UC END# *C75C9E1570AD_3266791D2583_impl*
end;//Op_Rubricator_SetListRoot.Call

class function Op_Rubricator_SetListRoot.Call(const aTarget: IvcmContainer;
 const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem): Boolean;
 {* ����� �������� Rubricator.SetListRoot � ���������� }
//#UC START# *E192AE0A4E35_3266791D2583_var*
//#UC END# *E192AE0A4E35_3266791D2583_var*
begin
//#UC START# *E192AE0A4E35_3266791D2583_impl*
 !!! Needs to be implemented !!!
//#UC END# *E192AE0A4E35_3266791D2583_impl*
end;//Op_Rubricator_SetListRoot.Call

constructor TRubricator_InitListRoot_Params.Create(const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem);
 {* ����������� TRubricator_InitListRoot_Params }
//#UC START# *17E12CFCA1E2_4FD3A4102DB6_var*
//#UC END# *17E12CFCA1E2_4FD3A4102DB6_var*
begin
//#UC START# *17E12CFCA1E2_4FD3A4102DB6_impl*
 !!! Needs to be implemented !!!
//#UC END# *17E12CFCA1E2_4FD3A4102DB6_impl*
end;//TRubricator_InitListRoot_Params.Create

class function TRubricator_InitListRoot_Params.Make(const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem): IRubricator_InitListRoot_Params;
 {* ������� TRubricator_InitListRoot_Params }
var
 l_Inst : TRubricator_InitListRoot_Params;
begin
 l_Inst := Create(aNode, aRootToKeep, aMenuSectionItemToKeep);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TRubricator_InitListRoot_Params.Make

function TRubricator_InitListRoot_Params.Get_RootToKeep: INodeBase;
//#UC START# *27E61DE967EE_4FD3A4102DB6get_var*
//#UC END# *27E61DE967EE_4FD3A4102DB6get_var*
begin
//#UC START# *27E61DE967EE_4FD3A4102DB6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *27E61DE967EE_4FD3A4102DB6get_impl*
end;//TRubricator_InitListRoot_Params.Get_RootToKeep

function TRubricator_InitListRoot_Params.Get_MenuSectionItemToKeep: ISectionItem;
//#UC START# *7177F3DE7453_4FD3A4102DB6get_var*
//#UC END# *7177F3DE7453_4FD3A4102DB6get_var*
begin
//#UC START# *7177F3DE7453_4FD3A4102DB6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *7177F3DE7453_4FD3A4102DB6get_impl*
end;//TRubricator_InitListRoot_Params.Get_MenuSectionItemToKeep

function TRubricator_InitListRoot_Params.Get_Node: Il3SimpleNode;
//#UC START# *E86249C3E69F_4FD3A4102DB6get_var*
//#UC END# *E86249C3E69F_4FD3A4102DB6get_var*
begin
//#UC START# *E86249C3E69F_4FD3A4102DB6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *E86249C3E69F_4FD3A4102DB6get_impl*
end;//TRubricator_InitListRoot_Params.Get_Node

procedure TRubricator_InitListRoot_Params.ClearFields;
begin
 f_Node := nil;
 f_RootToKeep := nil;
 f_MenuSectionItemToKeep := nil;
 inherited;
end;//TRubricator_InitListRoot_Params.ClearFields

class function Op_Rubricator_InitListRoot.Call(const aTarget: IvcmEntity;
 const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem): Boolean;
 {* ����� �������� Rubricator.InitListRoot � �������� }
//#UC START# *64F3B69EBA84_A043500A3603_var*
//#UC END# *64F3B69EBA84_A043500A3603_var*
begin
//#UC START# *64F3B69EBA84_A043500A3603_impl*
 !!! Needs to be implemented !!!
//#UC END# *64F3B69EBA84_A043500A3603_impl*
end;//Op_Rubricator_InitListRoot.Call

class function Op_Rubricator_InitListRoot.Call(const aTarget: IvcmAggregate;
 const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem): Boolean;
 {* ����� �������� Rubricator.InitListRoot � ��������� }
//#UC START# *47F7738244D5_A043500A3603_var*
//#UC END# *47F7738244D5_A043500A3603_var*
begin
//#UC START# *47F7738244D5_A043500A3603_impl*
 !!! Needs to be implemented !!!
//#UC END# *47F7738244D5_A043500A3603_impl*
end;//Op_Rubricator_InitListRoot.Call

class function Op_Rubricator_InitListRoot.Call(const aTarget: IvcmEntityForm;
 const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem): Boolean;
 {* ����� �������� Rubricator.InitListRoot � ����� }
//#UC START# *E9BEF4197897_A043500A3603_var*
//#UC END# *E9BEF4197897_A043500A3603_var*
begin
//#UC START# *E9BEF4197897_A043500A3603_impl*
 !!! Needs to be implemented !!!
//#UC END# *E9BEF4197897_A043500A3603_impl*
end;//Op_Rubricator_InitListRoot.Call

class function Op_Rubricator_InitListRoot.Call(const aTarget: IvcmContainer;
 const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem): Boolean;
 {* ����� �������� Rubricator.InitListRoot � ���������� }
//#UC START# *2FC19F16AEA1_A043500A3603_var*
//#UC END# *2FC19F16AEA1_A043500A3603_var*
begin
//#UC START# *2FC19F16AEA1_A043500A3603_impl*
 !!! Needs to be implemented !!!
//#UC END# *2FC19F16AEA1_A043500A3603_impl*
end;//Op_Rubricator_InitListRoot.Call

class function Op_Rubricator_Synchronize.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� Rubricator.Synchronize � �������� }
//#UC START# *8AE25AEF3C2C_32C843315381_var*
//#UC END# *8AE25AEF3C2C_32C843315381_var*
begin
//#UC START# *8AE25AEF3C2C_32C843315381_impl*
 !!! Needs to be implemented !!!
//#UC END# *8AE25AEF3C2C_32C843315381_impl*
end;//Op_Rubricator_Synchronize.Call

class function Op_Rubricator_Synchronize.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� Rubricator.Synchronize � ��������� }
//#UC START# *BB221ADEC67C_32C843315381_var*
//#UC END# *BB221ADEC67C_32C843315381_var*
begin
//#UC START# *BB221ADEC67C_32C843315381_impl*
 !!! Needs to be implemented !!!
//#UC END# *BB221ADEC67C_32C843315381_impl*
end;//Op_Rubricator_Synchronize.Call

class function Op_Rubricator_Synchronize.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� Rubricator.Synchronize � ����� }
//#UC START# *7525D8C21A16_32C843315381_var*
//#UC END# *7525D8C21A16_32C843315381_var*
begin
//#UC START# *7525D8C21A16_32C843315381_impl*
 !!! Needs to be implemented !!!
//#UC END# *7525D8C21A16_32C843315381_impl*
end;//Op_Rubricator_Synchronize.Call

class function Op_Rubricator_Synchronize.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� Rubricator.Synchronize � ���������� }
//#UC START# *1A8909936035_32C843315381_var*
//#UC END# *1A8909936035_32C843315381_var*
begin
//#UC START# *1A8909936035_32C843315381_impl*
 !!! Needs to be implemented !!!
//#UC END# *1A8909936035_32C843315381_impl*
end;//Op_Rubricator_Synchronize.Call

constructor TRubricator_GetRoot_Params.Create;
 {* ����������� TRubricator_GetRoot_Params }
//#UC START# *16908252C187_5F95D6966545_var*
//#UC END# *16908252C187_5F95D6966545_var*
begin
//#UC START# *16908252C187_5F95D6966545_impl*
 !!! Needs to be implemented !!!
//#UC END# *16908252C187_5F95D6966545_impl*
end;//TRubricator_GetRoot_Params.Create

class function TRubricator_GetRoot_Params.Make: IRubricator_GetRoot_Params;
 {* ������� TRubricator_GetRoot_Params }
var
 l_Inst : TRubricator_GetRoot_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TRubricator_GetRoot_Params.Make

function TRubricator_GetRoot_Params.Get_ResultValue: Il3SimpleNode;
//#UC START# *2FC37EEDF50A_5F95D6966545get_var*
//#UC END# *2FC37EEDF50A_5F95D6966545get_var*
begin
//#UC START# *2FC37EEDF50A_5F95D6966545get_impl*
 !!! Needs to be implemented !!!
//#UC END# *2FC37EEDF50A_5F95D6966545get_impl*
end;//TRubricator_GetRoot_Params.Get_ResultValue

procedure TRubricator_GetRoot_Params.Set_ResultValue(const aValue: Il3SimpleNode);
//#UC START# *2FC37EEDF50A_5F95D6966545set_var*
//#UC END# *2FC37EEDF50A_5F95D6966545set_var*
begin
//#UC START# *2FC37EEDF50A_5F95D6966545set_impl*
 !!! Needs to be implemented !!!
//#UC END# *2FC37EEDF50A_5F95D6966545set_impl*
end;//TRubricator_GetRoot_Params.Set_ResultValue

procedure TRubricator_GetRoot_Params.ClearFields;
begin
 f_ResultValue := nil;
 inherited;
end;//TRubricator_GetRoot_Params.ClearFields

class function Op_Rubricator_GetRoot.Call(const aTarget: IvcmEntity): Il3SimpleNode;
 {* ����� �������� Rubricator.GetRoot � �������� }
//#UC START# *563B1DF53759_B82060518628_var*
//#UC END# *563B1DF53759_B82060518628_var*
begin
//#UC START# *563B1DF53759_B82060518628_impl*
 !!! Needs to be implemented !!!
//#UC END# *563B1DF53759_B82060518628_impl*
end;//Op_Rubricator_GetRoot.Call

class function Op_Rubricator_GetRoot.Call(const aTarget: IvcmAggregate): Il3SimpleNode;
 {* ����� �������� Rubricator.GetRoot � ��������� }
//#UC START# *867ADDE3C1A9_B82060518628_var*
//#UC END# *867ADDE3C1A9_B82060518628_var*
begin
//#UC START# *867ADDE3C1A9_B82060518628_impl*
 !!! Needs to be implemented !!!
//#UC END# *867ADDE3C1A9_B82060518628_impl*
end;//Op_Rubricator_GetRoot.Call

class function Op_Rubricator_GetRoot.Call(const aTarget: IvcmEntityForm): Il3SimpleNode;
 {* ����� �������� Rubricator.GetRoot � ����� }
//#UC START# *40233499B40B_B82060518628_var*
//#UC END# *40233499B40B_B82060518628_var*
begin
//#UC START# *40233499B40B_B82060518628_impl*
 !!! Needs to be implemented !!!
//#UC END# *40233499B40B_B82060518628_impl*
end;//Op_Rubricator_GetRoot.Call

class function Op_Rubricator_GetRoot.Call(const aTarget: IvcmContainer): Il3SimpleNode;
 {* ����� �������� Rubricator.GetRoot � ���������� }
//#UC START# *19FE5D7DF53B_B82060518628_var*
//#UC END# *19FE5D7DF53B_B82060518628_var*
begin
//#UC START# *19FE5D7DF53B_B82060518628_impl*
 !!! Needs to be implemented !!!
//#UC END# *19FE5D7DF53B_B82060518628_impl*
end;//Op_Rubricator_GetRoot.Call
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
