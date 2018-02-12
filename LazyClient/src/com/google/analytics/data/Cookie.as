// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.data.Cookie

package com.google.analytics.data
{
    public interface Cookie 
    {

        function fromSharedObject(_arg_1:Object):void;
        function toURLString():String;
        function get creation():Date;
        function toSharedObject():Object;
        function isExpired():Boolean;
        function set creation(_arg_1:Date):void;
        function set expiration(_arg_1:Date):void;
        function get expiration():Date;

    }
}//package com.google.analytics.data

