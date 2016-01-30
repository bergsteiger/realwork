{$IfNDef WorkWithRedactions_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\WorkWithRedactions.imp.pas"
// Стереотип: "VCMForm"

{$Define WorkWithRedactions_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _WorkWithRedactions_ = {abstract} class(_WorkWithRedactions_Parent_)
  {* Работа с редакциями документа }
  protected
   function CaneHaveDocumentCompareEditionsOperation: Boolean; virtual;
   function GetRedactionOnLeftEdition: Integer; virtual;
   function RedactionCurrentPara: IeeLeafPara; virtual; abstract;
    {* Текущий параграф редакции для синхронизации с окном сравннения редакций }
   function CanBeChanged: Boolean; virtual; abstract;
    {* Может ли документ быть изменён }
  public
   procedure CompareEditions; override;
    {* Сравнение редакций }
 end;//_WorkWithRedactions_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_WorkWithRedactions_ = _WorkWithRedactions_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else WorkWithRedactions_imp}

{$IfNDef WorkWithRedactions_imp_impl}

{$Define WorkWithRedactions_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
function _WorkWithRedactions_.CaneHaveDocumentCompareEditionsOperation: Boolean;
//#UC START# *4EF354C8018B_4A7B03ED01E3_var*
//#UC END# *4EF354C8018B_4A7B03ED01E3_var*
begin
//#UC START# *4EF354C8018B_4A7B03ED01E3_impl*
 Result := true;
//#UC END# *4EF354C8018B_4A7B03ED01E3_impl*
end;//_WorkWithRedactions_.CaneHaveDocumentCompareEditionsOperation

function _WorkWithRedactions_.GetRedactionOnLeftEdition: Integer;
//#UC START# *4F2BEF740060_4A7B03ED01E3_var*
//#UC END# *4F2BEF740060_4A7B03ED01E3_var*
begin
//#UC START# *4F2BEF740060_4A7B03ED01E3_impl*
 Result := -1;
//#UC END# *4F2BEF740060_4A7B03ED01E3_impl*
end;//_WorkWithRedactions_.GetRedactionOnLeftEdition

procedure _WorkWithRedactions_.CompareEditions;
 {* Сравнение редакций }
//#UC START# *4C7BAEB4010E_4A7B03ED01E3_var*
//#UC END# *4C7BAEB4010E_4A7B03ED01E3_var*
begin
//#UC START# *4C7BAEB4010E_4A7B03ED01E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7BAEB4010E_4A7B03ED01E3_impl*
end;//_WorkWithRedactions_.CompareEditions
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf WorkWithRedactions_imp_impl}

{$EndIf WorkWithRedactions_imp}

