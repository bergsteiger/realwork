unit nsDataExchangeProxy;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\nsDataExchangeProxy.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsDataExchangeProxy" MUID: (54FEC834013B)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , DynamicDocListUnit
 , bsTypes
;

type
 InsDataExchangeSubscriber = interface
  ['{20C77FB9-BA8F-42A3-8DA2-CA5B86F19816}']
  procedure MakeAndOpenList(const aList: IDynList;
   aOpenFrom: TbsListOpenFrom = bsTypes.lofNone);
 end;//InsDataExchangeSubscriber

 TnsDataExchangeProxy = class(Tl3ProtoDataContainer)
  private
   f_Subscriber: InsDataExchangeSubscriber;
  protected
   procedure pm_SetSubscriber(const aValue: InsDataExchangeSubscriber);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   procedure MakeAndOpenList(const aList: IDynList;
    aOpenFrom: TbsListOpenFrom = bsTypes.lofNone);
   class function Instance: TnsDataExchangeProxy;
    {* Метод получения экземпляра синглетона TnsDataExchangeProxy }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Subscriber: InsDataExchangeSubscriber
    read f_Subscriber
    write pm_SetSubscriber;
 end;//TnsDataExchangeProxy
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TnsDataExchangeProxy: TnsDataExchangeProxy = nil;
 {* Экземпляр синглетона TnsDataExchangeProxy }

procedure TnsDataExchangeProxyFree;
 {* Метод освобождения экземпляра синглетона TnsDataExchangeProxy }
begin
 l3Free(g_TnsDataExchangeProxy);
end;//TnsDataExchangeProxyFree

procedure TnsDataExchangeProxy.pm_SetSubscriber(const aValue: InsDataExchangeSubscriber);
//#UC START# *54FEC8BB0295_54FEC834013Bset_var*
//#UC END# *54FEC8BB0295_54FEC834013Bset_var*
begin
//#UC START# *54FEC8BB0295_54FEC834013Bset_impl*
 if Assigned(f_Subscriber) and Assigned(aValue) and (f_Subscriber <> aValue) then
  Assert(False);
 f_Subscriber := aValue;
//#UC END# *54FEC8BB0295_54FEC834013Bset_impl*
end;//TnsDataExchangeProxy.pm_SetSubscriber

procedure TnsDataExchangeProxy.MakeAndOpenList(const aList: IDynList;
 aOpenFrom: TbsListOpenFrom = bsTypes.lofNone);
//#UC START# *54FEC90002B4_54FEC834013B_var*
//#UC END# *54FEC90002B4_54FEC834013B_var*
begin
//#UC START# *54FEC90002B4_54FEC834013B_impl*
 if Assigned(f_Subscriber) then
  f_Subscriber.MakeAndOpenList(aList, aOpenFrom);
//#UC END# *54FEC90002B4_54FEC834013B_impl*
end;//TnsDataExchangeProxy.MakeAndOpenList

class function TnsDataExchangeProxy.Instance: TnsDataExchangeProxy;
 {* Метод получения экземпляра синглетона TnsDataExchangeProxy }
begin
 if (g_TnsDataExchangeProxy = nil) then
 begin
  l3System.AddExitProc(TnsDataExchangeProxyFree);
  g_TnsDataExchangeProxy := Create;
 end;
 Result := g_TnsDataExchangeProxy;
end;//TnsDataExchangeProxy.Instance

class function TnsDataExchangeProxy.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsDataExchangeProxy <> nil;
end;//TnsDataExchangeProxy.Exists

procedure TnsDataExchangeProxy.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_54FEC834013B_var*
//#UC END# *479731C50290_54FEC834013B_var*
begin
//#UC START# *479731C50290_54FEC834013B_impl*
 f_Subscriber := nil;
 inherited;
//#UC END# *479731C50290_54FEC834013B_impl*
end;//TnsDataExchangeProxy.Cleanup

procedure TnsDataExchangeProxy.ClearFields;
begin
 Subscriber := nil;
 inherited;
end;//TnsDataExchangeProxy.ClearFields
{$IfEnd} // NOT Defined(Admin)

end.
