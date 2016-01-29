unit nsComplectInfoNode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Common$Lib"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Common/nsComplectInfoNode.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Common$Lib::ComplectInfo::TnsComplectInfoNode
//
// ���� ������ � ����������� � ���������
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
  l3Interfaces,
  nsINodeWrapBase,
  DynamicTreeUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsComplectInfoNode = class(TnsINodeWrapBase, Il3MultipartText)
  {* ���� ������ � ����������� � ��������� }
 private
 // private fields
   fValue : Il3CString;
 protected
 // realized methods
   function GetTextPart(aIndex: Integer): Tl3PCharLenPrim;
     {* ���������� ����� ������ �� �������. }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
 public
 // overridden public methods
   constructor Create(const aNode: INodeBase); override;
     {* ������ ��������� ���� ������ }
 end;//TnsComplectInfoNode
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils,
  ComplectUnit,
  l3String,
  nsTypes,
  IOUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsComplectInfoNode

function TnsComplectInfoNode.GetTextPart(aIndex: Integer): Tl3PCharLenPrim;
//#UC START# *46A6199402FB_4682778E0223_var*
//#UC END# *46A6199402FB_4682778E0223_var*
begin
//#UC START# *46A6199402FB_4682778E0223_impl*
 case aIndex of
  // ��������
  0 : Result := Get_Text;
  // ��������
  1 : Result := nsWStr(fValue);
  else
  begin
   l3AssignNil(Result);
   Assert(false);
  end;//else
 end;//case aIndex
//#UC END# *46A6199402FB_4682778E0223_impl*
end;//TnsComplectInfoNode.GetTextPart

procedure TnsComplectInfoNode.Cleanup;
//#UC START# *479731C50290_4682778E0223_var*
//#UC END# *479731C50290_4682778E0223_var*
begin
//#UC START# *479731C50290_4682778E0223_impl*
 fValue := nil;
 inherited;
//#UC END# *479731C50290_4682778E0223_impl*
end;//TnsComplectInfoNode.Cleanup

constructor TnsComplectInfoNode.Create(const aNode: INodeBase);
//#UC START# *490982310145_4682778E0223_var*
var
 l_CI  : IComplectInfoNode;
 l_Str : IString;
//#UC END# *490982310145_4682778E0223_var*
begin
//#UC START# *490982310145_4682778E0223_impl*
 inherited Create(aNode);
 if Supports(aNode, IComplectInfoNode, l_CI) then
 try
  l_CI.GetInfo(l_Str);
  try
   fValue := nsCStr(l_Str);
  finally
   l_CI := nil;
  end;//try..finally
 finally
  l_CI := nil;
 end;//try..finally
//#UC END# *490982310145_4682778E0223_impl*
end;//TnsComplectInfoNode.Create

{$IfEnd} //not Admin AND not Monitorings

end.