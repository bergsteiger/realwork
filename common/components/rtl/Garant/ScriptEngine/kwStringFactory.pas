unit kwStringFactory;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwStringFactory.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TkwStringFactory" MUID: (4F3E416701E8)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwStringList
 , kwString
 , l3Interfaces
;

type
 TkwStringFactory = class(TkwStringList)
  protected
   procedure InitFields; override;
  public
   function MakeKW(const aValue: Il3CString): TkwString;
   class function Instance: TkwStringFactory;
    {* Метод получения экземпляра синглетона TkwStringFactory }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TkwStringFactory
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3String
 , l3Base
 //#UC START# *4F3E416701E8impl_uses*
 //#UC END# *4F3E416701E8impl_uses*
;

var g_TkwStringFactory: TkwStringFactory = nil;
 {* Экземпляр синглетона TkwStringFactory }

procedure TkwStringFactoryFree;
 {* Метод освобождения экземпляра синглетона TkwStringFactory }
begin
 l3Free(g_TkwStringFactory);
end;//TkwStringFactoryFree

function TkwStringFactory.MakeKW(const aValue: Il3CString): TkwString;
//#UC START# *4F3E41C603BC_4F3E416701E8_var*
const
 cLimit = 300;
var
 l_Len : Integer;
 l_Index : Integer;
 l_KW : TkwString;
//#UC END# *4F3E41C603BC_4F3E416701E8_var*
begin
//#UC START# *4F3E41C603BC_4F3E416701E8_impl*
 l_Len := l3Len(aValue);
 if (l_Len < cLimit) then
 begin
  if FindData(aValue, l_Index) then
   Result := Self.Items[l_Index].Use
  else
  begin
   l_KW := TkwString.Create(aValue);
   Result := l_KW;
   Self.DirectInsert(l_Index, l_KW);
  end;//FindData(aValue, l_Index)
 end//l_Len < cLimit
 else
  Result := TkwString.Create(aValue);
//#UC END# *4F3E41C603BC_4F3E416701E8_impl*
end;//TkwStringFactory.MakeKW

class function TkwStringFactory.Instance: TkwStringFactory;
 {* Метод получения экземпляра синглетона TkwStringFactory }
begin
 if (g_TkwStringFactory = nil) then
 begin
  l3System.AddExitProc(TkwStringFactoryFree);
  g_TkwStringFactory := Create;
 end;
 Result := g_TkwStringFactory;
end;//TkwStringFactory.Instance

class function TkwStringFactory.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TkwStringFactory <> nil;
end;//TkwStringFactory.Exists

procedure TkwStringFactory.InitFields;
//#UC START# *47A042E100E2_4F3E416701E8_var*
//#UC END# *47A042E100E2_4F3E416701E8_var*
begin
//#UC START# *47A042E100E2_4F3E416701E8_impl*
 inherited;
 Sorted := true;
//#UC END# *47A042E100E2_4F3E416701E8_impl*
end;//TkwStringFactory.InitFields
{$IfEnd} // NOT Defined(NoScripts)

end.
