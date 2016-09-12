unit ncsServiceProviderParams;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsServiceProviderParams.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsServiceProviderParams" MUID: (54F044E00390)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
;

type
 TncsServiceProviderParams = class(Tl3ProtoObject)
  private
   f_ServerHostName: AnsiString;
   f_ServerPort: Integer;
   f_Login: AnsiString;
   f_Password: AnsiString;
   f_IsDeveloper: Boolean;
   f_StandAlone: Boolean;
   f_CorrectTempPath: Boolean;
  protected
   procedure InitFields; override;
   procedure ClearFields; override;
  public
   property ServerHostName: AnsiString
    read f_ServerHostName
    write f_ServerHostName;
   property ServerPort: Integer
    read f_ServerPort
    write f_ServerPort;
   property Login: AnsiString
    read f_Login
    write f_Login;
   property Password: AnsiString
    read f_Password
    write f_Password;
   property IsDeveloper: Boolean
    read f_IsDeveloper
    write f_IsDeveloper;
   property StandAlone: Boolean
    read f_StandAlone
    write f_StandAlone;
   property CorrectTempPath: Boolean
    read f_CorrectTempPath
    write f_CorrectTempPath;
 end;//TncsServiceProviderParams
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *54F044E00390impl_uses*
 //#UC END# *54F044E00390impl_uses*
;

procedure TncsServiceProviderParams.InitFields;
//#UC START# *47A042E100E2_54F044E00390_var*
//#UC END# *47A042E100E2_54F044E00390_var*
begin
//#UC START# *47A042E100E2_54F044E00390_impl*
 inherited;
 f_CorrectTempPath := True;
//#UC END# *47A042E100E2_54F044E00390_impl*
end;//TncsServiceProviderParams.InitFields

procedure TncsServiceProviderParams.ClearFields;
begin
 ServerHostName := '';
 Login := '';
 Password := '';
 inherited;
end;//TncsServiceProviderParams.ClearFields
{$IfEnd} // NOT Defined(Nemesis)

end.
