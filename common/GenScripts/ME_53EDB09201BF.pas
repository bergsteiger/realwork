unit csCourtDecisionSabCheckerParams;

// Модуль: "w:\common\components\rtl\Garant\cs\csCourtDecisionSabCheckerParams.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsCourtDecisionSabCheckerParams" MUID: (53EDB09201BF)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3Variant
 , csCourtsListHelper
 , k2Base
 , Classes
;

type
 _evdTagHolder_Parent_ = Tl3Tag;
 {$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}
 TcsCourtDecisionSabCheckerParams = class(_evdTagHolder_)
  protected
   function pm_GetDocTypeID: Integer;
   procedure pm_SetDocTypeID(aValue: Integer);
   {$If NOT Defined(Region)}
   function pm_GetLastUpdateDate: TDateTime;
   {$IfEnd} // NOT Defined(Region)
   {$If NOT Defined(Region)}
   procedure pm_SetLastUpdateDate(aValue: TDateTime);
   {$IfEnd} // NOT Defined(Region)
   function pm_GetNotifyList: AnsiString;
   procedure pm_SetNotifyList(const aValue: AnsiString);
   function pm_GetCourtsList: CourtsListHelper;
   function pm_GetIsParamsValid: Boolean;
   procedure pm_SetIsParamsValid(aValue: Boolean);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property DocTypeID: Integer
    read pm_GetDocTypeID
    write pm_SetDocTypeID;
   {$If NOT Defined(Region)}
   property LastUpdateDate: TDateTime
    read pm_GetLastUpdateDate
    write pm_SetLastUpdateDate;
   {$IfEnd} // NOT Defined(Region)
   property NotifyList: AnsiString
    read pm_GetNotifyList
    write pm_SetNotifyList;
   property CourtsList: CourtsListHelper
    read pm_GetCourtsList;
   property IsParamsValid: Boolean
    read pm_GetIsParamsValid
    write pm_SetIsParamsValid;
 end;//TcsCourtDecisionSabCheckerParams
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , CourtDecisionSabCheckerParams_Const
 , SysUtils
 , evdNativeWriter
 , l3Filer
 , l3Types
 , k2TagGen
 , evdNativeReader
 , k2DocumentBuffer
;

{$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}

function TcsCourtDecisionSabCheckerParams.pm_GetDocTypeID: Integer;
//#UC START# *4EEADA1C3DD0_53EDB09201BFget_var*
//#UC END# *4EEADA1C3DD0_53EDB09201BFget_var*
begin
//#UC START# *4EEADA1C3DD0_53EDB09201BFget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4EEADA1C3DD0_53EDB09201BFget_impl*
end;//TcsCourtDecisionSabCheckerParams.pm_GetDocTypeID

procedure TcsCourtDecisionSabCheckerParams.pm_SetDocTypeID(aValue: Integer);
//#UC START# *4EEADA1C3DD0_53EDB09201BFset_var*
//#UC END# *4EEADA1C3DD0_53EDB09201BFset_var*
begin
//#UC START# *4EEADA1C3DD0_53EDB09201BFset_impl*
 !!! Needs to be implemented !!!
//#UC END# *4EEADA1C3DD0_53EDB09201BFset_impl*
end;//TcsCourtDecisionSabCheckerParams.pm_SetDocTypeID

{$If NOT Defined(Region)}
function TcsCourtDecisionSabCheckerParams.pm_GetLastUpdateDate: TDateTime;
//#UC START# *E24C1E692D7A_53EDB09201BFget_var*
//#UC END# *E24C1E692D7A_53EDB09201BFget_var*
begin
//#UC START# *E24C1E692D7A_53EDB09201BFget_impl*
 !!! Needs to be implemented !!!
//#UC END# *E24C1E692D7A_53EDB09201BFget_impl*
end;//TcsCourtDecisionSabCheckerParams.pm_GetLastUpdateDate
{$IfEnd} // NOT Defined(Region)

{$If NOT Defined(Region)}
procedure TcsCourtDecisionSabCheckerParams.pm_SetLastUpdateDate(aValue: TDateTime);
//#UC START# *E24C1E692D7A_53EDB09201BFset_var*
//#UC END# *E24C1E692D7A_53EDB09201BFset_var*
begin
//#UC START# *E24C1E692D7A_53EDB09201BFset_impl*
 !!! Needs to be implemented !!!
//#UC END# *E24C1E692D7A_53EDB09201BFset_impl*
end;//TcsCourtDecisionSabCheckerParams.pm_SetLastUpdateDate
{$IfEnd} // NOT Defined(Region)

function TcsCourtDecisionSabCheckerParams.pm_GetNotifyList: AnsiString;
//#UC START# *43C9B3E0B545_53EDB09201BFget_var*
//#UC END# *43C9B3E0B545_53EDB09201BFget_var*
begin
//#UC START# *43C9B3E0B545_53EDB09201BFget_impl*
 !!! Needs to be implemented !!!
//#UC END# *43C9B3E0B545_53EDB09201BFget_impl*
end;//TcsCourtDecisionSabCheckerParams.pm_GetNotifyList

procedure TcsCourtDecisionSabCheckerParams.pm_SetNotifyList(const aValue: AnsiString);
//#UC START# *43C9B3E0B545_53EDB09201BFset_var*
//#UC END# *43C9B3E0B545_53EDB09201BFset_var*
begin
//#UC START# *43C9B3E0B545_53EDB09201BFset_impl*
 !!! Needs to be implemented !!!
//#UC END# *43C9B3E0B545_53EDB09201BFset_impl*
end;//TcsCourtDecisionSabCheckerParams.pm_SetNotifyList

function TcsCourtDecisionSabCheckerParams.pm_GetCourtsList: CourtsListHelper;
//#UC START# *C4D1E41E73D1_53EDB09201BFget_var*
//#UC END# *C4D1E41E73D1_53EDB09201BFget_var*
begin
//#UC START# *C4D1E41E73D1_53EDB09201BFget_impl*
 !!! Needs to be implemented !!!
//#UC END# *C4D1E41E73D1_53EDB09201BFget_impl*
end;//TcsCourtDecisionSabCheckerParams.pm_GetCourtsList

function TcsCourtDecisionSabCheckerParams.pm_GetIsParamsValid: Boolean;
//#UC START# *B67A69AEE25A_53EDB09201BFget_var*
//#UC END# *B67A69AEE25A_53EDB09201BFget_var*
begin
//#UC START# *B67A69AEE25A_53EDB09201BFget_impl*
 !!! Needs to be implemented !!!
//#UC END# *B67A69AEE25A_53EDB09201BFget_impl*
end;//TcsCourtDecisionSabCheckerParams.pm_GetIsParamsValid

procedure TcsCourtDecisionSabCheckerParams.pm_SetIsParamsValid(aValue: Boolean);
//#UC START# *B67A69AEE25A_53EDB09201BFset_var*
//#UC END# *B67A69AEE25A_53EDB09201BFset_var*
begin
//#UC START# *B67A69AEE25A_53EDB09201BFset_impl*
 !!! Needs to be implemented !!!
//#UC END# *B67A69AEE25A_53EDB09201BFset_impl*
end;//TcsCourtDecisionSabCheckerParams.pm_SetIsParamsValid

class function TcsCourtDecisionSabCheckerParams.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53EDB09201BF_var*
//#UC END# *53AC03EE01FD_53EDB09201BF_var*
begin
//#UC START# *53AC03EE01FD_53EDB09201BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53EDB09201BF_impl*
end;//TcsCourtDecisionSabCheckerParams.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
