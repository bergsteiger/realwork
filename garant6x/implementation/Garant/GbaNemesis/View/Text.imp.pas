{$IfNDef Text_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Text.imp.pas"
// Стереотип: "VCMForm"
// Элемент модели: "Text" MUID: (4A853E260311)
// Имя типа: "_Text_"

{$Define Text_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _Text_ = {abstract} class(_Text_Parent_)
  {* Обработка текста }
  protected
   function pm_GetSettings: IafwSettings;
   function GetTopParaID: IeePara;
    {* Возвращает верхний нумерованный параграф на видимой странице }
   function GetParaForPositionning(aSearchDown: Boolean = True): IeeLeafPara;
    {* Возвращает текущий параграф, если он виден или первый видимый на экране }
  protected
   property Settings: IafwSettings
    read pm_GetSettings;
 end;//_Text_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_Text_ = _Text_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else Text_imp}

{$IfNDef Text_imp_impl}

{$Define Text_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
function _Text_.pm_GetSettings: IafwSettings;
//#UC START# *4DF1F6B3027A_4A853E260311get_var*
//#UC END# *4DF1F6B3027A_4A853E260311get_var*
begin
//#UC START# *4DF1F6B3027A_4A853E260311get_impl*
 Result := afw.Application.Settings;
//#UC END# *4DF1F6B3027A_4A853E260311get_impl*
end;//_Text_.pm_GetSettings

function _Text_.GetTopParaID: IeePara;
 {* Возвращает верхний нумерованный параграф на видимой странице }
var l_TopCursor: InevBasePoint;
//#UC START# *4A854E340357_4A853E260311_var*
//#UC END# *4A854E340357_4A853E260311_var*
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

function _Text_.GetParaForPositionning(aSearchDown: Boolean = True): IeeLeafPara;
 {* Возвращает текущий параграф, если он виден или первый видимый на экране }
var l_Para: IeePara;
//#UC START# *4A854F880181_4A853E260311_var*
//#UC END# *4A854F880181_4A853E260311_var*
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf Text_imp_impl}

{$EndIf Text_imp}

