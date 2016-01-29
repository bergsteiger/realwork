{$IfNDef Text_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Text.imp.pas"
// Начат: 14.08.2009 14:40
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Base Operations::View::Base Forms::Text
//
// Обработка текста
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define Text_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _Text_ = {abstract form} class(_Text_Parent_)
  {* Обработка текста }
 protected
 // property methods
   function pm_GetSettings: IafwSettings;
 protected
 // protected methods
   function GetTopParaID: IeePara;
     {* Возвращает верхний нумерованный параграф на видимой странице }
   function GetParaForPositionning(aSearchDown: Boolean = true): IeeLeafPara;
     {* Возвращает текущий параграф, если он виден или первый видимый на экране }
 protected
 // protected properties
   property Settings: IafwSettings
     read pm_GetSettings;
 end;//_Text_
{$Else}

 _Text_ = _Text_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else Text_imp}

{$If not defined(Admin) AND not defined(Monitorings)}

// start class _Text_

function _Text_.GetTopParaID: IeePara;
//#UC START# *4A854E340357_4A853E260311_var*
//#UC END# *4A854E340357_4A853E260311_var*
var
 l_TopCursor : InevBasePoint;
begin
//#UC START# *4A854E340357_4A853E260311_impl*
 if _Instance_R_(Self).Text.GetTopCursor(l_TopCursor) then
  try
   Result := TeePara.Make(l_TopCursor.MostInner.Obj.AsPara.AsObject, _Instance_R_(Self).Text As IeeDocumentEx);
  finally
   l_TopCursor := nil;
  end//try..finally
 else
  Result := nil;
//#UC END# *4A854E340357_4A853E260311_impl*
end;//_Text_.GetTopParaID

function _Text_.GetParaForPositionning(aSearchDown: Boolean = true): IeeLeafPara;
//#UC START# *4A854F880181_4A853E260311_var*
//#UC END# *4A854F880181_4A853E260311_var*
var
 l_Para : IeePara;
begin
//#UC START# *4A854F880181_4A853E260311_impl*
 l_Para := nil;
 with _Instance_R_(Self).Text do
 begin
  if (View <> nil) then
  begin
   if View.IsCaretVisible then
    l_Para := TeePara.Make(Selection.Cursor.MostInner.Obj^.AsObject, _Instance_R_(Self).Text)
   else
    l_Para := GetTopParaID;
  end;//View <> nil
 end;//with Text
 Result := eeFindNumberedPara(l_Para,
                              _Instance_R_(Self).Text as IeeDocumentEx,
                              aSearchDown);
//#UC END# *4A854F880181_4A853E260311_impl*
end;//_Text_.GetParaForPositionning

function _Text_.pm_GetSettings: IafwSettings;
//#UC START# *4DF1F6B3027A_4A853E260311get_var*
//#UC END# *4DF1F6B3027A_4A853E260311get_var*
begin
//#UC START# *4DF1F6B3027A_4A853E260311get_impl*
 Result := afw.Application.Settings;
//#UC END# *4DF1F6B3027A_4A853E260311get_impl*
end;//_Text_.pm_GetSettings

{$IfEnd} //not Admin AND not Monitorings

{$EndIf Text_imp}
