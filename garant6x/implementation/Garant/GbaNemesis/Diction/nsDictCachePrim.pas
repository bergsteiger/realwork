unit nsDictCachePrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Diction"
// �����: ������ �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Diction/nsDictCachePrim.pas"
// �����: 2004/02/20 08:36:17
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ���������� ��������::Diction::Diction::Diction$Unit::TnsDictCachePrim
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
  l3CacheableBase,
  bsTypes,
  nsLangList,
  afwInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _afwApplicationDataUpdate_Parent_ = Tl3CacheableBase;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}
 TnsDictCachePrim = class(_afwApplicationDataUpdate_)
 private
 // private fields
   f_AvailableLangs : TnsLangList;
   f_IsRootReceived : Boolean;
    {* ���� ��� �������� IsRootReceived}
   f_Root : INodeBase;
    {* ���� ��� �������� Root}
 protected
 // property methods
   function pm_GetRoot: INodeBase;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   procedure FinishDataUpdate; override;
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
 protected
 // protected methods
   function DoGetRoot: INodeBase; virtual; abstract;
 public
 // public methods
   procedure ClearCache; virtual;
   function ContainsLang(aLang: TbsLanguage): Boolean;
 protected
 // protected properties
   property IsRootReceived: Boolean
     read f_IsRootReceived
     write f_IsRootReceived;
     {* ���������� �������� �� �� ������ ������ ���������� � ��������. ���
           ������, ����� ���������� �� ���� ��� ��������� ������� � ��� ������
           ������ ������������ ���������� ��������� �����, ��� ��������
           ��������� �� �������� ���������� ��������� ������ }
 public
 // public properties
   property Root: INodeBase
     read pm_GetRoot;
 end;//TnsDictCachePrim
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  bsConvert,
  DataAdapter,
  nsTypes,
  l3Base,
  afwFacade
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

{$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}

// start class TnsDictCachePrim

function TnsDictCachePrim.pm_GetRoot: INodeBase;
//#UC START# *490819DA005E_4908190C017Cget_var*
//#UC END# *490819DA005E_4908190C017Cget_var*
begin
//#UC START# *490819DA005E_4908190C017Cget_impl*
 if not IsRootReceived then
 begin
  try
   f_Root := DoGetRoot;
  except
   f_Root := nil;
   // - ���� �������� �������� ����� �������� ������� ������
  end;//try..except
  IsRootReceived := True;
 end;//if not IsRootReceived then
 Result := f_Root;
//#UC END# *490819DA005E_4908190C017Cget_impl*
end;//TnsDictCachePrim.pm_GetRoot

procedure TnsDictCachePrim.ClearCache;
//#UC START# *49081A3A00AC_4908190C017C_var*
//#UC END# *49081A3A00AC_4908190C017C_var*
begin
//#UC START# *49081A3A00AC_4908190C017C_impl*
 f_Root := nil;
 IsRootReceived := False;
 l3Free(f_AvailableLangs);
//#UC END# *49081A3A00AC_4908190C017C_impl*
end;//TnsDictCachePrim.ClearCache

function TnsDictCachePrim.ContainsLang(aLang: TbsLanguage): Boolean;
//#UC START# *49081A4F001E_4908190C017C_var*
var
 l_Layers : ILayerIdList;
 l_Index  : Integer;
 l_PLayer : TLayerId;
//#UC END# *49081A4F001E_4908190C017C_var*
begin
//#UC START# *49081A4F001E_4908190C017C_impl*
 Result := False;
 if not Assigned(f_AvailableLangs) and Assigned(Root) then
 begin
  f_AvailableLangs := TnsLangList.Create;
  Root.GetAvailableLayers(l_Layers);
  if l_Layers <> nil then
   for l_Index :=0 to l_Layers.Count - 1 do
   begin
    l_PLayer := l_Layers[l_Index];
    f_AvailableLangs.Add(bsAdapterToBusiness(l_PLayer));
   end;//for l_Index :=0 to l_Layers.GetCount - 1 do
 end;//if Root <> nil then
 // �������� ������� ������, ��� ����� ���� �� ������� � ������ ��������
 // ��������� �������, ����� ���������� ����� ��� ��������� �������
 if Assigned(f_AvailableLangs) then
  Result := f_AvailableLangs.IndexOf(aLang) >= 0;
//#UC END# *49081A4F001E_4908190C017C_impl*
end;//TnsDictCachePrim.ContainsLang

procedure TnsDictCachePrim.Cleanup;
//#UC START# *479731C50290_4908190C017C_var*
//#UC END# *479731C50290_4908190C017C_var*
begin
//#UC START# *479731C50290_4908190C017C_impl*
 f_Root := nil;
 l3Free(f_AvailableLangs);
 inherited;
//#UC END# *479731C50290_4908190C017C_impl*
end;//TnsDictCachePrim.Cleanup

procedure TnsDictCachePrim.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4908190C017C_var*
//#UC END# *47EA4E9002C6_4908190C017C_var*
begin
//#UC START# *47EA4E9002C6_4908190C017C_impl*
 inherited;
 ClearCache;
//#UC END# *47EA4E9002C6_4908190C017C_impl*
end;//TnsDictCachePrim.FinishDataUpdate

procedure TnsDictCachePrim.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Root := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TnsDictCachePrim.ClearFields

{$IfEnd} //not Admin AND not Monitorings

end.