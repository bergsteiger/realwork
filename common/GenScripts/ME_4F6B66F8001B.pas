unit F1Like_FormDefinitions_Controls;

// Модуль: "w:\common\components\gui\Garant\VCM\View\F1Like_FormDefinitions_Controls.pas"
// Стереотип: "VCMControls"

{$Include f1LikeAppDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwString
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 fm_ChildForm: TvcmFormDescriptor = (rFormID : (rName : 'ChildForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TChildForm }

const
 fm_ParentForm: TvcmFormDescriptor = (rFormID : (rName : 'ParentForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TParentForm }

type
 ChildFormDef = interface
  ['{CFF21CFB-D277-44C2-940B-C1A99F33511F}']
 end;//ChildFormDef

 ParentFormDef = interface
  ['{DEC20464-3FB2-4ABC-921C-08A93E75DAD5}']
 end;//ParentFormDef

implementation

uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_Form_Child_ID = {final} class(TtfwString)
  {* Слово словаря для идентификатора формы Child
----
*Пример использования*:
[code]
'aControl' форма::Child TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Child_ID
 {$IfEnd} // NOT Defined(NoScripts)

 {$If NOT Defined(NoScripts)}
 Tkw_Form_Parent_ID = {final} class(TtfwString)
  {* Слово словаря для идентификатора формы Parent
----
*Пример использования*:
[code]
'aControl' форма::Parent TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Parent_ID
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_Child_ID.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::Child';
end;//Tkw_Form_Child_ID.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_Form_Child_ID.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_BBEB9821B6DA_var*
//#UC END# *4DDFD2EA0116_BBEB9821B6DA_var*
begin
//#UC START# *4DDFD2EA0116_BBEB9821B6DA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_BBEB9821B6DA_impl*
end;//Tkw_Form_Child_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_Parent_ID.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::Parent';
end;//Tkw_Form_Parent_ID.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_Form_Parent_ID.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_4D2D1B64FF3F_var*
//#UC END# *4DDFD2EA0116_4D2D1B64FF3F_var*
begin
//#UC START# *4DDFD2EA0116_4D2D1B64FF3F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_4D2D1B64FF3F_impl*
end;//Tkw_Form_Parent_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_Form_Child_ID.RegisterInEngine;
 {* Регистрация Tkw_Form_Child_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_Parent_ID.RegisterInEngine;
 {* Регистрация Tkw_Form_Parent_ID }
{$IfEnd} // NOT Defined(NoScripts)

end.
