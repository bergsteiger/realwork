unit TestNameList;
 {* Список тестов для  запуска. }

// Модуль: "w:\common\components\rtl\Garant\DUnitTuning\TestNameList.pas"
// Стереотип: "SimpleClass"

{$Include tfwDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
uses
 l3IntfUses
 , l3StringList
 , l3Base
;

type
 TLoadOperation = (
  lo_Clear
  , lo_AND
  , lo_OR
  , lo_NOT
 );//TLoadOperation

 TTestNameList = class(Tl3StringList)
  {* Список тестов для  запуска. }
  protected
   function StringItemClass: Rl3String; override;
  public
   class function Exists: Boolean;
   class procedure LoadFromFileEX(const aFileName: AnsiString;
    aOperation: TLoadOperation);
   class procedure ClearList;
   class function Instance: TTestNameList;
    {* Метод получения экземпляра синглетона TTestNameList }
 end;//TTestNameList
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

implementation

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
uses
 l3ImplUses
 , TestNameString
 , SysUtils
;

var g_TTestNameList: TTestNameList = nil;
 {* Экземпляр синглетона TTestNameList }

procedure TTestNameListFree;
 {* Метод освобождения экземпляра синглетона TTestNameList }
begin
 l3Free(g_TTestNameList);
end;//TTestNameListFree

class function TTestNameList.Exists: Boolean;
//#UC START# *4D2EE63E0318_4D1AEAC80371_var*
//#UC END# *4D2EE63E0318_4D1AEAC80371_var*
begin
//#UC START# *4D2EE63E0318_4D1AEAC80371_impl*
 Result := g_TTestNameList <> nil;
//#UC END# *4D2EE63E0318_4D1AEAC80371_impl*
end;//TTestNameList.Exists

class procedure TTestNameList.LoadFromFileEX(const aFileName: AnsiString;
 aOperation: TLoadOperation);
//#UC START# *5245135701C4_4D1AEAC80371_var*
var
 l_NewList : TTestNameList;

 function lp_CheckData(aWord: Pointer; anIndex: Integer): Boolean;
 var
  l_Index : Integer;
 begin
  Result := True;
  if not Tl3PrimString(aWord^).Empty then
   if g_TTestNameList.FindData(Tl3PrimString(aWord^).AsWStr, l_Index) then
    if aOperation = lo_AND then
     l_NewList.Add(Tl3PrimString(aWord^).AsWStr)
    else
     g_TTestNameList.Delete(l_Index)
   else
    if aOperation = lo_NOT then
     l_NewList.Add(Tl3PrimString(aWord^).AsWStr);
 end;

 function lp_AddData(aWord: Pointer; anIndex: Integer): Boolean;
 var
  l_Index : Integer;
 begin
  Result := True;
  l_NewList.Add(Tl3PrimString(aWord^).AsWStr);
 end;

var
 l_TempList: TTestNameList;
//#UC END# *5245135701C4_4D1AEAC80371_var*
begin
//#UC START# *5245135701C4_4D1AEAC80371_impl*
 if TTestNameList.Exists then
  case aOperation of
   lo_Clear: TTestNameList.Instance.Clear;
   lo_AND, lo_NOT: begin
    l_NewList := Create;
    l_TempList := Create;
    try
     l_TempList.LoadFromFile(aFileName);
     l_TempList.IterateAllF(l3L2IA(@lp_CheckData));
     if aOperation = lo_NOT then
      g_TTestNameList.IterateAllF(l3L2IA(@lp_AddData));
     TTestNameListFree;
     g_TTestNameList := l_NewList;
    finally
     l3Free(l_TempList);
    end;
    Exit;
   end;
  end;
 TTestNameList.Instance.LoadFromFile(aFileName);
//#UC END# *5245135701C4_4D1AEAC80371_impl*
end;//TTestNameList.LoadFromFileEX

class procedure TTestNameList.ClearList;
//#UC START# *525CFBC20231_4D1AEAC80371_var*
//#UC END# *525CFBC20231_4D1AEAC80371_var*
begin
//#UC START# *525CFBC20231_4D1AEAC80371_impl*
 if Exists then
  TTestNameList.Instance.Clear;
//#UC END# *525CFBC20231_4D1AEAC80371_impl*
end;//TTestNameList.ClearList

class function TTestNameList.Instance: TTestNameList;
 {* Метод получения экземпляра синглетона TTestNameList }
begin
 if (g_TTestNameList = nil) then
 begin
  l3System.AddExitProc(TTestNameListFree);
  g_TTestNameList := Create;
 end;
 Result := g_TTestNameList;
end;//TTestNameList.Instance

function TTestNameList.StringItemClass: Rl3String;
//#UC START# *47B1E5230151_4D1AEAC80371_var*
//#UC END# *47B1E5230151_4D1AEAC80371_var*
begin
//#UC START# *47B1E5230151_4D1AEAC80371_impl*
 Result := TTestNameString;
//#UC END# *47B1E5230151_4D1AEAC80371_impl*
end;//TTestNameList.StringItemClass
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

end.
