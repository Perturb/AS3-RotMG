// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.AnalyticsTracker

package com.google.analytics
{
    import com.google.analytics.v4.GoogleAnalyticsAPI;
    import flash.events.IEventDispatcher;
    import com.google.analytics.v4.Configuration;
    import com.google.analytics.debug.DebugConfiguration;

    public interface AnalyticsTracker extends GoogleAnalyticsAPI, IEventDispatcher 
    {

        function set account(_arg_1:String):void;
        function get config():Configuration;
        function get mode():String;
        function set config(_arg_1:Configuration):void;
        function set mode(_arg_1:String):void;
        function set debug(_arg_1:DebugConfiguration):void;
        function get visualDebug():Boolean;
        function get account():String;
        function set visualDebug(_arg_1:Boolean):void;
        function isReady():Boolean;
        function get debug():DebugConfiguration;

    }
}//package com.google.analytics

