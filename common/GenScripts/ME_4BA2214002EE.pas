unit l3ConstStrings;

// Модуль: "w:\common\components\rtl\Garant\L3\l3ConstStrings.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ConstStrings1
;

type
 Tl3ConstStrings = class(Tl3ConstStrings1)
  public
   class function Exists: Boolean;
   class function Instance: Tl3ConstStrings;
    {* Метод получения экземпляра синглетона Tl3ConstStrings }
 end;//Tl3ConstStrings

var g_l3ConstStringsSealed: Boolean = False;

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_Tl3ConstStrings: Tl3ConstStrings = nil;
 {* Экземпляр синглетона Tl3ConstStrings }

procedure Tl3ConstStringsFree;
 {* Метод освобождения экземпляра синглетона Tl3ConstStrings }
begin
 l3Free(g_Tl3ConstStrings);
end;//Tl3ConstStringsFree

class function Tl3ConstStrings.Exists: Boolean;
//#UC START# *4BA227540063_4BA2214002EE_var*
//#UC END# *4BA227540063_4BA2214002EE_var*
begin
//#UC START# *4BA227540063_4BA2214002EE_impl*
 Result := (g_Tl3ConstStrings <> nil);
//#UC END# *4BA227540063_4BA2214002EE_impl*
end;//Tl3ConstStrings.Exists

class function Tl3ConstStrings.Instance: Tl3ConstStrings;
 {* Метод получения экземпляра синглетона Tl3ConstStrings }
begin
 if (g_Tl3ConstStrings = nil) then
 begin
  l3System.AddExitProc(Tl3ConstStringsFree);
  g_Tl3ConstStrings := Create;
 end;
 Result := g_Tl3ConstStrings;
end;//Tl3ConstStrings.Instance

end.
