unit PictureEtalonsWorkingPack;

interface

uses
 l3IntfUses
 , tfwGlobalKeyWord
 , tfwScriptingInterfaces
 , TypInfo
;

implementation

uses
 l3ImplUses
 , l3PicturePathService
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwEnabledSaveRTFPictures = class(TtfwGlobalKeyWord)
  {* Слово скрипта EnabledSaveRTFPictures
[panel]Включить режим сохранения картинок при импорте из RTF/DOC/DOCX. Нужно вызывать перед каждой выливкой из RTF, т.к.флаг сбрасывается.[panel]
*Пример:*
[code]
 EnabledSaveRTFPictures
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwEnabledSaveRTFPictures
 
 TkwGeneratePDFForEtalon = class(TtfwGlobalKeyWord)
  {* Слово скрипта GeneratePDFForEtalon
[panel]*Формат*:
[code]
aFlag GeneratePDFForEtalon
[code]
где aFlag - true или false.
Включить/выключить режим генерации текстового PDF, который удобно использовать для сравнения. Нужно выставлять при каждом экспорте, т.к.флаг сбрасывается в False.[panel]
*Пример:*
[code]
 aValue GeneratePDFForEtalon
[code]  }
  procedure GeneratePDFForEtalon(const aCtx: TtfwContext;
   aValue: Boolean);
   {* Реализация слова скрипта GeneratePDFForEtalon }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwGeneratePDFForEtalon
 
end.
