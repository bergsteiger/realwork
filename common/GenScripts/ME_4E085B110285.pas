unit bsDocumentMissingMessage;
 {* сообщение которое выдается при открытии документа или ссылки, которой
       нет в базе (находится в отсутствующих блоках) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Common\bsDocumentMissingMessage.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUnit
 , l3StringIDEx
 , l3MessageID
;

type
 TbsDocumentMissingMessage = class
  {* сообщение которое выдается при открытии документа или ссылки, которой
       нет в базе (находится в отсутствующих блоках) }
  public
   class procedure Show(AllowConsulting: Boolean = False;
    const aMissingInfo: IMissingInfo = nil);
    {* Показывает сообщение }
 end;//TbsDocumentMissingMessage
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , l3String
 , nsTypes
 , DataAdapter
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 , SearchUnit
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene)}
 , vcmDialogs
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene)
 , l3Interfaces
 , IOUnit
 {$If NOT Defined(NoVCM)}
 , vcmGUI
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Chars
 , nsQuery
 , StrUtils
;

const
 {* Варианты выбора для диалога DocumentMissing }
 str_DocumentMissing_Choice_First: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DocumentMissing_Choice_First'; rValue : 'Запросить отсутствующий документ у специалиста Правовой поддержки онлайн');
  {* 'Запросить отсутствующий документ у специалиста Правовой поддержки онлайн' }
 str_DocumentMissing_Choice_Second: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DocumentMissing_Choice_Second'; rValue : 'Вернуться в открытый документ');
  {* 'Вернуться в открытый документ' }
 {* Локализуемые строки Local }
 str_DocumentMissing: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'DocumentMissing'; rValue : 'Данный документ не включён в состав Вашего комплекта.');
  {* 'Данный документ не включён в состав Вашего комплекта.' }
 str_MissingDocumentIsContainedInBlock: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MissingDocumentIsContainedInBlock'; rValue : 'Документ содержится в информационном блоке:');
  {* 'Документ содержится в информационном блоке:' }
 str_MissingDocumentIsContainedInBlocks: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MissingDocumentIsContainedInBlocks'; rValue : 'Документ содержится в информационных блоках:');
  {* 'Документ содержится в информационных блоках:' }
 str_MissingDocumentInfo: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MissingDocumentInfo'; rValue : 'Подробнее о запрашиваемом документе');
  {* 'Подробнее о запрашиваемом документе' }
 str_ContactInfo: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ContactInfo'; rValue : 'Контактная информация');
  {* 'Контактная информация' }

class procedure TbsDocumentMissingMessage.Show(AllowConsulting: Boolean = False;
 const aMissingInfo: IMissingInfo = nil);
 {* Показывает сообщение }
//#UC START# *4E085B3F01F5_4E085B110285_var*
var
 l_Msg: Tl3Message;
 l_Footer: Il3CString;
 l_MissingMessage: Il3CString;
 l_String: IString;
 l_Query: IQuery;
 l_ConsultationText: Il3CString;
 //l_NeedConsulting: Boolean;
 l_Name: Il3CString;
const
 cIndentCount = 2; 
//#UC END# *4E085B3F01F5_4E085B110285_var*
begin
//#UC START# *4E085B3F01F5_4E085B110285_impl*
 l_Name := nil;
