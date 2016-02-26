unit tfwCStringArraySing2;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwCStringArraySing2.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

uses
 l3IntfUses
 , tfwCStringArray
;

type
 TtfwCStringArraySing2 = class(TtfwCStringArray)
  public
   class function Instance: TtfwCStringArraySing2;
    {* Метод получения экземпляра синглетона TtfwCStringArraySing2 }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TtfwCStringArraySing2

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TtfwCStringArraySing2: TtfwCStringArraySing2 = nil;
 {* Экземпляр синглетона TtfwCStringArraySing2 }

procedure TtfwCStringArraySing2Free;
 {* Метод освобождения экземпляра синглетона TtfwCStringArraySing2 }
begin
 l3Free(g_TtfwCStringArraySing2);
end;//TtfwCStringArraySing2Free

class function TtfwCStringArraySing2.Instance: TtfwCStringArraySing2;
 {* Метод получения экземпляра синглетона TtfwCStringArraySing2 }
begin
 if (g_TtfwCStringArraySing2 = nil) then
 begin
  l3System.AddExitProc(TtfwCStringArraySing2Free);
  g_TtfwCStringArraySing2 := Create;
 end;
 Result := g_TtfwCStringArraySing2;
end;//TtfwCStringArraySing2.Instance

class function TtfwCStringArraySing2.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TtfwCStringArraySing2 <> nil;
end;//TtfwCStringArraySing2.Exists

end.
