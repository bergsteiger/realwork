{$IfNDef atHasStringParamAddOn_imp}

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atHasStringParamAddOn.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "atHasStringParamAddOn" MUID: (5036475001FC)
// Имя типа: "_atHasStringParamAddOn_"

{$Define atHasStringParamAddOn_imp}

 _atHasStringParamAddOn_ = class(_atHasStringParamAddOn_Parent_)
  private
   f_Strings: TatStringProvider;
  private
   function InitStringList: Boolean; virtual;
  protected
   function OnString(const aString: AnsiString): Boolean; virtual; abstract;
   procedure ExecuteSelf; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitParamList; override;
 end;//_atHasStringParamAddOn_

{$Else atHasStringParamAddOn_imp}

{$IfNDef atHasStringParamAddOn_imp_impl}

{$Define atHasStringParamAddOn_imp_impl}

function _atHasStringParamAddOn_.InitStringList: Boolean;
//#UC START# *5036545B039D_5036475001FC_var*
  var
    l_SyncFile, l_StrFile : String;
//#UC END# *5036545B039D_5036475001FC_var*
begin
//#UC START# *5036545B039D_5036475001FC_impl*
  Result := true;
  //
  l_SyncFile := Parameters['str.sync_file'].AsStr;
  l_StrFile := Parameters['str.file'].AsStr;
  //
  if NOT Assigned(f_Strings) then
  begin
    if l_StrFile = '' then
      f_Strings := TatConstStringProvider.Create(Parameters['str.value'].AsStr)
    else if l_SyncFile = '' then
      f_Strings := TatStringFileReader.Create(l_StrFile)
    else
      f_Strings := TatSyncedStringFileReader.Create(l_StrFile, l_SyncFile);
    //
    f_Strings.Looped := Parameters['str.is_looped'].AsBool;
    f_Strings.Random := Parameters['str.is_random'].AsBool;
  end
  else
    if l_SyncFile = '' then
      f_Strings.Reset;
//#UC END# *5036545B039D_5036475001FC_impl*
end;//_atHasStringParamAddOn_.InitStringList

procedure _atHasStringParamAddOn_.ExecuteSelf;
//#UC START# *48089F460352_5036475001FC_var*
  var
    l_Str : String;
    i, l_MaxCount : Integer;
//#UC END# *48089F460352_5036475001FC_var*
begin
//#UC START# *48089F460352_5036475001FC_impl*
  inherited;
  //
  l_MaxCount := Parameters['str.max_count'].AsInt;
  //
  i := 0;
  if InitStringList then
    while f_Strings.AcquireNext(l_Str) AND ((l_MaxCount = -1) OR (i < l_MaxCount))do
      if OnString(l_Str) then
        Inc(i)
      else
        break;
//#UC END# *48089F460352_5036475001FC_impl*
end;//_atHasStringParamAddOn_.ExecuteSelf

procedure _atHasStringParamAddOn_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5036475001FC_var*
//#UC END# *479731C50290_5036475001FC_var*
begin
//#UC START# *479731C50290_5036475001FC_impl*
  FreeAndNil(f_Strings);
  inherited;
//#UC END# *479731C50290_5036475001FC_impl*
end;//_atHasStringParamAddOn_.Cleanup

procedure _atHasStringParamAddOn_.InitParamList;
//#UC START# *48089F3701B4_5036475001FC_var*
//#UC END# *48089F3701B4_5036475001FC_var*
begin
//#UC START# *48089F3701B4_5036475001FC_impl*
  inherited;
  with f_ParamList do
  begin
    Add( ParamType.Create('str.is_looped', 'Начинать сначала перебирать строки после окончания?', 'false'));
    Add( ParamType.Create('str.is_random', 'Выбирать строки в случайном порядке?', 'false'));
    Add( ParamType.Create('str.file', 'Путь к файлу со строками', ''));
    Add( ParamType.Create('str.max_count', 'Обрабатывать не более заданного количества строк', '-1'));
    Add( ParamType.Create('str.sync_file', 'Путь к файлу для синхронизации', ''));
    Add( ParamType.Create('str.value', 'Явно заданная строка', ''));
  end;
//#UC END# *48089F3701B4_5036475001FC_impl*
end;//_atHasStringParamAddOn_.InitParamList

{$EndIf atHasStringParamAddOn_imp_impl}

{$EndIf atHasStringParamAddOn_imp}

