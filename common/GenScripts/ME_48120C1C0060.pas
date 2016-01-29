unit nevBaseDetachedView;

interface

uses
 l3IntfUses
 , nevBaseView
 , nevTools
 , evdStyles
 , nevBase
 , l3Variant
;

type
 TnevBaseDetachedView = class(TnevBaseView, InevViewMetrics)
  procedure Create(const aText: InevObject;
   const aCanvas: InevCanvas);
  function Make(const aText: InevObject;
   const aCanvas: InevCanvas): InevView;
  function DoGetExcludeSuper: TevNormalSegLayerHandleSet;
  function GetNeedTotalRecalc: Boolean;
  function GetIsWebStyle: Boolean;
  function GetShowDocumentParts: Boolean;
  function GetShowSpecial: Boolean;
  function GetHiddenStyles: TevStandardStyles;
  function GetLimitWidth: Integer;
  function GetAllowRubberTables: TnevRubberTablesMode;
  function LimitWidth: TnevInch;
  function InfoCanvas: InevInfoCanvas;
   {* информационный контекст устройства, для которого надо форматировать параграфы. }
  function IsWebStyle: Boolean;
  function ShowDocumentParts: Boolean;
   {* показывать ли блочную структуру документа? }
  function ShowSpecial: Boolean;
  function HiddenStyles: TnevStandardStyles;
  function Extent: TnevPoint;
  function ExcludeSuper: TevNormalSegLayerHandleSet;
   {* Отключаемые при отображении слои }
  function FormatCanvas: InevInfoCanvas;
   {* Канва для форматирования. [$157450362] }
  function AllowRubberTables: TnevRubberTablesMode;
   {* Разрешены ли резиновые таблицы }
  function IsTagCollapsed(aTag: Tl3Variant): Boolean;
  function Data: InevObjectPrim;
  function AACLike: TnevAACLikeMode;
  function NeedTotalRecalc: Boolean;
 end;//TnevBaseDetachedView
 
implementation

uses
 l3ImplUses
 , k2Tags
 , k2Facade
 , k2Base
 , TextPara_Const
;

end.
