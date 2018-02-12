// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.v4.GoogleAnalyticsAPI

package com.google.analytics.v4
{
    import com.google.analytics.core.EventTracker;
    import com.google.analytics.core.ServerOperationMode;

    public interface GoogleAnalyticsAPI 
    {

        function setCampSourceKey(_arg_1:String):void;
        function setDetectTitle(_arg_1:Boolean):void;
        function setLocalRemoteServerMode():void;
        function resetSession():void;
        function setLocalServerMode():void;
        function setCampContentKey(_arg_1:String):void;
        function addOrganic(_arg_1:String, _arg_2:String):void;
        function setDetectFlash(_arg_1:Boolean):void;
        function setAllowLinker(_arg_1:Boolean):void;
        function trackEvent(_arg_1:String, _arg_2:String, _arg_3:String=null, _arg_4:Number=NaN):Boolean;
        function setCampTermKey(_arg_1:String):void;
        function setCampNameKey(_arg_1:String):void;
        function getLinkerUrl(_arg_1:String="", _arg_2:Boolean=false):String;
        function addItem(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:Number, _arg_6:int):void;
        function clearIgnoredRef():void;
        function addTrans(_arg_1:String, _arg_2:String, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:String, _arg_7:String, _arg_8:String):void;
        function getDetectFlash():Boolean;
        function setCampaignTrack(_arg_1:Boolean):void;
        function createEventTracker(_arg_1:String):EventTracker;
        function setCookieTimeout(_arg_1:int):void;
        function setAllowAnchor(_arg_1:Boolean):void;
        function trackTrans():void;
        function clearOrganic():void;
        function trackPageview(_arg_1:String=""):void;
        function setLocalGifPath(_arg_1:String):void;
        function getVersion():String;
        function getLocalGifPath():String;
        function getServiceMode():ServerOperationMode;
        function setVar(_arg_1:String):void;
        function clearIgnoredOrganic():void;
        function setCampMediumKey(_arg_1:String):void;
        function addIgnoredRef(_arg_1:String):void;
        function setClientInfo(_arg_1:Boolean):void;
        function setCookiePath(_arg_1:String):void;
        function setSampleRate(_arg_1:Number):void;
        function setSessionTimeout(_arg_1:int):void;
        function setRemoteServerMode():void;
        function setDomainName(_arg_1:String):void;
        function addIgnoredOrganic(_arg_1:String):void;
        function setAllowHash(_arg_1:Boolean):void;
        function getAccount():String;
        function linkByPost(_arg_1:Object, _arg_2:Boolean=false):void;
        function link(_arg_1:String, _arg_2:Boolean=false):void;
        function setCampNOKey(_arg_1:String):void;
        function getClientInfo():Boolean;
        function cookiePathCopy(_arg_1:String):void;
        function getDetectTitle():Boolean;

    }
}//package com.google.analytics.v4

