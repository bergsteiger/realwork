unit bsDocumentMissingMessage;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Common$Lib"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Common/bsDocumentMissingMessage.pas"
// Начат: 27.06.2011 14:27
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Common$Lib::DocumentUtils::TbsDocumentMissingMessage
//
// сообщение которое выдается при открытии документа или ссылки, которой
// нет в базе (находится в отсутствующих блоках)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit,
  l3StringIDEx,
  l3MessageID
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TbsDocumentMissingMessage = class
  {* сообщение которое выдается при открытии документа или ссылки, которой
       нет в базе (находится в отсутствующих блоках) }
 public
 // public methods
   class procedure Show(AllowConsulting: Boolean = false;
     const aMissingInfo: IMissingInfo = nil);
     {* Показывает сообщение }
 end;//TbsDocumentMissingMessage
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  l3String,
  nsTypes,
  DataAdapter
  {$If not defined(NoVCM)}
  ,
  vcmMessagesSupport
  {$IfEnd} //not NoVCM
  ,
  SearchUnit
  {$If not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmDialogs
  {$IfEnd} //not NoVCM AND not NoVGScene
  ,
  l3Interfaces,
  IOUnit
  {$If not defined(NoVCM)}
  ,
  vcmGUI
  {$IfEnd} //not NoVCM
  ,
  SysUtils
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  l3Chars,
  nsQuery,
  StrUtils
  {$If not defined(NoVCL)}
  ,
  Dialogs
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Варианты выбора для диалога DocumentMissing }
  str_DocumentMissing_Choice_First : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DocumentMissing_Choice_First'; rValue : 'Запросить отсутствующий документ у специалиста Правовой поддержки онлайн');
   { 'Запросить отсутствующий документ у специалиста Правовой поддержки онлайн' }
  str_DocumentMissing_Choice_Second : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DocumentMissing_Choice_Second'; rValue : 'Вернуться в открытый документ');
   { 'Вернуться в открытый документ' }

var
   { Локализуемые строки Local }
  str_DocumentMissing : Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'DocumentMissing'; rValue : 'Данный документ не включён в состав Вашего комплекта.');
   { 'Данный документ не включён в состав Вашего комплекта.' }
  str_MissingDocumentIsContainedInBlock : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MissingDocumentIsContainedInBlock'; rValue : 'Документ содержится в информационном блоке:');
   { 'Документ содержится в информационном блоке:' }
  str_MissingDocumentIsContainedInBlocks : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MissingDocumentIsContainedInBlocks'; rValue : 'Документ содержится в информационных блоках:');
   { 'Документ содержится в информационных блоках:' }
  str_MissingDocumentInfo : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MissingDocumentInfo'; rValue : 'Подробнее о запрашиваемом документе');
   { 'Подробнее о запрашиваемом документе' }
  str_ContactInfo : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ContactInfo'; rValue : 'Контактная информация');
   { 'Контактная информация' }

// start class TbsDocumentMissingMessage

class procedure TbsDocumentMissingMessage.Show(AllowConsulting: Boolean = false;
  const aMissingInfo: IMissingInfo = nil);
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

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_DocumentMissing_Choice_First
 str_DocumentMissing_Choice_First.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_DocumentMissing_Choice_Second
 str_DocumentMissing_Choice_Second.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_DocumentMissing
 str_DocumentMissing.Init;
 str_DocumentMissing.AddChoice(str_DocumentMissing_Choice_First);
 str_DocumentMissing.AddChoice(str_DocumentMissing_Choice_Second);
 str_DocumentMissing.AddCustomChoice(str_DocumentMissing_Choice_First);
 str_DocumentMissing.AddDefaultChoice(str_DocumentMissing_Choice_Second);
 str_DocumentMissing.SetDlgType(mtWarning);
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_MissingDocumentIsContainedInBlock
 str_MissingDocumentIsContainedInBlock.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_MissingDocumentIsContainedInBlocks
 str_MissingDocumentIsContainedInBlocks.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_MissingDocumentInfo
 str_MissingDocumentInfo.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_ContactInfo
 str_ContactInfo.Init;
{$IfEnd} //not Admin AND not Monitorings

end.