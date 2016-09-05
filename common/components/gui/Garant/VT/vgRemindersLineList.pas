unit vgRemindersLineList;

// ������: "w:\common\components\gui\Garant\VT\vgRemindersLineList.pas"
// ���������: "SimpleClass"
// ������� ������: "TvgRemindersLineList" MUID: (533EAC970267)

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
    {* ����� ��������� ���������� ���������� TvgRemindersLineList }
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
 //#UC START# *533EAC970267impl_uses*
 //#UC END# *533EAC970267impl_uses*
;

var g_TvgRemindersLineList: TvgRemindersLineList = nil;
 {* ��������� ���������� TvgRemindersLineList }

procedure TvgRemindersLineListFree;
 {* ����� ������������ ���������� ���������� TvgRemindersLineList }
begin
 l3Free(g_TvgRemindersLineList);
end;//TvgRemindersLineListFree

type _Instance_R_ = TvgRemindersLineList;

{$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}

class function TvgRemindersLineList.Exists: Boolean;
begin
 Result := g_TvgRemindersLineList <> nil;
end;//TvgRemindersLineList.Exists

class function TvgRemindersLineList.Instance: TvgRemindersLineList;
 {* ����� ��������� ���������� ���������� TvgRemindersLineList }
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
