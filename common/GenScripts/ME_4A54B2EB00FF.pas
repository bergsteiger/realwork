unit atNewConsultation;
 {* Работа с новой консультацией }

// Модуль: "w:\quality\test\garant6x\AdapterTest\AdapterHelpers\atNewConsultation.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatNewConsultation" MUID: (4A54B2EB00FF)

interface

uses
 l3IntfUses
 , atQuery
;

type
 TatNewConsultation = class(TObject)
  {* Работа с новой консультацией }
  private
   f_Query: TatQuery;
   f_UserName: AnsiString;
    {* Поле для свойства UserName }
   f_CityCode: AnsiString;
    {* Поле для свойства CityCode }
   f_PhoneNumber: AnsiString;
    {* Поле для свойства PhoneNumber }
   f_QuestionText: AnsiString;
    {* Поле для свойства QuestionText }
   f_EMail: AnsiString;
    {* Поле для свойства EMail }
  protected
   procedure pm_SetUserName(const aValue: AnsiString);
   procedure pm_SetCityCode(const aValue: AnsiString);
   procedure pm_SetPhoneNumber(const aValue: AnsiString);
   procedure pm_SetQuestionText(const aValue: AnsiString);
   procedure pm_SetEMail(const aValue: AnsiString);
  public
   constructor Create; reintroduce;
   procedure Send; virtual;
   destructor Destroy; override;
  public
   property UserName: AnsiString
    read f_UserName
    write pm_SetUserName;
   property CityCode: AnsiString
    read f_CityCode
    write pm_SetCityCode;
   property PhoneNumber: AnsiString
    read f_PhoneNumber
    write pm_SetPhoneNumber;
   property QuestionText: AnsiString
    read f_QuestionText
    write pm_SetQuestionText;
   property EMail: AnsiString
    read f_EMail
    write pm_SetEMail;
 end;//TatNewConsultation

implementation

uses
 l3ImplUses
 , SearchUnit
 , atStringHelper
 , SysUtils
;

procedure TatNewConsultation.pm_SetUserName(const aValue: AnsiString);
//#UC START# *4A54B65D01D0_4A54B2EB00FFset_var*
  const
    TAG = 'AT_USER_NAME';
//#UC END# *4A54B65D01D0_4A54B2EB00FFset_var*
begin
//#UC START# *4A54B65D01D0_4A54B2EB00FFset_impl*
  if (f_UserName <> aValue) then
  begin
    f_UserName := aValue;
    f_Query.ClearAttribute(TAG);
    if (f_UserName <> '') then
      f_Query.SaveContextAttribute(TAG, QLO_AND, f_UserName);
  end;
//#UC END# *4A54B65D01D0_4A54B2EB00FFset_impl*
end;//TatNewConsultation.pm_SetUserName

procedure TatNewConsultation.pm_SetCityCode(const aValue: AnsiString);
//#UC START# *4A54B674018C_4A54B2EB00FFset_var*
  const
    TAG= 'AT_USER_PHONE';
//#UC END# *4A54B674018C_4A54B2EB00FFset_var*
begin
//#UC START# *4A54B674018C_4A54B2EB00FFset_impl*
  if (f_CityCode <> aValue) then
  begin
    f_CityCode := aValue;
    if (f_CityCode <> '') then
      f_Query.SavePhoneAttribute(TAG, f_CityCode, f_PhoneNumber);
  end;
//#UC END# *4A54B674018C_4A54B2EB00FFset_impl*
end;//TatNewConsultation.pm_SetCityCode

procedure TatNewConsultation.pm_SetPhoneNumber(const aValue: AnsiString);
//#UC START# *4A54B68C024F_4A54B2EB00FFset_var*
  const
    TAG= 'AT_USER_PHONE';
//#UC END# *4A54B68C024F_4A54B2EB00FFset_var*
begin
//#UC START# *4A54B68C024F_4A54B2EB00FFset_impl*
  if (f_PhoneNumber <> aValue) then
  begin
    f_PhoneNumber := aValue;
    if (f_PhoneNumber <> '') then
      f_Query.SavePhoneAttribute(TAG, f_CityCode, f_PhoneNumber);
  end;
//#UC END# *4A54B68C024F_4A54B2EB00FFset_impl*
end;//TatNewConsultation.pm_SetPhoneNumber

procedure TatNewConsultation.pm_SetQuestionText(const aValue: AnsiString);
//#UC START# *4A54B6AE0370_4A54B2EB00FFset_var*
  const
    TAG = 'AT_LAW_SUPPORT_TEXT';
//#UC END# *4A54B6AE0370_4A54B2EB00FFset_var*
begin
//#UC START# *4A54B6AE0370_4A54B2EB00FFset_impl*
  if (f_QuestionText <> aValue) then
  begin
    f_QuestionText := aValue;
    f_Query.ClearAttribute(TAG);
    if (f_QuestionText <> '') then
      f_Query.SaveContextAttribute(TAG, QLO_OR, f_QuestionText);
  end;
//#UC END# *4A54B6AE0370_4A54B2EB00FFset_impl*
end;//TatNewConsultation.pm_SetQuestionText

procedure TatNewConsultation.pm_SetEMail(const aValue: AnsiString);
//#UC START# *4A54C04003B8_4A54B2EB00FFset_var*
  const
    TAG = 'AT_EMAIL';
//#UC END# *4A54C04003B8_4A54B2EB00FFset_var*
begin
//#UC START# *4A54C04003B8_4A54B2EB00FFset_impl*
  if (f_EMail <> aValue) then
  begin
    f_EMail := aValue;
    f_Query.ClearAttribute(TAG);
    if (f_EMail <> '') then
      f_Query.SaveContextAttribute(TAG, QLO_AND, f_EMail);
  end;
//#UC END# *4A54C04003B8_4A54B2EB00FFset_impl*
end;//TatNewConsultation.pm_SetEMail

constructor TatNewConsultation.Create;
//#UC START# *4A54B41C00D9_4A54B2EB00FF_var*
//#UC END# *4A54B41C00D9_4A54B2EB00FF_var*
begin
//#UC START# *4A54B41C00D9_4A54B2EB00FF_impl*
  inherited;
  f_Query := TatQuery.CreateByType(QT_HANDYCRAFT_CONSULT);
  Assert(f_Query <> nil, 'f_Query <> nil');
  f_QuestionText := '';
  f_UserName := '';
  f_PhoneNumber := '';
  f_CityCode := '';
//#UC END# *4A54B41C00D9_4A54B2EB00FF_impl*
end;//TatNewConsultation.Create

procedure TatNewConsultation.Send;
//#UC START# *4A54B5E90298_4A54B2EB00FF_var*
//#UC END# *4A54B5E90298_4A54B2EB00FF_var*
begin
//#UC START# *4A54B5E90298_4A54B2EB00FF_impl*
  f_Query.Query.SendQuery;
//#UC END# *4A54B5E90298_4A54B2EB00FF_impl*
end;//TatNewConsultation.Send

destructor TatNewConsultation.Destroy;
//#UC START# *48077504027E_4A54B2EB00FF_var*
//#UC END# *48077504027E_4A54B2EB00FF_var*
begin
//#UC START# *48077504027E_4A54B2EB00FF_impl*
  FreeAndNil(f_Query);
  inherited;
//#UC END# *48077504027E_4A54B2EB00FF_impl*
end;//TatNewConsultation.Destroy

end.
