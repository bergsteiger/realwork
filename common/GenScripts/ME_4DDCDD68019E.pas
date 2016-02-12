unit dsChangesBetweenEditions;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\ChangesBetweenEditions\dsChangesBetweenEditions.pas"
// Стереотип: "ViewAreaControllerImp"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentAndListInterfaces
 , ChangesBetweenEditionsInterfaces
 , nevTools
 , afwInterfaces
 , DocumentUnit
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , l3NotifyPtrList
 , DocumentInterfaces
 , l3StringIDEx
;

type
 _InitDataType_ = InsChangesBetweenEditionsInfo;
 _FormDataSourceType_ = IdsChangesBetweenEditions;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}
 _deDocInfoProvider_Parent_ = _vcmFormDataSource_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Presentation\deDocInfoProvider.imp.pas}
 TdsChangesBetweenEditions = class(_deDocInfoProvider_, IucpHAFMacroReplacerFactory, IdsChangesBetweenEditions)
  private
   f_Cont: InevDocumentContainer;
  protected
   function MakeHAFMacroReplacer: IafwHAFMacroReplacer;
   function Get_RightEdition: IDocument;
   function Get_DocumentContainer: InevDocumentContainer;
   function Get_LeftEdition: IDocument;
   function DocumentForDocInfoProvider: IDocument; override;
   procedure ClearFields; override;
 end;//TdsChangesBetweenEditions
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsChangesBetweenEditionsDocumentContainer
 , evFormatHAFMacroReplacer
 , nsDocInfoHAFMacroReplacer
 , IOUnit
 , nsTypes
 , l3String
 , l3MessageID
 , l3InterfacesMisc
 , SysUtils
 , l3Base
 , deDocInfo
;

const
 {* Локализуемые строки Обзор изменений документа }
 str_cnevChangesBetweenEditions: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cnevChangesBetweenEditions'; rValue : 'Обзор изменений документа: ');
  {* 'Обзор изменений документа: ' }

{$If not Declared(_UseCaseControllerType_)}type _UseCaseControllerType_ = IvcmFormSetDataSource;{$IfEnd}

type _Instance_R_ = TdsChangesBetweenEditions;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Presentation\deDocInfoProvider.imp.pas}

function TdsChangesBetweenEditions.MakeHAFMacroReplacer: IafwHAFMacroReplacer;
//#UC START# *4AE56DE80093_4DDCDD68019E_var*
var
 l_IDocName: IString;
 l_DocName: Tl3WString;
//#UC END# *4AE56DE80093_4DDCDD68019E_var*
begin
//#UC START# *4AE56DE80093_4DDCDD68019E_impl*
 Get_RightEdition.GetName(l_IDocName);
 l_DocName := nsWStr(l_IDocName);

 Result := TevFormatHAFMacroReplacer.Make(TnsDocInfoHAFMacroReplacer.Make(nil, Self.pm_GetDocInfo),
                                          l3Cat(str_cnevChangesBetweenEditions.AsCStr, l_DocName));
//#UC END# *4AE56DE80093_4DDCDD68019E_impl*
end;//TdsChangesBetweenEditions.MakeHAFMacroReplacer

function TdsChangesBetweenEditions.Get_RightEdition: IDocument;
//#UC START# *4DDCE9110130_4DDCDD68019Eget_var*
//#UC END# *4DDCE9110130_4DDCDD68019Eget_var*
begin
//#UC START# *4DDCE9110130_4DDCDD68019Eget_impl*
 Result := PartData.RightEdition;
//#UC END# *4DDCE9110130_4DDCDD68019Eget_impl*
end;//TdsChangesBetweenEditions.Get_RightEdition

function TdsChangesBetweenEditions.Get_DocumentContainer: InevDocumentContainer;
//#UC START# *4DDD0C170344_4DDCDD68019Eget_var*
//#UC END# *4DDD0C170344_4DDCDD68019Eget_var*
begin
//#UC START# *4DDD0C170344_4DDCDD68019Eget_impl*
 if (f_Cont = nil) then
  f_Cont := TnsChangesBetweenEditionsDocumentContainer.Make(PartData);
 Result := f_Cont;
//#UC END# *4DDD0C170344_4DDCDD68019Eget_impl*
end;//TdsChangesBetweenEditions.Get_DocumentContainer

function TdsChangesBetweenEditions.Get_LeftEdition: IDocument;
//#UC START# *4F2BF187026F_4DDCDD68019Eget_var*
//#UC END# *4F2BF187026F_4DDCDD68019Eget_var*
begin
//#UC START# *4F2BF187026F_4DDCDD68019Eget_impl*
 Result := PartData.LeftEdition;
//#UC END# *4F2BF187026F_4DDCDD68019Eget_impl*
end;//TdsChangesBetweenEditions.Get_LeftEdition

function TdsChangesBetweenEditions.DocumentForDocInfoProvider: IDocument;
//#UC START# *4F548A0D0096_4DDCDD68019E_var*
//#UC END# *4F548A0D0096_4DDCDD68019E_var*
begin
//#UC START# *4F548A0D0096_4DDCDD68019E_impl*
 Result := Get_RightEdition;
//#UC END# *4F548A0D0096_4DDCDD68019E_impl*
end;//TdsChangesBetweenEditions.DocumentForDocInfoProvider

procedure TdsChangesBetweenEditions.ClearFields;
begin
 f_Cont := nil;
 inherited;
end;//TdsChangesBetweenEditions.ClearFields

initialization
 str_cnevChangesBetweenEditions.Init;
 {* Инициализация str_cnevChangesBetweenEditions }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
