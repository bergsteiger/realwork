unit vcmModuleDef;

{ Ѕиблиотека "vcm"        }
{ јвтор: Ћюлин ј.¬. ©     }
{ ћодуль: vcmModuleDef -  }
{ Ќачат: 13.03.2003 12:32 }
{ $Id: vcmModuleDef.pas,v 1.35 2013/07/05 09:10:35 lulin Exp $ }

// $Log: vcmModuleDef.pas,v $
// Revision 1.35  2013/07/05 09:10:35  lulin
// - чистим код.
//
// Revision 1.34  2012/04/13 19:00:43  lulin
// {RequestLink:237994598}
//
// Revision 1.33  2010/09/15 18:15:01  lulin
// {RequestLink:235047275}.
//
// Revision 1.32  2010/09/15 16:19:49  lulin
// {RequestLink:235047275}.
//
// Revision 1.31  2010/09/15 16:00:00  lulin
// {RequestLink:235047275}.
//
// Revision 1.30  2010/09/13 16:12:49  lulin
// {RequestLink:235047275}.
//
// Revision 1.29  2009/11/12 18:07:34  lulin
// - убираем ненужные возвращаемые значени€.
//
// Revision 1.28  2009/10/14 18:39:48  lulin
// {RequestLink:166855347}.
//
// Revision 1.27  2009/02/20 15:19:00  lulin
// - <K>: 136941122.
//
// Revision 1.26  2009/02/20 13:44:19  lulin
// - <K>: 136941122.
//
// Revision 1.25  2009/02/20 13:07:06  lulin
// - <K>: 136941122.
//
// Revision 1.24  2007/04/12 07:57:09  lulin
// - используем строки с кодировкой.
//
// Revision 1.23  2007/04/10 14:06:22  lulin
// - используем строки с кодировкой.
//
// Revision 1.22  2006/03/24 14:05:36  lulin
// - cleanup: не пишем пустые коллекции.
//
// Revision 1.21  2006/03/15 12:27:21  lulin
// - cleanup.
//
// Revision 1.20  2006/03/13 12:00:57  lulin
// - берем _Caption модул€ из общего репозитари€.
//
// Revision 1.19  2004/09/21 16:23:31  mmorozov
// new: возвращает интерфейс IvcmIdentifiedUserFriendlyControl;
//
// Revision 1.18  2004/09/11 12:29:10  lulin
// - cleanup: избавл€емс€ от пр€мого использовани€ деструкторов.
// - new unit: vcmComponent.
//
// Revision 1.17  2004/09/10 14:04:04  lulin
// - оптимизаци€ - кешируем EntityDef и передаем ссылку на EntityItem, а не на кучу параметров.
//
// Revision 1.16  2004/02/04 14:30:07  am
// change: property _ToolbarPos имеет теперь default vcm_tbpTop
//
// Revision 1.15  2004/02/02 13:30:26  am
// new: более одного тулбара у формы
//
// Revision 1.14.4.1  2004/01/20 15:25:04  am
// *** empty log message ***
//
// Revision 1.14  2003/12/30 10:03:55  law
// - optimization: при создании второго Main-окна не создаем по новой все формы сущностей (CQ OIT5-5628).
//
// Revision 1.13  2003/11/30 15:15:31  law
// - new behavior: добавлена генераци€ констант дл€ операций модул€.
//
// Revision 1.12  2003/11/18 19:35:54  law
// - new: начал делать общий репозиторий модулей, сущностей и операций в MenuManager'е. „тобы все можно было править из одного места.
//
// Revision 1.11  2003/06/17 11:42:46  narry
// - update: продолжение документировани€
//
// Revision 1.10  2003/06/02 15:19:29  narry
// - update: продолжение документировани€ библиотеки
//
// Revision 1.9  2003/04/04 10:58:58  law
// - bug fix: была ошибка в имени типа TvcmControlID.
//
// Revision 1.8  2003/04/03 15:58:28  demon
// - bug fix: модуль не подписывалс€ на событи€.
//
// Revision 1.7  2003/04/03 09:26:18  law
// - new behavior: сделал возможность подписки на событи€.
//
// Revision 1.6  2003/04/02 14:02:03  law
// - change type: TvcmNotifyEvent.
//
// Revision 1.5  2003/04/02 14:00:07  law
// - new prop: TvcmCustomModuleDef.OnNotify.
//
// Revision 1.4  2003/04/02 12:54:19  law
// - new interface: IvcmSubscriber.
//
// Revision 1.3  2003/04/02 11:10:37  law
// - new interface: IvcmAggregate.
//
// Revision 1.2  2003/04/02 10:40:52  law
// - bug fix: используем Name модул€ вместо _ClassName.
//
// Revision 1.1  2003/04/01 12:54:44  law
// - переименовываем MVC в VCM.
//
// Revision 1.3  2003/03/27 14:36:52  law
// - new prop: операци€ теперь имеет картинку.
//
// Revision 1.2  2003/03/26 12:13:41  law
// - cleanup.
//
// Revision 1.1  2003/03/13 09:52:02  law
// - new component: TvcmModuleDef.
//

