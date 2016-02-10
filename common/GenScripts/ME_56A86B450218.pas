unit caDataProviderParams;

// Модуль: "w:\common\components\rtl\Garant\ComboAccess\caDataProviderParams.pas"
// Стереотип: "SimpleClass"

{$Include caDefine.inc}

interface

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3IntfUses
 , htDataProviderParams
 , ComboAccessProviderParams_Const
 , pgDataProviderParams
 , k2Base
 , daDataProviderParams
;

type
 TcaDataProviderParams = class(ThtDataProviderParams)
  private
   f_HTParams: ThtDataProviderParams;
    {* Поле для свойства HTParams }
   f_PGParams: TpgDataProviderParams;
    {* Поле для свойства PGParams }
  protected
   function pm_GetDataServerHostName: AnsiString;
   procedure pm_SetDataServerHostName(const aValue: AnsiString);
   function pm_GetDataServerPort: Integer;
   procedure pm_SetDataServerPort(aValue: Integer);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aHTParams: ThtDataProviderParams;
    aPGParams: TpgDataProviderParams); reintroduce;
   procedure LoadFromAlienParams;
   procedure SaveToAlienParams;
   class function GetTaggedDataType: Tk2Type; override;
   procedure ChangeBasePath(const aPath: AnsiString); override;
   procedure AssignParams(aParams: TdaDataProviderParams); override;
  public
   property HTParams: ThtDataProviderParams
    read f_HTParams;
   property PGParams: TpgDataProviderParams
    read f_PGParams;
   property DataServerHostName: AnsiString
    read pm_GetDataServerHostName
    write pm_SetDataServerHostName;
   property DataServerPort: Integer
    read pm_GetDataServerPort
    write pm_SetDataServerPort;
 end;//TcaDataProviderParams
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

implementation

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3ImplUses
 , SysUtils
;

function TcaDataProviderParams.pm_GetDataServerHostName: AnsiString;
//#UC START# *52A37A4E5D05_56A86B450218get_var*
//#UC END# *52A37A4E5D05_56A86B450218get_var*
begin
//#UC START# *52A37A4E5D05_56A86B450218get_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A37A4E5D05_56A86B450218get_impl*
end;//TcaDataProviderParams.pm_GetDataServerHostName

procedure TcaDataProviderParams.pm_SetDataServerHostName(const aValue: AnsiString);
//#UC START# *52A37A4E5D05_56A86B450218set_var*
//#UC END# *52A37A4E5D05_56A86B450218set_var*
begin
//#UC START# *52A37A4E5D05_56A86B450218set_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A37A4E5D05_56A86B450218set_impl*
end;//TcaDataProviderParams.pm_SetDataServerHostName

function TcaDataProviderParams.pm_GetDataServerPort: Integer;
//#UC START# *0DC358F22E97_56A86B450218get_var*
//#UC END# *0DC358F22E97_56A86B450218get_var*
begin
//#UC START# *0DC358F22E97_56A86B450218get_impl*
 !!! Needs to be implemented !!!
//#UC END# *0DC358F22E97_56A86B450218get_impl*
end;//TcaDataProviderParams.pm_GetDataServerPort

procedure TcaDataProviderParams.pm_SetDataServerPort(aValue: Integer);
//#UC START# *0DC358F22E97_56A86B450218set_var*
//#UC END# *0DC358F22E97_56A86B450218set_var*
begin
//#UC START# *0DC358F22E97_56A86B450218set_impl*
 !!! Needs to be implemented !!!
//#UC END# *0DC358F22E97_56A86B450218set_impl*
end;//TcaDataProviderParams.pm_SetDataServerPort

constructor TcaDataProviderParams.Create(aHTParams: ThtDataProviderParams;
 aPGParams: TpgDataProviderParams);
//#UC START# *56B9C44F02BE_56A86B450218_var*
//#UC END# *56B9C44F02BE_56A86B450218_var*
begin
//#UC START# *56B9C44F02BE_56A86B450218_impl*
 !!! Needs to be implemented !!!
//#UC END# *56B9C44F02BE_56A86B450218_impl*
end;//TcaDataProviderParams.Create

procedure TcaDataProviderParams.LoadFromAlienParams;
//#UC START# *56B9D5D8017F_56A86B450218_var*
//#UC END# *56B9D5D8017F_56A86B450218_var*
begin
//#UC START# *56B9D5D8017F_56A86B450218_impl*
 !!! Needs to be implemented !!!
//#UC END# *56B9D5D8017F_56A86B450218_impl*
end;//TcaDataProviderParams.LoadFromAlienParams

procedure TcaDataProviderParams.SaveToAlienParams;
//#UC START# *56B9E3810358_56A86B450218_var*
//#UC END# *56B9E3810358_56A86B450218_var*
begin
//#UC START# *56B9E3810358_56A86B450218_impl*
 !!! Needs to be implemented !!!
//#UC END# *56B9E3810358_56A86B450218_impl*
end;//TcaDataProviderParams.SaveToAlienParams

procedure TcaDataProviderParams.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_56A86B450218_var*
//#UC END# *479731C50290_56A86B450218_var*
begin
//#UC START# *479731C50290_56A86B450218_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_56A86B450218_impl*
end;//TcaDataProviderParams.Cleanup

class function TcaDataProviderParams.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_56A86B450218_var*
//#UC END# *53AC03EE01FD_56A86B450218_var*
begin
//#UC START# *53AC03EE01FD_56A86B450218_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_56A86B450218_impl*
end;//TcaDataProviderParams.GetTaggedDataType

procedure TcaDataProviderParams.ChangeBasePath(const aPath: AnsiString);
//#UC START# *55195AE803E0_56A86B450218_var*
//#UC END# *55195AE803E0_56A86B450218_var*
begin
//#UC START# *55195AE803E0_56A86B450218_impl*
 !!! Needs to be implemented !!!
//#UC END# *55195AE803E0_56A86B450218_impl*
end;//TcaDataProviderParams.ChangeBasePath

procedure TcaDataProviderParams.AssignParams(aParams: TdaDataProviderParams);
//#UC START# *553A37E902C9_56A86B450218_var*
//#UC END# *553A37E902C9_56A86B450218_var*
begin
//#UC START# *553A37E902C9_56A86B450218_impl*
 !!! Needs to be implemented !!!
//#UC END# *553A37E902C9_56A86B450218_impl*
end;//TcaDataProviderParams.AssignParams
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

end.
