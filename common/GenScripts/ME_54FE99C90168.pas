unit ncsDataAccessServices;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsDataAccessServices.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsDataAccessServices" MUID: (54FE99C90168)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
;

type
 TncsDataAccessServices = {final} class(Tl3ProtoObject)
  private
   f_InitCounter: Integer;
  public
   procedure InitClient;
    {* Настраивает и регестрирует фабрики для TdaDataProviderSuperFactory
Должен быть вызван до обращения к методам TdaDataProviderSuperFactory }
   procedure InitServer;
   class function Instance: TncsDataAccessServices;
    {* Метод получения экземпляра синглетона TncsDataAccessServices }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TncsDataAccessServices
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , SysUtils
 , htDataProviderFactory
 , daDataProviderSuperFactory
 , ncsClientParamsStorage
 , daScheme
 {$If Defined(UsePostgres)}
 , pgDataProviderFactory
 {$IfEnd} // Defined(UsePostgres)
 {$If Defined(UsePostgres) AND Defined(TestComboAccess)}
 , caDataProviderFactory
 {$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)
 {$If Defined(AppServerSide)}
 , ncsServerParamsStorage
 {$IfEnd} // Defined(AppServerSide)
 , l3Base
;

var g_TncsDataAccessServices: TncsDataAccessServices = nil;
 {* Экземпляр синглетона TncsDataAccessServices }

procedure TncsDataAccessServicesFree;
 {* Метод освобождения экземпляра синглетона TncsDataAccessServices }
begin
 l3Free(g_TncsDataAccessServices);
end;//TncsDataAccessServicesFree

procedure TncsDataAccessServices.InitClient;
 {* Настраивает и регестрирует фабрики для TdaDataProviderSuperFactory
Должен быть вызван до обращения к методам TdaDataProviderSuperFactory }
//#UC START# *54FE9A000180_54FE99C90168_var*
var
 l_HyTechProviderFactory : ThtDataProviderFactory;
{$IFDEF UsePostgres}
 l_PostgressProviderFactory : TpgDataProviderFactory;
{$IFDEF TestComboAccess}
 l_ComboAccessProviderFactory : TcaDataProviderFactory;
{$ENDIF TestComboAccess}
{$ENDIF UsePostgres}
//#UC END# *54FE9A000180_54FE99C90168_var*
begin
//#UC START# *54FE9A000180_54FE99C90168_impl*
 Inc(f_InitCounter);
 if f_InitCounter = 1 then
 begin
  TdaScheme.Instance.BuildScheme;
  TdaDataProviderSuperFactory.Instance.ParamsStorage := TncsClientParamsStorage.Make;
  l_HyTechProviderFactory := ThtDataProviderFactory.Create;
  try
   TdaDataProviderSuperFactory.Instance.Register(l_HyTechProviderFactory);
   TdaDataProviderSuperFactory.Instance.DefaultFactory := l_HyTechProviderFactory;
{$IFDEF UsePostgres}
   l_PostgressProviderFactory := TpgDataProviderFactory.Create;
   try
    TdaDataProviderSuperFactory.Instance.Register(l_PostgressProviderFactory);
{$IFDEF TestComboAccess}
    l_ComboAccessProviderFactory := TcaDataProviderFactory.Create(l_HyTechProviderFactory, l_PostgressProviderFactory);
    try
     TdaDataProviderSuperFactory.Instance.Register(l_ComboAccessProviderFactory);
    finally
     FreeAndNil(l_ComboAccessProviderFactory);
    end;
{$ENDIF TestComboAccess}
   finally
    FreeAndNil(l_PostgressProviderFactory);
   end;
{$ENDIF UsePostgres}
  finally
   FreeAndNil(l_HyTechProviderFactory);
  end;
 end;
//#UC END# *54FE9A000180_54FE99C90168_impl*
end;//TncsDataAccessServices.InitClient

procedure TncsDataAccessServices.InitServer;
//#UC START# *5502A9100004_54FE99C90168_var*
var
 l_HyTechProviderFactory : ThtDataProviderFactory;
{$IFDEF UsePostgres}
 l_PostgressProviderFactory : TpgDataProviderFactory;
{$IFDEF TestComboAccess}
 l_ComboAccessProviderFactory : TcaDataProviderFactory;
{$ENDIF TestComboAccess}
{$ENDIF UsePostgres}
//#UC END# *5502A9100004_54FE99C90168_var*
begin
//#UC START# *5502A9100004_54FE99C90168_impl*
 {$If defined(AppServerSide) AND not defined(Nemesis)}
 Inc(f_InitCounter);
 if f_InitCounter = 1 then
 begin
  TdaScheme.Instance.BuildScheme;
  TdaDataProviderSuperFactory.Instance.ParamsStorage := TncsServerParamsStorage.Make;
  l_HyTechProviderFactory := ThtDataProviderFactory.Create;
  try
   TdaDataProviderSuperFactory.Instance.Register(l_HyTechProviderFactory);
   TdaDataProviderSuperFactory.Instance.DefaultFactory := l_HyTechProviderFactory;
  finally
   FreeAndNil(l_HyTechProviderFactory);
  end;
{$IFDEF UsePostgres}
  l_PostgressProviderFactory := TpgDataProviderFactory.Create;
  try
   TdaDataProviderSuperFactory.Instance.Register(l_PostgressProviderFactory);
{$IFDEF TestComboAccess}
   l_ComboAccessProviderFactory := TcaDataProviderFactory.Create(l_HyTechProviderFactory, l_PostgressProviderFactory);
   try
    TdaDataProviderSuperFactory.Instance.Register(l_ComboAccessProviderFactory);
   finally
    FreeAndNil(l_ComboAccessProviderFactory);
   end;
{$ENDIF TestComboAccess}
  finally
   FreeAndNil(l_PostgressProviderFactory);
  end;
{$ENDIF UsePostgres}
 end;
 {$IfEnd defined(AppServerSide) AND not defined(Nemesis)}
//#UC END# *5502A9100004_54FE99C90168_impl*
end;//TncsDataAccessServices.InitServer

class function TncsDataAccessServices.Instance: TncsDataAccessServices;
 {* Метод получения экземпляра синглетона TncsDataAccessServices }
begin
 if (g_TncsDataAccessServices = nil) then
 begin
  l3System.AddExitProc(TncsDataAccessServicesFree);
  g_TncsDataAccessServices := Create;
 end;
 Result := g_TncsDataAccessServices;
end;//TncsDataAccessServices.Instance

class function TncsDataAccessServices.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TncsDataAccessServices <> nil;
end;//TncsDataAccessServices.Exists
{$IfEnd} // NOT Defined(Nemesis)

end.
