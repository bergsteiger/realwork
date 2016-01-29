unit bsOpenListInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/List/bsOpenListInfo.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Business::List::TbsOpenListInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  ListInterfaces,
  bsBase,
  PrimPrimListInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TbsOpenListInfo = class(TbsBase)
 private
 // private fields
   f_Data : IUnknown;
   f_LinkType : TbsLinkType;
    {* Поле для свойства LinkType}
 private
 // private methods
   procedure Init(const aList: IdeList);
 protected
 // property methods
   function pm_GetData: IUnknown;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aList: IdeList); reintroduce;
 public
 // public properties
   property Data: IUnknown
     read pm_GetData;
     {* данные необходимые для инициализации сборки }
   property LinkType: TbsLinkType
     read f_LinkType;
     {* тип ссылки }
 end;//TbsOpenListInfo
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  afwFacade,
  nsConst,
  bsUtils,
  DynamicTreeUnit,
  bsTypes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TbsOpenListInfo

procedure TbsOpenListInfo.Init(const aList: IdeList);
//#UC START# *4DF217A402DE_4AA4D8A6012B_var*
var
 l_Root: INodeBase;

 procedure lpOpenFirstDoc;
 var
  l_Node: INodeBase;
 begin
  f_LinkType := ltDocument;
  l_Root.GetFirstChild(l_Node);
  try
   f_Data := bsDocInfoMake(l_Node, aList.List);
  finally
   l_Node := nil;
  end;
 end;//lpOpenFirstDoc

 function lpIsOneDoc: Boolean;
 var
  l_Node: INodeBase;
  l_Temp: INodeBase;
 begin
  l_Node := l_Root;
  while Assigned(l_Node) and (l_Node.GetChildCount <= 1) do
  begin
   l_Node.GetFirstChild(l_Temp);
   l_Node := l_Temp;
  end;//while Assigned(l_Node) and (
  Result := not Assigned(l_Node) or (l_Node.GetChildCount <= 1);
 end;//lpHasMoreThenOne

//#UC END# *4DF217A402DE_4AA4D8A6012B_var*
begin
//#UC START# *4DF217A402DE_4AA4D8A6012B_impl*
 f_Data := aList;
 f_LinkType := ltList;
 // Получим количество документов
 aList.List.GetRoot(l_Root);
 try
  if lpIsOneDoc then
  begin
   // Определим какие данные возвращать
   case aList.WhatDoingIfOneDoc of
    wdAlwaysOpen:
     lpOpenFirstDoc;
    wdOpenIfUserDefine:
     if afw.Settings.LoadBoolean(pi_List_AutoTransfer, dv_List_AutoTransfer) then
      lpOpenFirstDoc;
   end;//case aList.WhatDoingIfOneDoc of
  end;//if lpIsOneDoc then
 finally
  l_Root := nil;
 end;//aList.List.GetRoot(l_Root);
//#UC END# *4DF217A402DE_4AA4D8A6012B_impl*
end;//TbsOpenListInfo.Init

constructor TbsOpenListInfo.Create(const aList: IdeList);
//#UC START# *4DF2178601C8_4AA4D8A6012B_var*
//#UC END# *4DF2178601C8_4AA4D8A6012B_var*
begin
//#UC START# *4DF2178601C8_4AA4D8A6012B_impl*
 inherited Create;
 Init(aList);
//#UC END# *4DF2178601C8_4AA4D8A6012B_impl*
end;//TbsOpenListInfo.Create

function TbsOpenListInfo.pm_GetData: IUnknown;
//#UC START# *4DF2171B00F8_4AA4D8A6012Bget_var*
//#UC END# *4DF2171B00F8_4AA4D8A6012Bget_var*
begin
//#UC START# *4DF2171B00F8_4AA4D8A6012Bget_impl*
 Result := f_Data;
//#UC END# *4DF2171B00F8_4AA4D8A6012Bget_impl*
end;//TbsOpenListInfo.pm_GetData

procedure TbsOpenListInfo.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Data := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TbsOpenListInfo.ClearFields

{$IfEnd} //not Admin AND not Monitorings

end.