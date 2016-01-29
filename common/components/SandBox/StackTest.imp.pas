{$IfNDef StackTest_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBoxTest"
// Модуль: "StackTest.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: TestCaseMixIn::Class Shared Delphi Sand Box::SandBoxTest::ContainersTestsPrim::StackTest
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define StackTest_imp}
{$If defined(nsTest)}
 TEtalonData = ItemsHolder;

 _StackTest_ = class(TTestCase)
 protected
 // protected methods
   procedure DoDoIt;
   function GetEtalonData: TEtalonData; virtual; abstract;
   function ArrayToEtalon(const aData: array of _ItemType_): TEtalonData;
     {* Вспомогательная функция появившаяся оттого, что динамические массивы умеют к открытым приводиться автоматом, а обратно - нет }
 published
 // published methods
   procedure DoIt;
 end;//_StackTest_
{$Else}

 _StackTest_ = TTestCase;

{$IfEnd} //nsTest

{$Else StackTest_imp}

{$If defined(nsTest)}

// start class _StackTest_

procedure _StackTest_.DoDoIt;
//#UC START# *5159938101A2_515992DE031D_var*
var
 l_Etalons : TEtalonData;
 l_S : _StackType_;
 l_I : Integer;
//#UC END# *5159938101A2_515992DE031D_var*
begin
//#UC START# *5159938101A2_515992DE031D_impl*
 l_S := _StackType_.Create;
 try
  l_Etalons := GetEtalonData;
  for l_I := Low(l_Etalons) to High(l_Etalons) do
   l_S.Push(l_Etalons[l_I]);
  for l_I := High(l_Etalons) downto Low(l_Etalons) do
   Check(l_S.Pop = l_Etalons[l_I]);
 finally
  FreeAndNil(l_S);
 end;//try..finally
//#UC END# *5159938101A2_515992DE031D_impl*
end;//_StackTest_.DoDoIt

function _StackTest_.ArrayToEtalon(const aData: array of _ItemType_): TEtalonData;
//#UC START# *51599BD5015F_515992DE031D_var*
var
 l_I : Integer;
//#UC END# *51599BD5015F_515992DE031D_var*
begin
//#UC START# *51599BD5015F_515992DE031D_impl*
 SetLength(Result, Length(aData));
 for l_I := Low(aData) to High(aData) do
  Result[l_I] := aData[l_I];
//#UC END# *51599BD5015F_515992DE031D_impl*
end;//_StackTest_.ArrayToEtalon

procedure _StackTest_.DoIt;
//#UC START# *515996DE014C_515992DE031D_var*
//#UC END# *515996DE014C_515992DE031D_var*
begin
//#UC START# *515996DE014C_515992DE031D_impl*
 DoDoIt;
//#UC END# *515996DE014C_515992DE031D_impl*
end;//_StackTest_.DoIt

{$IfEnd} //nsTest

{$EndIf StackTest_imp}
