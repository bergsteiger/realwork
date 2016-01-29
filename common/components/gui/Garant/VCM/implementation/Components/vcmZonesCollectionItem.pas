unit vcmZonesCollectionItem;
{* Элемент коллекции зон докинга. }

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmZonesCollectionItem - }
{ Начат: 21.04.2003 19:32 }
{ $Id: vcmZonesCollectionItem.pas,v 1.112 2015/03/18 11:14:08 lulin Exp $ }

// $Log: vcmZonesCollectionItem.pas,v $
// Revision 1.112  2015/03/18 11:14:08  lulin
// - упорядочиваем генерацию зависимостей.
//
// Revision 1.111  2015/03/02 13:59:54  morozov
// {RequestLink: 588809860}
//
// Revision 1.110  2014/02/19 14:25:40  lulin
// - вычищаем ненужное.
//
// Revision 1.109  2014/02/05 12:34:19  morozov
// {RequestLink: 370384532}
//
// Revision 1.108  2013/11/11 15:35:23  lulin
// - вычищаем устаревший код.
//
// Revision 1.107  2013/11/11 15:21:14  lulin
// - вычищаем устаревший код.
//
// Revision 1.106  2013/01/22 15:52:24  kostitsin
// [$424399029]
//
// Revision 1.105  2012/12/05 14:49:12  lulin
// {RequestLink:371649474}
//
// Revision 1.104  2012/08/06 14:58:49  lulin
// {RequestLink:315261181}
//
// Revision 1.103  2012/07/17 11:52:46  lulin
// {RequestLink:378541134}
//
// Revision 1.102  2012/04/13 14:37:56  lulin
// {RequestLink:237994598}
//
// Revision 1.101  2012/04/09 08:38:58  lulin
// {RequestLink:237994598}
// - думаем о VGScene.
//
// Revision 1.100  2012/04/04 08:56:59  lulin
// {RequestLink:237994598}
//
// Revision 1.99  2011/12/22 14:46:43  lulin
// {RequestLink:320745296}
//
// Revision 1.98  2011/04/15 14:50:06  lulin
// {RequestLink:228688732}.
// - делаем оснастку для возможности придания каждой медали своего баллона.
//
// Revision 1.97  2011/03/28 12:44:03  lulin
// {RequestLink:259169894}.
//
// Revision 1.96  2011/03/28 12:34:44  lulin
// {RequestLink:259169894}.
//
// Revision 1.95  2011/03/28 12:15:47  lulin
// {RequestLink:259169894}.
//
// Revision 1.94  2010/04/27 18:02:24  lulin
// {RequestLink:159352361}.
// - признак возможности закрытия формы переносим на модель.
//
// Revision 1.93  2010/01/14 13:04:46  lulin
// {RequestLink:177963744}.
//
// Revision 1.92  2009/10/14 18:39:48  lulin
// {RequestLink:166855347}.
//
// Revision 1.91  2009/10/01 14:58:30  lulin
// - убираем сферического коня в вакууме.
//
// Revision 1.90  2009/09/30 15:23:00  lulin
// - убираем ненужное приведение ко вполне понятным интерфейсам.
//
// Revision 1.89  2009/09/25 12:09:14  lulin
// - выкидываем ненужное.
//
// Revision 1.88  2009/08/13 13:53:26  lulin
// - убираем ненужные панельки.
//
// Revision 1.87  2009/08/06 16:08:15  lulin
// {RequestLink:159352843}.
//
// Revision 1.86  2009/08/04 16:53:01  lulin
// - наконец-то дошли до вызова сравнения редакций, которое падает.
//
// Revision 1.85  2009/02/20 10:56:47  lulin
// - избавляемся от завязок на модуль, которые всё равно никто не использует.
//
// Revision 1.84  2009/02/12 18:06:12  lulin
// - <K>: 135604584. Переносим константы.
//
// Revision 1.83  2009/02/12 12:26:39  lulin
// - <K>: 135604584. Выделен новый интерфейсный модуль.
//
// Revision 1.82  2007/12/10 12:44:50  mmorozov
// - new: реализуем шаблон publisher\subscriber при редактировании настроек, замены настроек (переключения конфигураций), настройке панелей инструментов (в рамках CQ: OIT5-27823);
//
// Revision 1.81  2007/06/18 13:49:03  mmorozov
// - new behaviour: при открытии нового прецедента сначала удаляем формы из панели задач потом регистрируем новые, алгоритм по которому выполнены измнения см. в К<18219426>;
//
// Revision 1.80  2007/05/02 14:20:43  oman
// - new: Нотификация о том что форма в зоне уже поменялась (cq25145)
//
// Revision 1.79  2007/04/13 09:55:07  oman
// - fix: Откатил изменения по ЦК24524 поскольку сломалась история
//   и эти изменения все равно не решили полностью проблемы когда
//   у сборки меняется только содержимое без закрытия форм (cq25016)
//
// Revision 1.78  2007/04/10 13:29:09  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.77  2007/04/10 12:52:13  oman
// - fix: В историю пищем после CloseQuery (cq24524)
//
// Revision 1.76  2007/03/28 11:13:08  lulin
// - cleanup.
// - bug fix: вставлена проверка на то, что указан контрол дока.
//
// Revision 1.75  2006/12/27 15:19:57  mmorozov
// - new: проверка необходимости сохранения стиля формы;
//
// Revision 1.74  2006/12/27 14:44:59  mmorozov
// - change: механизм объединения панелей инструментов (CQ: OIT5-23903);
//
// Revision 1.73  2006/12/13 09:22:06  mmorozov
// - new: возможность указывать фиксированный размер для зон стыковки панелей инструментов формы, в рамках работы над CQ: OIT5-13323;
//
// Revision 1.72  2006/12/10 16:35:36  lulin
// - cleanup.
//
// Revision 1.71  2006/02/26 15:34:42  mmorozov
// - bugfix: правильно восстанавливаем размер для всячески выровненных компонентов (CQ: 19794);
//
// Revision 1.70  2005/10/06 10:51:02  lulin
// - класс панелей переехал в более правильное место.
//
// Revision 1.69  2005/10/06 09:17:55  lulin
// - базовый класс панелей переехал в более правильное место.
//
// Revision 1.68  2005/01/14 10:42:30  lulin
// - методы Get*ParentForm переехали в библиотеку AFW.
//
// Revision 1.67  2004/10/15 14:03:56  am
// change: отбил заголовок вдоченой формы линией (иначе сливалось с выделенными элементами в дереве, см. ППС 5.x)
//
// Revision 1.66  2004/10/08 11:57:53  am
// change: TvcmZonesCollectionItem._ControlIsPanel теперь пытается спросить с контрола интерфейс TvcmDockType
//
// Revision 1.65  2004/10/07 12:35:10  mmorozov
// new: field _f_ControlSize;
// new: запоминаем размеры компонента зоны после загрузки;
// new: method _RestoreControlSize;
//
// Revision 1.64  2004/10/05 11:53:26  mmorozov
// new: при вставке формы устанавливаем ей компонент зоны;
//
// Revision 1.63  2004/09/16 11:31:01  lulin
// - навел подобие порядка с регистрацией компонент библиотеки.
//
// Revision 1.62  2004/09/14 12:32:13  lulin
// - bug fix: _UpdateMainCaption стало вызываться слишком рано.
//
// Revision 1.61  2004/09/13 08:56:10  lulin
// - new behavior: TvcmPrimCollectionItem теперь может кешироваться и распределяться в пуле объектов.
//
// Revision 1.60  2004/09/10 16:49:55  mmorozov
// remove: ControlHasForm, _HasForm;
//
// Revision 1.59  2004/09/06 08:41:33  fireton
// - correction: поправил приведение типов в соответствии с комментариями коллег
//
// Revision 1.58  2004/09/06 06:40:49  fireton
// - bug fix: не компилялось
//
// Revision 1.57  2004/09/03 11:52:38  fireton
// - bug fix: учитываем рамочки у TevPanel при докинге в нее
//
// Revision 1.56  2004/09/02 17:13:06  mmorozov
// new: property TvcmZonesCollectionItem.OnlySmallImages;
//
// Revision 1.55  2004/09/02 06:57:07  law
// - bug fix: при восстановлении формы из истории не учитывался GUID (точнее подменялся старый) и из-за этого не сохранялось состояние формы по операции Back (и соответственно не восстанавливалось по Forward) (CQ OIT5-8743).
//
// Revision 1.54  2004/08/06 12:37:19  am
// change: при выводе строки-заголовка, в случае, если она не помещается, активируем тултип
//
// Revision 1.53  2004/08/06 11:28:36  am
// change: при выводе строки-заголовка, в случае, если она не помещается, рисуем многоточие в конце.
//
// Revision 1.52  2004/07/22 14:43:47  am
// bugfix: непрорисовка SynchroView
// bugfix: вернул оптимизацию прорисовки
//
// Revision 1.51  2004/07/22 13:15:56  am
// bugfix: открутил пока оптимизацию моргания. Приводило к непрорисовке statictext'а на формах :-(
//
// Revision 1.50  2004/07/20 11:10:37  am
// change: частично избегаем промаргивания при вставке формы
//
// Revision 1.49  2004/05/17 14:51:00  am
// change: vcm: теперь можно безболезненно делать
// Container._InsertForm(aForm), где aForm - форма, которая в настоящее
// время находится в той зоне, куда делаем Insert
// change: vcm: TvcmZonesCollectionItem._InsertForm: Result не зависит
// от результата ManualDock
//
// Revision 1.48  2004/04/14 13:51:53  mmorozov
// new behaviour: не производится поиск формы в форме, которая не является контейнером;
//
// Revision 1.47  2004/03/20 10:35:11  mmorozov
// bugfix;
//
// Revision 1.46  2004/03/19 15:03:19  mmorozov
// new: в метод _HasForm добавлен параметр (UserType : Integer = vcm_utAny);
//
// Revision 1.45  2004/03/13 12:53:01  law
// - bug fix: плавающая форма поднималась не по запомненным координатам.
//
// Revision 1.44  2004/01/29 16:16:27  law
// - new class method: _TvcmEntityForm._FormID.
//
// Revision 1.43  2004/01/21 18:49:31  migel
// - fix: чиним фокус и апдейт заголовков основной формы.
//
// Revision 1.42  2004/01/13 09:24:38  migel
// - fix: не компилировался в пакет.
//
// Revision 1.41  2004/01/10 11:37:43  law
// - bug fix: можно было закрыть придоченную форму, которая не имела кнопки [x] (CQ OIT5-5234).
//
// Revision 1.40  2003/12/26 10:56:43  demon
// - cleanup: comment code изменениря размеров формы для устранения мерцания
//
// Revision 1.39  2003/12/18 17:19:58  law
// - борьба с мерцанием.
//
// Revision 1.38  2003/11/28 13:01:30  law
// - new behavior: опираемся на идентификаторы форм, а не на имена.
//
// Revision 1.37  2003/11/11 17:08:25  law
// - new event: vcm_etFormInZoneChange.
//
// Revision 1.36  2003/10/23 12:12:11  law
// - remove proc: EntityBroadcast, как ненужную и не совсем прозрачную.
//
// Revision 1.35  2003/10/20 10:51:29  migel
// - new: посылка операции сущности в режиме бродкаста.
//
// Revision 1.34  2003/10/16 12:51:38  mmorozov
// - переход с _CanClose: Boolean на _CanClose: TvcmCanClose;
// + определение в методе TvcmZonesCollectionItem._InsertForm свойства _CanClose всталяемой в зону докинга формы;
//
// Revision 1.33  2003/09/25 17:00:25  law
// - new behavior: сделано отложенное убивание форм.
//
// Revision 1.32  2003/09/22 15:52:15  law
// no message
//
// Revision 1.31  2003/09/19 17:44:26  law
// - bug fix: реализован свой менеджер докинга, который вроде пока работает без ошибок.
//
// Revision 1.30  2003/09/04 11:49:08  law
// - new behavior: Caption основного объекта выводится в Caption главного окна.
//
// Revision 1.29  2003/09/04 11:12:14  law
// - new method: IvcmEntityForm._IsMainObjectForm.
//
// Revision 1.28  2003/09/04 11:01:52  law
// - new behavior: не рисуем Caption активного объекта (_vcm_ztParent) в "сером поле".
//
// Revision 1.27  2003/07/29 12:44:44  law
// - new behavior: считаем размер Caption'а по высоте строчки.
//
// Revision 1.26  2003/07/29 09:06:54  law
// - bug fix: не для всех форм рисовался Caption.
//
// Revision 1.25  2003/07/25 15:18:00  law
// - new behavior: сделана отрисовка Caption'ов в придоченной форме.
//
// Revision 1.24  2003/07/01 11:08:29  demon
// - bug fix: если компонент TWinControl и не находили форму - не проверялся интерфейс IvcmControlsContainer.
//
// Revision 1.23  2003/06/30 16:16:35  law
// - new: расширен интерфейс IeeHyperlink.
//
// Revision 1.22  2003/06/27 17:09:37  law
// - new behavior: опробовано рисование заголовка придоченной формы (пока закомментировано).
//
// Revision 1.21  2003/06/27 11:03:20  law
// - bug fix: неправильно было сделано "не объединяем toolbar'ы, когда форма вставляется в панель".
//
// Revision 1.20  2003/06/27 10:47:51  law
// - new behavior: не объединяем toolbar'ы, когда форма вставляется в панель.
//
// Revision 1.19  2003/06/19 11:46:03  law
// - bug fix: не работала история навигации. До конца не починено - сейчас восстанавливается только самая верхняя форма.
//
// Revision 1.18  2003/05/20 15:15:10  law
// - bug fix: при уничтожении формы не пропадала связанная с ней закладка.
//
// Revision 1.17  2003/05/20 12:03:06  law
// - bug fix: при Close формы не сразу удалялись дочерние формы.
//
// Revision 1.16  2003/04/30 13:25:26  demon
// - bug fix: формы не исключались из зон.
//
// Revision 1.15  2003/04/29 13:28:53  law
// - new methods: IvcmFormDispatcher._Lock, Unlock.
//
// Revision 1.14  2003/04/29 09:16:27  law
// - new prop: TvcmZonesCollectionItem._CanClose.
//
// Revision 1.13  2003/04/29 06:43:04  law
// - new behavior: запретил рисование "палочек" и "крестиков" для панели, когда _CanUndock = false.
//
// Revision 1.12  2003/04/28 14:07:57  law
// - new behavior: запретил отдочивать по DblClick.
//
// Revision 1.11  2003/04/25 15:02:18  law
// - new type: _TvcmEffectiveZoneType.
//
// Revision 1.10  2003/04/25 13:53:28  law
// - bug fix: пытаемся починить потерю фокуса.
//
// Revision 1.9  2003/04/24 11:47:36  demon
// - bug fix: _HasForm не заходила рекурсивно в TWinControl'ы.
//
// Revision 1.8  2003/04/23 16:09:51  law
// - new behavior: в панель вставляем только одну форму.
//
// Revision 1.7  2003/04/23 16:02:45  demon
// - bug fix: не отрабатывалась рекурсивная проверка форм в зонах.
//
// Revision 1.6  2003/04/23 15:47:50  law
// - new method: TvcmZonesCollectionItem.ControlHasForm.
//
// Revision 1.5  2003/04/23 14:54:32  law
// - new method: _IvcmContainer._HasForm.
//
// Revision 1.4  2003/04/22 15:50:51  law
// - new behavior: при докинге пользователем проверяем тип зоны, куда пользователь пытается вставить форму.
//
// Revision 1.3  2003/04/22 15:00:30  law
// - bug fix: оттестировал вставку форм в контейнер.
//
// Revision 1.2  2003/04/21 16:16:04  law
// - new behavior: сделана вставка формы в контрол, связанный с зоной.
//
// Revision 1.1  2003/04/21 15:51:06  law
// - new: реализуем описание зон докинга в _TvcmContainerForm - свойство Zones.
//

