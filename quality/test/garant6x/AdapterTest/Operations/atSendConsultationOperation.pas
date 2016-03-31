unit atSendConsultationOperation;
 {* ������� � �������� ����� ������������ }

// ������: "w:\quality\test\garant6x\AdapterTest\Operations\atSendConsultationOperation.pas"
// ���������: "SimpleClass"
// ������� ������: "TatSendConsultationOperation" MUID: (4A54BDC0001E)

interface

uses
 l3IntfUses
 , atOperationBase
;

type
 TatSendConsultationOperation = class(TatOperationBase)
  {* ������� � �������� ����� ������������ }
  protected
   procedure ExecuteSelf; override;
   procedure InitParamList; override;
 end;//TatSendConsultationOperation

implementation

uses
 l3ImplUses
 , atNewConsultation
 , atLogger
 , SysUtils
 , Math
 , atCommon
;

procedure TatSendConsultationOperation.ExecuteSelf;
//#UC START# *48089F460352_4A54BDC0001E_var*
  var
    l_QuestionText, l_UserName, l_CityCode, l_PhoneNumber, l_EMail : String;
    l_QTextMin, l_QTextMax : Integer;
    l_NewConsultation : TatNewConsultation;
//#UC END# *48089F460352_4A54BDC0001E_var*
begin
//#UC START# *48089F460352_4A54BDC0001E_impl*
  l_QuestionText := Parameters['question_text'].AsStr;
  l_UserName := Parameters['user_name'].AsStr;
  l_CityCode := Parameters['city_code'].AsStr;
  l_PhoneNumber := Parameters['phone_number'].AsStr;
  l_EMail := Parameters['email'].AsStr;
  l_QTextMin := Parameters['question_text_min_size'].AsInt;
  l_QTextMax := Parameters['question_text_max_size'].AsInt;
  //
  if l_UserName = '' then l_UserName := ExecutionContext.F_LoginData.Login;
  if l_CityCode = '' then l_CityCode := IntToStr(RandomRange(100, 99999));
  if l_PhoneNumber = '' then l_PhoneNumber := IntToStr(RandomRange(10000, 9999999));
  if l_EMail = '' then l_EMail := GetRandomStr(8) + '@garant.ru';
  if l_QuestionText = '' then l_QuestionText := GetRandomStr(RandomRange(l_QTextMin, l_QTextMax));
  //
  Logger.Info('�������� ������������. ��� ������������: %s, ��� ������: %s, �������: %s, e-mail: %s, ����� �������: %d',
    [l_UserName, l_CityCode, l_PhoneNumber, l_EMail, Length(l_QuestionText)]);
  l_NewConsultation := TatNewConsultation.Create;
  try
    with l_NewConsultation do
    begin
      UserName := l_UserName;
      CityCode := l_CityCode;
      PhoneNumber := l_PhoneNumber;
      EMail := l_EMail;
      QuestionText := l_QuestionText;
      Send;
    end;
    Logger.Info('������������ �������');
  finally
    FreeAndNil(l_NewConsultation);
  end;
//#UC END# *48089F460352_4A54BDC0001E_impl*
end;//TatSendConsultationOperation.ExecuteSelf

procedure TatSendConsultationOperation.InitParamList;
//#UC START# *48089F3701B4_4A54BDC0001E_var*
//#UC END# *48089F3701B4_4A54BDC0001E_var*
begin
//#UC START# *48089F3701B4_4A54BDC0001E_impl*
  inherited;
  with f_ParamList do
  begin
    Add( ParamType.Create('question_text', '����� �������', '') );
    Add( ParamType.Create('user_name', '��� ������������', '') );
    Add( ParamType.Create('city_code', '��� ������', '') );
    Add( ParamType.Create('phone_number', '����� ��������', '') );
    Add( ParamType.Create('email', '��. �����', '') );
    Add( ParamType.Create('question_text_min_size', '����������� ������ ������', '0') );
    Add( ParamType.Create('question_text_max_size', '������������ ������ ������', '1024') );
  end;
//#UC END# *48089F3701B4_4A54BDC0001E_impl*
end;//TatSendConsultationOperation.InitParamList

end.
