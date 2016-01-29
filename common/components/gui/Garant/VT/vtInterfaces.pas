unit vtInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT$ImgList"
// Модуль: "w:/common/components/gui/Garant/VT/vtInterfaces.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::VT$ImgList::vtInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VT\vtDefine.inc}

interface

uses
  Classes,
  Graphics
  {$If not defined(NoVCL)}
  ,
  ImgList
  {$IfEnd} //not NoVCL
  
  ;

type
 TvtPILBpp = (
   bpp24
 , bpp8
 , bpp4
 );//TvtPILBpp

 TvtPILSize = (
   ps16x16
 , ps32x32
 , ps24x24
 );//TvtPILSize

 TvtPILSizes = set of TvtPILSize;

 IvtFlashImageList = interface(IUnknown)
   ['{D0EB2AAD-4D5B-44F4-8A99-D20950095AA0}']
   procedure SaveImageToStream(aStream: TStream;
     aIndex: TImageIndex;
     aBpp: TvtPILBpp);
   procedure Draw(Canvas: TCanvas;
    X: Integer;
    Y: Integer;
    Index: TImageIndex;
    Enabled: Boolean = True;
    HalfTransparent: Boolean = True);
 end;//IvtFlashImageList

implementation

end.