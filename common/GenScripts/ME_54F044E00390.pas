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
    {* Поле для свойства ServerHostName }
   f_ServerPort: Integer;
    {* Поле для свойства ServerPort }
   f_Login: AnsiString;
    {* Поле для свойства Login }
   f_Password: AnsiString;
    {* Поле для свойства Password }
   f_IsDeveloper: Boolean;
    {* Поле для свойства IsDeveloper }
   f_StandAlone: Boolean;
    {* Поле для свойства StandAlone }
  protected
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
 end;//TncsServiceProviderParams
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;

procedure TncsServiceProviderParams.ClearFields;
begin
 ServerHostName := '';
 Login := '';
 Password := '';
 inherited;
end;//TncsServiceProviderParams.ClearFields
{$IfEnd} // NOT Defined(Nemesis)

end.
