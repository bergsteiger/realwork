{$IfNDef atOpenFoldersObjectAddon_imp}

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atOpenFoldersObjectAddon.imp.pas"
// Стереотип: "Impurity"

{$Define atOpenFoldersObjectAddon_imp}

const
 PN_IS_EMULATE_OPENING: AnsiString = 'is_emulate_opening';

 _atOpenFoldersObjectAddon_ = class(_atOpenFoldersObjectAddon_Parent_, IatFoldersNodeCallback)
  protected
   f_IsEmulateOpening: Boolean;
  protected
   procedure OnFoldersObject(const aFoldersObject: _ObjectType_); virtual; abstract;
   procedure ExecuteSelf; override;
   procedure OnFoldersNode(const aFoldersNode: IFoldersNode);
   procedure InitParamList; override;
 end;//_atOpenFoldersObjectAddon_

{$Else atOpenFoldersObjectAddon_imp}

{$IfNDef atOpenFoldersObjectAddon_imp_impl}

{$Define atOpenFoldersObjectAddon_imp_impl}

procedure _atOpenFoldersObjectAddon_.ExecuteSelf;
//#UC START# *48089F460352_4FD0D1E00242_var*
//#UC END# *48089F460352_4FD0D1E00242_var*
begin
//#UC START# *48089F460352_4FD0D1E00242_impl*
  f_IsEmulateOpening := Parameters[PN_IS_EMULATE_OPENING].AsBool;
  //
  inherited;
//#UC END# *48089F460352_4FD0D1E00242_impl*
end;//_atOpenFoldersObjectAddon_.ExecuteSelf

procedure _atOpenFoldersObjectAddon_.OnFoldersNode(const aFoldersNode: IFoldersNode);
//#UC START# *4FCF8EE001D4_4FD0D1E00242_var*
  var
    l_Object : IUnknown;
//#UC END# *4FCF8EE001D4_4FD0D1E00242_var*
begin
//#UC START# *4FCF8EE001D4_4FD0D1E00242_impl*
  inherited;
  //

  try
    aFoldersNode.Open(l_Object);
  except
    on ECanNotFindData do
    begin
      Logger.Info('Не открывается объект типа %d с именем "%s"',
        [aFoldersNode.GetObjectType, TatNodeHelper.GetCaption(aFoldersNode)]);
      Exit;
    end;
  end;
  //
  if (l_Object <> nil) then
    OnFoldersObject(l_Object as _ObjectType_)
  else
    Raise Exception.Create('Не могу получить объект из папки!');
//#UC END# *4FCF8EE001D4_4FD0D1E00242_impl*
end;//_atOpenFoldersObjectAddon_.OnFoldersNode

procedure _atOpenFoldersObjectAddon_.InitParamList;
//#UC START# *48089F3701B4_4FD0D1E00242_var*
//#UC END# *48089F3701B4_4FD0D1E00242_var*
begin
//#UC START# *48089F3701B4_4FD0D1E00242_impl*
  inherited;
  with f_ParamList do
    Add( ParamType.Create(PN_IS_EMULATE_OPENING, 'Эмулировать ли открытие объекта?', 'true') );
//#UC END# *48089F3701B4_4FD0D1E00242_impl*
end;//_atOpenFoldersObjectAddon_.InitParamList

{$EndIf atOpenFoldersObjectAddon_imp_impl}

{$EndIf atOpenFoldersObjectAddon_imp}

