unit nsBaseSearchServiceImpl;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\nsBaseSearchServiceImpl.pas"
// Стереотип: "ServiceImplementation"
// Элемент модели: "TnsBaseSearchServiceImpl" MUID: (563208C60299)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ProtoObject
 , nsBaseSearchService
 , BaseSearchInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _KeyType_ = Pointer;
 _ValueType_ = Pointer;
 _l3Map_Parent_ = Tl3ProtoDataContainer;
 {$Include w:\common\components\rtl\Garant\L3\l3Map.imp.pas}
 TnsContainerToBaseSearcherMap = class(_l3Map_)
 end;//TnsContainerToBaseSearcherMap

 TnsBaseSearchServiceImpl = {final} class(Tl3ProtoObject, InsBaseSearchService)
  private
   f_SearcherMap: TnsContainerToBaseSearcherMap;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   procedure RegisterBaseSearchView(const aBaseSearchView: InsBaseSearchView;
    const aContainer: IvcmContainer);
   function GetBaseSearchController(const aContainer: IvcmContainer): InsBaseSearchController;
   function GetBaseSearchModel(const aContainer: IvcmContainer): InsBaseSearchModel;
   function GetBaseSearchView(const aContainer: IvcmContainer): InsBaseSearchView;
   function GetBaseSearcher(const aEntityForm: IvcmEntityForm): InsBaseSearcher;
   procedure OpenBaseSearch(const aContainer: IvcmContainer;
    aOpenKind: TnsBaseSearchOpenKind);
   function GetBaseSearchWindow(const aContainer: IvcmContainer): IvcmEntityForm;
   procedure RegisterBaseSearcherProvider(const aContainer: IvcmContainer;
    const aProvider: InsBaseSearcherProvider);
   procedure UnregisterBaseSearcherProvider(const aContainer: IvcmContainer;
    const aProvider: InsBaseSearcherProvider);
   class function Instance: TnsBaseSearchServiceImpl;
    {* Метод получения экземпляра синглетона TnsBaseSearchServiceImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TnsBaseSearchServiceImpl
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3MinMax
 , RTLConsts
;

var g_TnsBaseSearchServiceImpl: TnsBaseSearchServiceImpl = nil;
 {* Экземпляр синглетона TnsBaseSearchServiceImpl }

procedure TnsBaseSearchServiceImplFree;
 {* Метод освобождения экземпляра синглетона TnsBaseSearchServiceImpl }
begin
 l3Free(g_TnsBaseSearchServiceImpl);
end;//TnsBaseSearchServiceImplFree

function CompareKeys(const aA: _KeyType_;
 const aB: _KeyType_): Integer;
//#UC START# *5609091B00C0_56320A830305_var*
//#UC END# *5609091B00C0_56320A830305_var*
begin
//#UC START# *5609091B00C0_56320A830305_impl*
 Result := Integer(aB) - Integer(aA);
//#UC END# *5609091B00C0_56320A830305_impl*
end;//CompareKeys

type _Instance_R_ = TnsContainerToBaseSearcherMap;

{$Include w:\common\components\rtl\Garant\L3\l3Map.imp.pas}

procedure TnsBaseSearchServiceImpl.RegisterBaseSearchView(const aBaseSearchView: InsBaseSearchView;
 const aContainer: IvcmContainer);
//#UC START# *130AF2617571_563208C60299_var*
//#UC END# *130AF2617571_563208C60299_var*
begin
//#UC START# *130AF2617571_563208C60299_impl*
 Assert(False);
//#UC END# *130AF2617571_563208C60299_impl*
end;//TnsBaseSearchServiceImpl.RegisterBaseSearchView

function TnsBaseSearchServiceImpl.GetBaseSearchController(const aContainer: IvcmContainer): InsBaseSearchController;
//#UC START# *29D9062E385E_563208C60299_var*
//#UC END# *29D9062E385E_563208C60299_var*
begin
//#UC START# *29D9062E385E_563208C60299_impl*
 Assert(False);
//#UC END# *29D9062E385E_563208C60299_impl*
end;//TnsBaseSearchServiceImpl.GetBaseSearchController

function TnsBaseSearchServiceImpl.GetBaseSearchModel(const aContainer: IvcmContainer): InsBaseSearchModel;
//#UC START# *3ABD99A8B9EE_563208C60299_var*
//#UC END# *3ABD99A8B9EE_563208C60299_var*
begin
//#UC START# *3ABD99A8B9EE_563208C60299_impl*
 Assert(False);
//#UC END# *3ABD99A8B9EE_563208C60299_impl*
end;//TnsBaseSearchServiceImpl.GetBaseSearchModel

function TnsBaseSearchServiceImpl.GetBaseSearchView(const aContainer: IvcmContainer): InsBaseSearchView;
//#UC START# *48C239B7B9E8_563208C60299_var*
//#UC END# *48C239B7B9E8_563208C60299_var*
begin
//#UC START# *48C239B7B9E8_563208C60299_impl*
 Result := nil;
 Assert(false);
//#UC END# *48C239B7B9E8_563208C60299_impl*
end;//TnsBaseSearchServiceImpl.GetBaseSearchView

function TnsBaseSearchServiceImpl.GetBaseSearcher(const aEntityForm: IvcmEntityForm): InsBaseSearcher;
//#UC START# *4923CA8F0CFB_563208C60299_var*
var
 l_MainForm: IvcmContainer;
 l_Provider: InsBaseSearcherProvider;
//#UC END# *4923CA8F0CFB_563208C60299_var*
begin
//#UC START# *4923CA8F0CFB_563208C60299_impl*
 Result := nil;
 l_MainForm := aEntityForm.NativeMainForm;
 if f_SearcherMap.Has(Pointer(l_MainForm)) then
 begin
  l_Provider := InsBaseSearcherProvider(f_SearcherMap.ValueByKey(Pointer(l_MainForm)));
  Result := l_Provider.BaseSearcher;
 end; 
//#UC END# *4923CA8F0CFB_563208C60299_impl*
end;//TnsBaseSearchServiceImpl.GetBaseSearcher

procedure TnsBaseSearchServiceImpl.OpenBaseSearch(const aContainer: IvcmContainer;
 aOpenKind: TnsBaseSearchOpenKind);
//#UC START# *5434702F7752_563208C60299_var*
var
 l_BaseSearcher: InsBaseSearcher;
//#UC END# *5434702F7752_563208C60299_var*
begin
//#UC START# *5434702F7752_563208C60299_impl*
 l_BaseSearcher := GetBaseSearcher(aContainer.AsForm);
 try
  l_BaseSearcher.ShowWindowByUser(aOpenKind);
 finally
  l_BaseSearcher := nil;
 end;
//#UC END# *5434702F7752_563208C60299_impl*
end;//TnsBaseSearchServiceImpl.OpenBaseSearch

function TnsBaseSearchServiceImpl.GetBaseSearchWindow(const aContainer: IvcmContainer): IvcmEntityForm;
//#UC START# *5E9BD918F50B_563208C60299_var*
//#UC END# *5E9BD918F50B_563208C60299_var*
begin
//#UC START# *5E9BD918F50B_563208C60299_impl*
 Assert(False);
//#UC END# *5E9BD918F50B_563208C60299_impl*
end;//TnsBaseSearchServiceImpl.GetBaseSearchWindow

procedure TnsBaseSearchServiceImpl.RegisterBaseSearcherProvider(const aContainer: IvcmContainer;
 const aProvider: InsBaseSearcherProvider);
//#UC START# *B86FD3ED4532_563208C60299_var*
//#UC END# *B86FD3ED4532_563208C60299_var*
begin
//#UC START# *B86FD3ED4532_563208C60299_impl*
f_SearcherMap.Add(Pointer(aContainer), Pointer(aProvider));
//#UC END# *B86FD3ED4532_563208C60299_impl*
end;//TnsBaseSearchServiceImpl.RegisterBaseSearcherProvider

procedure TnsBaseSearchServiceImpl.UnregisterBaseSearcherProvider(const aContainer: IvcmContainer;
 const aProvider: InsBaseSearcherProvider);
//#UC START# *CB784FFDCCE4_563208C60299_var*
var
 l_Index: Integer;
//#UC END# *CB784FFDCCE4_563208C60299_var*
begin
//#UC START# *CB784FFDCCE4_563208C60299_impl*
 if f_SearcherMap.FindData(Tl3KeyValuePair_ForFind(Pointer(aContainer)), l_Index) then
  f_SearcherMap.Delete(l_Index);
//#UC END# *CB784FFDCCE4_563208C60299_impl*
end;//TnsBaseSearchServiceImpl.UnregisterBaseSearcherProvider

class function TnsBaseSearchServiceImpl.Instance: TnsBaseSearchServiceImpl;
 {* Метод получения экземпляра синглетона TnsBaseSearchServiceImpl }
begin
 if (g_TnsBaseSearchServiceImpl = nil) then
 begin
  l3System.AddExitProc(TnsBaseSearchServiceImplFree);
  g_TnsBaseSearchServiceImpl := Create;
 end;
 Result := g_TnsBaseSearchServiceImpl;
end;//TnsBaseSearchServiceImpl.Instance

class function TnsBaseSearchServiceImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsBaseSearchServiceImpl <> nil;
end;//TnsBaseSearchServiceImpl.Exists

procedure TnsBaseSearchServiceImpl.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_563208C60299_var*
//#UC END# *479731C50290_563208C60299_var*
begin
//#UC START# *479731C50290_563208C60299_impl*
 FreeAndNil(f_SearcherMap);
 inherited;
//#UC END# *479731C50290_563208C60299_impl*
end;//TnsBaseSearchServiceImpl.Cleanup

procedure TnsBaseSearchServiceImpl.InitFields;
//#UC START# *47A042E100E2_563208C60299_var*
//#UC END# *47A042E100E2_563208C60299_var*
begin
//#UC START# *47A042E100E2_563208C60299_impl*
 f_SearcherMap := TnsContainerToBaseSearcherMap.Create; 
//#UC END# *47A042E100E2_563208C60299_impl*
end;//TnsBaseSearchServiceImpl.InitFields

initialization
 TnsBaseSearchService.Instance.Alien := TnsBaseSearchServiceImpl.Instance;
 {* Регистрация TnsBaseSearchServiceImpl }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