{$Include vcmDefine.inc }

interface

uses
  Windows,
  
  Types,
  Classes,
  Controls,

  vcmInterfaces,
  vcmBase,
  vcmStyle,
  vcmControlsCollectionItem
  ;

type
  TvcmZonesCollectionItem = class(TvcmControlsCollectionItem)
   {* Элемент коллекции зон докинга. }
    private
    // property fields
      f_ZoneType    : TvcmEffectiveZoneType;
      f_CanUndock   : Boolean;
      f_CanClose    : TvcmCanClose;
      f_ControlSize : TSize;
        {* - размер компонента считанный из Design-Time. }
      f_FormStyle   : TvcmFormStyle;
    protected
    // property methods
      procedure pm_SetControl(aValue: TComponent);
        override;
        {-}
(*      procedure pm_SetFormStyle(const aValue: TvcmFormStyle);
        {* - иконки зоны. }*)
(*      function pm_GetIsStoredStyle: Boolean;
        {-}*)
    protected
    // internal methods
      procedure ControlGetSiteInfo(Sender            : TObject;
                                   DockClient        : TControl;
                                   var InfluenceRect : TRect;
                                   MousePos          : TPoint;
                                   var CanDock       : Boolean);
        {-}
      procedure ControlCannotUndock(Sender : TObject;
                                    Client : TControl;
                                    NewTarget: TWinControl;
                                    var Allow: Boolean);
        {-}
      function ControlIsPanel(aControl : TComponent): Boolean;
        {-}
      procedure BeforeAddToCache;
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(Collection: TCollection);
        override;
        {* - создает элемент коллекции. }
      function InsertForm(const aForm : IvcmEntityForm;
                          aNeedShow   : Boolean): Boolean;
        {* - вставляет форму в зону. }
      function AcceptForm(const aForm : IvcmEntityForm;
                          aControl    : TComponent = nil): Boolean;
        {-}
      procedure RestoreControlSize;
        {* - восстанавливает размер компонента считанный из Design-Time. }
    public    
      property CanUndock: Boolean
        read f_CanUndock
        write f_CanUndock
        default false;
        {* - можно ли вытаскивать формы из зоны. }
      property CanClose: TvcmCanClose
        read f_CanClose
        write f_CanClose
        default vcm_ccNone;
        {* - можно ли закрывать формы зоны. }
      property FormStyle: TvcmFormStyle
        read f_FormStyle
