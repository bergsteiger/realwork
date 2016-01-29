unit ncsServiceProviderParams;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsServiceProviderParams.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::ClientSide::TncsServiceProviderParams
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
 TncsServiceProviderParams = class(Tl3ProtoObject)
 private
 // private fields
   f_ServerHostName : AnsiString;
    {* Поле для свойства ServerHostName}
   f_ServerPort : Integer;
    {* Поле для свойства ServerPort}
   f_Login : AnsiString;
    {* Поле для свойства Login}
   f_Password : AnsiString;
    {* Поле для свойства Password}
   f_IsDeveloper : Boolean;
    {* Поле для свойства IsDeveloper}
   f_StandAlone : Boolean;
    {* Поле для свойства StandAlone}
 public
 // public properties
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
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}


{$IfEnd} //not Nemesis
end.