(* with DefDataAdapter do
  l_NeedConsulting := AllowConsulting and
                      ConsultationManager.CheckConsultingAvailable and
                      not AdministratorLogin;*)
 l_MissingMessage := defDataAdapter.GetUnexistDocMessage;
 l_Msg := str_DocumentMissing.AsMessage;
 if not l3IsNil(l_MissingMessage) then
  l_Msg := l_Msg.ChangeMessage(l_MissingMessage);
 l_Footer := nsCStr('{cloak}' + #13#10);
 if (aMissingInfo <> nil) then
 begin
  aMissingInfo.GetObjName(l_String);
  l_Name := nsCStr(l_String);
  l_Footer := l3Cat([l_Footer, str_MissingDocumentInfo.AsCStr]);
  l_Footer := l3Cat(l_Footer, DupeString(#13#10 + '{indent}', cIndentCount));
  aMissingInfo.GetBlocksInfo(l_String);
  l_Footer := l3Cat(l_Footer, #13#10 + 'h2. ');
  if aMissingInfo.IsOneBlock then
   l_Footer := l3Cat([l_Footer, str_MissingDocumentIsContainedInBlock.AsCStr])
  else
   l_Footer := l3Cat([l_Footer, str_MissingDocumentIsContainedInBlocks.AsCStr]);
  l_Footer := l3Cat(l_Footer, #13#10 + '{list}' + #13#10);
  l_Footer := l3Cat(l_Footer, '{fontsize:10}' + #13#10);
  l_Footer := l3Cat([l_Footer, nsCStr(l_String)]);
  l_Footer := l3Cat(l_Footer, #13#10 + '{/fontsize}');
  l_Footer := l3Cat(l_Footer, #13#10 + '{/list}' + #13#10);
  l_Footer := l3Cat(l_Footer, 'h2. ');
  l_Footer := l3Cat([l_Footer, str_ContactInfo.AsCStr]);
  l_Footer := l3Cat(l_Footer, ':');
 end//aMissingInfo <> nil
 else
 begin
  l_Footer := l3Cat([l_Footer, str_ContactInfo.AsCStr]);
  l_Footer := l3Cat(l_Footer, DupeString(#13#10 + '{indent}', cIndentCount));
 end;//aMissingInfo <> nil
 l_Footer := l3Cat(l_Footer, #13#10'{justification:ev_itLeft}');
 l_Footer := l3Cat(l_Footer, #13#10);
 l_Footer := l3Cat(l_Footer, '{fontsize:10}' + #13#10);
 l_Footer := l3Cat(l_Footer, '{indent}' + #13#10);
 l_Footer := l3Cat([l_Footer, defDataAdapter.GetDealerInfo]);
 l_Footer := l3Cat(l_Footer, #13#10 + '{/indent}');
 l_Footer := l3Cat(l_Footer, #13#10 + '{/fontsize}');
 l_Footer := l3Cat(l_Footer, DupeString(#13#10 + '{/indent}', cIndentCount));
 l_Footer := l3Cat(l_Footer, #13#10 + '{/justification}');
 l_Footer := l3Cat(l_Footer, #13#10 + '{/cloak}');
 l_Msg := l_Msg.ChangeFooterInfo(l_Footer);
 if (vcmMessageDlg(l_Msg) = vcm_mrCustomButton) then
 begin
  DefDataAdapter.Search.CreateQuery(QT_HANDYCRAFT_CONSULT, l_Query);
  if Assigned(l_Name) then
  begin
   l_ConsultationText := vcmFmt(str_MissingDocTemplate, [l_Name]);
   l_ConsultationText := l3StringReplace(l_ConsultationText, cc_EOLStr, cc_SoftEnterNativeStr, [rfReplaceAll]);
   l_ConsultationText := l3StringReplace(l_ConsultationText, cc_HardEnterNativeStr, cc_SoftEnterNativeStr, [rfReplaceAll]);
   SaveContextNew(l_Query, nsCStr(AT_LAW_SUPPORT_TEXT), l_ConsultationText);
  end;//Assigned(l_Name)
  TdmStdRes.OpenSendConsultation(l_Query);
 end;//vcmMessageDlg(l_Msg) = vcm_mrCustomButton
//#UC END# *4E085B3F01F5_4E085B110285_impl*
end;//TbsDocumentMissingMessage.Show

initialization
 str_DocumentMissing_Choice_First.Init;
 {* Инициализация str_DocumentMissing_Choice_First }
 str_DocumentMissing_Choice_Second.Init;
 {* Инициализация str_DocumentMissing_Choice_Second }
 str_DocumentMissing.Init;
!!! Lost Message ini !!!
 {* Инициализация str_DocumentMissing }
 str_MissingDocumentIsContainedInBlock.Init;
 {* Инициализация str_MissingDocumentIsContainedInBlock }
 str_MissingDocumentIsContainedInBlocks.Init;
 {* Инициализация str_MissingDocumentIsContainedInBlocks }
 str_MissingDocumentInfo.Init;
 {* Инициализация str_MissingDocumentInfo }
 str_ContactInfo.Init;
 {* Инициализация str_ContactInfo }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
