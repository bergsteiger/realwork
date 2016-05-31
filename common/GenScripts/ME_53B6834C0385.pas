unit ddCommonDataRequestPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\ddCommonDataRequestPrim.pas"
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
   constructor Create(aUserID: TUserID); override;
   class function GetTaggedDataType: Tk2Type; override;
 end;//TddCommonDataRequestPrim
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , evdTaskTypes
 , CommonDataRequest_Const
;

constructor TddCommonDataRequestPrim.Create(aUserID: TUserID);
//#UC START# *53B3D8A8011F_53B6834C0385_var*
//#UC END# *53B3D8A8011F_53B6834C0385_var*
begin
//#UC START# *53B3D8A8011F_53B6834C0385_impl*
 inherited;
 //TaskType := cs_ttCommonData;
//#UC END# *53B3D8A8011F_53B6834C0385_impl*
end;//TddCommonDataRequestPrim.Create

class function TddCommonDataRequestPrim.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typCommonDataRequest;
end;//TddCommonDataRequestPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
