{$IfNDef atProcessNamedFoldersObjectOperation_imp}

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atProcessNamedFoldersObjectOperation.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "atProcessNamedFoldersObjectOperation" MUID: (484FA0FD0223)
// Имя типа: "_atProcessNamedFoldersObjectOperation_"

{$Define atProcessNamedFoldersObjectOperation_imp}

 {$Include w:\quality\test\garant6x\AdapterTest\Operations\atProcessFoldersObjectOperation.imp.pas}
 _atProcessNamedFoldersObjectOperation_ = {abstract} class(_atProcessFoldersObjectOperation_)
  protected
   procedure InitParamList; override;
   procedure InitMatcher; override;
 end;//_atProcessNamedFoldersObjectOperation_

{$Else atProcessNamedFoldersObjectOperation_imp}

{$IfNDef atProcessNamedFoldersObjectOperation_imp_impl}

{$Define atProcessNamedFoldersObjectOperation_imp_impl}

{$Include w:\quality\test\garant6x\AdapterTest\Operations\atProcessFoldersObjectOperation.imp.pas}

procedure _atProcessNamedFoldersObjectOperation_.InitParamList;
//#UC START# *48089F3701B4_484FA0FD0223_var*
//#UC END# *48089F3701B4_484FA0FD0223_var*
begin
//#UC START# *48089F3701B4_484FA0FD0223_impl*
  inherited;
  with f_ParamList do
  begin
    Add( ParamType.Create('object_name', 'Имя удаляемого объекта', '') );
    Add( ParamType.Create('is_regexp', 'Задано ли соответвие имени в виде регулярного выражения', 'false') );
  end;
//#UC END# *48089F3701B4_484FA0FD0223_impl*
end;//_atProcessNamedFoldersObjectOperation_.InitParamList

procedure _atProcessNamedFoldersObjectOperation_.InitMatcher;
//#UC START# *484FDD22003E_484FA0FD0223_var*
  var
    l_Name : String;
    l_IsRegExp : Boolean;
//#UC END# *484FDD22003E_484FA0FD0223_var*
begin
//#UC START# *484FDD22003E_484FA0FD0223_impl*
  inherited;
  // а здесь устанавливаем имя и т.д.
  l_Name := Parameters['object_name'].AsStr;
  l_IsRegExp := Parameters['is_regexp'].AsBool;
  //
  with (f_Matcher as IatNameMatcher) do
  begin
    // определяем, кк будем узнавать, нужно ли удалять рассматирваему ноду
    if l_Name = '' then
      MatchMethod := MM_ALL
    else if l_IsRegExp then
      MatchMethod := MM_REGEXP
    else
      MatchMethod := MM_COMPARE;
    // задаем имя
    Name := l_Name;
  end;
//#UC END# *484FDD22003E_484FA0FD0223_impl*
end;//_atProcessNamedFoldersObjectOperation_.InitMatcher

{$EndIf atProcessNamedFoldersObjectOperation_imp_impl}

{$EndIf atProcessNamedFoldersObjectOperation_imp}

