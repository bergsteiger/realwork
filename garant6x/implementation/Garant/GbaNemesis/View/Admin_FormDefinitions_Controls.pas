unit Admin_FormDefinitions_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin_FormDefinitions_Controls.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Администратор::Admin::View::FormDefinitions
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  tfwString
  {$IfEnd} //not NoScripts
  ,
  vcmExternalInterfaces {a}
  ;

const
   { AdminFormIDs }
  fm_cfAdminForm : TvcmFormDescriptor = (rFormID : (rName : 'cfAdminForm'; rID : 0); rFactory : nil);
   { Идентификатор формы TcfAdminForm }

type
 AdminFormFormDef = interface(IUnknown)
   ['{7E787B8C-F566-443C-9C95-6711D628B038}']
 end;//AdminFormFormDef

const
   { GroupListIDs }
  fm_efGroupList : TvcmFormDescriptor = (rFormID : (rName : 'efGroupList'; rID : 0); rFactory : nil);
   { Идентификатор формы TefGroupList }

type
 GroupListFormDef = interface(IUnknown)
   ['{427E23A9-B9FD-4256-8312-ED9653D862C6}']
 end;//GroupListFormDef

const
   { UserListIDs }
  fm_efUserList : TvcmFormDescriptor = (rFormID : (rName : 'efUserList'; rID : 0); rFactory : nil);
   { Идентификатор формы TefUserList }

type
 UserListFormDef = interface(IUnknown)
   ['{CCC79038-4B92-428C-ADD7-D68C5BCE408C}']
 end;//UserListFormDef

const
   { UserPropertyIDs }
  fm_efUserProperty : TvcmFormDescriptor = (rFormID : (rName : 'efUserProperty'; rID : 0); rFactory : nil);
   { Идентификатор формы TefUserProperty }

type
 UserPropertyFormDef = interface(IUnknown)
   ['{5FCF4F0A-B828-487D-9E35-8D8643E02C6C}']
 end;//UserPropertyFormDef
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
{$If defined(Admin) AND not defined(NoScripts)}

type
 Tkw_Form_AdminForm_ID = {final scriptword} class(TtfwString)
  {* Слово словаря для идентификатора формы AdminForm
----
*Пример использования*:
[code]
'aControl' форма::AdminForm TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_AdminForm_ID
{$IfEnd} //Admin AND not NoScripts

{$If defined(Admin) AND not defined(NoScripts)}

// start class Tkw_Form_AdminForm_ID

class function Tkw_Form_AdminForm_ID.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::AdminForm';
end;//Tkw_Form_AdminForm_ID.GetWordNameForRegister

function Tkw_Form_AdminForm_ID.GetString: AnsiString;
 {-}
begin
 Result := 'cfAdminForm';
end;//Tkw_Form_AdminForm_ID.GetString

{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}

type
 Tkw_Form_GroupList_ID = {final scriptword} class(TtfwString)
  {* Слово словаря для идентификатора формы GroupList
----
*Пример использования*:
[code]
'aControl' форма::GroupList TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_GroupList_ID
{$IfEnd} //Admin AND not NoScripts

{$If defined(Admin) AND not defined(NoScripts)}

// start class Tkw_Form_GroupList_ID

class function Tkw_Form_GroupList_ID.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::GroupList';
end;//Tkw_Form_GroupList_ID.GetWordNameForRegister

function Tkw_Form_GroupList_ID.GetString: AnsiString;
 {-}
begin
 Result := 'efGroupList';
end;//Tkw_Form_GroupList_ID.GetString

{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}

type
 Tkw_Form_UserList_ID = {final scriptword} class(TtfwString)
  {* Слово словаря для идентификатора формы UserList
----
*Пример использования*:
[code]
'aControl' форма::UserList TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_UserList_ID
{$IfEnd} //Admin AND not NoScripts

{$If defined(Admin) AND not defined(NoScripts)}

// start class Tkw_Form_UserList_ID

class function Tkw_Form_UserList_ID.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::UserList';
end;//Tkw_Form_UserList_ID.GetWordNameForRegister

function Tkw_Form_UserList_ID.GetString: AnsiString;
 {-}
begin
 Result := 'efUserList';
end;//Tkw_Form_UserList_ID.GetString

{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}

type
 Tkw_Form_UserProperty_ID = {final scriptword} class(TtfwString)
  {* Слово словаря для идентификатора формы UserProperty
----
*Пример использования*:
[code]
'aControl' форма::UserProperty TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_UserProperty_ID
{$IfEnd} //Admin AND not NoScripts

{$If defined(Admin) AND not defined(NoScripts)}

// start class Tkw_Form_UserProperty_ID

class function Tkw_Form_UserProperty_ID.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::UserProperty';
end;//Tkw_Form_UserProperty_ID.GetWordNameForRegister

function Tkw_Form_UserProperty_ID.GetString: AnsiString;
 {-}
begin
 Result := 'efUserProperty';
end;//Tkw_Form_UserProperty_ID.GetString

{$IfEnd} //Admin AND not NoScripts
{$IfEnd} //Admin


initialization
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_Form_AdminForm_ID
 Tkw_Form_AdminForm_ID.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_Form_GroupList_ID
 Tkw_Form_GroupList_ID.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_Form_UserList_ID
 Tkw_Form_UserList_ID.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_Form_UserProperty_ID
 Tkw_Form_UserProperty_ID.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts

end.