//        write pm_SetFormStyle
{        stored pm_GetIsStoredStyle};
        {* - иконки зоны. }
    published
    // published properties
      property ZoneType: TvcmEffectiveZoneType
        read f_ZoneType
        write f_ZoneType
        default vcm_ztMain;
        {* - тип зоны. }
  end;//TvcmZonesCollectionItem

implementation

uses
  SysUtils,

  Graphics,
  ExtCtrls,
  Forms,

  {$IfDef vcmNeedL3}
  l3DockTree,
  {$EndIf vcmNeedL3}

  afwDockingInterfaces,
  afwFacade,

  vtPanel,

  vcmExternalInterfaces,
  vcmForm,
  vcmEntityForm,
  vcmContainerForm,
  vcmTaskPanelInterfaces,

  vcmInternalConst,

  vcmDockTree
  ;

// start class TvcmZonesCollectionItem

type
  THackWinControl = class(TWinControl);

constructor TvcmZonesCollectionItem.Create(Collection: TCollection);
  //override;
  {* - создает элемент коллекции. }
begin
 inherited Create(Collection);
 f_ZoneType := vcm_ztMain;
 f_FormStyle := TvcmFormStyle.Create;
end;

procedure TvcmZonesCollectionItem.Cleanup;
  // override;
  {-}
