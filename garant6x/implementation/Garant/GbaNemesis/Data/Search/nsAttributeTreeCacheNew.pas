unit nsAttributeTreeCacheNew;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Data"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Search/nsAttributeTreeCacheNew.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ������� ����������� ���������� �������::LegalDomain::Data::Search::TnsAttributeTreeCacheNew
//
// �������, ��� ���?
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  DynamicTreeUnit,
  l3Interfaces,
  l3InterfacedStringList,
  afwInterfaces
  ;

type
 _afwApplicationDataUpdate_Parent_ = Tl3InterfacedStringList;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}
 TnsAttributeTreeCacheNew = class(_afwApplicationDataUpdate_)
  {* �������, ��� ���? }
 private
 // private methods
   function GetAttributeRoot(const aTag: Il3CString;
    aDropFlags: Boolean = False): INodeBase;
     {* �������, ��� ���? }
 protected
 // property methods
   function pm_GetAttributeRoot(const aTag: Il3CString): INodeBase;
   function pm_GetAttributeRootClosed(const aTag: Il3CString): INodeBase;
 protected
 // overridden protected methods
   procedure FinishDataUpdate; override;
 public
 // overridden public methods
   constructor Create; override;
 public
 // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // public properties
   property AttributeRoot[const aTag: Il3CString]: INodeBase
     read pm_GetAttributeRoot;
   property AttributeRootClosed[const aTag: Il3CString]: INodeBase
     read pm_GetAttributeRootClosed;
 public
 // singleton factory method
   class function Instance: TnsAttributeTreeCacheNew;
    {- ���������� ��������� ����������. }
 end;//TnsAttributeTreeCacheNew

implementation

uses
  l3Base {a},
  nsTypes,
  DataAdapter,
  GblAdapter,
  afwFacade
  ;


// start class TnsAttributeTreeCacheNew

var g_TnsAttributeTreeCacheNew : TnsAttributeTreeCacheNew = nil;

procedure TnsAttributeTreeCacheNewFree;
begin
 l3Free(g_TnsAttributeTreeCacheNew);
end;

class function TnsAttributeTreeCacheNew.Instance: TnsAttributeTreeCacheNew;
begin
 if (g_TnsAttributeTreeCacheNew = nil) then
 begin
  l3System.AddExitProc(TnsAttributeTreeCacheNewFree);
  g_TnsAttributeTreeCacheNew := Create;
 end;
 Result := g_TnsAttributeTreeCacheNew;
end;


{$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}

// start class TnsAttributeTreeCacheNew

function TnsAttributeTreeCacheNew.pm_GetAttributeRoot(const aTag: Il3CString): INodeBase;
//#UC START# *4912ABB40360_4912AB3A01EDget_var*
//#UC END# *4912ABB40360_4912AB3A01EDget_var*
begin
//#UC START# *4912ABB40360_4912AB3A01EDget_impl*
 Result := GetAttributeRoot(aTag);
//#UC END# *4912ABB40360_4912AB3A01EDget_impl*
end;//TnsAttributeTreeCacheNew.pm_GetAttributeRoot

function TnsAttributeTreeCacheNew.pm_GetAttributeRootClosed(const aTag: Il3CString): INodeBase;
//#UC START# *4912ABE4035C_4912AB3A01EDget_var*
//#UC END# *4912ABE4035C_4912AB3A01EDget_var*
begin
//#UC START# *4912ABE4035C_4912AB3A01EDget_impl*
 Result := GetAttributeRoot(aTag, true);
//#UC END# *4912ABE4035C_4912AB3A01EDget_impl*
end;//TnsAttributeTreeCacheNew.pm_GetAttributeRootClosed

function TnsAttributeTreeCacheNew.GetAttributeRoot(const aTag: Il3CString;
  aDropFlags: Boolean = False): INodeBase;
//#UC START# *4912AC600333_4912AB3A01ED_var*
var
 l_Interface: IUnknown;
 l_Node: INodeBase;
//#UC END# *4912AC600333_4912AB3A01ED_var*
begin
//#UC START# *4912AC600333_4912AB3A01ED_impl*
 l_Interface := FindInterface(nsWStr(aTag));
 if (l_Interface = nil) then
 begin
  try
   l_Node := DefDataAdapter.NativeAdapter.MakeNodeBase(nsAStr(aTag).S);
   Add(aTag, l_Node);
  except
   on EUnknownFactoryKey do
    l_Node := nil;
  end;
 end//l_Interface = nil
 else
 begin
  l_Node := l_Interface as INodeBase;
  if aDropFlags then
  begin
   l_Node.SetAllFlag(FM_Open, False);
   l_Node.SetAllFlag(FM_Selection, False);
  end;//aDropFlags
 end;//l_Interface = nil
 Result := l_Node;
//#UC END# *4912AC600333_4912AB3A01ED_impl*
end;//TnsAttributeTreeCacheNew.GetAttributeRoot

class function TnsAttributeTreeCacheNew.Exists: Boolean;
 {-}
begin
 Result := g_TnsAttributeTreeCacheNew <> nil;
end;//TnsAttributeTreeCacheNew.Exists

constructor TnsAttributeTreeCacheNew.Create;
//#UC START# *47B9866E034D_4912AB3A01ED_var*
//#UC END# *47B9866E034D_4912AB3A01ED_var*
begin
//#UC START# *47B9866E034D_4912AB3A01ED_impl*
 inherited;
 Sorted := true;
//#UC END# *47B9866E034D_4912AB3A01ED_impl*
end;//TnsAttributeTreeCacheNew.Create

procedure TnsAttributeTreeCacheNew.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4912AB3A01ED_var*
//#UC END# *47EA4E9002C6_4912AB3A01ED_var*
begin
//#UC START# *47EA4E9002C6_4912AB3A01ED_impl*
 inherited;
 Clear;
//#UC END# *47EA4E9002C6_4912AB3A01ED_impl*
end;//TnsAttributeTreeCacheNew.FinishDataUpdate

end.