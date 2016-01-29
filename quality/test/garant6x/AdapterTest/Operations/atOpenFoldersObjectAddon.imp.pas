{$IfNDef atOpenFoldersObjectAddon_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/Operations/atOpenFoldersObjectAddon.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> garant6x_test::AdapterTest::Operations::atOpenFoldersObjectAddon
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define atOpenFoldersObjectAddon_imp}
const
  { ParametersNames }
 PN_IS_EMULATE_OPENING : AnsiString = 'is_emulate_opening';

type
 _atOpenFoldersObjectAddon_ = {mixin} class(_atOpenFoldersObjectAddon_Parent_, IatFoldersNodeCallback)
 protected
 // realized methods
   procedure ExecuteSelf; override;
   procedure OnFoldersNode(const aFoldersNode: IFoldersNode);
 protected
 // overridden protected methods
   procedure InitParamList; override;
 protected
 // protected fields
   f_IsEmulateOpening : Boolean;
 protected
 // protected methods
   procedure OnFoldersObject(const aFoldersObject: _ObjectType_); virtual; abstract;
 end;//_atOpenFoldersObjectAddon_

{$Else atOpenFoldersObjectAddon_imp}

// start class _atOpenFoldersObjectAddon_

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

{$EndIf atOpenFoldersObjectAddon_imp}
