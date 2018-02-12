// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.google.analytics.data.UTMX

package com.google.analytics.data
{
    public class UTMX extends UTMCookie 
    {

        private var _value:String;

        public function UTMX()
        {
            super("utmx", "__utmx", ["value"], 0);
            _value = "-";
        }

        public function get value():String
        {
            return (_value);
        }

        public function set value(_arg_1:String):void
        {
            _value = _arg_1;
        }


    }
}//package com.google.analytics.data

