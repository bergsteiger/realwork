unit ncsDataAccessServices;

// ������: "w:\common\components\rtl\Garant\cs\ncsDataAccessServices.pas"
// ���������: "SimpleClass"

{$Include CsDefine.inc}

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
    {* ����������� � ������������ ������� ��� TdaDataProviderSuperFactory
������ ���� ������ �� ��������� � ������� TdaDataProviderSuperFactory }
   procedure InitServer;
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TncsDataAccessServices;
    {* ����� ��������� ���������� ���������� TncsDataAccessServices }
 end;//TncsDataAccessServices
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
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
;

var g_TncsDataAccessServices: TncsDataAccessServices = nil;
 {* ��������� ���������� TncsDataAccessServices }

procedure TncsDataAccessServicesFree;
 {* ����� ������������ ���������� ���������� TncsDataAccessServices }
begin
 l3Free(g_TncsDataAccessServices);
end;//TncsDataAccessServicesFree

procedure TncsDataAccessServices.InitClient;
 {* ����������� � ������������ ������� ��� TdaDataProviderSuperFactory
������ ���� ������ �� ��������� � ������� TdaDataProviderSuperFactory }
//#UC START# *54FE9A000180_54FE99C90168_var*
var
 l_HyTechProviderFactory : ThtDataProviderFactory;
{$IFDEF UsePostgres}
 l_PostgressProviderFactory : TpgDataProviderFactory;
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
  finally
   FreeAndNil(l_HyTechProviderFactory);
  end;
{$IFDEF UsePostgres}
  l_PostgressProviderFactory := TpgDataProviderFactory.Create;
  try
   TdaDataProviderSuperFactory.Instance.Register(l_PostgressProviderFactory);
  finally
   FreeAndNil(l_PostgressProviderFactory);
  end;
{$ENDIF UsePostgres}
 end;
//#UC END# *54FE9A000180_54FE99C90168_impl*
end;//TncsDataAccessServices.InitClient

procedure TncsDataAccessServices.InitServer;
//#UC START# *5502A9100004_54FE99C90168_var*
var
 l_HyTechProviderFactory : ThtDataProviderFactory;
{$IFDEF UsePostgres}
 l_PostgressProviderFactory : TpgDataProviderFactory;
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
  finally
   FreeAndNil(l_PostgressProviderFactory);
  end;
{$ENDIF UsePostgres}
 end;
 {$IfEnd defined(AppServerSide) AND not defined(Nemesis)}
//#UC END# *5502A9100004_54FE99C90168_impl*
end;//TncsDataAccessServices.InitServer

class function TncsDataAccessServices.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TncsDataAccessServices <> nil;
end;//TncsDataAccessServices.Exists

class function TncsDataAccessServices.Instance: TncsDataAccessServices;
 {* ����� ��������� ���������� ���������� TncsDataAccessServices }
begin
 if (g_TncsDataAccessServices = nil) then
 begin
  l3System.AddExitProc(TncsDataAccessServicesFree);
  g_TncsDataAccessServices := Create;
 end;
 Result := g_TncsDataAccessServices;
end;//TncsDataAccessServices.Instance
{$IfEnd} // NOT Defined(Nemesis)

end.
