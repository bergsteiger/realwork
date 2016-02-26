unit tfwCStringArraySing;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwCStringArraySing.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

uses
 l3IntfUses
 , tfwCStringArray
;

type
 TtfwCStringArraySing = class(TtfwCStringArray)
  public
   class function Instance: TtfwCStringArraySing;
    {* Метод получения экземпляра синглетона TtfwCStringArraySing }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TtfwCStringArraySing

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TtfwCStringArraySing: TtfwCStringArraySing = nil;
 {* Экземпляр синглетона TtfwCStringArraySing }

procedure TtfwCStringArraySingFree;
 {* Метод освобождения экземпляра синглетона TtfwCStringArraySing }
begin
 l3Free(g_TtfwCStringArraySing);
end;//TtfwCStringArraySingFree

class function TtfwCStringArraySing.Instance: TtfwCStringArraySing;
 {* Метод получения экземпляра синглетона TtfwCStringArraySing }
begin
 if (g_TtfwCStringArraySing = nil) then
 begin
  l3System.AddExitProc(TtfwCStringArraySingFree);
  g_TtfwCStringArraySing := Create;
 end;
 Result := g_TtfwCStringArraySing;
end;//TtfwCStringArraySing.Instance

class function TtfwCStringArraySing.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TtfwCStringArraySing <> nil;
end;//TtfwCStringArraySing.Exists

end.
