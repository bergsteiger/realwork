{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Clipboard;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.Rtti, System.SysUtils, FMX.Platform, FMX.Surfaces;

type
  /// <summary>
  ///   Clipboard support service
  /// </summary>
  IFMXExtendedClipboardService = interface(IFMXClipboardService)
    ['{E96E4776-8234-49F9-B15F-301074E23F70}']
    /// <summary>
    ///   Returns True is clipboard containter text data
    /// </summary>
    function HasText: Boolean;
    /// <summary>
    ///   Gets text data from then clipboard
    /// </summary>
    function GetText: string;
    /// <summary>
    ///   Sets text as a clipboard data
    /// </summary>
    procedure SetText(const Value: string);
    /// <summary>
    ///   Returns True is clipboard containter image data
    /// </summary>
    function HasImage: Boolean;
    /// <summary>
    ///   Gets image data from the clipboard
    /// </summary>
    function GetImage: TBitmapSurface;
    /// <summary>
    ///   Sets image as a clipboard data
    /// </summary>
    procedure SetImage(const Value: TBitmapSurface);
    /// <summary>
    ///   Registers custom clipboard format with <c>AFormatName</c> name
    /// </summary>
    /// <param name="AFormatName">
    ///   Specify the name for the custom format
    /// </param>
    /// <remarks>
    ///   Methods throws <c>EClipboardFormatRegisterError</c> in case format with <c>AFormatName</c> name had already
    ///  registered or thare was a platform error while registration
    /// </remarks>
    procedure RegisterCustomFormat(const AFormatName: string);
    /// <summary>
    ///   Checks wherever custom format is registered
    /// </summary>
    /// <param name="AFormatName">
    ///   Specify the name for the custom format
    /// </param>
    function IsCustomFormatRegistered(const AFormatName: string): Boolean;
    /// <summary>
    ///   Unregister custom clipboard format with <c>AFormatName</c> name
    /// </summary>
    /// <param name="AFormatName">
    ///   Specify the name for the custom format
    /// </param>
    /// <remarks>
    ///   Method throws <c>EClipboardFormatNotRegistered</c> in case format with <c>AFormatName</c> was not registered
    /// </remarks>
    procedure UnregisterCustomFormat(const AFormatName: string);
    /// <summary>
    ///   Checks wherever clipboard contains custom format
    /// </summary>
    /// <param name="AFormatName">
    ///   Specify the name for the custom format
    /// </param>
    /// <returns>
    ///   Returns <c>True</c> if clipboard contains custom format
    /// </returns>
    /// <remarks>
    ///   Method throws <c>EArgumentException</c> in case <c>AFormatName</c> is empty
    ///   Method throws <c>EClipboardFormatNotRegistered</c> in case format with <c>AFormatName</c> was not registered
    /// </remarks>
    function HasCustomFormat(const AFormatName: string): Boolean;
    /// <summary>
    ///   Get data stream for the custom clipboard format
    /// </summary>
    /// <param name="AFormatName">
    ///   Specify the name for the custom format
    /// </param>
    /// <param name="AStream">
    ///   Specify the stream that will get custom format data
    /// </param>
    /// <returns>
    ///   Returns <c>True</c> in case custom format was succesfuly written in <c>AStream</c>
    ///  <c>AFormatName</c> data
    /// </returns>
    /// <remarks>
    ///   Method throws <c>EArgumentException</c> in case <c>AFormatName</c> is empty
    ///   Method throws <c>EArgumentNilException</c> in case <c>AStream</c> is nil
    ///   Method throws <c>EClipboardFormatNotRegistered</c> in case format with <c>AFormatName</c> was not registered
    /// </remarks>
    function GetCustomFormat(const AFormatName: string; const AStream: TStream): Boolean;
    /// <summary>
    ///   Set clipboard data with custom format specified by <c>AFormatName</c> name and data in the <c>AStream</c>
    /// </summary>
    /// <param name="AFormatName">
    ///   Specify the name for the custom format
    /// </param>
    /// <param name="AStream">
    ///   Specify the stream that contains data for the custom format
    /// </param>
    /// <remarks>
    ///   Method throws <c>EArgumentException</c> in case <c>AFormatName</c> is empty
    ///   Method throws <c>EArgumentNilException</c> in case <c>AStream</c> is nil
    ///   Method throws <c>EClipboardFormatNotRegistered</c> in case format with <c>AFormatName</c> was not registered
    /// </remarks>
    procedure SetCustomFormat(const AFormatName: string; const AStream: TStream);
  end;

  /// <summary>
  ///   Basic exception that can be thrown by the methods of the <c>IFMXClipboardService</c>
  /// </summary>
  EClipboardError = class(Exception);
  /// <summary>
  ///   Throws when there was some error while registering custom format
  /// </summary>
  EClipboardFormatRegisterError = class(EClipboardError);
  /// <summary>
  ///   Throws when trying to use custom format methods with format name that wasn't registered
  /// </summary>
  EClipboardFormatNotRegistered = class(EClipboardError);

implementation

uses
{$IFDEF MSWINDOWS}FMX.Clipboard.Win;{$ENDIF}
{$IFDEF IOS}FMX.Clipboard.iOS;{$ENDIF}
{$IFDEF OSX}FMX.Clipboard.Mac;{$ENDIF}
{$IFDEF Android}FMX.Clipboard.Android;{$ENDIF}

end.
