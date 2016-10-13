unit msmDefaultModels;

// Модуль: "w:\common\components\gui\Garant\msm\msmDefaultModels.pas"
// Стереотип: "Interfaces"
// Элемент модели: "msmDefaultModels" MUID: (57FF348E0031)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 , Types
 , msmModels
 , msmEvents
;

 (*
 MmsmDragAndDropModel = interface
  function Drop(aFormat: Tl3ClipboardFormat;
   const aMedium: Tl3StoragePlace;
   var dwEffect: Integer;
   const aPoint: Tl3SPoint): Boolean;
  function DragOver(const aData: IDataObject;
   const aPoint: TPoint): Boolean;
 end;//MmsmDragAndDropModel
 *)

type
 ImsmDragAndDropModel = interface(ImsmModel)
  ['{1019541F-4F6F-4FBC-BC9A-F57BCF4AA4C9}']
  function Drop(aFormat: Tl3ClipboardFormat;
   const aMedium: Tl3StoragePlace;
   var dwEffect: Integer;
   const aPoint: Tl3SPoint): Boolean;
  function DragOver(const aData: IDataObject;
   const aPoint: TPoint): Boolean;
 end;//ImsmDragAndDropModel

implementation

uses
 l3ImplUses
;

end.
