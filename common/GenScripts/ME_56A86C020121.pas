unit caDataProviderFactory;

// Модуль: "w:\common\components\rtl\Garant\ComboAccess\caDataProviderFactory.pas"
// Стереотип: "SimpleClass"

{$Include caDefine.inc}

interface

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3IntfUses
 , daDataProviderFactory
 , htDataProviderFactory
 , pgDataProviderFactory
 , daDataProviderParams
 , ddAppConfig
 , daInterfaces
;

type
 TcaDataProviderFactory = class(TdaDataProviderFactory)
  private
   f_HTFactory: ThtDataProviderFactory;
   f_PGFactory: TpgDataProviderFactory;
  protected
   function DoMakeProvider(aParams: TdaDataProviderParams;
    ForCheckLogin: Boolean;
    AllowClearLocks: Boolean): IdaDataProvider; override;
   procedure LoginCheckSucceed(aParams: TdaDataProviderParams); override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aHTFactory: ThtDataProviderFactory;
    aPGFactory: TpgDataProviderFactory); reintroduce;
   class function Key: AnsiString; override;
   function MakeFromConfig: TdaDataProviderParams; override;
   procedure SaveToConfig(aParams: TdaDataProviderParams); override;
   function ParamType: TdaDataProviderParamsClass; override;
   procedure FillOutConfig(aConfig: TddAppConfiguration;
    aEtalon: TdaDataProviderParams;
    out aParams: TdaDataProviderParams); override;
   procedure FillInConfig(aConfig: TddAppConfiguration;
    aParams: TdaDataProviderParams;
    ForInfoOnly: Boolean = False); override;
   procedure BuildConfig(aConfig: TddAppConfiguration;
    const aProviderKey: AnsiString = '';
    ForInfoOnly: Boolean = False); override;
   procedure LoadDBVersion(aParams: TdaDataProviderParams); override;
 end;//TcaDataProviderFactory
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

implementation

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3ImplUses
 , caDataProviderParams
 , caDataProvider
 , SysUtils
;

constructor TcaDataProviderFactory.Create(aHTFactory: ThtDataProviderFactory;
 aPGFactory: TpgDataProviderFactory);
//#UC START# *56AB24FB0037_56A86C020121_var*
//#UC END# *56AB24FB0037_56A86C020121_var*
begin
//#UC START# *56AB24FB0037_56A86C020121_impl*
 inherited Create;
 aHTFactory.SetRefTo(f_HTFactory);
 aPGFactory.SetRefTo(f_PGFactory);
//#UC END# *56AB24FB0037_56A86C020121_impl*
end;//TcaDataProviderFactory.Create

class function TcaDataProviderFactory.Key: AnsiString;
//#UC START# *54F8635B023E_56A86C020121_var*
//#UC END# *54F8635B023E_56A86C020121_var*
begin
//#UC START# *54F8635B023E_56A86C020121_impl*
 Result := 'ComboAccess';
//#UC END# *54F8635B023E_56A86C020121_impl*
end;//TcaDataProviderFactory.Key

function TcaDataProviderFactory.MakeFromConfig: TdaDataProviderParams;
//#UC START# *54FEB57302B0_56A86C020121_var*
//#UC END# *54FEB57302B0_56A86C020121_var*
begin
//#UC START# *54FEB57302B0_56A86C020121_impl*
// Result := TcaDataProviderParams.Create;
// LoadCommonParams(Result);

 Result := nil;
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *54FEB57302B0_56A86C020121_impl*
end;//TcaDataProviderFactory.MakeFromConfig

procedure TcaDataProviderFactory.SaveToConfig(aParams: TdaDataProviderParams);
//#UC START# *550AAD0101F9_56A86C020121_var*
//#UC END# *550AAD0101F9_56A86C020121_var*
begin
//#UC START# *550AAD0101F9_56A86C020121_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *550AAD0101F9_56A86C020121_impl*
end;//TcaDataProviderFactory.SaveToConfig

function TcaDataProviderFactory.ParamType: TdaDataProviderParamsClass;
//#UC START# *550FD49301BF_56A86C020121_var*
//#UC END# *550FD49301BF_56A86C020121_var*
begin
//#UC START# *550FD49301BF_56A86C020121_impl*
 Result := TcaDataProviderParams;
//#UC END# *550FD49301BF_56A86C020121_impl*
end;//TcaDataProviderFactory.ParamType

procedure TcaDataProviderFactory.FillOutConfig(aConfig: TddAppConfiguration;
 aEtalon: TdaDataProviderParams;
 out aParams: TdaDataProviderParams);
//#UC START# *5512BAB20128_56A86C020121_var*
//#UC END# *5512BAB20128_56A86C020121_var*
begin
//#UC START# *5512BAB20128_56A86C020121_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *5512BAB20128_56A86C020121_impl*
end;//TcaDataProviderFactory.FillOutConfig

procedure TcaDataProviderFactory.FillInConfig(aConfig: TddAppConfiguration;
 aParams: TdaDataProviderParams;
 ForInfoOnly: Boolean = False);
//#UC START# *5512BB030346_56A86C020121_var*
//#UC END# *5512BB030346_56A86C020121_var*
begin
//#UC START# *5512BB030346_56A86C020121_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *5512BB030346_56A86C020121_impl*
end;//TcaDataProviderFactory.FillInConfig

procedure TcaDataProviderFactory.BuildConfig(aConfig: TddAppConfiguration;
 const aProviderKey: AnsiString = '';
 ForInfoOnly: Boolean = False);
//#UC START# *5512BB1F023F_56A86C020121_var*
//#UC END# *5512BB1F023F_56A86C020121_var*
begin
//#UC START# *5512BB1F023F_56A86C020121_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *5512BB1F023F_56A86C020121_impl*
end;//TcaDataProviderFactory.BuildConfig

procedure TcaDataProviderFactory.LoadDBVersion(aParams: TdaDataProviderParams);
//#UC START# *551904FC039A_56A86C020121_var*
//#UC END# *551904FC039A_56A86C020121_var*
begin
//#UC START# *551904FC039A_56A86C020121_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *551904FC039A_56A86C020121_impl*
end;//TcaDataProviderFactory.LoadDBVersion

function TcaDataProviderFactory.DoMakeProvider(aParams: TdaDataProviderParams;
 ForCheckLogin: Boolean;
 AllowClearLocks: Boolean): IdaDataProvider;
//#UC START# *551D06D402AF_56A86C020121_var*
//#UC END# *551D06D402AF_56A86C020121_var*
begin
//#UC START# *551D06D402AF_56A86C020121_impl*
 Result := nil;
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *551D06D402AF_56A86C020121_impl*
end;//TcaDataProviderFactory.DoMakeProvider

procedure TcaDataProviderFactory.LoginCheckSucceed(aParams: TdaDataProviderParams);
//#UC START# *55D706D201C3_56A86C020121_var*
//#UC END# *55D706D201C3_56A86C020121_var*
begin
//#UC START# *55D706D201C3_56A86C020121_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *55D706D201C3_56A86C020121_impl*
end;//TcaDataProviderFactory.LoginCheckSucceed

procedure TcaDataProviderFactory.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_56A86C020121_var*
//#UC END# *479731C50290_56A86C020121_var*
begin
//#UC START# *479731C50290_56A86C020121_impl*
 FreeAndNil(f_HTFactory);
 FreeAndNil(f_PGFactory);
 inherited;
//#UC END# *479731C50290_56A86C020121_impl*
end;//TcaDataProviderFactory.Cleanup
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

end.
