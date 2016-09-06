unit atDocumentUnderControlOperation;

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atDocumentUnderControlOperation.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatDocumentUnderControlOperation" MUID: (504F1A8B004B)

interface

uses
 l3IntfUses
 , atOperationBase
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
   procedure ExecuteSelf; override;
   procedure InitParamList; override;
 end;//TatDocumentUnderControlOperation

implementation

uses
 l3ImplUses
 , SysUtils
 , UnderControlUnit
 , atLogger
 , DocumentUnit
 , atControlStatusConverter
 , TypInfo
 , l3Base
 //#UC START# *504F1A8B004Bimpl_uses*
 //#UC END# *504F1A8B004Bimpl_uses*
;

type
 _EnumType_ = OpType;
 {$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}
 TatOpTypeConverter = class(_atEnumConverter_)
  public
   class function Instance: TatOpTypeConverter;
    {* Метод получения экземпляра синглетона TatOpTypeConverter }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TatOpTypeConverter

var g_TatOpTypeConverter: TatOpTypeConverter = nil;
 {* Экземпляр синглетона TatOpTypeConverter }

procedure TatOpTypeConverterFree;
 {* Метод освобождения экземпляра синглетона TatOpTypeConverter }
begin
 l3Free(g_TatOpTypeConverter);
end;//TatOpTypeConverterFree

{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}

class function TatOpTypeConverter.Instance: TatOpTypeConverter;
 {* Метод получения экземпляра синглетона TatOpTypeConverter }
begin
 if (g_TatOpTypeConverter = nil) then
 begin
  l3System.AddExitProc(TatOpTypeConverterFree);
  g_TatOpTypeConverter := Create;
 end;
 Result := g_TatOpTypeConverter;
end;//TatOpTypeConverter.Instance

class function TatOpTypeConverter.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
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
      Logger.Error('Неизвестная операция: %s', [l_OpTypeStr]);
      Exit;
    end;
  end;

  l_Doc := ExecutionContext.UserWorkContext.CurrDoc;
  if l_Doc = nil then
  begin
    Logger.Error('Нет открытого документа');
    Exit;
  end;

  l_Controllable := l_Doc as IControllable;
  if l_Controllable.GetControlled then
    Logger.Info('Обрабатываем документ %d, он на контроле и его статус "%s"',
      [l_Doc.GetInternalId, TatControlStatusConverter.Instance.ToValues(l_Controllable.GetControlStatus, '; ')])
  else
    Logger.Info('Обрабатываем документ %d, он не на контроле', [l_Doc.GetInternalId]);

  with l_Controllable do
  begin
    case l_OpType of
      SET_CONTROL:
        begin
          if NOT GetCanSetToControl then
          begin
            Logger.Error('Нельзя ставить на контроль!');
            Exit;
          end;
          Logger.Info('Ставии документ на контроль');
          if NOT GetControlled then SetControlled(true);
        end;
      UNSET_CONTROL:
        begin
          Logger.Info('Снимаем документ с контроля');
          if GetControlled then SetControlled(false);
        end;
      INVERT_CONTROL:
        begin
          if (NOT GetControlled) AND (NOT GetCanSetToControl) then
          begin
            Logger.Error('Нельзя ставить на контроль!');
            Exit;
          end;
          Logger.Info('Изменяем признак контроля на противоположный');          
          SetControlled(NOT GetControlled);
        end;
      RESET_CONTROL_STATUS:
        begin
          Logger.Info('Сбрасываем статус измененности');
          if GetControlled then
            ResetControlStatus;
        end;
    end;
    //
    if GetControlled then
      l_Str := ''
    else
      l_Str := 'не ';
    Logger.Info('Документ в состоянии "%s" и его статус "%s"',
      [l_Str + 'на контроле', TatControlStatusConverter.Instance.ToValues(GetControlStatus, '; ')]);
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
    Add( ParamType.Create('op_type', 'Что делать') );
  end;
//#UC END# *48089F3701B4_504F1A8B004B_impl*
end;//TatDocumentUnderControlOperation.InitParamList

initialization
{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}


end.
