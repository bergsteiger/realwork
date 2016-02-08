unit nevConfirm;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevConfirm.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , nevTools
;

type
 TnevConfirm = class(Tl3ProtoObject, InevConfirm)
  protected
   function ReplaceConfirm(const aBlock: InevRange;
    AlienReplaceConfirm: TevReplaceConfirmEvent): ShortInt;
    {* запрос на замену. Возвращаемое значение см. TevReplaceConfirmEvent. }
   function DeleteFoundRgn: Boolean;
   procedure Update;
   function Get_Progress: InevProgress;
   function Get_View: InevView;
  public
   class function Make: InevConfirm; reintroduce;
 end;//TnevConfirm

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
;

class function TnevConfirm.Make: InevConfirm;
var
 l_Inst : TnevConfirm;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnevConfirm.Make

function TnevConfirm.ReplaceConfirm(const aBlock: InevRange;
 AlienReplaceConfirm: TevReplaceConfirmEvent): ShortInt;
 {* запрос на замену. Возвращаемое значение см. TevReplaceConfirmEvent. }
//#UC START# *47C6CA4103BA_47FE40A503CD_var*
//#UC END# *47C6CA4103BA_47FE40A503CD_var*
begin
//#UC START# *47C6CA4103BA_47FE40A503CD_impl*
 if Assigned(AlienReplaceConfirm) then
  Result := AlienReplaceConfirm(Self, aBlock)
 else
  Result := mrAll; 
//#UC END# *47C6CA4103BA_47FE40A503CD_impl*
end;//TnevConfirm.ReplaceConfirm

function TnevConfirm.DeleteFoundRgn: Boolean;
//#UC START# *47C6CA560350_47FE40A503CD_var*
//#UC END# *47C6CA560350_47FE40A503CD_var*
begin
//#UC START# *47C6CA560350_47FE40A503CD_impl*
 Result := true;
//#UC END# *47C6CA560350_47FE40A503CD_impl*
end;//TnevConfirm.DeleteFoundRgn

procedure TnevConfirm.Update;
//#UC START# *47C6CA5D033F_47FE40A503CD_var*
//#UC END# *47C6CA5D033F_47FE40A503CD_var*
begin
//#UC START# *47C6CA5D033F_47FE40A503CD_impl*
 // ничего не делаем
//#UC END# *47C6CA5D033F_47FE40A503CD_impl*
end;//TnevConfirm.Update

function TnevConfirm.Get_Progress: InevProgress;
//#UC START# *47DA7D8D02C3_47FE40A503CDget_var*
//#UC END# *47DA7D8D02C3_47FE40A503CDget_var*
begin
//#UC START# *47DA7D8D02C3_47FE40A503CDget_impl*
 Result := nil;
//#UC END# *47DA7D8D02C3_47FE40A503CDget_impl*
end;//TnevConfirm.Get_Progress

function TnevConfirm.Get_View: InevView;
//#UC START# *47FE414200D2_47FE40A503CDget_var*
//#UC END# *47FE414200D2_47FE40A503CDget_var*
begin
//#UC START# *47FE414200D2_47FE40A503CDget_impl*
 Result := nil;
//#UC END# *47FE414200D2_47FE40A503CDget_impl*
end;//TnevConfirm.Get_View

end.
