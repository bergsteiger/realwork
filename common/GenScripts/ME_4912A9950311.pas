unit NOT_FINISHED_l3InterfacedStringList;
 {* Класс реализующий список строк со связанными интерфейсами }

// Модуль: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3InterfacedStringList.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3StringList
 , l3_String
;

type
 Tl3InterfacedString = class(Tl3_String)
  {* Класс реализующий строки с возможностью хранения интерфейса }
  private
   f_Intf: IUnknown;
    {* Поле для свойства Intf }
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   property Intf: IUnknown
    read f_Intf
    write f_Intf;
 end;//Tl3InterfacedString

 Tl3InterfacedStringList = class(Tl3StringList)
  {* Класс реализующий список строк со связанными интерфейсами }
 end;//Tl3InterfacedStringList

implementation

uses
 l3ImplUses
;

procedure Tl3InterfacedString.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4912AA1802AD_var*
//#UC END# *479731C50290_4912AA1802AD_var*
begin
//#UC START# *479731C50290_4912AA1802AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_4912AA1802AD_impl*
end;//Tl3InterfacedString.Cleanup

procedure Tl3InterfacedString.ClearFields;
begin
 Intf := nil;
 inherited;
end;//Tl3InterfacedString.ClearFields

end.
