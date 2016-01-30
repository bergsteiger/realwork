unit dsCRWarning;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Document\dsCRWarning.pas"
// Стереотип: "ViewAreaControllerImp"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , dsWarning
 , nsTypes
 , nevBase
;

type
 TdsCRWarning = class(TdsWarning)
  protected
   function DoGenerateWarning(const aGenerator: InevTagGenerator;
    aUserType: Integer): TWarningTypeSet; override;
 end;//TdsCRWarning
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , BaloonWarningUserTypes_remListModified_UserType
 , nsListWarningGenerator
;

function TdsCRWarning.DoGenerateWarning(const aGenerator: InevTagGenerator;
 aUserType: Integer): TWarningTypeSet;
//#UC START# *4EF4849D01C9_4EF485030376_var*
//#UC END# *4EF4849D01C9_4EF485030376_var*
begin
//#UC START# *4EF4849D01C9_4EF485030376_impl*
 if (aUserType = remListModified) then
  Result := TnsListWarningGenerator.Generate(Self,
                                             Self.pm_GetDocInfo.Doc,
                                             aGenerator,
                                             aUserType,
                                             nil)
 else
  Result := inherited DoGenerateWarning(aGenerator, aUserType);
//#UC END# *4EF4849D01C9_4EF485030376_impl*
end;//TdsCRWarning.DoGenerateWarning
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
