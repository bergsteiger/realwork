unit nsHistoryTree;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Common$Lib"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Common/nsHistoryTree.pas"
// Начат: 2004/12/06 10:34:07
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Common$Lib::MainMenu::TnsHistoryTree
//
// Содержит поля и методы общие для деревьев содержащих последние открытые документы и запросы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsBaseMainMenuTree
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsHistoryTree = class(TnsBaseMainMenuTree)
  {* Содержит поля и методы общие для деревьев содержащих последние открытые документы и запросы }
 private
 // private fields
   f_MaxCount : Integer;
    {* Поле для свойства MaxCount}
 public
 // public methods
   constructor Create(aMaxCount: Integer); reintroduce;
 public
 // public properties
   property MaxCount: Integer
     read f_MaxCount;
     {* Определяет максимальное количество элементов в дереве. Ноль означает неограниченное количество элементов }
 end;//TnsHistoryTree
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsHistoryTree

constructor TnsHistoryTree.Create(aMaxCount: Integer);
//#UC START# *490AE2F50049_490AE2C7034B_var*
//#UC END# *490AE2F50049_490AE2C7034B_var*
begin
//#UC START# *490AE2F50049_490AE2C7034B_impl*
 inherited Create;
 f_MaxCount := aMaxCount;
//#UC END# *490AE2F50049_490AE2C7034B_impl*
end;//TnsHistoryTree.Create

{$IfEnd} //not Admin AND not Monitorings

end.