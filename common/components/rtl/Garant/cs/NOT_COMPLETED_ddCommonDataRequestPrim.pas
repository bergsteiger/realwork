unit NOT_COMPLETED_ddCommonDataRequestPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_COMPLETED_ddCommonDataRequestPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddCommonDataRequestPrim" MUID: (53B6834C0385)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csRequestTask
 , k2Base
 , dt_Types
;

type
 TddCommonDataRequestPrim = class(TddRequestTask)
  public
   class function GetTaggedDataType: Tk2Type; override;
   constructor Create(aUserID: TUserID); override;
 end;//TddCommonDataRequestPrim
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , evdTaskTypes
 , CommonDataRequest_Const
;

class function TddCommonDataRequestPrim.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53B6834C0385_var*
//#UC END# *53AC03EE01FD_53B6834C0385_var*
begin
//#UC START# *53AC03EE01FD_53B6834C0385_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53B6834C0385_impl*
end;//TddCommonDataRequestPrim.GetTaggedDataType

constructor TddCommonDataRequestPrim.Create(aUserID: TUserID);
//#UC START# *53B3D8A8011F_53B6834C0385_var*
//#UC END# *53B3D8A8011F_53B6834C0385_var*
begin
//#UC START# *53B3D8A8011F_53B6834C0385_impl*
 inherited;
 //TaskType := cs_ttCommonData;
//#UC END# *53B3D8A8011F_53B6834C0385_impl*
end;//TddCommonDataRequestPrim.Create
{$IfEnd} // NOT Defined(Nemesis)

end.
