unit l3ObjectList;
 {* ������� ���������� �� ������. }

// ������: "w:\common\components\rtl\Garant\L3\l3ObjectList.pas"
// ���������: "SimpleClass"
// ������� ������: "Tl3ObjectList" MUID: (4773DBBD000D)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TObject;
 _l3ObjectPtrList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}
 Tl3ObjectList = class(_l3ObjectPtrList_)
  {* ������� ���������� �� ������. }
  protected
   procedure DoDelete(Index: Integer); override;
    {* ������� ������� � �������� Index. �� ��������� ���������� �������. }
 end;//Tl3ObjectList

implementation

uses
 l3ImplUses
 , RTLConsts
 , l3Base
 , l3MinMax
 , SysUtils
 //#UC START# *4773DBBD000Dimpl_uses*
 //#UC END# *4773DBBD000Dimpl_uses*
;

type _Instance_R_ = Tl3ObjectList;

{$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}

procedure Tl3ObjectList.DoDelete(Index: Integer);
 {* ������� ������� � �������� Index. �� ��������� ���������� �������. }
//#UC START# *47B4895F01BE_4773DBBD000D_var*
var
 l_P : PItemType;
//#UC END# *47B4895F01BE_4773DBBD000D_var*
begin
//#UC START# *47B4895F01BE_4773DBBD000D_impl*
 // !!! ���������� �� _l3Items_.DoDelete ������ ����������� FreeSlot
 //     ��� ����� �� �������� ���������
 {$IfNDef l3Items_NoChanging}
 Changing;
 try
 {$EndIf l3Items_NoChanging}
  l_P := ItemSlot(Index);
  Dec(f_Count);
  if (Index = f_Count) then
   l_P^ := nil
  else
   MoveItems(Index, Succ(Index), f_Count-Index, Self);
 {$IfNDef l3Items_NoChanging}
 finally
  Changed;
 end;//try..finally
 {$EndIf  l3Items_NoChanging}
//#UC END# *47B4895F01BE_4773DBBD000D_impl*
end;//Tl3ObjectList.DoDelete

end.
