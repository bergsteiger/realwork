unit evDropCombo;

interface

uses
 l3IntfUses
 , evDropControl
 , evQueryCardInt
 , evQueryCardDropControlsInt
 , nevBase
 , l3Interfaces
 , l3TreeInterfaces
 , nevTools
;

type
 TEditableState = (
  esNone
  , esSemiCompleted
  , esCompleted
  , esWrong
 );//TEditableState
 
 TevDropCombo = class(TevDropControl, IevEditorFieldWithTree, IevDropCombo)
  function GetFullPath(const aNode: InevSimpleNode): Il3CString;
  procedure CheckAsterisk;
  function ComboReq: IevComboReq;
  procedure InitTree;
  function MakeNodesFromItems: Boolean;
  procedure ChangeDropTreeForHistory(ForHistory: Boolean);
  procedure SetRootNode(const Value: InevNode);
  procedure Change(const aView: InevView;
   const aPara: InevPara);
  procedure DefilterTree;
  procedure SetRoot(const aRoot: InevNode);
  procedure ChooseMean(NeedHide: Boolean);
  procedure FilterPromptTree;
  procedure FilterNewTree;
  function Filter(const aExpTree: Il3FilterableTree;
   const aContext: Il3CString;
   out anIndex: Integer;
   AutoOpen: Boolean;
   NeedRefilter: Boolean): Il3SimpleTree;
  procedure DoSetContextText(const aText: Il3CString);
  procedure SetNodeByIndex(aIndex: Integer);
  function GetNodeIndex(const aNode: InevSimpleNode): Integer;
   {* Возвращает номер узла. }
  procedure ShowNode(const aNode: InevSimpleNode);
   {* Отображает узел в поле. }
  function Value: InevSimpleNode;
   {* Выбранный узел в дереве. }
  function IsAsterisk: Boolean;
   {* Присутствует ли в тексте символ '*'. }
  function DefaultNode: InevSimpleNode;
   {* Узел с значением по умолчанию. }
  function Asterisk: AnsiChar;
   {* Символ звездочки. }
  function SourceTree: InevSimpleTree;
   {* Дерево с данными.
У Димы - Get_Tree. }
  function ComboStyle: TevComboStyle;
   {* Стиль поведения выпадающего списка. }
  function LogicalState: Integer;
   {* Выставленное логическое значение для поля. }
  function Down: Boolean;
   {* Нажата ли кнопка в редакторе.
У Димы - Get_Checked/Set_Checked. }
  procedure CheckTextVersusValue;
   {* Заточка на тот случай когда после Undo текст в контроле не совпадает
        с выбранной нодой - в этом случае очищаем все. }
  function GetNode(anIndex: Integer): InevSimpleNode;
   {* Возвращает узел. }
  procedure ChooseNode(const Value: InevSimpleNode;
   NeedHide: Boolean);
   {* Обработчик выбора узла в дереве при его закрытии. }
  function IsList: Boolean;
  function NeedClearOnEscape: Boolean;
  procedure DoDrop(const aPoint: TPoint;
   AInvert: Boolean;
   AWidth: Integer;
   ByUser: Boolean);
   {* Вываливает выпадающий виджет по указанным координатам }
  function IsLogicalStateButtonEnabled: Boolean;
  procedure SetMaskText(const aText: Il3CString);
 end;//TevDropCombo
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Chars
 , evControlParaTools
 , l3String
 , l3Const
 , k2Tags
 , evParaTools
 , l3Tree
 , l3Base
 , l3Nodes
 , evTextStyle_Const
 , l3Types
 , evTextParaTools
 , evdTextStyle_Const
 , l3Tree_TLB
;

end.
