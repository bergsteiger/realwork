unit evControlsBlockCursor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evControlsBlockCursor.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParaList Cursors::TevControlsBlockCursor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evUseVisibleCursors)}
uses
  evQueryCardInt,
  evDocumentPartCursor,
  l3Core,
  nevTools
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}
type
 TevControlsBlockCursor = class(TevDocumentPartCursor)
 protected
 // overridden protected methods
   function DoProcessMessage(const aView: InevControlView;
    var aMessage: TMessage;
    aTime: Cardinal): Boolean; override;
   procedure AfterCollapsed(const aView: InevControlView); override;
   function IsShowingDocumentParts(const aView: InevControlView): Boolean; override;
 protected
 // protected methods
   function GetControl: IevQueryGroup;
     {* Получить контрол по ссылке }
 end;//TevControlsBlockCursor
{$IfEnd} //evUseVisibleCursors

implementation

{$If defined(evUseVisibleCursors)}
uses
  OvcCmd,
  OvcConst,
  k2Tags,
  Windows
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}

// start class TevControlsBlockCursor

function TevControlsBlockCursor.GetControl: IevQueryGroup;
//#UC START# *4A40E33E0315_4A40E3070396_var*
//#UC END# *4A40E33E0315_4A40E3070396_var*
begin
//#UC START# *4A40E33E0315_4A40E3070396_impl*
 GetRedirect.QT(IevQueryGroup, Result);
//#UC END# *4A40E33E0315_4A40E3070396_impl*
end;//TevControlsBlockCursor.GetControl

function TevControlsBlockCursor.DoProcessMessage(const aView: InevControlView;
  var aMessage: TMessage;
  aTime: Cardinal): Boolean;
//#UC START# *49E343F60057_4A40E3070396_var*
var
 l_Cmd : Word;
//#UC END# *49E343F60057_4A40E3070396_var*
begin
//#UC START# *49E343F60057_4A40E3070396_impl*
 Result := False; 
 l_Cmd := aView.Control.CommandProcessor.TranslateUsing(ovcListCommands, aMessage, aTime);          
 Case l_Cmd of
  ccShortCut :
   begin
    if aMessage.WParam = VK_SUBTRACT then
    begin
     if not Self.HasInner then
      ExpandOrCollapse(aView);
    end;
    Result := True;
   end;
  ccDel:
   Result := GetRedirect.BoolA[k2_tiCollapsed]; //Лучше вырубить!
  ccActionItem :
  begin
   if not Self.HasInner then
   begin
    ExpandOrCollapse(aView);
    Result := true;
   end;//not Self.HasInner
  end;
 end;//Case l_Cmd
 if not Result then
  Result := inherited DoProcessMessage(aView, aMessage, aTime); 
//#UC END# *49E343F60057_4A40E3070396_impl*
end;//TevControlsBlockCursor.DoProcessMessage

procedure TevControlsBlockCursor.AfterCollapsed(const aView: InevControlView);
//#UC START# *4A3FA3EB01D5_4A40E3070396_var*
var
 l_Control : IevQueryGroup;
//#UC END# *4A3FA3EB01D5_4A40E3070396_var*
begin
//#UC START# *4A3FA3EB01D5_4A40E3070396_impl*
 l_Control := GetControl;
 if l_Control <> nil then
  l_Control.AfterCollapsed;      
//#UC END# *4A3FA3EB01D5_4A40E3070396_impl*
end;//TevControlsBlockCursor.AfterCollapsed

function TevControlsBlockCursor.IsShowingDocumentParts(const aView: InevControlView): Boolean;
//#UC START# *4A3FA3FA0033_4A40E3070396_var*
var
 l_Control : IevQueryGroup;
//#UC END# *4A3FA3FA0033_4A40E3070396_var*
begin
//#UC START# *4A3FA3FA0033_4A40E3070396_impl*
 l_Control := GetControl;
 if l_Control <> nil then 
  if l_Control.Expanded then
   Result := l_Control.CanCollapsed
  else
   Result := True
 else  
  Result := True;
//#UC END# *4A3FA3FA0033_4A40E3070396_impl*
end;//TevControlsBlockCursor.IsShowingDocumentParts

{$IfEnd} //evUseVisibleCursors

end.