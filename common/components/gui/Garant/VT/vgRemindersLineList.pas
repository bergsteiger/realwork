unit vgRemindersLineList;

// Модуль: "w:\common\components\gui\Garant\VT\vgRemindersLineList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvgRemindersLineList" MUID: (533EAC970267)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , vgRemindersLine
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TvgRemindersLine;
 _l3ObjectPtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}
 TvgRemindersLineList = class(_l3ObjectPtrList_)
  public
   class function Exists: Boolean;
   class function Instance: TvgRemindersLineList;
    {* Метод получения экземпляра синглетона TvgRemindersLineList }
 end;//TvgRemindersLineList
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

var g_TvgRemindersLineList: TvgRemindersLineList = nil;
 {* Экземпляр синглетона TvgRemindersLineList }

procedure TvgRemindersLineListFree;
 {* Метод освобождения экземпляра синглетона TvgRemindersLineList }
begin
 l3Free(g_TvgRemindersLineList);
end;//TvgRemindersLineListFree

type _Instance_R_ = TvgRemindersLineList;

{$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}

class function TvgRemindersLineList.Exists: Boolean;
//#UC START# *533EAC1502AD_533EAC970267_var*
//#UC END# *533EAC1502AD_533EAC970267_var*
begin
//#UC START# *533EAC1502AD_533EAC970267_impl*
 Result := Assigned(g_TvgRemindersLineList);
//#UC END# *533EAC1502AD_533EAC970267_impl*
end;//TvgRemindersLineList.Exists

class function TvgRemindersLineList.Instance: TvgRemindersLineList;
 {* Метод получения экземпляра синглетона TvgRemindersLineList }
begin
 if (g_TvgRemindersLineList = nil) then
 begin
  l3System.AddExitProc(TvgRemindersLineListFree);
  g_TvgRemindersLineList := Create;
 end;
 Result := g_TvgRemindersLineList;
end;//TvgRemindersLineList.Instance
{$IfEnd} // NOT Defined(NoVGScene)

end.
