unit NOT_FINISHED_k2Op;

// ������: "w:\common\components\rtl\Garant\K2\NOT_FINISHED_k2Op.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , l3CacheableBase
 , k2Prim
;

type
 Tk2Op = class(Tl3CacheableBase)
  protected
   function CanJoinWith(anOperation: Tk2Op): Boolean; virtual;
   function DoJoin(anOperation: Tk2Op): Tk2Op; virtual;
    {* ��������� ��� �������� � ����������:
          nil  - ���������� ��������
          Self - ���������� ������ � ��� ����������� � ������ ������
          New  - ������������ ����� �������� }
   procedure DoUndo(const Container: Ik2Op); virtual;
    {* �������� �������� }
   procedure DoRedo(const Container: Ik2Op); virtual;
    {* ������� �������� }
  public
   function CompareWith(anOp: Tk2Op): Integer; virtual;
 end;//Tk2Op

implementation

uses
 l3ImplUses
 , k2NilOp
;

function Tk2Op.CompareWith(anOp: Tk2Op): Integer;
//#UC START# *4DF7856D027C_47E3C7030369_var*
//#UC END# *4DF7856D027C_47E3C7030369_var*
begin
//#UC START# *4DF7856D027C_47E3C7030369_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DF7856D027C_47E3C7030369_impl*
end;//Tk2Op.CompareWith

function Tk2Op.CanJoinWith(anOperation: Tk2Op): Boolean;
//#UC START# *47F107C80149_47E3C7030369_var*
//#UC END# *47F107C80149_47E3C7030369_var*
begin
//#UC START# *47F107C80149_47E3C7030369_impl*
 !!! Needs to be implemented !!!
//#UC END# *47F107C80149_47E3C7030369_impl*
end;//Tk2Op.CanJoinWith

function Tk2Op.DoJoin(anOperation: Tk2Op): Tk2Op;
 {* ��������� ��� �������� � ����������:
          nil  - ���������� ��������
          Self - ���������� ������ � ��� ����������� � ������ ������
          New  - ������������ ����� �������� }
//#UC START# *47F107DF00E6_47E3C7030369_var*
//#UC END# *47F107DF00E6_47E3C7030369_var*
begin
//#UC START# *47F107DF00E6_47E3C7030369_impl*
 !!! Needs to be implemented !!!
//#UC END# *47F107DF00E6_47E3C7030369_impl*
end;//Tk2Op.DoJoin

procedure Tk2Op.DoUndo(const Container: Ik2Op);
 {* �������� �������� }
//#UC START# *47F1080F00E8_47E3C7030369_var*
//#UC END# *47F1080F00E8_47E3C7030369_var*
begin
//#UC START# *47F1080F00E8_47E3C7030369_impl*
 !!! Needs to be implemented !!!
//#UC END# *47F1080F00E8_47E3C7030369_impl*
end;//Tk2Op.DoUndo

procedure Tk2Op.DoRedo(const Container: Ik2Op);
 {* ������� �������� }
//#UC START# *47F1082B00D0_47E3C7030369_var*
//#UC END# *47F1082B00D0_47E3C7030369_var*
begin
//#UC START# *47F1082B00D0_47E3C7030369_impl*
 !!! Needs to be implemented !!!
//#UC END# *47F1082B00D0_47E3C7030369_impl*
end;//Tk2Op.DoRedo

end.