begin
 FreeAndNil(f_FormStyle);
 inherited;
end;

procedure TvcmZonesCollectionItem.BeforeAddToCache;
  //override;
  {-}
begin
 inherited;
 f_CanUndock := false;
 f_CanClose := Low(TvcmCanClose);
end;

procedure TvcmZonesCollectionItem.ControlCannotUndock(Sender : TObject;
                                                      Client : TControl;
                                                      NewTarget: TWinControl;
                                                      var Allow: Boolean);
  {-}
begin
 if f_CanUndock then
  Allow := true
 else
  Allow := false;
end;

procedure TvcmZonesCollectionItem.ControlGetSiteInfo(Sender            : TObject;
                                                     DockClient        : TControl;
                                                     var InfluenceRect : TRect;
                                                     MousePos          : TPoint;
                                                     var CanDock       : Boolean);
 {-}
var
 l_Form : TCustomForm;
 l_Container: TvcmContainerForm;
 l_ClientForm: IvcmEntityForm;
 l_AcceptedByZone: Boolean;
 l_AcceptedByContainer: Boolean;
begin
 if not (DockClient Is TvcmEntityForm) then
  CanDock := false
 else
 if (Sender Is TComponent) then
 begin
  l_Form := afw.GetParentForm(TComponent(Sender));
  if (l_Form Is TvcmContainerForm) then
  begin
   //http://mdp.garant.ru/pages/viewpage.action?pageId=370384532
   l_Container := TvcmContainerForm(l_Form);
   l_ClientForm := TvcmEntityForm(DockClient).As_IvcmEntityForm;
   try
    CanDock := l_Container.Zones.AcceptForm(l_ClientForm, TComponent(Sender)) AND
     l_Container.AcceptForm(l_ClientForm, TComponent(Sender));
   finally
    l_ClientForm := nil;
   end;//try..finally
  end;//(l_Form Is TvcmContainerForm)
 end;//not (DockClient Is TForm)
