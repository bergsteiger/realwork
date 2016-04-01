unit NOT_COMPLETED_csCourtDescription;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_COMPLETED_csCourtDescription.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsCourtDescription" MUID: (53EDB1000048)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3Variant
 , csDecisionPhrasesHelper
 , k2Base
 , Classes
;

type
 _evdTagHolder_Parent_ = Tl3Tag;
 {$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}
 TcsCourtDescription = class(_evdTagHolder_)
  protected
   function pm_GetName: AnsiString;
   procedure pm_SetName(const aValue: AnsiString);
   function pm_GetSourceID: Integer;
   procedure pm_SetSourceID(aValue: Integer);
   function pm_GetNeedProcess: Boolean;
   procedure pm_SetNeedProcess(aValue: Boolean);
   function pm_GetDecisionPhrases: DecisionPhrasesHelper;
  public
   procedure Clear;
   class function GetTaggedDataType: Tk2Type; override;
  public
   property Name: AnsiString
    read pm_GetName
    write pm_SetName;
   property SourceID: Integer
    read pm_GetSourceID
    write pm_SetSourceID;
   property NeedProcess: Boolean
    read pm_GetNeedProcess
    write pm_SetNeedProcess;
   property DecisionPhrases: DecisionPhrasesHelper
    read pm_GetDecisionPhrases;
 end;//TcsCourtDescription
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , CourtDescription_Const
 , SysUtils
 , evdNativeWriter
 , l3Filer
 , l3Types
 , k2TagGen
 , evdNativeReader
 , k2DocumentBuffer
;

{$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}

function TcsCourtDescription.pm_GetName: AnsiString;
//#UC START# *1647FA5EBD4E_53EDB1000048get_var*
//#UC END# *1647FA5EBD4E_53EDB1000048get_var*
begin
//#UC START# *1647FA5EBD4E_53EDB1000048get_impl*
 !!! Needs to be implemented !!!
//#UC END# *1647FA5EBD4E_53EDB1000048get_impl*
end;//TcsCourtDescription.pm_GetName

procedure TcsCourtDescription.pm_SetName(const aValue: AnsiString);
//#UC START# *1647FA5EBD4E_53EDB1000048set_var*
//#UC END# *1647FA5EBD4E_53EDB1000048set_var*
begin
//#UC START# *1647FA5EBD4E_53EDB1000048set_impl*
 !!! Needs to be implemented !!!
//#UC END# *1647FA5EBD4E_53EDB1000048set_impl*
end;//TcsCourtDescription.pm_SetName

function TcsCourtDescription.pm_GetSourceID: Integer;
//#UC START# *1604C1884F3C_53EDB1000048get_var*
//#UC END# *1604C1884F3C_53EDB1000048get_var*
begin
//#UC START# *1604C1884F3C_53EDB1000048get_impl*
 !!! Needs to be implemented !!!
//#UC END# *1604C1884F3C_53EDB1000048get_impl*
end;//TcsCourtDescription.pm_GetSourceID

procedure TcsCourtDescription.pm_SetSourceID(aValue: Integer);
//#UC START# *1604C1884F3C_53EDB1000048set_var*
//#UC END# *1604C1884F3C_53EDB1000048set_var*
begin
//#UC START# *1604C1884F3C_53EDB1000048set_impl*
 !!! Needs to be implemented !!!
//#UC END# *1604C1884F3C_53EDB1000048set_impl*
end;//TcsCourtDescription.pm_SetSourceID

function TcsCourtDescription.pm_GetNeedProcess: Boolean;
//#UC START# *2095F3B6D6AD_53EDB1000048get_var*
//#UC END# *2095F3B6D6AD_53EDB1000048get_var*
begin
//#UC START# *2095F3B6D6AD_53EDB1000048get_impl*
 !!! Needs to be implemented !!!
//#UC END# *2095F3B6D6AD_53EDB1000048get_impl*
end;//TcsCourtDescription.pm_GetNeedProcess

procedure TcsCourtDescription.pm_SetNeedProcess(aValue: Boolean);
//#UC START# *2095F3B6D6AD_53EDB1000048set_var*
//#UC END# *2095F3B6D6AD_53EDB1000048set_var*
begin
//#UC START# *2095F3B6D6AD_53EDB1000048set_impl*
 !!! Needs to be implemented !!!
//#UC END# *2095F3B6D6AD_53EDB1000048set_impl*
end;//TcsCourtDescription.pm_SetNeedProcess

function TcsCourtDescription.pm_GetDecisionPhrases: DecisionPhrasesHelper;
//#UC START# *28B5B5DE52B9_53EDB1000048get_var*
//#UC END# *28B5B5DE52B9_53EDB1000048get_var*
begin
//#UC START# *28B5B5DE52B9_53EDB1000048get_impl*
 !!! Needs to be implemented !!!
//#UC END# *28B5B5DE52B9_53EDB1000048get_impl*
end;//TcsCourtDescription.pm_GetDecisionPhrases

procedure TcsCourtDescription.Clear;
//#UC START# *53EDD3C40089_53EDB1000048_var*
//#UC END# *53EDD3C40089_53EDB1000048_var*
begin
//#UC START# *53EDD3C40089_53EDB1000048_impl*
 SetTaggedData(GetTaggedDataType.MakeTag.AsObject);
//#UC END# *53EDD3C40089_53EDB1000048_impl*
end;//TcsCourtDescription.Clear

class function TcsCourtDescription.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53EDB1000048_var*
//#UC END# *53AC03EE01FD_53EDB1000048_var*
begin
//#UC START# *53AC03EE01FD_53EDB1000048_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53EDB1000048_impl*
end;//TcsCourtDescription.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
