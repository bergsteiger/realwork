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
 , k2Base
;

type
 TcaDataProviderParams = class(ThtDataProviderParams)
  public
   class function GetTaggedDataType: Tk2Type; override;
 end;//TcaDataProviderParams
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

implementation

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3ImplUses
;

class function TcaDataProviderParams.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_56A86B450218_var*
//#UC END# *53AC03EE01FD_56A86B450218_var*
begin
//#UC START# *53AC03EE01FD_56A86B450218_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_56A86B450218_impl*
end;//TcaDataProviderParams.GetTaggedDataType
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

end.
