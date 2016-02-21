unit l3ConvertersList;

// Модуль: "w:\common\components\rtl\Garant\L3\l3ConvertersList.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3StringList
;

type
 Tl3ConvertersList = class(Tl3StringList)
  protected
   procedure InitFields; override;
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tl3ConvertersList;
    {* Метод получения экземпляра синглетона Tl3ConvertersList }
 end;//Tl3ConvertersList

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_Tl3ConvertersList: Tl3ConvertersList = nil;
 {* Экземпляр синглетона Tl3ConvertersList }

procedure Tl3ConvertersListFree;
 {* Метод освобождения экземпляра синглетона Tl3ConvertersList }
begin
 l3Free(g_Tl3ConvertersList);
end;//Tl3ConvertersListFree

class function Tl3ConvertersList.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3ConvertersList <> nil;
end;//Tl3ConvertersList.Exists

class function Tl3ConvertersList.Instance: Tl3ConvertersList;
 {* Метод получения экземпляра синглетона Tl3ConvertersList }
begin
 if (g_Tl3ConvertersList = nil) then
 begin
  l3System.AddExitProc(Tl3ConvertersListFree);
  g_Tl3ConvertersList := Create;
 end;
 Result := g_Tl3ConvertersList;
end;//Tl3ConvertersList.Instance

procedure Tl3ConvertersList.InitFields;
//#UC START# *47A042E100E2_4DD4F30E00C6_var*
//#UC END# *47A042E100E2_4DD4F30E00C6_var*
begin
//#UC START# *47A042E100E2_4DD4F30E00C6_impl*
 inherited;
 Sorted := true;
//#UC END# *47A042E100E2_4DD4F30E00C6_impl*
end;//Tl3ConvertersList.InitFields

end.
