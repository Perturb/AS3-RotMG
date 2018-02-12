// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.debug.ILayout

package com.google.analytics.debug
{
    import flash.display.DisplayObject;
    import flash.net.URLRequest;
    import com.google.analytics.core.GIFRequest;

    public interface ILayout 
    {

        function createAlert(_arg_1:String):void;
        function addToStage(_arg_1:DisplayObject):void;
        function createGIFRequestAlert(_arg_1:String, _arg_2:URLRequest, _arg_3:GIFRequest):void;
        function createWarning(_arg_1:String):void;
        function createPanel(_arg_1:String, _arg_2:uint, _arg_3:uint):void;
        function createInfo(_arg_1:String):void;
        function createFailureAlert(_arg_1:String):void;
        function addToPanel(_arg_1:String, _arg_2:DisplayObject):void;
        function init():void;
        function createSuccessAlert(_arg_1:String):void;
        function createVisualDebug():void;
        function destroy():void;
        function bringToFront(_arg_1:DisplayObject):void;
        function isAvailable():Boolean;

    }
}//package com.google.analytics.debug