end;

function TvcmZonesCollectionItem.InsertForm(const aForm : IvcmEntityForm;
                                            aNeedShow   : Boolean): Boolean;
  {* - вставляет форму в зону. }

  procedure lp_AddFormToTasksPanel(const aForm: IvcmEntityForm);
  var
   l_MainForm: IvcmMainForm;
  begin
   if Supports(aForm.NativeMainForm, IvcmMainForm, l_MainForm) then
   try
    if aForm.NeedAddFormToTasksPanel then
     l_MainForm.AddFormToTasksPanel(aForm);
   finally
    l_MainForm := nil;
   end;//try..finally
  end;//lp_AddFormToTasksPanel

  procedure lp_RemoveFormFromTasksPanel(const aForm: IvcmForm);
  var
   l_MainForm   : IvcmMainForm;
   l_EntityForm : IvcmEntityForm;
  begin
   if Supports(aForm, IvcmEntityForm, l_EntityForm) then
   try
    if Supports(l_EntityForm.NativeMainForm, IvcmMainForm, l_MainForm) then
    try
     l_MainForm.RemoveFormFromTasksPanel(l_EntityForm);
    finally
     l_MainForm := nil;
    end;//try..finally
   finally
    l_EntityForm := nil;
   end;//try..finally
  end;//lp_RemoveFormFromTasksPanel

