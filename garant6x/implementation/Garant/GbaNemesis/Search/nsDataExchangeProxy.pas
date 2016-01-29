unit nsDataExchangeProxy;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Search"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Search/nsDataExchangeProxy.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Common For Shell And Monitoring::Search::Search::nsQueryAttributes::TnsDataExchangeProxy
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  DynamicDocListUnit,
  bsTypes,
  l3ProtoDataContainer
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 InsDataExchangeSubscriber = interface(IUnknown)
   ['{20C77FB9-BA8F-42A3-8DA2-CA5B86F19816}']
   procedure MakeAndOpenList(const aList: IDynList;
     aOpenFrom: TbsListOpenFrom = lofNone);
 end;//InsDataExchangeSubscriber

 TnsDataExchangeProxy = class(Tl3ProtoDataContainer)
 private
 // private fields
   f_Subscriber : InsDataExchangeSubscriber;
    {* Поле для свойства Subscriber}
 protected
 // property methods
   procedure pm_SetSubscriber(const aValue: InsDataExchangeSubscriber);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   procedure MakeAndOpenList(const aList: IDynList;
     aOpenFrom: TbsListOpenFrom = lofNone);
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // public properties
   property Subscriber: InsDataExchangeSubscriber
     read f_Subscriber
     write pm_SetSubscriber;
 public
 // singleton factory method
   class function Instance: TnsDataExchangeProxy;
    {- возвращает экземпляр синглетона. }
 end;//TnsDataExchangeProxy
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  l3Base {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}


// start class TnsDataExchangeProxy

var g_TnsDataExchangeProxy : TnsDataExchangeProxy = nil;

procedure TnsDataExchangeProxyFree;
begin
 l3Free(g_TnsDataExchangeProxy);
end;

class function TnsDataExchangeProxy.Instance: TnsDataExchangeProxy;
begin
 if (g_TnsDataExchangeProxy = nil) then
 begin
  l3System.AddExitProc(TnsDataExchangeProxyFree);
  g_TnsDataExchangeProxy := Create;
 end;
 Result := g_TnsDataExchangeProxy;
end;


procedure TnsDataExchangeProxy.MakeAndOpenList(const aList: IDynList;
  aOpenFrom: TbsListOpenFrom = lofNone);
//#UC START# *54FEC90002B4_54FEC834013B_var*
//#UC END# *54FEC90002B4_54FEC834013B_var*
begin
//#UC START# *54FEC90002B4_54FEC834013B_impl*
 if Assigned(f_Subscriber) then
  f_Subscriber.MakeAndOpenList(aList, aOpenFrom);
//#UC END# *54FEC90002B4_54FEC834013B_impl*
end;//TnsDataExchangeProxy.MakeAndOpenList

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

class function TnsDataExchangeProxy.Exists: Boolean;
 {-}
begin
 Result := g_TnsDataExchangeProxy <> nil;
end;//TnsDataExchangeProxy.Exists

procedure TnsDataExchangeProxy.Cleanup;
//#UC START# *479731C50290_54FEC834013B_var*
//#UC END# *479731C50290_54FEC834013B_var*
begin
//#UC START# *479731C50290_54FEC834013B_impl*
 f_Subscriber := nil;
 inherited;
//#UC END# *479731C50290_54FEC834013B_impl*
end;//TnsDataExchangeProxy.Cleanup

procedure TnsDataExchangeProxy.ClearFields;
 {-}
begin
 {$If not defined(Admin)}
 Subscriber := nil;
 {$IfEnd} //not Admin
 inherited;
end;//TnsDataExchangeProxy.ClearFields

{$IfEnd} //not Admin

end.