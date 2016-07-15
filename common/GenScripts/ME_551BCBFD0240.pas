unit l3FormatObjectInfoHelper;

// Модуль: "w:\common\components\rtl\Garant\L3\l3FormatObjectInfoHelper.pas"
// Стереотип: "Service"
// Элемент модели: "Tl3FormatObjectInfoHelper" MUID: (551BCBFD0240)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

{$If NOT Defined(NoVCL)}
uses
 l3IntfUses
 , l3ProtoObject
 , l3RTTI
;

 (*
 Ml3FormatObjectInfoHelper = interface
  {* Контракт сервиса Tl3FormatObjectInfoHelper }
  function Format(anObject: TObject;
   aShortInfo: Boolean;
   anObjectPropFound: TRTTIInfoObjectPropertyFoundCallBack): AnsiString;
 end;//Ml3FormatObjectInfoHelper
 *)

type
 Il3FormatObjectInfoHelper = interface
  {* Интерфейс сервиса Tl3FormatObjectInfoHelper }
  function Format(anObject: TObject;
   aShortInfo: Boolean;
   anObjectPropFound: TRTTIInfoObjectPropertyFoundCallBack): AnsiString;
 end;//Il3FormatObjectInfoHelper

 Tl3FormatObjectInfoHelper = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3FormatObjectInfoHelper;
    {* Внешняя реализация сервиса Il3FormatObjectInfoHelper }
  protected
   procedure pm_SetAlien(const aValue: Il3FormatObjectInfoHelper);
   procedure ClearFields; override;
  public
   function Format(anObject: TObject;
    aShortInfo: Boolean;
    anObjectPropFound: TRTTIInfoObjectPropertyFoundCallBack): AnsiString;
   class function Instance: Tl3FormatObjectInfoHelper;
    {* Метод получения экземпляра синглетона Tl3FormatObjectInfoHelper }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: Il3FormatObjectInfoHelper
    write pm_SetAlien;
    {* Внешняя реализация сервиса Il3FormatObjectInfoHelper }
 end;//Tl3FormatObjectInfoHelper
{$IfEnd} // NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoVCL)}
uses
 l3ImplUses
 , l3FormatActionInfoHelper
 , Controls
 , ActnList
 , TypInfo
 , l3HugeMessageDlgWithWikiHelper
 , SysUtils
 , l3Base
;

var g_Tl3FormatObjectInfoHelper: Tl3FormatObjectInfoHelper = nil;
 {* Экземпляр синглетона Tl3FormatObjectInfoHelper }

procedure Tl3FormatObjectInfoHelperFree;
 {* Метод освобождения экземпляра синглетона Tl3FormatObjectInfoHelper }
begin
 l3Free(g_Tl3FormatObjectInfoHelper);
end;//Tl3FormatObjectInfoHelperFree

procedure Tl3FormatObjectInfoHelper.pm_SetAlien(const aValue: Il3FormatObjectInfoHelper);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3FormatObjectInfoHelper.pm_SetAlien

function Tl3FormatObjectInfoHelper.Format(anObject: TObject;
 aShortInfo: Boolean;
 anObjectPropFound: TRTTIInfoObjectPropertyFoundCallBack): AnsiString;
//#UC START# *D4A861440DBF_551BCBFD0240_var*
 procedure lp_AddInfo(var theInfo: AnsiString;
  const aCaption: AnsiString;
  const aValue: AnsiString;
  aNewLine: Boolean = False);
 begin
  if Length(aValue) > 0 then
  begin
   if Length(theInfo) > 0 then
    if aNewLine
     then theInfo := theInfo + #13#10
     else theInfo := theInfo + ', ';
   theInfo := theInfo + aCaption + ':' + aValue;
  end;
 end;

 function lp_FormatLinkToObject(anObject: TObject): AnsiString;
 begin
  Result := '$' + IntToHex(Integer(anObject), 8);
  if Assigned(anObjectPropFound) then
   anObjectPropFound(anObject, Result)
  else
   Result := Tl3HugeMessageDlgWithWikiHelper.Instance.FormatLink(Result, IntToStr(Integer(anObject)));
 end;
 
var
 l_Control: TControl;
 l_ActionProp: TObject;
//#UC END# *D4A861440DBF_551BCBFD0240_var*
begin
//#UC START# *D4A861440DBF_551BCBFD0240_impl*
 if Assigned(f_Alien) then
  Result := f_Alien.Format(anObject, aShortInfo, anObjectPropFound)
 else
  Result := '';

 if Length(Result) = 0 then
  if aShortInfo then
  begin
   if Assigned(anObject) and (anObject is TControl) then
   begin
    l_Control := TControl(anObject);
    lp_AddInfo(Result, 'name', l_Control.Name);
    lp_AddInfo(Result, 'class', l_Control.ClassName);
    if Assigned(l_Control.Owner) then
     lp_AddInfo(Result, 'Owner', lp_FormatLinkToObject(l_Control.Owner), True);
    if Assigned(l_Control.Parent) then
     lp_AddInfo(Result, 'Parent', lp_FormatLinkToObject(l_Control.Parent), True);
    try
     l_ActionProp := GetObjectProp(l_Control, 'Action', TCustomAction);
    except
     l_ActionProp := nil;
    end;
    if Assigned(l_ActionProp) then
     lp_AddInfo(Result, 'Action', Tl3FormatActionInfoHelper.Instance.Format(TCustomAction(l_ActionProp)), True);
   end;//Assigned(aControl)
  end
  else
   Result := L3FormatRTTIInfo(anObject, True, anObjectPropFound, Tl3HugeMessageDlgWithWikiHelper.Instance.CanUseWiki);
//#UC END# *D4A861440DBF_551BCBFD0240_impl*
end;//Tl3FormatObjectInfoHelper.Format

class function Tl3FormatObjectInfoHelper.Instance: Tl3FormatObjectInfoHelper;
 {* Метод получения экземпляра синглетона Tl3FormatObjectInfoHelper }
begin
 if (g_Tl3FormatObjectInfoHelper = nil) then
 begin
  l3System.AddExitProc(Tl3FormatObjectInfoHelperFree);
  g_Tl3FormatObjectInfoHelper := Create;
 end;
 Result := g_Tl3FormatObjectInfoHelper;
end;//Tl3FormatObjectInfoHelper.Instance

class function Tl3FormatObjectInfoHelper.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3FormatObjectInfoHelper <> nil;
end;//Tl3FormatObjectInfoHelper.Exists

procedure Tl3FormatObjectInfoHelper.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3FormatObjectInfoHelper.ClearFields
{$IfEnd} // NOT Defined(NoVCL)

end.
