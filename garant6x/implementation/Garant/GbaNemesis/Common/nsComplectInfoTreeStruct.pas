unit nsComplectInfoTreeStruct;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Common$Lib"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Common/nsComplectInfoTreeStruct.pas"
// �����: 2005/11/22 17:48:07
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Common$Lib::ComplectInfo::TnsComplectInfoTreeStruct
//
// ������ ���������� � ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DynamicTreeUnit,
  l3TreeInterfaces,
  nsDataResetTreeStruct,
  nsINodeWrapBase
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsComplectInfoTreeStruct = class(TnsDataResetTreeStruct)
  {* ������ ���������� � ��������� }
 private
 // private methods
   class function GetComplectInfoTree: INodeBase;
     {* �������� �������� ���� � �������� }
 protected
 // realized methods
   function ReAqurieUnfilteredRoot: INodeBase; override;
 protected
 // overridden protected methods
   function RootNodeClass: RnsINodeWrap; override;
     {* ���������� ����� ������� ��� Root }
 public
 // public methods
   constructor Create; reintroduce;
   class function Make: Il3SimpleTree; reintroduce;
     {* ������ �������� ������ }
 end;//TnsComplectInfoTreeStruct
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DataAdapter,
  ComplectUnit,
  nsTypes,
  nsComplectInfoRootNode
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsComplectInfoTreeStruct

constructor TnsComplectInfoTreeStruct.Create;
//#UC START# *490872B30390_468368FC017F_var*
//#UC END# *490872B30390_468368FC017F_var*
begin
//#UC START# *490872B30390_468368FC017F_impl*
 inherited Create(GetComplectInfoTree, False);
//#UC END# *490872B30390_468368FC017F_impl*
end;//TnsComplectInfoTreeStruct.Create

class function TnsComplectInfoTreeStruct.Make: Il3SimpleTree;
var
 l_Inst : TnsComplectInfoTreeStruct;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

class function TnsComplectInfoTreeStruct.GetComplectInfoTree: INodeBase;
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
//#UC START# *48FEE3640227_468368FC017F_var*
//#UC END# *48FEE3640227_468368FC017F_var*
begin
//#UC START# *48FEE3640227_468368FC017F_impl*
 Result := TnsComplectInfoRootNode;
//#UC END# *48FEE3640227_468368FC017F_impl*
end;//TnsComplectInfoTreeStruct.RootNodeClass

{$IfEnd} //not Admin AND not Monitorings

end.