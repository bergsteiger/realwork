unit ncsDataAccessServices;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsDataAccessServices.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::ArchiClientServer::TncsDataAccessServices
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3ProtoObject
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TncsDataAccessServices = {final} class(Tl3ProtoObject)
 private
 // private fields
   f_InitCounter : Integer;
 public
 // public methods
   procedure InitClient;
     {* Настраивает и регестрирует фабрики для TdaDataProviderSuperFactory
Должен быть вызван до обращения к методам TdaDataProviderSuperFactory }
   procedure InitServer;
     {* Сигнатура метода InitServer }
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TncsDataAccessServices;
    {- возвращает экземпляр синглетона. }
 end;//TncsDataAccessServices
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  l3Base {a},
  htDataProviderFactory,
  daDataProviderSuperFactory,
  ncsClientParamsStorage,
  daScheme
  {$If defined(UsePostgres)}
  ,
  pgDataProviderFactory
  {$IfEnd} //UsePostgres
  
  {$If defined(TestComboAccess) AND defined(UsePostgres)}
  ,
  caDataProviderFactory
  {$IfEnd} //TestComboAccess AND UsePostgres
  
  {$If defined(AppServerSide) AND not defined(Nemesis)}
  ,
  ncsServerParamsStorage
  {$IfEnd} //AppServerSide AND not Nemesis
  ,
  SysUtils
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}


// start class TncsDataAccessServices

var g_TncsDataAccessServices : TncsDataAccessServices = nil;

procedure TncsDataAccessServicesFree;
begin
 l3Free(g_TncsDataAccessServices);
end;

class function TncsDataAccessServices.Instance: TncsDataAccessServices;
begin
 if (g_TncsDataAccessServices = nil) then
 begin
  l3System.AddExitProc(TncsDataAccessServicesFree);
  g_TncsDataAccessServices := Create;
 end;
 Result := g_TncsDataAccessServices;
end;


procedure TncsDataAccessServices.InitClient;
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

class function TncsDataAccessServices.Exists: Boolean;
 {-}
begin
 Result := g_TncsDataAccessServices <> nil;
end;//TncsDataAccessServices.Exists

{$IfEnd} //not Nemesis

end.