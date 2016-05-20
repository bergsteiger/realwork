unit PictureInfo_Form;
 {* Информация о картинке }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\PictureInfo_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "PictureInfo" MUID: (4AB12FA70146)
// Имя типа: "Ten_PictureInfo"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimPictureInfoOptions_Form
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Ten_PictureInfo = {final} class(TPrimPictureInfoOptionsForm)
  {* Информация о картинке }
   Entities : TvcmEntities;
  protected
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//Ten_PictureInfo
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 , PictureInfo_ut_PictureInfo_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , PictureInfoKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

const
 {* Локализуемые строки ut_PictureInfoLocalConstants }
 str_ut_PictureInfoCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_PictureInfoCaption'; rValue : 'Информация о картинке');
  {* Заголовок пользовательского типа "Информация о картинке" }

{$R *.DFM}

{$If NOT Defined(NoVCM)}
procedure Ten_PictureInfo.MakeControls;
begin
 inherited;
 with AddUsertype(ut_PictureInfoName,
  str_ut_PictureInfoCaption,
  str_ut_PictureInfoCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_PictureInfoName
end;//Ten_PictureInfo.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_PictureInfo);
 {* Регистрация PictureInfo }
{$IfEnd} // NOT Defined(NoScripts)
 str_ut_PictureInfoCaption.Init;
 {* Инициализация str_ut_PictureInfoCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
