unit NOT_FINISHED_k2CustomFileGenerator;
 {* Базовый писатель тегов в файл. }

// Модуль: "w:\common\components\rtl\Garant\K2\NOT_FINISHED_k2CustomFileGenerator.pas"
// Стереотип: "SimpleClass"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , k2CustomStackGeneratorEx
;

type
 Tk2CustomFileGenerator = class(Tk2CustomStackGeneratorEx)
  {* Базовый писатель тегов в файл. }
  protected
   procedure OutEOL; virtual;
    {* Выводит конец строки. }
 end;//Tk2CustomFileGenerator

implementation

uses
 l3ImplUses
;

procedure Tk2CustomFileGenerator.OutEOL;
 {* Выводит конец строки. }
//#UC START# *483A6DE30208_4836BFC9011E_var*
//#UC END# *483A6DE30208_4836BFC9011E_var*
begin
//#UC START# *483A6DE30208_4836BFC9011E_impl*
 !!! Needs to be implemented !!!
//#UC END# *483A6DE30208_4836BFC9011E_impl*
end;//Tk2CustomFileGenerator.OutEOL

end.
