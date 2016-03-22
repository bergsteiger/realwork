unit kwIntegerFactory;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwIntegerFactory.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TkwIntegerFactory" MUID: (4F3E401D03AF)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwIntegerArray
 , kwInteger
;

type
 TkwIntegerFactory = class(TkwIntegerArray)
  public
   function MakeKW(aValue: Integer): TkwInteger;
   class function Instance: TkwIntegerFactory;
    {* Метод получения экземпляра синглетона TkwIntegerFactory }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TkwIntegerFactory
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TkwIntegerFactory: TkwIntegerFactory = nil;
 {* Экземпляр синглетона TkwIntegerFactory }

procedure TkwIntegerFactoryFree;
 {* Метод освобождения экземпляра синглетона TkwIntegerFactory }
begin
 l3Free(g_TkwIntegerFactory);
end;//TkwIntegerFactoryFree

function TkwIntegerFactory.MakeKW(aValue: Integer): TkwInteger;
//#UC START# *4F3E412801B7_4F3E401D03AF_var*
const
 cLimit = 3000;
var
 l_KW : TkwInteger;
//#UC END# *4F3E412801B7_4F3E401D03AF_var*
begin
//#UC START# *4F3E412801B7_4F3E401D03AF_impl*
 if (aValue >= 0) AND (aValue < cLimit) then
 begin
  l_KW := Self.Items[aValue];
  if (l_KW = nil) then
  begin
   l_KW := TkwInteger.Create(aValue);
   Self.Items[aValue] := l_KW;
   Result := l_KW;
  end//l_KW = nil
  else
   Result := l_KW.Use;
 end//aValue < cLimit
 else
  Result := TkwInteger.Create(aValue);
//#UC END# *4F3E412801B7_4F3E401D03AF_impl*
end;//TkwIntegerFactory.MakeKW

class function TkwIntegerFactory.Instance: TkwIntegerFactory;
 {* Метод получения экземпляра синглетона TkwIntegerFactory }
begin
 if (g_TkwIntegerFactory = nil) then
 begin
  l3System.AddExitProc(TkwIntegerFactoryFree);
  g_TkwIntegerFactory := Create;
 end;
 Result := g_TkwIntegerFactory;
end;//TkwIntegerFactory.Instance

class function TkwIntegerFactory.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TkwIntegerFactory <> nil;
end;//TkwIntegerFactory.Exists
{$IfEnd} // NOT Defined(NoScripts)

end.