var
 l_Form      : IvcmEntityForm;
 l_DM        : IDockManager;
 l_Container : IvcmContainer;
 l_History   : IvcmHistory;
 l_Control   : TWinControl;
 l_DC        : IafwDockableControl;
 l_Dock      : IafwControlDock;
begin
 Result := false;
 if AcceptForm(aForm) then
 begin
  aForm.Dispatcher.FormDispatcher.Lock;
  try
   if (Control Is TWinControl) then
    l_Control := TWinControl(Control)
   else
   begin
    l_Control := nil;
    if not Supports(Control, IafwControlDock, l_Dock) then
     Assert(false);
    try
     if not Supports(aForm, IafwDockableControl, l_DC) then
      Assert(false);
     try
      l_Control := l_Dock.GetDockControl(l_DC);
     finally
      l_DC := nil;
     end;//try..finally
    finally
     l_Dock := nil;
    end;//try..finally 
   end;//Control Is TWinControl
   if (l_Control <> nil) then
   begin
    l_DM := THackWinControl(l_Control).DockManager;
    aForm.Dispatcher.FormDispatcher.AddDockManager(l_DM);
    if ControlIsPanel(l_Control) then
    begin
     if Supports(Collection.Owner, IvcmContainer, l_Container) then
     try
      if l_Container.HasForm(fm_Any, ZoneType, false, @l_Form) then
      try
       if (l_Form.VCLWinControl = aForm.VCLWinControl) then
       begin
        Result := true;
        if aNeedShow then
         if not aForm.VCLWinControl.Visible then
         // http://mdp.garant.ru/pages/viewpage.action?pageId=371649474
          aForm.VCLWinControl.Show;
        exit;
       end//l_Form.VCLForm = aForm.VCLForm
       else
       begin
        l_History := Dispatcher.History;
        if Assigned(l_History) then
         l_History.BeforeFormDestroy(l_Form);
        lp_RemoveFormFromTasksPanel(l_Form);
        l_Form.SafeClose;
       end;//l_Form.VCLForm = aForm.VCLForm
      finally
       l_Form := nil;
      end;//try..finally
     finally
      l_Container := nil;
     end;//try..finally
    end//ControlIsPanel
    else
     aForm.Style.Toolbars.ForbidMerge;
    with (aForm.VCLWinControl As TForm) do
    begin
     //Align := alClient;
     // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
     //BoundsRect := Rect(0, 0, l_Control.Width * 2, l_Control.Height * 2);
     Left := High(SmallInt) - Width;
     // - это не бред! это борьба с мерцанием
     // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
     Result := ManualDock(l_Control, nil, alClient);
     if Result then begin
      (* Запомним компонент зоны *)
      aForm.ZoneControl := l_Control;
      DragKind := dkDock;
      if CanUndock then
       DragMode := dmAutomatic
      else
       DragMode := dmManual;
      { Определим может ли пользователь закрывать форму, для отработки в
        методе TvcmCustomMenuManager._BuildToolbar (vcmMenuManager) }
      if (aForm.VCLWinControl is TvcmEntityForm) then
       if (Self.CanClose <> vcm_ccNone) and
        (TvcmEntityForm(aForm.VCLWinControl).CanClose = vcm_ccNone) then
         TvcmEntityForm(aForm.VCLWinControl).CanClose := Self.CanClose;
      if aNeedShow then
      begin
       // специально для того, чтобы не случалось "промаргивания" формами. Например
       // при переходе из рубрикатора в список
       if (aForm.VCLWinControl.Parent <> nil) then
        aForm.VCLWinControl.BoundsRect := Rect(0, 0, aForm.VCLWinControl.Parent.Width, aForm.VCLWinControl.Parent.Height);
       Show;
      end;//aNeedShow
     end;//Result
     // !! результат ManualDock'а - не признак того, успешно прошёл док или нет
     // !! пример: вставляем форму в тот же док, где она присутствовала. ManualDock
     // !! для навигатора вернёт false. Условия с AcceptForm достаточно
     Result := true;
     lp_AddFormToTasksPanel(aForm);
    end;//with aForm.VCLForm
   end;//l_Control <> nil
  finally
   aForm.Dispatcher.FormDispatcher.UnLock;
  end;//try..finally
 end;//AcceptForm(aForm)
