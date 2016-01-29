unit atDocumentUnderControlOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AdapterTest"
// ������: "w:/quality/test/garant6x/AdapterTest/Operations/atDocumentUnderControlOperation.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatDocumentUnderControlOperation
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

uses
  atOperationBase
  ;

type
 OpType = (
   SET_CONTROL
 , UNSET_CONTROL
 , INVERT_CONTROL
 , RESET_CONTROL_STATUS
 );//OpType

 TatDocumentUnderControlOperation = class(TatOperationBase)
 protected
 // realized methods
   procedure ExecuteSelf; override;
 protected
 // overridden protected methods
   procedure InitParamList; override;
 end;//TatDocumentUnderControlOperation

implementation

uses
  l3Base {a},
  TypInfo,
  SysUtils,
  UnderControlUnit,
  atLogger,
  DocumentUnit,
  atControlStatusConverter
  ;

type
  _EnumType_ = OpType;
 {$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}
  TatOpTypeConverter = class(_atEnumConverter_)
  public
  // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
  public
  // singleton factory method
    class function Instance: TatOpTypeConverter;
     {- ���������� ��������� ����������. }
  end;//TatOpTypeConverter


// start class TatOpTypeConverter

var g_TatOpTypeConverter : TatOpTypeConverter = nil;

procedure TatOpTypeConverterFree;
begin
 l3Free(g_TatOpTypeConverter);
end;

class function TatOpTypeConverter.Instance: TatOpTypeConverter;
begin
 if (g_TatOpTypeConverter = nil) then
 begin
  l3System.AddExitProc(TatOpTypeConverterFree);
  g_TatOpTypeConverter := Create;
 end;
 Result := g_TatOpTypeConverter;
end;


{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}

// start class TatOpTypeConverter

class function TatOpTypeConverter.Exists: Boolean;
 {-}
begin
 Result := g_TatOpTypeConverter <> nil;
end;//TatOpTypeConverter.Exists

procedure TatDocumentUnderControlOperation.ExecuteSelf;
//#UC START# *48089F460352_504F1A8B004B_var*
  var
    l_OpTypeStr, l_Str : String;
    l_OpType : OpType;
    l_Doc : IDocument;
    l_Controllable : IControllable;
//#UC END# *48089F460352_504F1A8B004B_var*
begin
//#UC START# *48089F460352_504F1A8B004B_impl*

  ExecutionContext.GblAdapterWorker.ControlManager.UpdateStatus(false);

  l_OpTypeStr := Parameters['op_type'].AsStr;
  try
    l_OpType := TatOpTypeConverter.Instance.ToValueCI(l_OpTypeStr);
  except
    on ex : EConvertError do
    begin
      Logger.Error('����������� ��������: %s', [l_OpTypeStr]);
      Exit;
    end;
  end;

  l_Doc := ExecutionContext.UserWorkContext.CurrDoc;
  if l_Doc = nil then
  begin
    Logger.Error('��� ��������� ���������');
    Exit;
  end;

  l_Controllable := l_Doc as IControllable;
  if l_Controllable.GetControlled then
    Logger.Info('������������ �������� %d, �� �� �������� � ��� ������ "%s"',
      [l_Doc.GetInternalId, TatControlStatusConverter.Instance.ToValues(l_Controllable.GetControlStatus, '; ')])
  else
    Logger.Info('������������ �������� %d, �� �� �� ��������', [l_Doc.GetInternalId]);

  with l_Controllable do
  begin
    case l_OpType of
      SET_CONTROL:
        begin
          if NOT GetCanSetToControl then
          begin
            Logger.Error('������ ������� �� ��������!');
            Exit;
          end;
          Logger.Info('������ �������� �� ��������');
          if NOT GetControlled then SetControlled(true);
        end;
      UNSET_CONTROL:
        begin
          Logger.Info('������� �������� � ��������');
          if GetControlled then SetControlled(false);
        end;
      INVERT_CONTROL:
        begin
          if (NOT GetControlled) AND (NOT GetCanSetToControl) then
          begin
            Logger.Error('������ ������� �� ��������!');
            Exit;
          end;
          Logger.Info('�������� ������� �������� �� ���������������');          
          SetControlled(NOT GetControlled);
        end;
      RESET_CONTROL_STATUS:
        begin
          Logger.Info('���������� ������ ������������');
          if GetControlled then
            ResetControlStatus;
        end;
    end;
    //
    if GetControlled then
      l_Str := ''
    else
      l_Str := '�� ';
    Logger.Info('�������� � ��������� "%s" � ��� ������ "%s"',
      [l_Str + '�� ��������', TatControlStatusConverter.Instance.ToValues(GetControlStatus, '; ')]);
  end;
//#UC END# *48089F460352_504F1A8B004B_impl*
end;//TatDocumentUnderControlOperation.ExecuteSelf

procedure TatDocumentUnderControlOperation.InitParamList;
//#UC START# *48089F3701B4_504F1A8B004B_var*
//#UC END# *48089F3701B4_504F1A8B004B_var*
begin
//#UC START# *48089F3701B4_504F1A8B004B_impl*
  inherited;
  with f_ParamList do
  begin
    Add( ParamType.Create('op_type', '��� ������') );
  end;
//#UC END# *48089F3701B4_504F1A8B004B_impl*
end;//TatDocumentUnderControlOperation.InitParamList

end.