unit evStyleTableSpy;
 {* ћодуль дл€ поддержки с нотификации об изменении таблицы стилей }

// ћодуль: "w:\common\components\gui\Garant\Everest\evStyleTableSpy.pas"
// —тереотип: "UtilityPack"

{$Include evDefine.inc}

interface

{$If NOT Defined(DesignTimeLibrary)}
uses
 l3IntfUses
 , afwInterfaces
 , l3InterfacePtrList
;

type
 TevSpies = class(Tl3InterfacePtrList)
  public
   class function Exists: Boolean;
   class function Instance: TevSpies;
    {* ћетод получени€ экземпл€ра синглетона TevSpies }
 end;//TevSpies

procedure evAddStyleTableSpy(const aSpy: IafwStyleTableSpy;
 SelfNotify: Boolean = False;
 aAtEnd: Boolean = True);
 {* добавить объект принимающий нотификации об изменении таблицы стилей. }
procedure evDelStyleTableSpy(const aSpy: IafwStyleTableSpy);
 {* удалить объект принимающий нотификации об изменении таблицы стилей. }
procedure evNotifyStyleTableChanging;
 {* рассылает нотификацию об начале изменени€ таблицы стилей всем заинтересованным. }
procedure evNotifyStyleTableChanged(aCancel: Boolean = False);
 {* рассылает нотификацию об изменении таблицы стилей всем заинтересованным. }
{$IfEnd} // NOT Defined(DesignTimeLibrary)

implementation

{$If NOT Defined(DesignTimeLibrary)}
uses
 l3ImplUses
 , evStyleInterface
 , k2Facade
 , l3Base
 , l3Types
 , SysUtils
 , evResultFont
 , k2Tags
;

var g_TevSpies: TevSpies = nil;
 {* Ёкземпл€р синглетона TevSpies }
var f_Changes: Integer = 0;

procedure TevSpiesFree;
 {* ћетод освобождени€ экземпл€ра синглетона TevSpies }
begin
 l3Free(g_TevSpies);
end;//TevSpiesFree

procedure evAddStyleTableSpy(const aSpy: IafwStyleTableSpy;
 SelfNotify: Boolean = False;
 aAtEnd: Boolean = True);
 {* добавить объект принимающий нотификации об изменении таблицы стилей. }
//#UC START# *47ECB2BC01DF_47ECB297037D_var*
var
 l_Index : Integer;
 l_Spies : Tl3InterfacePtrList;
//#UC END# *47ECB2BC01DF_47ECB297037D_var*
begin
//#UC START# *47ECB2BC01DF_47ECB297037D_impl*
 k2.TypeTable;
 // - инициализируем таблицу тегов
 l_Spies := TevSpies.Instance;
 l_Index := l_Spies.IndexOf(aSpy);
 if (l_Index = -1) then
 begin
  if aAtEnd then
   l_Spies.Add(aSpy)
  else
   l_Spies.Insert(0, aSpy);
 end;//l_Index = -1
 if SelfNotify then
  aSpy.StyleTableChanged;
//#UC END# *47ECB2BC01DF_47ECB297037D_impl*
end;//evAddStyleTableSpy

procedure evDelStyleTableSpy(const aSpy: IafwStyleTableSpy);
 {* удалить объект принимающий нотификации об изменении таблицы стилей. }
//#UC START# *480DA98F0055_47ECB297037D_var*
//#UC END# *480DA98F0055_47ECB297037D_var*
begin
//#UC START# *480DA98F0055_47ECB297037D_impl*
 if TevSpies.Exists then
  TevSpies.Instance.Remove(aSpy);
//#UC END# *480DA98F0055_47ECB297037D_impl*
end;//evDelStyleTableSpy

procedure evNotifyStyleTableChanging;
 {* рассылает нотификацию об начале изменени€ таблицы стилей всем заинтересованным. }
//#UC START# *480DA99E035A_47ECB297037D_var*
//#UC END# *480DA99E035A_47ECB297037D_var*
begin
//#UC START# *480DA99E035A_47ECB297037D_impl*
 Inc(f_Changes);
//#UC END# *480DA99E035A_47ECB297037D_impl*
end;//evNotifyStyleTableChanging

procedure evNotifyStyleTableChanged(aCancel: Boolean = False);
 {* рассылает нотификацию об изменении таблицы стилей всем заинтересованным. }
//#UC START# *480DA9AC0180_47ECB297037D_var*

 function _SendNormal(pSpy: PIUnknown; anIndex: Integer): Bool;
 // используетс€, если счетчик изменений f_Changes == 0
 begin//_SendNormal
  Result := true;
  IafwStyleTableSpy(pSpy^).StyleTableChanged;
 end;//_SendNormal

 function _SendAlways(pSpy: PIUnknown; anIndex: Integer): Bool;
 // используетс€, если счетчик изменений f_Changes <> 0
 begin//_SendAlways
  Result := true;
  if Supports(pSpy^, IafwFontCache) then
   IafwStyleTableSpy(pSpy^).StyleTableChanged;
 end;//_SendAlways

var
 l_Spies : Tl3InterfacePtrList;
//#UC END# *480DA9AC0180_47ECB297037D_var*
begin
//#UC START# *480DA9AC0180_47ECB297037D_impl*
 Dec(f_Changes);
 if TevSpies.Exists and not(aCancel) then
 begin
  with TevStyleInterface.Make do
   try
    DefaultFontRecord[k2_tiSize] := Font.Size;
   finally
    Free;
   end;//try..finally
  l_Spies := TevSpies.Instance;
  if (l_Spies <> nil) then
   if (f_Changes = 0) then
    l_Spies.IterateAllF(l3L2IA(@_SendNormal))
   else
    l_Spies.IterateAllF(l3L2IA(@_SendAlways));
 end;
//#UC END# *480DA9AC0180_47ECB297037D_impl*
end;//evNotifyStyleTableChanged

class function TevSpies.Exists: Boolean;
//#UC START# *4DD3D2A20200_4DD3D2710378_var*
//#UC END# *4DD3D2A20200_4DD3D2710378_var*
begin
//#UC START# *4DD3D2A20200_4DD3D2710378_impl*
 Result := (g_TevSpies <> nil);
//#UC END# *4DD3D2A20200_4DD3D2710378_impl*
end;//TevSpies.Exists

class function TevSpies.Instance: TevSpies;
 {* ћетод получени€ экземпл€ра синглетона TevSpies }
begin
 if (g_TevSpies = nil) then
 begin
  l3System.AddExitProc(TevSpiesFree);
  g_TevSpies := Create;
 end;
 Result := g_TevSpies;
end;//TevSpies.Instance
{$IfEnd} // NOT Defined(DesignTimeLibrary)

end.
