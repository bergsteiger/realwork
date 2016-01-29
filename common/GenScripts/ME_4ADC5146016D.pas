unit nsWindowsListPrim;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Tree_TLB
 , l3Interfaces
 , OfficeLikeAppInterfaces
 , vcmInterfaces
 , vcmEntityForm
 , l3TabbedContainersDispatcher
 , l3Core
;

type
 TnsUniqueName = class(Tl3ProtoObject)
  {* класс позволяющий получать уникальные имена в списке благодаря добавлению в конце повторяющихся слов значение счетчика повторения. Например Слово, Слово (1), Слово (2) и т.д }
  function MakeName(const aName: Il3CString): Il3CString;
   {* возвращает уникальное имя }
  procedure Create;
 end;//TnsUniqueName
 
 TnsWindowsListPrim = class(Tl3ProtoObject)
  {* класс управляющий списком окон }
  function CheckLength(const aName: Il3CString): Il3CString;
   {* проверяет не выходит ли размер имени за допустимые пределы и корректирует при необходимости }
  function FindNode(const aForm: IvcmEntityForm): Il3Node;
   {* возвращает Il3Node для формы aForm }
  procedure Remove(const aForm: IvcmEntityForm);
   {* удаляет форму из списка }
  procedure Reload;
   {* перезагружает список }
  function nsGetWindowCaption(aForm: TvcmEntityForm): Il3CString;
   {* отрезает префикс оставляю только информацию о текущем контенте, а именно _caption формы находящейся в Parent зоне главной формы }
  procedure ContainersChanged(aNotification: Tl3TabbedContainerNotificationType);
 end;//TnsWindowsListPrim
 
implementation

uses
 l3ImplUses
 , vcmMainForm
 , vcmTabbedContainerFormDispatcher
 , vcmStringList
 , l3String
 , l3NodesModelPart
 , SysUtils
 , vcmBase
 , nsWindowNode
 , l3Chars
;

end.
