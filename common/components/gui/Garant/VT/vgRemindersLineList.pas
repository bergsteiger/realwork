unit vgRemindersLineList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT$Rem"
// Модуль: "w:/common/components/gui/Garant/VT/vgRemindersLineList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VT$Rem::NewReminders::TvgRemindersLineList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VT\vtDefine.inc}

interface

{$If not defined(NoVGScene)}
uses
  l3ProtoDataContainer,
  vgRemindersLine,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}
type
 _ItemType_ = TvgRemindersLine;
 _l3ObjectPtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}
 TvgRemindersLineList = class(_l3ObjectPtrList_)
 public
 // public methods
   class function Exists: Boolean;
 public
 // singleton factory method
   class function Instance: TvgRemindersLineList;
    {- возвращает экземпляр синглетона. }
 end;//TvgRemindersLineList
{$IfEnd} //not NoVGScene

implementation

{$If not defined(NoVGScene)}
uses
  l3Base {a},
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}


// start class TvgRemindersLineList

var g_TvgRemindersLineList : TvgRemindersLineList = nil;

procedure TvgRemindersLineListFree;
begin
 l3Free(g_TvgRemindersLineList);
end;

class function TvgRemindersLineList.Instance: TvgRemindersLineList;
begin
 if (g_TvgRemindersLineList = nil) then
 begin
  l3System.AddExitProc(TvgRemindersLineListFree);
  g_TvgRemindersLineList := Create;
 end;
 Result := g_TvgRemindersLineList;
end;


type _Instance_R_ = TvgRemindersLineList;

{$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}

// start class TvgRemindersLineList

class function TvgRemindersLineList.Exists: Boolean;
//#UC START# *533EAC1502AD_533EAC970267_var*
//#UC END# *533EAC1502AD_533EAC970267_var*
begin
//#UC START# *533EAC1502AD_533EAC970267_impl*
 Result := Assigned(g_TvgRemindersLineList);
//#UC END# *533EAC1502AD_533EAC970267_impl*
end;//TvgRemindersLineList.Exists

{$IfEnd} //not NoVGScene

end.