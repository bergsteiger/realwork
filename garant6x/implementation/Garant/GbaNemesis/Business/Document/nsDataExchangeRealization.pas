unit nsDataExchangeRealization;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/nsDataExchangeRealization.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Business::BaseDocument::TnsDataExchangeRealization
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3ProtoDataContainer,
  nsDataExchangeProxy,
  DynamicDocListUnit,
  bsTypes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsDataExchangeRealization = class(Tl3ProtoDataContainer, InsDataExchangeSubscriber)
 protected
 // realized methods
   procedure MakeAndOpenList(const aList: IDynList;
      aOpenFrom: TbsListOpenFrom = lofNone);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TnsDataExchangeRealization;
    {- возвращает экземпляр синглетона. }
 end;//TnsDataExchangeRealization
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  deListSet,
  deSearchInfo
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


// start class TnsDataExchangeRealization

var g_TnsDataExchangeRealization : TnsDataExchangeRealization = nil;

procedure TnsDataExchangeRealizationFree;
begin
 l3Free(g_TnsDataExchangeRealization);
end;

class function TnsDataExchangeRealization.Instance: TnsDataExchangeRealization;
begin
 if (g_TnsDataExchangeRealization = nil) then
 begin
  l3System.AddExitProc(TnsDataExchangeRealizationFree);
  g_TnsDataExchangeRealization := Create;
 end;
 Result := g_TnsDataExchangeRealization;
end;


class function TnsDataExchangeRealization.Exists: Boolean;
 {-}
begin
 Result := g_TnsDataExchangeRealization <> nil;
end;//TnsDataExchangeRealization.Exists

procedure TnsDataExchangeRealization.MakeAndOpenList(const aList: IDynList;
  aOpenFrom: TbsListOpenFrom = lofNone);
//#UC START# *54FECB920224_54FECC970155_var*
//#UC END# *54FECB920224_54FECC970155_var*
begin
//#UC START# *54FECB920224_54FECC970155_impl*
 TdmStdRes.OpenList(TdeListSet.Make(aList, wdOpenIfUserDefine, aOpenFrom, True, nil,
   TdeSearchInfo.Make(aList, aOpenFrom = lofAttributeSearch)), nil);
//#UC END# *54FECB920224_54FECC970155_impl*
end;//TnsDataExchangeRealization.MakeAndOpenList

procedure TnsDataExchangeRealization.Cleanup;
//#UC START# *479731C50290_54FECC970155_var*
//#UC END# *479731C50290_54FECC970155_var*
begin
//#UC START# *479731C50290_54FECC970155_impl*
 inherited;
//#UC END# *479731C50290_54FECC970155_impl*
end;//TnsDataExchangeRealization.Cleanup

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
//#UC START# *54FECE510392*
 TnsDataExchangeProxy.Instance.Subscriber := TnsDataExchangeRealization.Instance;
//#UC END# *54FECE510392*
{$IfEnd} //not Admin AND not Monitorings

end.