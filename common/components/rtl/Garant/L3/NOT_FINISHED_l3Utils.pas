unit NOT_FINISHED_l3Utils;
 {* Сервисные функции библиотеки L3. }

// Модуль: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3Utils.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "l3Utils" MUID: (480F78BC0146)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
;

procedure l3BoolReset;
procedure l3GetClipboardByFormatName;
function l3Decrypt(const aText: AnsiString): AnsiString;
function l3Encrypt(const aText: AnsiString): AnsiString;
function l3CreateStringGUID: AnsiString;
function l3FindNextLine: Integer;
 {* находит следующую строку в строковом буфере. }

implementation

uses
 l3ImplUses
 //#UC START# *480F78BC0146impl_uses*
 //#UC END# *480F78BC0146impl_uses*
;

const
 C1 = 439;
 C2 = 163;
 cKey = 17732;

procedure l3BoolReset;
//#UC START# *4C7CE66E0115_480F78BC0146_var*
//#UC END# *4C7CE66E0115_480F78BC0146_var*
begin
//#UC START# *4C7CE66E0115_480F78BC0146_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7CE66E0115_480F78BC0146_impl*
end;//l3BoolReset

procedure l3GetClipboardByFormatName;
//#UC START# *500D2F6F03D4_480F78BC0146_var*
//#UC END# *500D2F6F03D4_480F78BC0146_var*
begin
//#UC START# *500D2F6F03D4_480F78BC0146_impl*
 !!! Needs to be implemented !!!
//#UC END# *500D2F6F03D4_480F78BC0146_impl*
end;//l3GetClipboardByFormatName

function l3Decrypt(const aText: AnsiString): AnsiString;
//#UC START# *5437B2E60352_480F78BC0146_var*
//#UC END# *5437B2E60352_480F78BC0146_var*
begin
//#UC START# *5437B2E60352_480F78BC0146_impl*
 !!! Needs to be implemented !!!
//#UC END# *5437B2E60352_480F78BC0146_impl*
end;//l3Decrypt

function l3Encrypt(const aText: AnsiString): AnsiString;
//#UC START# *5437B29C03BD_480F78BC0146_var*
//#UC END# *5437B29C03BD_480F78BC0146_var*
begin
//#UC START# *5437B29C03BD_480F78BC0146_impl*
 !!! Needs to be implemented !!!
//#UC END# *5437B29C03BD_480F78BC0146_impl*
end;//l3Encrypt

function l3CreateStringGUID: AnsiString;
//#UC START# *54509FEC02EB_480F78BC0146_var*
//#UC END# *54509FEC02EB_480F78BC0146_var*
begin
//#UC START# *54509FEC02EB_480F78BC0146_impl*
 !!! Needs to be implemented !!!
//#UC END# *54509FEC02EB_480F78BC0146_impl*
end;//l3CreateStringGUID

function l3FindNextLine: Integer;
 {* находит следующую строку в строковом буфере. }
//#UC START# *480F78DF0287_480F78BC0146_var*
//#UC END# *480F78DF0287_480F78BC0146_var*
begin
//#UC START# *480F78DF0287_480F78BC0146_impl*
 !!! Needs to be implemented !!!
//#UC END# *480F78DF0287_480F78BC0146_impl*
end;//l3FindNextLine

end.
