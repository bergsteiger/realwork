unit nsAttributeTreeCacheNew;
 {* Коллеги, это что? }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Search\nsAttributeTreeCacheNew.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , l3InterfacedStringList
 , DynamicTreeUnit
 , l3Interfaces
 , afwInterfaces
;

type
 _afwApplicationDataUpdate_Parent_ = Tl3InterfacedStringList;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}
 TnsAttributeTreeCacheNew = class(_afwApplicationDataUpdate_)
  {* Коллеги, это что? }
  private
   function GetAttributeRoot(const aTag: Il3CString;
    aDropFlags: Boolean = False): INodeBase;
    {* Коллеги, это что? }
  protected
   function pm_GetAttributeRoot(const aTag: Il3CString): INodeBase;
   function pm_GetAttributeRootClosed(const aTag: Il3CString): INodeBase;
   procedure FinishDataUpdate; override;
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TnsAttributeTreeCacheNew;
    {* Метод получения экземпляра синглетона TnsAttributeTreeCacheNew }
   constructor Create; override;
  public
   property AttributeRoot[const aTag: Il3CString]: INodeBase
    read pm_GetAttributeRoot;
   property AttributeRootClosed[const aTag: Il3CString]: INodeBase
    read pm_GetAttributeRootClosed;
 end;//TnsAttributeTreeCacheNew

implementation

uses
 l3ImplUses
 , nsTypes
 , DataAdapter
 , GblAdapter
 , afwFacade
 , SysUtils
 , l3Base
;

var g_TnsAttributeTreeCacheNew: TnsAttributeTreeCacheNew = nil;
 {* Экземпляр синглетона TnsAttributeTreeCacheNew }

procedure TnsAttributeTreeCacheNewFree;
 {* Метод освобождения экземпляра синглетона TnsAttributeTreeCacheNew }
begin
 l3Free(g_TnsAttributeTreeCacheNew);
end;//TnsAttributeTreeCacheNewFree

{$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}

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
 {* Коллеги, это что? }
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
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsAttributeTreeCacheNew <> nil;
end;//TnsAttributeTreeCacheNew.Exists

class function TnsAttributeTreeCacheNew.Instance: TnsAttributeTreeCacheNew;
 {* Метод получения экземпляра синглетона TnsAttributeTreeCacheNew }
begin
 if (g_TnsAttributeTreeCacheNew = nil) then
 begin
  l3System.AddExitProc(TnsAttributeTreeCacheNewFree);
  g_TnsAttributeTreeCacheNew := Create;
 end;
 Result := g_TnsAttributeTreeCacheNew;
end;//TnsAttributeTreeCacheNew.Instance

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
