unit ddCommonDataRequestPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ddCommonDataRequestPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Tasks::TddCommonDataRequestPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  csRequestTask,
  k2Base,
  dt_Types
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TddCommonDataRequestPrim = class(TddRequestTask)
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // overridden public methods
   constructor Create(aUserID: TUserID); override;
 end;//TddCommonDataRequestPrim
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  evdTaskTypes,
  CommonDataRequest_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TddCommonDataRequestPrim

class function TddCommonDataRequestPrim.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typCommonDataRequest;
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

{$IfEnd} //not Nemesis

end.