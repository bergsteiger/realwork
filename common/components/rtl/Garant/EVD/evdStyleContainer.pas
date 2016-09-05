unit evdStyleContainer;
 {* описание базового контейнера стилей }

// Модуль: "w:\common\components\rtl\Garant\EVD\evdStyleContainer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevdStyleContainer" MUID: (4860B1230094)

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , k2DictionaryEx
 , l3Variant
 , k2Base
 , evdStyles
;

type
 _ItemType_ = Tl3Variant;
  {* Это вообще-то хак, но без этого не находится тип элемента }

 TevStandardStylesArray = array [TevStandardCachedStyle] of Tl3Tag;

 _StringType_ = Tl3Variant;
 TevdStyleContainer = class(Tk2DictionaryEx)
  {* описание базового контейнера стилей }
  private
   f_AutoNum: Integer;
   f_Styles: TevStandardStylesArray;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DirectInsert(anIndex: Integer;
    const aData: _ItemType_); override;
    {* Непосредственное удаление элемента. Без проверки валидности индекса. }
   function pm_GetDRByID(anID: Integer): _StringType_; override;
   function ControlFindByID: Boolean; override;
  public
   class procedure CheckValueTable(aType: Tk2Type);
    {* Проверяет таблицу значений. }
 end;//TevdStyleContainer

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Types
 , k2Tags
 //#UC START# *4860B1230094impl_uses*
 //#UC END# *4860B1230094impl_uses*
;

class procedure TevdStyleContainer.CheckValueTable(aType: Tk2Type);
 {* Проверяет таблицу значений. }
//#UC START# *4860B7AA025D_4860B1230094_var*
var
 VT : TevdStyleContainer;
//#UC END# *4860B7AA025D_4860B1230094_var*
begin
//#UC START# *4860B7AA025D_4860B1230094_impl*
 if (aType.ValueTable = nil) then
 begin
  VT := TevdStyleContainer.Create(aType);
  try
   VT.Duplicates := l3_dupAssign;
   aType.ValueTable := VT;
  finally
   FreeAndNil(VT); 
  end;{try..finally}
 end;//aType.ValueTable = nil
//#UC END# *4860B7AA025D_4860B1230094_impl*
end;//TevdStyleContainer.CheckValueTable

procedure TevdStyleContainer.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4860B1230094_var*
//#UC END# *479731C50290_4860B1230094_var*
begin
//#UC START# *479731C50290_4860B1230094_impl*
 Finalize(f_Styles);
 inherited;
//#UC END# *479731C50290_4860B1230094_impl*
end;//TevdStyleContainer.Cleanup

procedure TevdStyleContainer.DirectInsert(anIndex: Integer;
 const aData: _ItemType_);
 {* Непосредственное удаление элемента. Без проверки валидности индекса. }
//#UC START# *47B49EC50034_4860B1230094_var*
//#UC END# *47B49EC50034_4860B1230094_var*
begin
//#UC START# *47B49EC50034_4860B1230094_impl*
 if (aData.IntA[k2_tiHandle] = 0) then
 begin
  Inc(f_AutoNum);
  aData.IntA[k2_tiHandle] := f_AutoNum;
 end;//S.Alias >= 0
 if (aData.IntA[k2_tiHandle] = ev_saTxtNormalANSI) then
  Default := aData;
 inherited;
//#UC END# *47B49EC50034_4860B1230094_impl*
end;//TevdStyleContainer.DirectInsert

function TevdStyleContainer.pm_GetDRByID(anID: Integer): _StringType_;
//#UC START# *4B8BBA220048_4860B1230094get_var*

 function DoGetDRByID(anID: Integer): Tl3Tag;
 begin//DoGetDRByID
  Result := inherited pm_GetDRByID(anID);
  if (Result = nil) OR
     (Result.IntA[k2_tiHandle] <> anID) then
  begin
   Result := AtomType.MakeTag.AsObject;
   Result.IntA[k2_tiHandle] := anID;
   Result.StrA[k2_tiName] := 'Элемент №' + IntToStr(anID);
   Result.BoolA[k2_tiVisibleToUser] := False; // Он не нужен пользователю! См. http://mdp.garant.ru/pages/viewpage.action?pageId=259890927&focusedCommentId=259890934#comment-259890934
   Self.Add(Result);
   Assert(Result.IntA[k2_tiHandle] = anID);
   f_LastRec.rTag := Result;
   f_LastRec.rID := anID;
  end;//Result = nil..
 end;//DoGetDRByID

//#UC END# *4B8BBA220048_4860B1230094get_var*
begin
//#UC START# *4B8BBA220048_4860B1230094get_impl*
 if (anID >= Low(TevStandardCachedStyle)) AND
    (anID <= High(TevStandardCachedStyle)) then
 begin
  Result := f_Styles[anID];
  if (Result = nil) then
  begin
   Result := DoGetDRByID(anID);
   f_Styles[anID] := Result;
  end;//Result = nil
 end//anID >= Low(TevStandardCachedStyle)..
 else
  Result := DoGetDRByID(anID);
//#UC END# *4B8BBA220048_4860B1230094get_impl*
end;//TevdStyleContainer.pm_GetDRByID

function TevdStyleContainer.ControlFindByID: Boolean;
//#UC START# *4B8BBAA800AB_4860B1230094_var*
//#UC END# *4B8BBAA800AB_4860B1230094_var*
begin
//#UC START# *4B8BBAA800AB_4860B1230094_impl*
 Result := true;
//#UC END# *4B8BBAA800AB_4860B1230094_impl*
end;//TevdStyleContainer.ControlFindByID

end.