end;

function TvcmZonesCollectionItem.AcceptForm(const aForm : IvcmEntityForm;
                                            aControl    : TComponent = nil): Boolean;
  {-}
begin
 Assert(Control <> nil);
 Result := ((aForm.ZoneType = vcm_ztAny) OR (aForm.ZoneType = ZoneType)) AND
           ((aControl = nil) OR (aControl = Control));
end;

procedure TvcmZonesCollectionItem.RestoreControlSize;
var
 l_Height : Integer;
 l_Width  : Integer;
begin
 if (Control is TControl) then
  with TControl(Control) do
  begin
   l_Height := f_ControlSize.cy;
   l_Width := f_ControlSize.cx;
   case Align of
    alClient:
     Exit;
    alLeft, alRight:
     l_Height := Height;
    alTop, alBottom:
     l_Width := Width;
   end;//case Align of
   SetBounds(Left, Top, l_Width, l_Height);
  end;//with TControl(Control) do
end;//RestoreControlSize

(*function TvcmZonesCollectionItem.pm_GetIsStoredStyle: Boolean;
begin
 Result := not FormStyle.IsDefault;
end;//pm_GetIsStoredStyle*)

(*procedure TvcmZonesCollectionItem.pm_SetFormStyle(const aValue: TvcmFormStyle);
  {* - иконки зоны. }
begin
 f_FormStyle.Assign(aValue);
end;*)

procedure TvcmZonesCollectionItem.pm_SetControl(aValue: TComponent);
  //override;
  {-}
var
 l_M1 : TGetSiteInfoEvent;
 l_M2 : TUnDockEvent;
 l_E1 : TGetSiteInfoEvent;
 l_E2 : TUnDockEvent;

 l_MH1 : TMethod absolute l_M1;
 l_MH2 : TMethod absolute l_M2;
 l_EH1 : TMethod absolute l_E1;
 l_EH2 : TMethod absolute l_E2;
 l_DockTree : TvcmDockTree;
begin
 if (Control <> aValue) then
 begin
  l_E1 := Self.ControlGetSiteInfo;
  l_E2 := Self.ControlCannotUndock;
  if (Control Is TWinControl) AND
     not (csDesigning in Control.ComponentState) then
  begin
   l_M1 := THackWinControl(Control).OnGetSiteInfo;
   if (l_MH1.Code = l_EH1.Code) AND (l_MH1.Data = l_EH1.Data) then
    THackWinControl(Control).OnGetSiteInfo := nil;
   l_M2 := THackWinControl(Control).OnUnDock;
   if (l_MH2.Code = l_EH2.Code) AND (l_MH2.Data = l_EH2.Data) then
    THackWinControl(Control).OnUnDock := nil;
  end;//Control Is TWinControl
  inherited;
  if (Control Is TWinControl) AND
     not (csDesigning in Control.ComponentState) then
  begin
   if not Assigned(THackWinControl(Control).OnGetSiteInfo) then
    THackWinControl(Control).OnGetSiteInfo := l_E1;
   if not CanUndock then
    if not Assigned(THackWinControl(Control).OnUnDock) then
     THackWinControl(Control).OnUnDock := l_E2;
   if ControlIsPanel(aValue) then
   begin
    l_DockTree := TvcmDockTree.Create(TWinControl(Control));
    l_DockTree.CanUndock := CanUndock;
    l_DockTree.CanClose := CanClose;
    THackWinControl(Control).DockManager := l_DockTree;
   end;//ControlIsPanel
   THackWinControl(Control).DockSite := true;
  end;//Control Is TWinControl
  (* Запомним размеры компонента, они являются размерами по умолчанию,
     используются при восстановлении всех настроек системы *)
  if (Control is TControl) then
  begin
   with f_ControlSize, TControl(Control) do
   begin
    cx := Width;
    cy := Height;
   end;//with f_ControlSize, TControl(Control)
  end;//Control is TControl
 end;//Control <> aValue
end;

function TvcmZonesCollectionItem.ControlIsPanel(aControl : TComponent): Boolean;
  {-}
var
 l_DockType: IvcmDockType;
begin
 if Supports(aControl, IvcmDockType, l_DockType) then
  Result := l_DockType.ControlIsPanel
 else
  Result := (aControl Is TPanel)
            OR (aControl Is TvtCustomPanel);
end;

end.
