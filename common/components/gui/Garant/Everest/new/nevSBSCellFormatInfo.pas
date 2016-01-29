unit nevSBSCellFormatInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevSBSCellFormatInfo.pas"
// Начат: 14.09.2011 12:26
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Rendering::TnevSBSCellFormatInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  nevListFormatInfo
  ;

type
 _CellFormatInfoCommon_Parent_ = TnevListFormatInfo;
 {$Include ..\new\CellFormatInfoCommon.imp.pas}
 TnevSBSCellFormatInfo = class(_CellFormatInfoCommon_)
 public
 // overridden public methods
   function VerticalAlignmentMargin: Integer; override;
     {* Возвращает смещение параграфа от верхней границы, в зависимости от вертикального выравнивания. }
 end;//TnevSBSCellFormatInfo

implementation

uses
  evdTypes,
  nevBase,
  k2Tags
  ;

{$Include ..\new\CellFormatInfoCommon.imp.pas}

// start class TnevSBSCellFormatInfo

function TnevSBSCellFormatInfo.VerticalAlignmentMargin: Integer;
//#UC START# *52021CDE00B2_4E706504020E_var*
//#UC END# *52021CDE00B2_4E706504020E_var*
begin
//#UC START# *52021CDE00B2_4E706504020E_impl*
 Result := GetVerticalAlignmentMargin;
//#UC END# *52021CDE00B2_4E706504020E_impl*
end;//TnevSBSCellFormatInfo.VerticalAlignmentMargin

end.