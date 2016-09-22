unit arCustomMultiModifyDocsHelper;

// Модуль: "w:\archi\source\projects\Common\Utils\arCustomMultiModifyDocsHelper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TarCustomMultiModifyDocsHelper" MUID: (57E2548A0223)

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , nevInternalInterfaces
 , daTypes
 , k2TagGen
 , l3DatLst
;

type
 TarCustomMultiModifyDocsHelper = class(Tl3ProtoObject)
  private
   f_FamilyID: TdaFamilyID;
   f_WasException: Boolean;
   f_AnouncedDate: TDateTime;
  protected
   f_Generator: Tk2TagGenerator;
  protected
   function pm_GetGenerator: Tk2TagGenerator;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aFamily: TdaFamilyID;
    anAnouncedDate: TDateTime); reintroduce;
   procedure ModifyDocs; virtual; abstract;
   function HasLockedDocs: Boolean; virtual; abstract;
   procedure SignalException;
   procedure FillLockedList(aList: Tl3StringDataList); virtual; abstract;
  protected
   property FamilyID: TdaFamilyID
    read f_FamilyID;
   property WasException: Boolean
    read f_WasException;
   property AnouncedDate: TDateTime
    read f_AnouncedDate;
  public
   property Generator: Tk2TagGenerator
    read pm_GetGenerator;
 end;//TarCustomMultiModifyDocsHelper

implementation

uses
 l3ImplUses
 , SysUtils
 //#UC START# *57E2548A0223impl_uses*
 //#UC END# *57E2548A0223impl_uses*
;

function TarCustomMultiModifyDocsHelper.pm_GetGenerator: Tk2TagGenerator;
//#UC START# *57E254D2005D_57E2548A0223get_var*
//#UC END# *57E254D2005D_57E2548A0223get_var*
begin
//#UC START# *57E254D2005D_57E2548A0223get_impl*
 !!! Needs to be implemented !!!
//#UC END# *57E254D2005D_57E2548A0223get_impl*
end;//TarCustomMultiModifyDocsHelper.pm_GetGenerator

constructor TarCustomMultiModifyDocsHelper.Create(aFamily: TdaFamilyID;
 anAnouncedDate: TDateTime);
//#UC START# *57E256C401F8_57E2548A0223_var*
//#UC END# *57E256C401F8_57E2548A0223_var*
begin
//#UC START# *57E256C401F8_57E2548A0223_impl*
 !!! Needs to be implemented !!!
//#UC END# *57E256C401F8_57E2548A0223_impl*
end;//TarCustomMultiModifyDocsHelper.Create

procedure TarCustomMultiModifyDocsHelper.SignalException;
//#UC START# *57E2566D037A_57E2548A0223_var*
//#UC END# *57E2566D037A_57E2548A0223_var*
begin
//#UC START# *57E2566D037A_57E2548A0223_impl*
 !!! Needs to be implemented !!!
//#UC END# *57E2566D037A_57E2548A0223_impl*
end;//TarCustomMultiModifyDocsHelper.SignalException

procedure TarCustomMultiModifyDocsHelper.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57E2548A0223_var*
//#UC END# *479731C50290_57E2548A0223_var*
begin
//#UC START# *479731C50290_57E2548A0223_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_57E2548A0223_impl*
end;//TarCustomMultiModifyDocsHelper.Cleanup

end.
