unit ContentChecker;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ContentChecker.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ContentChecker" MUID: (461CD65E0280)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
;

function CheckContent(const content): ByteBool; stdcall;
 {* Проверка контента на существование }
function CheckServerContent(const content): ByteBool; stdcall;
 {* Проверка существует ли контент (лезем на сервер) }

implementation

uses
 l3ImplUses
 , ApplicationHelper
;

function CheckContent(const content): ByteBool;
 {* Проверка контента на существование }
//#UC START# *45F8045C03D2_461CD65E0280_var*
//#UC END# *45F8045C03D2_461CD65E0280_var*
begin
//#UC START# *45F8045C03D2_461CD65E0280_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F8045C03D2_461CD65E0280_impl*
end;//CheckContent

function CheckServerContent(const content): ByteBool;
 {* Проверка существует ли контент (лезем на сервер) }
//#UC START# *45F804B50161_461CD65E0280_var*
//#UC END# *45F804B50161_461CD65E0280_var*
begin
//#UC START# *45F804B50161_461CD65E0280_impl*
 !!! Needs to be implemented !!!
//#UC END# *45F804B50161_461CD65E0280_impl*
end;//CheckServerContent

end.
