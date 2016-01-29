unit evStyleTableSpy;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evStyleTableSpy.pas"
// Начат: 23.09.2002 09:32
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::StyleTable::evStyleTableSpy
//
// Модуль для поддержки с нотификации об изменении таблицы стилей
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If not defined(DesignTimeLibrary)}
uses
  afwInterfaces,
  l3InterfacePtrList
  ;

type
 TevSpies = class(Tl3InterfacePtrList)
 public
 // public methods
   class function Exists: Boolean;
 public
 // singleton factory method
   class function Instance: TevSpies;
    {- возвращает экземпляр синглетона. }
 end;//TevSpies

procedure EvAddStyleTableSpy(const aSpy: IafwStyleTableSpy;
  SelfNotify: Boolean = false;
  aAtEnd: Boolean = true);
   {* добавить объект принимающий нотификации об изменении таблицы стилей. }
procedure EvDelStyleTableSpy(const aSpy: IafwStyleTableSpy);
   {* удалить объект принимающий нотификации об изменении таблицы стилей. }
procedure EvNotifyStyleTableChanging;
   {* рассылает нотификацию об начале изменения таблицы стилей всем заинтересованным. }
procedure EvNotifyStyleTableChanged(aCancel: Boolean = false);
   {* рассылает нотификацию об изменении таблицы стилей всем заинтересованным. }
{$IfEnd} //not DesignTimeLibrary

implementation

{$If not defined(DesignTimeLibrary)}
uses
  l3Base {a},
  evStyleInterface,
  k2Facade,
  l3Types,
  SysUtils,
  evResultFont,
  k2Tags
  ;

var f_Changes : Integer = 0;


// start class TevSpies

var g_TevSpies : TevSpies = nil;

procedure TevSpiesFree;
begin
 l3Free(g_TevSpies);
end;

class function TevSpies.Instance: TevSpies;
begin
 if (g_TevSpies = nil) then
 begin
  l3System.AddExitProc(TevSpiesFree);
  g_TevSpies := Create;
 end;
 Result := g_TevSpies;
end;


class function TevSpies.Exists: Boolean;
//#UC START# *4DD3D2A20200_4DD3D2710378_var*
//#UC END# *4DD3D2A20200_4DD3D2710378_var*
begin
//#UC START# *4DD3D2A20200_4DD3D2710378_impl*
 Result := (g_TevSpies <> nil);
//#UC END# *4DD3D2A20200_4DD3D2710378_impl*
end;//TevSpies.Exists

procedure EvAddStyleTableSpy(const aSpy: IafwStyleTableSpy;
  SelfNotify: Boolean = false;
  aAtEnd: Boolean = true);
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
end;//EvAddStyleTableSpy

procedure EvDelStyleTableSpy(const aSpy: IafwStyleTableSpy);
//#UC START# *480DA98F0055_47ECB297037D_var*
//#UC END# *480DA98F0055_47ECB297037D_var*
begin
//#UC START# *480DA98F0055_47ECB297037D_impl*
 if TevSpies.Exists then
  TevSpies.Instance.Remove(aSpy);
//#UC END# *480DA98F0055_47ECB297037D_impl*
end;//EvDelStyleTableSpy

procedure EvNotifyStyleTableChanging;
//#UC START# *480DA99E035A_47ECB297037D_var*
//#UC END# *480DA99E035A_47ECB297037D_var*
begin
//#UC START# *480DA99E035A_47ECB297037D_impl*
 Inc(f_Changes);
//#UC END# *480DA99E035A_47ECB297037D_impl*
end;//EvNotifyStyleTableChanging

procedure EvNotifyStyleTableChanged(aCancel: Boolean = false);
//#UC START# *480DA9AC0180_47ECB297037D_var*

 function _SendNormal(pSpy: PIUnknown; anIndex: Integer): Bool;
 // используется, если счетчик изменений f_Changes == 0
 begin//_SendNormal
  Result := true;
  IafwStyleTableSpy(pSpy^).StyleTableChanged;
 end;//_SendNormal

 function _SendAlways(pSpy: PIUnknown; anIndex: Integer): Bool;
 // используется, если счетчик изменений f_Changes <> 0
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
end;//EvNotifyStyleTableChanged
{$IfEnd} //not DesignTimeLibrary

end.