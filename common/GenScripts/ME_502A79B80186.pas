{$IfNDef atExecutesQueryAddOn_imp}

// ћодуль: "w:\quality\test\garant6x\AdapterTest\Operations\atExecutesQueryAddOn.imp.pas"
// —тереотип: "Impurity"
// Ёлемент модели: "atExecutesQueryAddOn" MUID: (502A79B80186)
// »м€ типа: "_atExecutesQueryAddOn_"

{$Define atExecutesQueryAddOn_imp}

 _atExecutesQueryAddOn_ = class(_atExecutesQueryAddOn_Parent_)
  protected
   function ExecuteQuery(const anQuery: TatQuery): Boolean; overload; virtual;
   function ExecuteQuery(const anQuery: IQuery): Boolean; overload; virtual;
 end;//_atExecutesQueryAddOn_

{$Else atExecutesQueryAddOn_imp}

{$IfNDef atExecutesQueryAddOn_imp_impl}

{$Define atExecutesQueryAddOn_imp_impl}

function _atExecutesQueryAddOn_.ExecuteQuery(const anQuery: TatQuery): Boolean;
//#UC START# *502A7A0A03E7_502A79B80186_var*
//#UC END# *502A7A0A03E7_502A79B80186_var*
begin
//#UC START# *502A7A0A03E7_502A79B80186_impl*
  Result := false;
  //
  if anQuery.Name <> '' then
    Logger.Info('¬ыполн€ем запрос с именем "%s"', [anQuery.Name]);
  //  
  with TatSearchHelper.Create(anQuery.Use) do // .Use потому что известно, что TatSearchHelper становитс€ owner'ом запроса и удалит его, а это не нужно, т.к. здесь неизвестно кто создал запрос и что еще планирует с ним делать
  try
    if ExecuteAndBuildList then
    begin
      ExecutionContext.UserWorkContext.AddListToHistory(List);
      Result := true;
    end;
  finally
    Free;
  end;
//#UC END# *502A7A0A03E7_502A79B80186_impl*
end;//_atExecutesQueryAddOn_.ExecuteQuery

function _atExecutesQueryAddOn_.ExecuteQuery(const anQuery: IQuery): Boolean;
//#UC START# *502A7A4701EC_502A79B80186_var*
  var
    l_Query : TatQuery;
//#UC END# *502A7A4701EC_502A79B80186_var*
begin
//#UC START# *502A7A4701EC_502A79B80186_impl*
  l_Query := TatQuery.Create(anQuery);
  try
    Result := ExecuteQuery(l_Query);
  finally
    FreeAndNil(l_Query);
  end;
//#UC END# *502A7A4701EC_502A79B80186_impl*
end;//_atExecutesQueryAddOn_.ExecuteQuery

{$EndIf atExecutesQueryAddOn_imp_impl}

{$EndIf atExecutesQueryAddOn_imp}