{$Include vcmDefine.inc }

interface

uses
  Classes,

  vcmExternalInterfaces,
  vcmUserControls,
  vcmInterfaces,
  vcmBase,
  vcmOperations
  ;

type
  TvcmCustomModuleDef = class(TvcmCustomOperations)
   {* ќписание модул€. }
    {$IfNDef DesignTimeLibrary}
    private
    // property fields
      f_ModuleDef : IvcmModuleDef;
    protected
      function  pm_GetModuleDef: IvcmModuleDef;
        {-}
    {$EndIf DesignTimeLibrary}    
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      procedure Operation(const anID    : TvcmControlID;
                         aMode         : TvcmOperationMode;
                         const aParams : IvcmParams);
        {* - выполн€ет операцию модул€. }
      function QueryInterface(const IID: TGUID; out Obj): HResult;
        override;
        {-}
    public
    // public properties
      {$IfNDef DesignTimeLibrary}
      property ModuleDef: IvcmModuleDef
        read pm_GetModuleDef;
        {* - описатель модул€. }
      {$EndIf DesignTimeLibrary}  
  end;//TvcmCustomModuleDef

implementation

uses
  SysUtils,

  vcmBaseModuleDef,
  vcmModule
  
  {$IfNDef DesignTimeLibrary}
  ,
  vcmBaseMenuManager,
  vcmBaseCollectionItem
  {$EndIf  DesignTimeLibrary}
  ;

// start class TvcmCustomModuleDef

procedure TvcmCustomModuleDef.Cleanup;
  //override;
  {-}
begin
 {$IfNDef DesignTimeLibrary}
 f_ModuleDef := nil;
 {$EndIf  DesignTimeLibrary}
 inherited;
end;

procedure TvcmCustomModuleDef.Operation(const anID        : TvcmControlID;
                                       aMode             : TvcmOperationMode;
                                       const aParams     : IvcmParams);
  {* - выполн€ет операцию модул€. }
begin
 Operations.Operation(Owner, nil, anID, aMode, aParams);
end;

function TvcmCustomModuleDef.QueryInterface(const IID: TGUID; out Obj): HResult;
  //override;
  {-}
begin
 {$IfNDef DesignTimeLibrary}
 if IsEqualGUID(IID, IvcmUserFriendlyControl) then
 begin
  Result := S_Ok;
  IvcmUserFriendlyControl(Obj) := ModuleDef;
 end
 else
 if IsEqualGUID(IID, IvcmIdentifiedUserFriendlyControl) then
 begin
  Result := S_Ok;
  IvcmIdentifiedUserFriendlyControl(Obj) := ModuleDef;
 end
 else
 if IsEqualGUID(IID, IvcmModuleDef) then
 begin
  Result := S_Ok;
  IvcmModuleDef(Obj) := ModuleDef;
 end
 else
 {$EndIf DesignTimeLibrary}
  Result := inherited QueryInterface(IID, Obj);
end;

{$IfNDef DesignTimeLibrary}
function TvcmCustomModuleDef.pm_GetModuleDef: IvcmModuleDef;
  {-}

 function MakeBaseModuleDef: IvcmModuleDef;
   //overload;
   {* - возвращает базовый описатель модул€. }
 var
  l_Module      : TvcmModule;
  l_ModuleDef   : TvcmBaseModuleDef;
  l_Caption     : IvcmCString;
  l_Hint        : IvcmCString;
  l_LongHint    : IvcmCString;
  //l_Description : String;
  l_Obj         : TvcmBaseCollectionItem;
 begin
  l_Module := Owner As TvcmModule;
  l_Obj := g_MenuManager.ObjectByType(vcm_objModule, l_Module.Name);
  Assert(l_Obj <> nil);
  if (l_Obj.Caption = '') then
   l_Caption := vcmCStr(l_Module.Name)
  else
   l_Caption := vcmCStr(l_Obj.Caption);
  l_Hint := l_Caption;
  l_LongHint := l_Hint;
  //l_Description := vcmStr(l_LongHint);
  l_ModuleDef := TvcmBaseModuleDef.Create(l_Module.ID,
                                          RvcmModule(l_Module.ClassType),
                                          l_Module.Name,
                                          l_Caption,
                                          l_Hint, l_LongHint, vcm_tbpTop,
                                          -1, Operations);
  try
   Result := l_ModuleDef;
  finally
   FreeAndNil(l_ModuleDef);
  end;//try..finally
 end;

begin
 if (f_ModuleDef = nil) then
 begin
  Result := MakeBaseModuleDef;
  Assert(not (csLoading in ComponentState));
  if not (csLoading in ComponentState) then
   f_ModuleDef := Result;
 end
 else
  Result := f_ModuleDef;
end;
{$EndIf DesignTimeLibrary}

end.

