unit arDirectMultiOperationHelper;

// Модуль: "w:\archi\source\projects\Common\Utils\arDirectMultiOperationHelper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TarDirectMultiOperationHelper" MUID: (57ED158F01BB)

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

uses
 l3IntfUses
 , arCustomMultiOperationHelper
;

type
 TarDirectMultiOperationHelper = class(TarCustomMultiOperationHelper)
  private
   procedure DoGroupTouch;
   procedure DoTouchIZM;
   procedure DoChangeKeywords;
   procedure DoSetClonePublishedIn;
  public
   procedure ModifyDocs; override;
 end;//TarDirectMultiOperationHelper

implementation

uses
 l3ImplUses
 , l3MarshalledTypes
 {$If NOT Defined(Nemesis)}
 , dt_LinkServ
 {$IfEnd} // NOT Defined(Nemesis)
 , dt_Types
 //#UC START# *57ED158F01BBimpl_uses*
 //#UC END# *57ED158F01BBimpl_uses*
;

procedure TarDirectMultiOperationHelper.DoGroupTouch;
//#UC START# *57EE39E001C8_57ED158F01BB_var*
//#UC END# *57EE39E001C8_57ED158F01BB_var*
begin
//#UC START# *57EE39E001C8_57ED158F01BB_impl*
 LinkServer(FamilyID).LogBook.PutLogRecToDocs(DocsList, acAttrWork);
//#UC END# *57EE39E001C8_57ED158F01BB_impl*
end;//TarDirectMultiOperationHelper.DoGroupTouch

procedure TarDirectMultiOperationHelper.DoTouchIZM;
//#UC START# *57EE3A50011C_57ED158F01BB_var*
//#UC END# *57EE3A50011C_57ED158F01BB_var*
begin
//#UC START# *57EE3A50011C_57ED158F01BB_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *57EE3A50011C_57ED158F01BB_impl*
end;//TarDirectMultiOperationHelper.DoTouchIZM

procedure TarDirectMultiOperationHelper.DoChangeKeywords;
//#UC START# *57EE3A5C035A_57ED158F01BB_var*
//#UC END# *57EE3A5C035A_57ED158F01BB_var*
begin
//#UC START# *57EE3A5C035A_57ED158F01BB_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *57EE3A5C035A_57ED158F01BB_impl*
end;//TarDirectMultiOperationHelper.DoChangeKeywords

procedure TarDirectMultiOperationHelper.DoSetClonePublishedIn;
//#UC START# *57EE3A710357_57ED158F01BB_var*
//#UC END# *57EE3A710357_57ED158F01BB_var*
begin
//#UC START# *57EE3A710357_57ED158F01BB_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *57EE3A710357_57ED158F01BB_impl*
end;//TarDirectMultiOperationHelper.DoSetClonePublishedIn

procedure TarDirectMultiOperationHelper.ModifyDocs;
//#UC START# *57ED15AC02A7_57ED158F01BB_var*
//#UC END# *57ED15AC02A7_57ED158F01BB_var*
begin
//#UC START# *57ED15AC02A7_57ED158F01BB_impl*
 case Operation of
  ar_moGroupTouch: DoGroupTouch;
  ar_moTouchIZM: DoTouchIZM;
  ar_moChangeKeywords: DoChangeKeywords;
  ar_moSetClonePublishedin: DoSetClonePublishedin;
 else
  Assert(False);
 end;
//#UC END# *57ED15AC02A7_57ED158F01BB_impl*
end;//TarDirectMultiOperationHelper.ModifyDocs

end.
