unit EULA_Form;
 {* Условия использования }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\EULA_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "EULA" MUID: (4A93FB8C0121)
// Имя типа: "TefEULA"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimEULA_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_efEULA: TvcmFormDescriptor = (rFormID : (rName : 'efEULA'; rID : 0); rFactory : nil);
  {* Идентификатор формы TefEULA }

type
 TefEULA = class;

 EULAFormDef = interface
  {* Идентификатор формы EULA }
  ['{DF5FBE77-74EC-44AD-8636-CBFDE4947FC7}']
 end;//EULAFormDef

 TefEULA = {final} class(TPrimEULAForm, EULAFormDef)
  {* Условия использования }
   Entities : TvcmEntities;
  protected
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TefEULA
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , EULA_ut_EULA_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , EULAKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

const
 {* Локализуемые строки ut_EULALocalConstants }
 str_ut_EULACaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_EULACaption'; rValue : 'Условия использования');
  {* Заголовок пользовательского типа "Условия использования" }

{$R *.DFM}

{$If NOT Defined(NoVCM)}
procedure TefEULA.MakeControls;
begin
 inherited;
 with AddUsertype(ut_EULAName,
  str_ut_EULACaption,
  str_ut_EULACaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_EULAName
end;//TefEULA.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_ut_EULACaption.Init;
 {* Инициализация str_ut_EULACaption }
 fm_efEULA.SetFactory(TefEULA.Make);
 {* Регистрация фабрики формы EULA }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefEULA);
 {* Регистрация EULA }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
